import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/network/tolerant_parse.dart';
import 'package:mulearn_app/features/mentor/data/datasources/mentor_remote_datasource.dart';
import 'package:mulearn_app/features/mentor/data/dtos/mentor_analytics_dto.dart';
import 'package:mulearn_app/features/mentor/data/dtos/mentor_profile_completion_dto.dart';
import 'package:mulearn_app/features/mentor/data/dtos/mentor_scope_dto.dart';
import 'package:mulearn_app/features/mentor/data/dtos/mentor_session_dto.dart';
import 'package:mulearn_app/features/mentor/data/dtos/session_participant_dto.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_analytics.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_profile_completion.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_scope.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_session.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_draft.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_participant.dart';
import 'package:mulearn_app/features/mentor/domain/repositories/mentor_repository.dart';

class MentorRepositoryImpl implements MentorRepository {
  const MentorRepositoryImpl(this._remote);

  final MentorRemoteDataSource _remote;

  @override
  Future<List<MentorScope>> getOverview() => _guard(() async {
        final body = await _remote.fetchOverview();
        return parseEachOrReport(
          body['scopes'] as List<dynamic>? ?? const [],
          (json) => MentorScopeDto.fromJson(json).toDomain(),
          what: 'MentorScopeDto',
        );
      });

  @override
  Future<MentorAnalytics> getAnalytics() =>
      _guard(() async => MentorAnalyticsDto.fromJson(await _remote.fetchAnalytics()).toDomain());

  @override
  Future<MentorProfileCompletion> getProfileCompletion() =>
      _guard(() async => MentorProfileCompletionDto.fromJson(await _remote.fetchProfileCompletion()).toDomain());

  @override
  Future<SessionPage> getSessions({
    required bool ascending,
    required int pageIndex,
    SessionStatus? status,
    int perPage = 20,
  }) =>
      _guard(() async {
        final body = await _remote.fetchSessions({
          ...PageIndexPaging.query(pageIndex, perPage: perPage),
          'sortBy': ascending ? 'starts_at' : '-starts_at',
          if (status != null && status != SessionStatus.unknown) 'status': status.wire,
        });
        final page = PageIndexPaging.parse(body['pagination'] as Map<String, dynamic>?);
        final items = parseEachOrReport(
          body['data'] as List<dynamic>? ?? const [],
          (json) => MentorSessionDto.fromJson(json).toDomain(),
          what: 'MentorSessionDto',
        );
        return (items: items, hasNext: page.hasNext, count: page.count);
      });

  @override
  Future<MentorSession> getSession(String id) =>
      _guard(() async => MentorSessionDto.fromJson(await _remote.fetchSession(id)).toDomain());

  @override
  Future<int> getStudentRequestCount() => _guard(() async {
        final body = await _remote.fetchStudentRequests(PageIndexPaging.query(1, perPage: 1));
        return PageIndexPaging.parse(body['pagination'] as Map<String, dynamic>?).count;
      });

  @override
  Future<String> createSession(SessionDraft draft) =>
      _guard(() async => _message(await _remote.createSession(draft.toCreateJson())));

  @override
  Future<String> updateSession(String id, SessionDraft draft) =>
      _guard(() async => _message(await _remote.updateSession(id, draft.toUpdateJson())));

  @override
  Future<String> deleteSession(String id) => _guard(() async => _message(await _remote.deleteSession(id)));

  @override
  Future<List<IgOption>> getMentorIgs() => _guard(() async {
        final rows = await _remote.fetchIgDropdown();
        return [
          for (final row in rows)
            if (row is Map && row['id'] is String) IgOption(id: row['id'] as String, name: '${row['name'] ?? ''}'),
        ];
      });

  @override
  Future<({List<SessionParticipant> items, bool hasNext, int count})> getParticipants(
    String sessionId, {
    required int pageIndex,
  }) =>
      _guard(() async {
        final body = await _remote.fetchParticipants(sessionId, PageIndexPaging.query(pageIndex, perPage: 50));
        final page = PageIndexPaging.parse(body['pagination'] as Map<String, dynamic>?);
        final items = parseEachOrReport(
          body['data'] as List<dynamic>? ?? const [],
          (json) => SessionParticipantDto.fromJson(json).toDomain(),
          what: 'SessionParticipantDto',
        );
        return (items: items, hasNext: page.hasNext, count: page.count);
      });

  @override
  Future<String> updateParticipant(
    String linkId, {
    AttendanceStatus? attendance,
    String? progressNote,
    int? contributedMinutes,
  }) =>
      _guard(() async => _message(await _remote.updateParticipant(linkId, {
            if (attendance != null) 'attendance_status': attendance.wire,
            if (contributedMinutes != null) 'contributed_minutes': contributedMinutes,
            if (progressNote != null) 'progress_note': progressNote,
          })));

  @override
  Future<String> addParticipant(String sessionId, {required String muid}) =>
      _guard(() async => _message(await _remote.addParticipant(sessionId, muid)));

  @override
  Future<String> completeSession(String id) => _guard(() async => _message(await _remote.completeSession(id)));

  /// Unwraps the envelope (throwing on `hasError`) and returns its message.
  String _message(Response<dynamic> response) => ApiEnvelope.unwrapMessage(response) ?? '';

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
