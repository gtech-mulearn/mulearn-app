import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/my_profile_payload.dart';
import 'package:mulearn_app/features/interest_groups/data/datasources/interest_groups_remote_datasource.dart';
import 'package:mulearn_app/features/interest_groups/data/repositories/interest_groups_repository_impl.dart';
import 'package:mulearn_app/features/interest_groups/domain/entities/ig_related.dart';
import 'package:mulearn_app/features/interest_groups/domain/entities/interest_group_summary.dart';
import 'package:mulearn_app/features/interest_groups/domain/repositories/interest_groups_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'interest_groups_controller.g.dart';

@riverpod
InterestGroupsRemoteDataSource interestGroupsRemoteDataSource(Ref ref) =>
    InterestGroupsRemoteDataSource(ref.watch(dioProvider));

/// Presentation depends on the [InterestGroupsRepository] contract
/// (rules.md §2/§5).
@riverpod
InterestGroupsRepository interestGroupsRepository(Ref ref) =>
    InterestGroupsRepositoryImpl(
      ref.watch(interestGroupsRemoteDataSourceProvider),
    );

@riverpod
Future<List<InterestGroupSummary>> interestGroupsCatalog(Ref ref) =>
    ref.watch(interestGroupsRepositoryProvider).getCatalog();

@riverpod
Future<InterestGroupSummary> interestGroupDetail(Ref ref, String id) =>
    ref.watch(interestGroupsRepositoryProvider).getDetail(id);

@Riverpod(retry: noRetry)
Future<List<String>> myInterestGroupIds(Ref ref) async {
  final repository = ref.watch(interestGroupsRepositoryProvider);
  return repository.groupIdsFromPayload(
    await ref.watch(myProfilePayloadProvider.future),
  );
}

/// The most interest groups a learner can be in (dash_ig_view.py:1275).
const int maxLearnerGroups = 3;

/// The first circles in a group, and how many it has, for its page.
@Riverpod(retry: noRetry)
Future<IgPreview<IgCircleRef>> circlesInGroup(Ref ref, String igId) =>
    ref.watch(interestGroupsRepositoryProvider).getCirclesInGroup(igId);

/// The first events scoped to a group, and how many, for its page.
@Riverpod(retry: noRetry)
Future<IgPreview<IgEventRef>> eventsInGroup(Ref ref, String igId) =>
    ref.watch(interestGroupsRepositoryProvider).getEventsInGroup(igId);

/// Joins or leaves one group through its own endpoints (FEAT-08) — no
/// full-list rewrite, so a group joined elsewhere can't be dropped — then
/// refreshes the shared profile so every card (and Profile) shows it.
///
/// Stays loading until the refreshed profile has landed and the member ids
/// are rebuilt from it. Settling earlier left a window (as long as the slow
/// `user-profile` request) where the old ids still said "not a member" and
/// the button read Join again right after joining.
@riverpod
class InterestGroupMembershipController
    extends _$InterestGroupMembershipController {
  @override
  Future<void> build() async {}

  Future<void> toggle(String groupId, {required bool join}) async {
    final repo = ref.read(interestGroupsRepositoryProvider);
    final link = ref.keepAlive(); // finish the refresh even if the page closes
    state = const AsyncLoading();
    try {
      final result = await AsyncValue.guard(
        () => join ? repo.join(groupId) : repo.leave(groupId),
      );
      if (!result.hasError) {
        ref
          ..invalidate(myProfilePayloadProvider)
          ..invalidate(interestGroupDetailProvider(groupId)); // member count
        try {
          await ref.read(myInterestGroupIdsProvider.future);
        } on Object catch (_) {
          // The change is saved; a failed refresh shows on the screens that
          // read the profile, with their own Retry.
        }
      }
      if (ref.mounted) state = result;
    } finally {
      link.close();
    }
  }
}
