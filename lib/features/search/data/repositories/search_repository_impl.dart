import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/features/search/data/datasources/search_remote_datasource.dart';
import 'package:mulearn_app/features/search/data/dtos/user_search_result_dto.dart';
import 'package:mulearn_app/features/search/domain/entities/campus_search_result.dart';
import 'package:mulearn_app/features/search/domain/entities/user_search_page.dart';
import 'package:mulearn_app/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  const SearchRepositoryImpl(this._remote);

  final SearchRemoteDataSource _remote;

  @override
  Future<UserSearchPage> searchUsers({
    required String query,
    String? role,
    int pageIndex = 1,
    int perPage = 30,
  }) async {
    try {
      final json = await _remote.searchUsers(
        query: query,
        role: role,
        pageIndex: pageIndex,
        perPage: perPage,
      );
      final results = (json['data'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map((item) => UserSearchResultDto.fromJson(item).toDomain())
          .toList();
      final pagination = json['pagination'] as Map<String, dynamic>;
      return UserSearchPage(
        results: results,
        pageIndex: pageIndex,
        totalPages: pagination['totalPages'] as int? ?? pageIndex,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  static int _int(Object? v) =>
      v is num ? v.toInt() : int.tryParse('${v ?? ''}') ?? 0;

  static String? _str(Object? v) {
    final s = v == null ? '' : '$v'.trim();
    return s.isEmpty ? null : s;
  }

  static CampusSearchResult campusFromJson(
    Map<String, dynamic> j, {
    required bool isSchool,
  }) => CampusSearchResult(
    id: '${j['id']}',
    title: _str(j['title']) ?? 'Campus',
    code: _str(j['code']) ?? '',
    learners: _int(j['user_count']),
    karma: _int(j['total_karma']),
    isSchool: isSchool,
    district: _str(j['district']),
    zone: _str(j['zone']),
    state: _str(j['state']),
  );

  @override
  Future<CampusSearchPage> searchCampuses({
    required String query,
    int pageIndex = 1,
    int perPage = 20,
  }) async {
    ApiException? lastError;
    Future<(List<CampusSearchResult>, bool)?> one(String type) async {
      try {
        final json = await _remote.searchCampuses(
          type: type,
          query: query,
          pageIndex: pageIndex,
          perPage: perPage,
        );
        final rows = (json['data'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>();
        final info = PageIndexPaging.parse(
          json['pagination'] as Map<String, dynamic>?,
        );
        return (
          [for (final r in rows) campusFromJson(r, isSchool: type == 'school')],
          info.hasNext,
        );
      } on DioException catch (e) {
        // Remember the failure; only fail the search if both kinds fail.
        lastError = ApiException.fromDioException(e);
        return null;
      }
    }

    final results = await Future.wait([one('college'), one('school')]);
    if (results.every((r) => r == null)) {
      throw lastError ?? const ApiException(message: 'Search failed.');
    }
    return CampusSearchPage(
      results: [for (final r in results) ...?r?.$1],
      hasMore: results.any((r) => r?.$2 ?? false),
    );
  }
}
