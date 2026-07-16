import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:mulearn_app/features/dashboard/data/dtos/featured_event_dto.dart';
import 'package:mulearn_app/features/dashboard/data/dtos/karma_feed_dto.dart';
import 'package:mulearn_app/features/dashboard/data/dtos/my_progress_summary_dto.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/featured_event.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/karma_feed.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/my_progress_summary.dart';
import 'package:mulearn_app/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  const DashboardRepositoryImpl(this._remote);

  final DashboardRemoteDataSource _remote;

  @override
  Future<KarmaFeed> getKarmaFeed() => _guard(() async {
        final json = await _remote.fetchKarmaFeed();
        return KarmaFeedDto.fromJson(json).toDomain();
      });

  @override
  Future<List<FeaturedEvent>> getFeaturedEvents() => _guard(() async {
        final items = await _remote.fetchFeaturedEvents();
        return items
            .cast<Map<String, dynamic>>()
            .map((json) => FeaturedEventDto.fromJson(json).toDomain())
            .toList();
      });

  @override
  Future<MyProgressSummary> getMyProgressSummary() => _guard(() async {
        final json = await _remote.fetchMyProgressSummary();
        return MyProgressSummaryDto.fromJson(json).toDomain();
      });

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
