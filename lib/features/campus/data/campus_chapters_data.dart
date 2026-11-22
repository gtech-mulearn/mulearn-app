import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/api_paths.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_chapter.dart';
import 'package:mulearn_app/features/campus/domain/repositories/campus_chapters_repository.dart';

/// `api/dashboard/campus/urls.py`: `ig-chapters/` (`CampusIGChapterAPI`) and
/// `execom/search/`, as the dashboard's Campus Manage IG tab calls them.
abstract final class CampusChapterPaths {
  const CampusChapterPaths._();

  static const String _base = '/api/v1/dashboard/campus';
  static const String chapters = '$_base/ig-chapters/';
  static String chapter(String id) => '$_base/ig-chapters/$id/';
  static const String memberSearch = '$_base/execom/search/';
}

class CampusChaptersRemoteDataSource {
  const CampusChaptersRemoteDataSource(this._dio);

  final Dio _dio;

  /// A plain list (not paginated).
  Future<List<dynamic>> fetchChapters() async => ApiEnvelope.unwrapList(
    await _dio.get<dynamic>(CampusChapterPaths.chapters),
  );

  Future<String?> create(Map<String, Object?> body) async =>
      ApiEnvelope.unwrapMessage(
        await _dio.post<dynamic>(CampusChapterPaths.chapters, data: body),
      );

  Future<String?> update(String id, Map<String, Object?> body) async =>
      ApiEnvelope.unwrapMessage(
        await _dio.patch<dynamic>(CampusChapterPaths.chapter(id), data: body),
      );

  Future<String?> remove(String id) async => ApiEnvelope.unwrapMessage(
    await _dio.delete<dynamic>(CampusChapterPaths.chapter(id)),
  );

  /// `{data: [{id, full_name, muid, profile_pic}]}`.
  Future<Map<String, dynamic>> searchMembers(String query) async =>
      ApiEnvelope.unwrapObject(
        await _dio.get<dynamic>(
          CampusChapterPaths.memberSearch,
          queryParameters: {'q': query},
        ),
      );

  /// `{interestGroup: [...]}`.
  Future<Map<String, dynamic>> fetchInterestGroups() async =>
      ApiEnvelope.unwrapObject(
        await _dio.get<dynamic>(ApiPaths.interestGroupsList),
      );
}

class CampusChaptersRepositoryImpl implements CampusChaptersRepository {
  const CampusChaptersRepositoryImpl(this._remote);

  final CampusChaptersRemoteDataSource _remote;

  static String? _str(Object? v) {
    if (v == null) return null;
    final s = '$v'.trim();
    return s.isEmpty ? null : s;
  }

  static int _int(Object? v) =>
      v is num ? v.toInt() : int.tryParse('${v ?? ''}') ?? 0;

  /// `CampusIGChapterListSerializer`.
  static CampusChapter? parseChapter(Map<String, dynamic> j) {
    final id = _str(j['id']);
    if (id == null) return null;
    return CampusChapter(
      id: id,
      igId: _str(j['ig_id']) ?? '',
      igName: _str(j['ig_name']) ?? 'Interest group',
      igCode: _str(j['ig_code']) ?? '',
      members: _int(j['campus_ig_member_count']),
      isActive: j['is_active'] != false,
      leadName: _str(j['lead_name']),
      coLeadName: _str(j['co_lead_name']),
      description: _str(j['description']),
    );
  }

  /// Active chapters first, then by members; inactive ones last.
  static List<CampusChapter> parseChapters(List<dynamic> rows) =>
      [for (final r in rows.whereType<Map<String, dynamic>>()) ?parseChapter(r)]
        ..sort((a, b) {
          if (a.isActive != b.isActive) return a.isActive ? -1 : 1;
          return b.members.compareTo(a.members);
        });

  static List<CampusMember> parseMembers(Map<String, dynamic> json) {
    final data = json['data'];
    return [
      if (data is List)
        for (final m in data.whereType<Map<String, dynamic>>())
          if (_str(m['muid']) != null)
            (
              muid: _str(m['muid'])!,
              name: _str(m['full_name']) ?? _str(m['muid'])!,
              photoUrl: _str(m['profile_pic']),
            ),
    ];
  }

  static List<ChapterIgOption> parseInterestGroups(Map<String, dynamic> json) {
    final rows =
        json['interestGroup'] ?? json['interest_group'] ?? json['data'];
    return [
      if (rows is List)
        for (final g in rows.whereType<Map<String, dynamic>>())
          if (_str(g['id']) != null && _str(g['name']) != null)
            (id: _str(g['id'])!, name: _str(g['name'])!),
    ]..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }

  Future<T> _guard<T>(Future<T> Function() body) async {
    try {
      return await body();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<List<CampusChapter>> chapters() =>
      _guard(() async => parseChapters(await _remote.fetchChapters()));

  @override
  Future<String> create({
    required String igId,
    String? description,
    String? leadMuid,
  }) => _guard(
    () async =>
        await _remote.create({
          'ig': igId,
          if ((description ?? '').trim().isNotEmpty)
            'description': description!.trim(),
          if (leadMuid != null) 'lead': leadMuid,
        }) ??
        'Chapter started',
  );

  @override
  Future<String> update(
    String id, {
    required String description,
    required bool isActive,
    String? leadMuid,
  }) => _guard(
    () async =>
        await _remote.update(id, {
          'description': description.trim(),
          'is_active': isActive,
          // The list only carries the lead's name and id; the backend takes
          // a muid, so the lead is sent only when a new one was picked.
          if (leadMuid != null) 'lead': leadMuid,
        }) ??
        'Chapter updated',
  );

  @override
  Future<String> remove(String id) =>
      _guard(() async => await _remote.remove(id) ?? 'Chapter removed');

  @override
  Future<List<CampusMember>> searchMembers(String query) =>
      _guard(() async => parseMembers(await _remote.searchMembers(query)));

  @override
  Future<List<ChapterIgOption>> interestGroups() => _guard(
    () async => parseInterestGroups(await _remote.fetchInterestGroups()),
  );
}
