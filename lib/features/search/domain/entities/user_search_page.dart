import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/search/domain/entities/user_search_result.dart';

part 'user_search_page.freezed.dart';

/// One page of search results, plus enough pagination metadata to know
/// whether more pages exist — pure-Dart domain entity (rules.md §2).
@freezed
abstract class UserSearchPage with _$UserSearchPage {
  const factory UserSearchPage({
    required List<UserSearchResult> results,
    required int pageIndex,
    required int totalPages,
  }) = _UserSearchPage;

  const UserSearchPage._();

  bool get hasMore => pageIndex < totalPages;
}
