import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_search_result.freezed.dart';

/// A single user found via search — pure-Dart domain entity (rules.md §2).
/// Confirmed against a real `GET /api/v1/dashboard/user/search/` response
/// (rules.md §3/§9).
@freezed
abstract class UserSearchResult with _$UserSearchResult {
  const factory UserSearchResult({
    required String id,
    required String muid,
    required String fullName,
    required int karma,
    String? profilePicUrl,
    String? organization,
    @Default([]) List<String> interestGroupNames,
  }) = _UserSearchResult;
}
