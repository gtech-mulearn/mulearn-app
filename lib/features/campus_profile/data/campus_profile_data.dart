import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/features/campus_profile/domain/entities/public_campus.dart';
import 'package:mulearn_app/features/campus_profile/domain/repositories/campus_profile_repository.dart';

/// The public campus endpoints (`api/dashboard/campus/urls.py`, the
/// catch-all `<org_id>` routes), as the dashboard's campus page calls them.
abstract final class CampusProfilePaths {
  const CampusProfilePaths._();

  static String detail(String id) => '/api/v1/dashboard/campus/$id/';
  static String weeklyKarma(String id) => '/api/v1/dashboard/campus/weekly-karma/$id/';
}

class CampusProfileRemoteDataSource {
  const CampusProfileRemoteDataSource(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> fetchCampus(String id) async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(CampusProfilePaths.detail(id)));

  Future<Map<String, dynamic>> fetchWeeklyKarma(String id) async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(CampusProfilePaths.weeklyKarma(id)));
}

/// Maps `CampusDetailsPublicSerializer` and the weekly-karma map, tolerating
/// missing pieces (a campus with no lead, no chapters, no links).
class CampusProfileRepositoryImpl implements CampusProfileRepository {
  const CampusProfileRepositoryImpl(this._remote);

  final CampusProfileRemoteDataSource _remote;

  static String? _str(Object? v) {
    if (v == null) return null;
    final s = '$v'.trim();
    return s.isEmpty ? null : s;
  }

  static int _int(Object? v) => v is num ? v.toInt() : int.tryParse('${v ?? ''}') ?? 0;

  static List<Map<String, dynamic>> _rows(Object? v) =>
      v is List ? v.whereType<Map<String, dynamic>>().toList() : const [];

  static PublicCampus parse(String id, Map<String, dynamic> json) {
    final lead = json['campus_lead'];
    final clusters = json['karma_by_cluster'];
    return PublicCampus(
      id: _str(json['org_id']) ?? id,
      name: _str(json['college_name']) ?? 'Campus',
      code: _str(json['campus_code']) ?? '',
      zone: _str(json['campus_zone']) ?? '',
      totalKarma: _int(json['total_karma']),
      members: _int(json['total_members']),
      activeMembers: _int(json['active_members']),
      rank: json['rank'] is num && (json['rank'] as num) > 0 ? (json['rank'] as num).toInt() : null,
      lead: lead is Map<String, dynamic> && _str(lead['muid']) != null
          ? CampusPerson(
              muid: _str(lead['muid'])!,
              fullName: _str(lead['full_name']) ?? _str(lead['muid'])!,
              profilePic: _str(lead['profile_pic']),
              role: _str(lead['role']),
            )
          : null,
      execom: [
        for (final m in _rows(json['execom']))
          if (_str(m['muid']) != null)
            CampusPerson(
              muid: _str(m['muid'])!,
              fullName: _str(m['full_name']) ?? _str(m['muid'])!,
              role: _str(m['role_title']),
            ),
      ],
      topLearners: [
        for (final r in _rows(json['top_10_campus_leaderboard']))
          if (_str(r['muid']) != null)
            CampusLeader(
              rank: _int(r['rank']),
              muid: _str(r['muid'])!,
              fullName: _str(r['full_name']) ?? _str(r['muid'])!,
              karma: _int(r['karma']),
              profilePic: _str(r['profile_pic']),
            ),
      ],
      chapters: [
        for (final ch in _rows(json['active_ig_chapters']))
          CampusChapter(
            name: _str(ch['ig_name']) ?? 'Interest group',
            code: _str(ch['ig_code']) ?? '',
            members: _int(ch['member_count']),
            leadName: ch['lead'] is Map ? _str((ch['lead'] as Map)['full_name']) : null,
          ),
      ],
      clusters: clusters is Map<String, dynamic>
          ? [
              for (final e in clusters.entries)
                if (e.value is Map)
                  CampusCluster(
                    cluster: e.key,
                    karma: _int((e.value as Map)['total_karma']),
                    members: _int((e.value as Map)['member_count']),
                  ),
            ]
          : const [],
      links: [
        for (final l in _rows(json['social_links']))
          if (_str(l['url']) != null) CampusLink(platform: _str(l['platform']) ?? 'Link', url: _str(l['url'])!),
      ],
    );
  }

  static List<CampusKarmaDay> parseWeekly(Map<String, dynamic> json) {
    final days = <CampusKarmaDay>[
      for (final e in json.entries)
        if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(e.key) && DateTime.tryParse(e.key) != null)
          (day: DateTime.parse(e.key), karma: _int(e.value)),
    ]..sort((a, b) => a.day.compareTo(b.day));
    return days;
  }

  Future<T> _guard<T>(Future<T> Function() body) async {
    try {
      return await body();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<PublicCampus> campus(String id) => _guard(() async => parse(id, await _remote.fetchCampus(id)));

  @override
  Future<List<CampusKarmaDay>> weeklyKarma(String id) =>
      _guard(() async => parseWeekly(await _remote.fetchWeeklyKarma(id)));
}
