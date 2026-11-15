import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/features/weekly_twitches/domain/entities/twitch.dart';
import 'package:mulearn_app/features/weekly_twitches/domain/repositories/weekly_twitches_repository.dart';

/// `api/dashboard/media_content/urls.py`: a list and a detail per show, open
/// to any signed-in member.
abstract final class WeeklyTwitchesPaths {
  const WeeklyTwitchesPaths._();

  static String list(TwitchShow show) => '/api/v1/dashboard/media-content/${show.slug}/';
  static String detail(TwitchShow show, String id) => '/api/v1/dashboard/media-content/${show.slug}/$id/';
}

class WeeklyTwitchesRemoteDataSource {
  const WeeklyTwitchesRemoteDataSource(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> fetchList(TwitchShow show, Map<String, Object> query) async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(WeeklyTwitchesPaths.list(show), queryParameters: query));

  Future<Map<String, dynamic>> fetchDetail(TwitchShow show, String id) async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(WeeklyTwitchesPaths.detail(show, id)));
}

/// Maps the four read serializers (`OfficeHoursReadSerializer`, …) to
/// [TwitchEpisode]s.
class WeeklyTwitchesRepositoryImpl implements WeeklyTwitchesRepository {
  const WeeklyTwitchesRepositoryImpl(this._remote);

  final WeeklyTwitchesRemoteDataSource _remote;

  static String? _str(Object? v) {
    if (v == null) return null;
    final s = '$v'.trim();
    return s.isEmpty ? null : s;
  }

  /// `YYYY-MM-DD`, or the `DD/MM/YYYY` Office Hours are written with.
  static DateTime? parseDate(Object? v) {
    final s = _str(v);
    if (s == null) return null;
    final iso = DateTime.tryParse(s);
    if (iso != null) return DateTime(iso.year, iso.month, iso.day);
    final m = RegExp(r'^(\d{1,2})/(\d{1,2})/(\d{4})$').firstMatch(s);
    if (m == null) return null;
    return DateTime(int.parse(m.group(3)!), int.parse(m.group(2)!), int.parse(m.group(1)!));
  }

  /// `HH:mm[:ss]`.
  static ({int hour, int minute})? parseTime(Object? v) {
    final m = RegExp(r'^(\d{1,2}):(\d{2})').firstMatch(_str(v) ?? '');
    if (m == null) return null;
    final hour = int.parse(m.group(1)!);
    final minute = int.parse(m.group(2)!);
    return hour < 24 && minute < 60 ? (hour: hour, minute: minute) : null;
  }

  static String? _zone(Object? v) => switch (_str(v)?.toUpperCase()) {
    'NORTH' => 'North',
    'CENTRAL' => 'Central',
    'SOUTH' => 'South',
    _ => null,
  };

  static TwitchEpisode? parse(TwitchShow show, Map<String, dynamic> json) {
    final id = _str(json['id']);
    final date = parseDate(json['date']);
    if (id == null || date == null) return null;
    final igs = json['interest_groups'];
    return TwitchEpisode(
      id: id,
      show: show,
      title: _str(json['title']) ?? _str(json['topic']) ?? show.label,
      date: date,
      time: parseTime(json['time']),
      status: TwitchStatus.parse(json['status']),
      performer: _str(json['performer']),
      designation: _str(json['designation']),
      campus: _str(json['campus']),
      zone: _zone(json['zone']),
      description: _str(json['description']),
      link: _str(json['link']),
      posterUrl: _str(json['poster_thumbnail']),
      interestGroups: igs is List ? [for (final g in igs) ?_str(g)] : const [],
    );
  }

  static TwitchPage parsePage(TwitchShow show, Map<String, dynamic> json) {
    final data = json['data'];
    final rows = data is List ? data.whereType<Map<String, dynamic>>() : const <Map<String, dynamic>>[];
    return (
      items: [for (final r in rows) ?parse(show, r)],
      hasNext: PageIndexPaging.parse(json['pagination'] as Map<String, dynamic>?).hasNext,
    );
  }

  Future<T> _guard<T>(Future<T> Function() body) async {
    try {
      return await body();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<TwitchPage> episodes(
    TwitchShow show, {
    Set<TwitchStatus> statuses = const {},
    int pageIndex = 1,
    int perPage = PageIndexPaging.defaultPerPage,
  }) => _guard(() async {
    final query = {
      ...PageIndexPaging.query(pageIndex, perPage: perPage),
      // The list accepts comma-separated statuses (`_filter_by_status`).
      if (statuses.isNotEmpty) 'status': statuses.map((s) => s.name).join(','),
    };
    return parsePage(show, await _remote.fetchList(show, query));
  });

  @override
  Future<TwitchEpisode> episode(TwitchShow show, String id) => _guard(() async {
    final episode = parse(show, await _remote.fetchDetail(show, id));
    if (episode == null) throw const ApiException(message: "This episode couldn't be read.");
    return episode;
  });
}
