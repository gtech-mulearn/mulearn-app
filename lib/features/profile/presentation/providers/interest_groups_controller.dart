import 'package:mulearn_app/features/profile/domain/entities/interest_group_list_item.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'interest_groups_controller.g.dart';

/// The full interest-group catalog for the group picker — distinct from the
/// user's own membership list embedded in [UserProfile].
@riverpod
Future<List<InterestGroupListItem>> interestGroupsList(Ref ref) =>
    ref.watch(profileRepositoryProvider).getInterestGroupsList();

/// Saves the user's chosen interest groups, then refreshes the main profile
/// so the sidebar reflects the change.
@riverpod
class InterestGroupsEditController extends _$InterestGroupsEditController {
  @override
  Future<void> build() async {}

  Future<void> save(List<String> groupIds) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(profileRepositoryProvider).updateInterestGroups(groupIds);
      ref.invalidate(profileControllerProvider);
    });
  }
}
