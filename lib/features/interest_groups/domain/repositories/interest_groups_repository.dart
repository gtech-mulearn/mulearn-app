import 'package:mulearn_app/features/interest_groups/domain/entities/interest_group_summary.dart';

/// Contract for browsing the interest-group catalog and managing the
/// current user's own membership (rules.md §2 — presentation depends on
/// this abstraction, never the Dio datasource directly).
abstract interface class InterestGroupsRepository {
  Future<List<InterestGroupSummary>> getCatalog();

  Future<InterestGroupSummary> getDetail(String id);

  /// The current user's joined group ids — sourced from their own profile
  /// (`GET .../profile/user-profile/`), fetched independently of the
  /// `profile` feature (rules.md §2: features never import each other) by
  /// calling the same shared endpoint with a minimal projection.
  Future<List<String>> getMyGroupIds();

  /// Replaces the user's full set of joined groups — the backend's
  /// `ig-edit` endpoint takes the complete list, not a single add/remove.
  Future<void> setMyGroupIds(List<String> groupIds);
}
