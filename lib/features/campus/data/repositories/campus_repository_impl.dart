import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/network/tolerant_parse.dart';
import 'package:mulearn_app/features/campus/data/datasources/campus_remote_datasource.dart';
import 'package:mulearn_app/features/campus/data/dtos/campus_dtos.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_groups.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_summary.dart';
import 'package:mulearn_app/features/campus/domain/entities/student_activity.dart';
import 'package:mulearn_app/features/campus/domain/repositories/campus_repository.dart';

class CampusRepositoryImpl implements CampusRepository {
  const CampusRepositoryImpl(this._remote);

  final CampusRemoteDataSource _remote;

  @override
  Future<CampusSummary> getSummary() => _guard(() async => parseCampusSummary(await _remote.fetchSummary()));

  @override
  Future<List<KarmaDay>> getWeeklyKarma() => _guard(() async => parseWeeklyKarma(await _remote.fetchWeeklyKarma()));

  @override
  Future<StudentPage> getStudents({
    required int pageIndex,
    String search = '',
    String sortBy = '-karma',
    bool? alumni,
    int perPage = 20,
  }) =>
      _guard(() async {
        final body = await _remote.fetchStudents({
          ...PageIndexPaging.query(pageIndex, perPage: perPage),
          'sortBy': sortBy,
          if (search.trim().isNotEmpty) 'search': search.trim(),
          if (alumni != null) 'is_alumni': alumni ? 'true' : 'false',
        });
        final page = PageIndexPaging.parse(body['pagination'] as Map<String, dynamic>?);
        final items = parseEachOrReport(
          body['data'] as List<dynamic>? ?? const [],
          (json) => CampusStudentDto.fromJson(json).toDomain(),
          what: 'CampusStudentDto',
        );
        return (items: items, hasNext: page.hasNext, count: page.count);
      });

  Map<String, Object> _listQuery(int pageIndex, String search) => {
        ...PageIndexPaging.query(pageIndex),
        'sortBy': '-member_count',
        if (search.trim().isNotEmpty) 'search': search.trim(),
      };

  @override
  Future<({List<CampusCircle> items, bool hasNext})> getCircles({required int pageIndex, String search = ''}) =>
      _guard(() async {
        final body = await _remote.fetchCircles(_listQuery(pageIndex, search));
        final items = parseEachOrReport(
          body['data'] as List<dynamic>? ?? const [],
          (json) => CampusCircleDto.fromJson(json).toDomain(),
          what: 'CampusCircleDto',
        );
        return (items: items, hasNext: PageIndexPaging.parse(body['pagination'] as Map<String, dynamic>?).hasNext);
      });

  @override
  Future<({List<CampusIg> items, bool hasNext})> getIgs({required int pageIndex, String search = ''}) =>
      _guard(() async {
        final body = await _remote.fetchIgs(_listQuery(pageIndex, search));
        final items = parseEachOrReport(
          body['data'] as List<dynamic>? ?? const [],
          (json) => CampusIgDto.fromJson(json).toDomain(),
          what: 'CampusIgDto',
        );
        return (items: items, hasNext: PageIndexPaging.parse(body['pagination'] as Map<String, dynamic>?).hasNext);
      });

  @override
  Future<({List<StudentActivity> items, bool hasNext})> getStudentActivity(String muid, {required int pageIndex}) =>
      _guard(() async {
        final body = await _remote.fetchStudentActivity(muid, PageIndexPaging.query(pageIndex));
        final items = parseEachOrReport(
          body['data'] as List<dynamic>? ?? const [],
          (json) => StudentActivityDto.fromJson(json).toDomain(),
          what: 'StudentActivityDto',
        );
        return (items: items, hasNext: PageIndexPaging.parse(body['pagination'] as Map<String, dynamic>?).hasNext);
      });

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
