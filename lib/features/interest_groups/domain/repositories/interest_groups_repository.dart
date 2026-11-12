import 'package:mulearn_app/features/interest_groups/domain/entities/interest_group_summary.dart';

/// Contract for browsing the interest-group catalog and managing the
/// current user's own membership (rules.md §2 — presentation depends on
/// this abstraction, never the Dio datasource directly).
abstract interface class InterestGroupsRepository {
  Future<List<InterestGroupSummary>> getCatalog();

  Future<InterestGroupSummary> getDetail(String id);

  /// The joined group ids in the shared `user-profile` payload
  /// (`interest_groups`, already filtered to joined groups).
  List<String> groupIdsFromPayload(Map<String, dynamic> payload);

  /// Replaces the user's full set of joined groups — the backend's
  /// `ig-edit` endpoint takes the complete list, not a single add/remove.
  Future<void> setMyGroupIds(List<String> groupIds);
}
