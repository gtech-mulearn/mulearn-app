import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/features/mentor/data/dtos/mentor_session_dto.dart';
import 'package:mulearn_app/features/mentor/domain/entities/learner_sessions.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_session.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';
import 'package:mulearn_app/features/mentor/domain/repositories/learner_sessions_repository.dart';

/// The learner endpoints of `api/dashboard/mentor/urls.py` (§24
/// participation, §25 student requests).
abstract final class LearnerSessionPaths {
  const LearnerSessionPaths._();

  static const _base = '/api/v1/dashboard/mentor/session';
  static const String available = '$_base/available/';
  static const String history = '$_base/participant/history/';
  static const String myRequests = '$_base/student/my-requests/';
  static const String request = '$_base/student/request/';
  static String join(String id) => '$_base/participation/join/$id/';
  static String feedback(String id) => '$_base/participant/feedback/$id/';
}

/// A learner has a handful of these; one page of this size holds them.
const _perPage = 50;

class LearnerSessionsRemoteDataSource {
  const LearnerSessionsRemoteDataSource(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> _list(String path) async =>
      ApiEnvelope.unwrapObject(
        await _dio.get<dynamic>(
          path,
          queryParameters: PageIndexPaging.query(1, perPage: _perPage),
        ),
      );

  Future<Map<String, dynamic>> fetchAvailable() =>
      _list(LearnerSessionPaths.available);
  Future<Map<String, dynamic>> fetchHistory() =>
      _list(LearnerSessionPaths.history);
  Future<Map<String, dynamic>> fetchMyRequests() =>
      _list(LearnerSessionPaths.myRequests);

  Future<String?> join(String id) async => ApiEnvelope.unwrapMessage(
    await _dio.post<dynamic>(
      LearnerSessionPaths.join(id),
      data: const <String, Object>{},
    ),
  );

  Future<String?> request(Map<String, Object?> body) async =>
      ApiEnvelope.unwrapMessage(
        await _dio.post<dynamic>(LearnerSessionPaths.request, data: body),
      );

  Future<String?> feedback(String id, Map<String, Object?> body) async =>
      ApiEnvelope.unwrapMessage(
        await _dio.patch<dynamic>(LearnerSessionPaths.feedback(id), data: body),
      );
}

class LearnerSessionsRepositoryImpl implements LearnerSessionsRepository {
  const LearnerSessionsRepositoryImpl(this._remote);

  final LearnerSessionsRemoteDataSource _remote;

  static String? _str(Object? v) {
    if (v == null) return null;
    final s = '$v'.trim();
    return s.isEmpty ? null : s;
  }

  static DateTime? _time(Object? v) =>
      DateTime.tryParse(_str(v) ?? '')?.toUtc();

  static Iterable<Map<String, dynamic>> _rows(Map<String, dynamic> json) {
    final data = json['data'];
    return data is List ? data.whereType<Map<String, dynamic>>() : const [];
  }

  static List<AvailableSession> parseAvailable(Map<String, dynamic> json) => [
    for (final r in _rows(json))
      AvailableSession(
        session: MentorSessionDto.fromJson(r).toDomain(),
        mentorName: _str(r['created_by_name']) ?? 'A mentor',
      ),
  ]..sort((a, b) => a.session.startsAt.compareTo(b.session.startsAt));

  static SessionRecord? parseRecord(Map<String, dynamic> r) {
    final id = _str(r['session_id']);
    final starts = _time(r['session_starts_at']);
    final ends = _time(r['session_ends_at']);
    if (id == null || starts == null || ends == null) return null;
    return SessionRecord(
      session: MentorSession(
        id: id,
        entityId: _str(r['session_entity_id']) ?? '',
        entityName: _str(r['session_entity_name']) ?? '',
        type: SessionType.fromWire(_str(r['session_type'])),
        title: _str(r['session_title']) ?? 'Session',
        description: '',
        mode: SessionMode.fromWire(_str(r['session_mode'])),
        startsAt: starts,
        endsAt: ends,
        status: SessionStatus.fromWire(_str(r['session_status'])),
        isRecurring: false,
        meetingLink: _str(r['session_meeting_link']),
        venue: _str(r['session_venue']),
      ),
      attendance: LearnerAttendance.fromWire(_str(r['attendance_status'])),
      feedback: _str(r['feedback']),
    );
  }

  /// Newest first.
  static List<SessionRecord> parseHistory(Map<String, dynamic> json) =>
      [for (final r in _rows(json)) ?parseRecord(r)]
        ..sort((a, b) => b.session.startsAt.compareTo(a.session.startsAt));

  static List<MySessionRequest> parseRequests(Map<String, dynamic> json) => [
    for (final r in _rows(json))
      if (_str(r['id']) != null &&
          _time(r['starts_at']) != null &&
          _time(r['ends_at']) != null)
        MySessionRequest(
          id: _str(r['id'])!,
          title: _str(r['title']) ?? 'Session request',
          description: _str(r['description']) ?? '',
          groupName: _str(r['entity_name']) ?? '',
          mode: SessionMode.fromWire(_str(r['mode'])),
          startsAt: _time(r['starts_at'])!,
          endsAt: _time(r['ends_at'])!,
          status: SessionStatus.fromWire(_str(r['status'])),
          meetingLink: _str(r['meeting_link']),
          venue: _str(r['venue']),
        ),
  ];

  Future<T> _guard<T>(Future<T> Function() body) async {
    try {
      return await body();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<List<AvailableSession>> available() =>
      _guard(() async => parseAvailable(await _remote.fetchAvailable()));

  @override
  Future<List<SessionRecord>> history() =>
      _guard(() async => parseHistory(await _remote.fetchHistory()));

  @override
  Future<List<MySessionRequest>> myRequests() =>
      _guard(() async => parseRequests(await _remote.fetchMyRequests()));

  @override
  Future<String> join(String sessionId) => _guard(
    () async =>
        await _remote.join(sessionId) ??
        "You're in. It's on your sessions list.",
  );

  @override
  Future<String> request(SessionRequestDraft draft) => _guard(
    () async =>
        await _remote.request(draft.toJson()) ?? 'Request sent to the mentors.',
  );

  @override
  Future<String> feedback(String sessionId, {int? rating, String? text}) =>
      _guard(
        () async =>
            await _remote.feedback(sessionId, {
              if (rating != null) 'rating': rating,
              if ((text ?? '').trim().isNotEmpty) 'feedback': text!.trim(),
            }) ??
            'Thanks for the feedback.',
      );
}
