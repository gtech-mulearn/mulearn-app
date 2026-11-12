import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/core/widgets/searchable_select_field.dart';
import 'package:mulearn_app/features/learning_circles/data/datasources/learning_circles_remote_datasource.dart';
import 'package:mulearn_app/features/learning_circles/data/repositories/learning_circles_repository_impl.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/circle_invite.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/circle_members.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/join_request.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/learning_circle.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/learning_circle_detail.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/received_circle_invite.dart';
import 'package:mulearn_app/features/learning_circles/domain/repositories/learning_circles_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'learning_circles_controller.g.dart';

@riverpod
LearningCirclesRemoteDataSource learningCirclesRemoteDataSource(Ref ref) =>
    LearningCirclesRemoteDataSource(ref.watch(dioProvider));

/// Presentation depends on the [LearningCirclesRepository] contract
/// (rules.md §2/§5).
@riverpod
LearningCirclesRepository learningCirclesRepository(Ref ref) =>
    LearningCirclesRepositoryImpl(ref.watch(learningCirclesRemoteDataSourceProvider));

@riverpod
Future<List<LearningCircle>> myCircles(Ref ref) =>
    ref.watch(learningCirclesRepositoryProvider).getMyCircles();

@riverpod
Future<LearningCircleDetail> circleDetail(Ref ref, String id) =>
    ref.watch(learningCirclesRepositoryProvider).getCircleDetail(id);

@riverpod
Future<CircleMembers> circleMembers(Ref ref, String id) =>
    ref.watch(learningCirclesRepositoryProvider).getCircleMembers(id);

@riverpod
Future<List<JoinRequest>> circleJoinRequests(Ref ref, String id) =>
    ref.watch(learningCirclesRepositoryProvider).getJoinRequests(id);

@riverpod
Future<List<CircleInvite>> circleSentInvites(Ref ref, String id) =>
    ref.watch(learningCirclesRepositoryProvider).getSentInvites(id);

@riverpod
Future<List<ReceivedCircleInvite>> myPendingCircleInvites(Ref ref) =>
    ref.watch(learningCirclesRepositoryProvider).getMyPendingInvites();

/// IG options for the create-circle picker — `{id, name}` only (rules.md
/// §2: fetched independently rather than importing the `interest_groups`
/// feature's richer catalog).
@riverpod
Future<List<SelectOption>> circleIgOptions(Ref ref) async {
  final items =
      await ref.watch(learningCirclesRemoteDataSourceProvider).fetchIgOptions();
  return items
      .cast<Map<String, dynamic>>()
      .map((json) => SelectOption(
            id: json['id'] as String,
            label: json['name'] as String,
          ))
      .toList();
}

/// Accumulates circle catalog pages across "load more". A failed page keeps
/// the circles already shown and records the error for an inline retry.
@riverpod
class CirclesListController extends _$CirclesListController {
  int _pageIndex = 1;
  Future<void>? _inFlight;

  @override
  Future<PagedState<LearningCircle>> build() async {
    _pageIndex = 1;
    _inFlight = null;
    final page =
        await ref.watch(learningCirclesRepositoryProvider).getCircles(pageIndex: 1);
    return PagedState(items: page.circles, hasMore: page.hasNext);
  }

  /// Loads the next page, or retries it after a failure. Calls made while a
  /// page is in flight (a scroll listener firing every frame, for example
  /// when "Circles near you" filters the list short) share that one request.
  Future<void> loadMore() =>
      _inFlight ??= _loadNextPage().whenComplete(() => _inFlight = null);

  Future<void> _loadNextPage() async {
    final current = state.value;
    if (current == null || !current.hasMore) return;
    state = AsyncData(current.copyWith(isLoadingMore: true, loadMoreError: null));
    final next = _pageIndex + 1;
    try {
      final page =
          await ref.read(learningCirclesRepositoryProvider).getCircles(pageIndex: next);
      if (!ref.mounted) return;
      _pageIndex = next;
      state = AsyncData(PagedState(
        items: mergeUniqueBy(current.items, page.circles, (c) => c.id),
        hasMore: page.hasNext,
      ));
    } on Object catch (e, st) {
      appLogger.w('Loading more circles failed', error: e, stackTrace: st);
      if (!ref.mounted) return;
      state = AsyncData(current.copyWith(isLoadingMore: false, loadMoreError: e));
    }
  }
}

/// Every mutating circle action (create/edit/delete/join/membership/
/// invites) — a single notifier so screens show one consistent busy/error
/// state, mirroring [InterestGroupMembershipController]'s pattern.
@riverpod
class CircleActionsController extends _$CircleActionsController {
  @override
  Future<void> build() async {}

  Future<String?> createCircle({
    required String igId,
    required String orgId,
    required String title,
    required String description,
  }) async {
    state = const AsyncLoading();
    String? circleId;
    state = await AsyncValue.guard(() async {
      circleId = await ref.read(learningCirclesRepositoryProvider).createCircle(
            igId: igId,
            orgId: orgId,
            title: title,
            description: description,
          );
    });
    return circleId;
  }

  Future<void> editCircle(
    String id, {
    String? igId,
    String? orgId,
    String? title,
    String? description,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(learningCirclesRepositoryProvider).editCircle(
            id,
            igId: igId,
            orgId: orgId,
            title: title,
            description: description,
          );
      ref.invalidate(circleDetailProvider(id));
    });
  }

  Future<bool> deleteCircle(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(learningCirclesRepositoryProvider).deleteCircle(id),
    );
    return !state.hasError;
  }

  Future<void> requestToJoin(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(learningCirclesRepositoryProvider).requestToJoin(id),
    );
  }


  Future<void> transferLead(String circleId, {required String muid}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(learningCirclesRepositoryProvider)
          .transferLead(circleId, muid: muid);
      ref
        ..invalidate(circleMembersProvider(circleId))
        ..invalidate(circleDetailProvider(circleId));
    });
  }

  Future<void> respondToJoinRequest(
    String circleId, {
    required String linkId,
    required bool accept,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(learningCirclesRepositoryProvider)
          .respondToJoinRequest(circleId, linkId: linkId, accept: accept);
      ref
        ..invalidate(circleJoinRequestsProvider(circleId))
        ..invalidate(circleMembersProvider(circleId));
    });
  }

  Future<void> sendInvite(String circleId, {required String muid}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(learningCirclesRepositoryProvider)
          .sendInvite(circleId, muid: muid);
      ref.invalidate(circleSentInvitesProvider(circleId));
    });
  }

  Future<void> respondToInvite(String linkId, {required bool accept}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(learningCirclesRepositoryProvider)
          .respondToInvite(linkId, accept: accept);
      ref
        ..invalidate(myPendingCircleInvitesProvider)
        ..invalidate(myCirclesProvider);
    });
  }
}
