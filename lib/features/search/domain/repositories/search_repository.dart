import 'package:mulearn_app/features/search/domain/entities/user_search_page.dart';

/// Search repository contract (rules.md §2/§5). Throws [ApiException] on
/// failure.
abstract interface class SearchRepository {
  /// `GET /api/v1/dashboard/user/search/?search=&role=&pageIndex=&perPage=`.
  /// [role] is `'mentor'` to search mentors only, `null` for all users
  /// (confirmed live: the same endpoint, filtered server-side by `role`).
  Future<UserSearchPage> searchUsers({
    required String query,
    String? role,
    int pageIndex = 1,
    int perPage = 30,
  });
}
