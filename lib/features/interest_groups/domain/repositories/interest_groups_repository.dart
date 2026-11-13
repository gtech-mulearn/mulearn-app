import 'package:mulearn_app/features/interest_groups/domain/entities/ig_related.dart';
import 'package:mulearn_app/features/interest_groups/domain/entities/interest_group_summary.dart';

/// Contract for browsing the interest-group catalog and managing the
/// current user's own membership (rules.md §2 — presentation depends on
/// this abstraction, never the Dio datasource directly).
abstract interface class InterestGroupsRepository {
  /// Joins [id] (`POST ig/<id>/join/`); the backend caps learners at 3.
  Future<void> join(String id);

  /// Leaves [id] (`DELETE ig/<id>/leave/`).
  Future<void> leave(String id);

  Future<List<IgCircleRef>> getCirclesInGroup(String igId);

  Future<List<IgEventRef>> getEventsInGroup(String igId);

  Future<List<InterestGroupSummary>> getCatalog();

  Future<InterestGroupSummary> getDetail(String id);

  /// The joined group ids in the shared `user-profile` payload
  /// (`interest_groups`, already filtered to joined groups).
  List<String> groupIdsFromPayload(Map<String, dynamic> payload);

}
