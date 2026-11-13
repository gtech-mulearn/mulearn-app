import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/features/interest_groups/data/datasources/interest_groups_remote_datasource.dart';
import 'package:mulearn_app/features/interest_groups/data/dtos/interest_group_summary_dto.dart';
import 'package:mulearn_app/features/interest_groups/domain/entities/ig_related.dart';
import 'package:mulearn_app/features/interest_groups/domain/entities/interest_group_summary.dart';
import 'package:mulearn_app/features/interest_groups/domain/repositories/interest_groups_repository.dart';

class InterestGroupsRepositoryImpl implements InterestGroupsRepository {
  const InterestGroupsRepositoryImpl(this._remote);

  final InterestGroupsRemoteDataSource _remote;

  @override
  Future<List<InterestGroupSummary>> getCatalog() => _guard(() async {
        final items = await _remote.fetchCatalog();
        final results = <InterestGroupSummary>[];
        for (final item in items) {
          try {
            results.add(InterestGroupSummaryDto.fromJson(
              item as Map<String, dynamic>,
            ).toDomain());
          } on Object catch (e, st) {
            // One malformed catalog row (confirmed live, rules.md §3/§9:
            // `prerequisites` sent as a bare string on at least one record)
            // shouldn't take down the whole directory — skip and log it.
            appLogger.e(
              'Skipping malformed interest-group catalog row',
              error: e,
              stackTrace: st,
            );
          }
        }
        return results;
      });

  @override
  Future<InterestGroupSummary> getDetail(String id) => _guard(() async {
        final json = await _remote.fetchDetail(id);
        return InterestGroupSummaryDto.fromJson(json).toDomain();
      });

  @override
  List<String> groupIdsFromPayload(Map<String, dynamic> payload) =>
      (payload['interest_groups'] as List<dynamic>? ?? const [])
          .cast<Map<String, dynamic>>()
          .map((g) => g['id'] as String)
          .toList();

  @override
  Future<void> join(String id) => _guard(() => _remote.join(id));

  @override
  Future<void> leave(String id) => _guard(() => _remote.leave(id));

  @override
  Future<List<IgCircleRef>> getCirclesInGroup(String igId) => _guard(() async => [
        for (final c in (await _remote.fetchCirclesInGroup(igId)).whereType<Map<String, dynamic>>())
          if (c['id'] is String)
            IgCircleRef(
              id: c['id'] as String,
              title: c['title'] as String? ?? '',
              totalMembers: (c['total_members'] as num?)?.toInt(),
            ),
      ]);

  @override
  Future<List<IgEventRef>> getEventsInGroup(String igId) => _guard(() async => [
        for (final e in (await _remote.fetchEventsInGroup(igId)).whereType<Map<String, dynamic>>())
          if (e['id'] is String)
            IgEventRef(
              id: e['id'] as String,
              title: e['title'] as String? ?? '',
              startsAt: DateTime.tryParse(e['start_datetime'] as String? ?? '')?.toUtc(),
            ),
      ]);


  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } on Object catch (e, st) {
      // Riverpod's generated FutureProviders swallow thrown errors straight
      // into AsyncError without printing them anywhere, so a parsing bug
      // here would otherwise be invisible in the console — log it before
      // rethrowing so it still shows up in `flutter run`'s output.
      appLogger.e('InterestGroupsRepository action failed', error: e, stackTrace: st);
      rethrow;
    }
  }
}
