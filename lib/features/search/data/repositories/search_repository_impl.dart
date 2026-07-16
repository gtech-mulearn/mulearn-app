import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/features/search/data/datasources/search_remote_datasource.dart';
import 'package:mulearn_app/features/search/data/dtos/user_search_result_dto.dart';
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
}
