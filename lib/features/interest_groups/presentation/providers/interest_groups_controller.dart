import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/features/interest_groups/data/datasources/interest_groups_remote_datasource.dart';
import 'package:mulearn_app/features/interest_groups/data/repositories/interest_groups_repository_impl.dart';
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
    InterestGroupsRepositoryImpl(ref.watch(interestGroupsRemoteDataSourceProvider));

@riverpod
Future<List<InterestGroupSummary>> interestGroupsCatalog(Ref ref) =>
    ref.watch(interestGroupsRepositoryProvider).getCatalog();

@riverpod
Future<InterestGroupSummary> interestGroupDetail(Ref ref, String id) =>
    ref.watch(interestGroupsRepositoryProvider).getDetail(id);

@riverpod
Future<List<String>> myInterestGroupIds(Ref ref) =>
    ref.watch(interestGroupsRepositoryProvider).getMyGroupIds();

/// Joins or leaves a single group by replacing the user's full membership
/// set (the backend's `ig-edit` takes the complete list, not a delta) —
/// then invalidates [myInterestGroupIdsProvider] so every card reflects the
/// change.
@riverpod
class InterestGroupMembershipController
    extends _$InterestGroupMembershipController {
  @override
  Future<void> build() async {}

  Future<void> toggle(String groupId, {required bool join}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(interestGroupsRepositoryProvider);
      final currentIds = await repo.getMyGroupIds();
      final nextIds = join
          ? {...currentIds, groupId}.toList()
          : (currentIds.toList()..remove(groupId));
      await repo.setMyGroupIds(nextIds);
      ref.invalidate(myInterestGroupIdsProvider);
    });
  }
}
