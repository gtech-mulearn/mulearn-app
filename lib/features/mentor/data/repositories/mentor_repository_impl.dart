import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/network/tolerant_parse.dart';
import 'package:mulearn_app/features/mentor/data/datasources/mentor_remote_datasource.dart';
import 'package:mulearn_app/features/mentor/data/dtos/mentor_analytics_dto.dart';
import 'package:mulearn_app/features/mentor/data/dtos/mentor_profile_completion_dto.dart';
import 'package:mulearn_app/features/mentor/data/dtos/mentor_scope_dto.dart';
import 'package:mulearn_app/features/mentor/data/dtos/mentor_session_dto.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_analytics.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_profile_completion.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_scope.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_session.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';
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

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
