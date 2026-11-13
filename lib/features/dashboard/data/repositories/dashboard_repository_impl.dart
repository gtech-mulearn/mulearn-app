import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:mulearn_app/features/dashboard/data/dtos/featured_event_dto.dart';
import 'package:mulearn_app/features/dashboard/data/dtos/learner_summary_dto.dart';
import 'package:mulearn_app/features/dashboard/data/dtos/my_progress_summary_dto.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/featured_event.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/learner_summary.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/my_progress_summary.dart';
import 'package:mulearn_app/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  const DashboardRepositoryImpl(this._remote);

  final DashboardRemoteDataSource _remote;


  @override
  Future<List<FeaturedEvent>> getFeaturedEvents() => _guard(() async {
        final items = await _remote.fetchFeaturedEvents();
        return items
            .cast<Map<String, dynamic>>()
            .map((json) => FeaturedEventDto.fromJson(json).toDomain())
            .toList();
      });

  @override
  MyProgressSummary summaryFromPayload(Map<String, dynamic> payload) =>
      MyProgressSummaryDto.fromJson(payload).toDomain();

  @override
  Future<LearnerSummary> getLearnerSummary() =>
      _guard(() async => LearnerSummaryDto.fromJson(await _remote.fetchLearnerSummary()).toDomain());

  @override
  Future<int> getMentorUpcomingCount() => _guard(() async {
        final body = await _remote.fetchMentorOverview();
        var total = 0;
        for (final scope in body['scopes'] as List<dynamic>? ?? const []) {
          final metrics = (scope as Map<String, dynamic>)['metrics'] as Map<String, dynamic>?;
          total += (metrics?['upcoming_sessions'] as num?)?.toInt() ?? 0;
        }
        return total;
      });

  @override
  Future<({String code, String college, String? statLabel, num? statValue})> getCampusHeadline() => _guard(() async {
        final body = await _remote.fetchCampusSummary();
        final campus = body['campus'] as Map<String, dynamic>? ?? const {};
        final stats = body['stat_cards'] as List<dynamic>? ?? const [];
        final first = stats.isEmpty ? null : stats.first as Map<String, dynamic>;
        return (
          code: '${campus['campus_code'] ?? ''}',
          college: '${campus['college_name'] ?? ''}',
          statLabel: first?['label'] as String?,
          statValue: first?['value'] as num?,
        );
      });

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
