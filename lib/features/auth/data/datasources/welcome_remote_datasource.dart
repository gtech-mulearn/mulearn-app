import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';
import 'package:mulearn_app/features/auth/domain/entities/public_community.dart';

/// The public, no-sign-in endpoints the pre-login screens show.
class WelcomeRemoteDataSource {
  const WelcomeRemoteDataSource(this._dio);

  final Dio _dio;

  static int? _int(Object? v) => v is num ? v.toInt() : int.tryParse('$v');

  static int? _countWhere(Object? list, String key, String match, String countKey) {
    if (list is! List) return null;
    for (final row in list.whereType<Map<String, dynamic>>()) {
      if ('${row[key]}'.toLowerCase() == match) return _int(row[countKey]);
    }
    return null;
  }

  Future<PublicStats> fetchStats() async {
    final json = ApiEnvelope.unwrapObject(await _dio.get<dynamic>(ApiPaths.publicGlobalCount));
    return PublicStats(
      members: _int(json['members']),
      campuses: _countWhere(json['org_type_counts'], 'org_type', 'college', 'org_count'),
      companies: _countWhere(json['org_type_counts'], 'org_type', 'company', 'org_count'),
      mentors: _countWhere(json['enablers_mentors_count'], 'role__title', 'mentor', 'role_count'),
      interestGroups: _int(json['ig_count']),
      circles: _int(json['learning_circle_count']),
    );
  }

  Future<List<GuestEvent>> fetchFeaturedEvents() async {
    final json = ApiEnvelope.unwrapObject(await _dio.get<dynamic>(ApiPaths.publicFeaturedEvents));
    final data = json['data'];
    if (data is! List) return const [];
    return [
      for (final e in data.whereType<Map<String, dynamic>>())
        if (e['id'] is String && e['title'] is String)
          GuestEvent(
            id: e['id'] as String,
            title: e['title'] as String,
            start: DateTime.tryParse('${e['start_datetime']}')?.toLocal(),
            end: DateTime.tryParse('${e['end_datetime']}')?.toLocal(),
            place: _place(e['venue']),
            interested: _int(e['interest_count']) ?? 0,
            coverImage: e['cover_image'] as String?,
            type: e['event_type'] as String?,
          ),
    ];
  }

  static String _place(Object? venue) {
    if (venue is! Map<String, dynamic>) return 'Venue TBA';
    if (venue['venue_type'] == 'online') return 'Online';
    final city = venue['venue_city'];
    return city is String && city.isNotEmpty ? city : 'Venue TBA';
  }

  Future<List<GuestInterestGroup>> fetchInterestGroups() async {
    final json = ApiEnvelope.unwrapObject(await _dio.get<dynamic>(ApiPaths.publicInterestGroups));
    final list = json['interestGroups'];
    if (list is! List) return const [];
    return [
      for (final g in list.whereType<Map<String, dynamic>>())
        if (g['id'] is String && g['name'] is String)
          GuestInterestGroup(id: g['id'] as String, name: g['name'] as String),
    ];
  }
}
