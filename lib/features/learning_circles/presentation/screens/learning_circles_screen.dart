import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_empty_state.dart';
import 'package:mulearn_app/core/widgets/mu_icon_button.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/circle_invite.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/learning_circles_controller.dart';
import 'package:mulearn_app/features/learning_circles/presentation/widgets/learning_circle_tile.dart';

/// Browse every circle or view the ones the current user belongs to —
/// mirrors the reference dashboard's learning-circle list page.
class LearningCirclesScreen extends ConsumerStatefulWidget {
  const LearningCirclesScreen({super.key});

  @override
  ConsumerState<LearningCirclesScreen> createState() =>
      _LearningCirclesScreenState();
}

class _LearningCirclesScreenState extends ConsumerState<LearningCirclesScreen>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 3, vsync: this);
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(circlesListControllerProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final invitesState = ref.watch(myPendingCircleInvitesProvider);
    final pendingCount = invitesState.value?.length ?? 0;

    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(
        title: const Text('Learning Circles'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            const Tab(text: 'Browse'),
            const Tab(text: 'My Circles'),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Invites'),
                  if (pendingCount > 0) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                      decoration: const BoxDecoration(
                        color: MuColors.coral,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$pendingCount',
                        style: MuType.chip.copyWith(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RoutePaths.createLearningCircle),
        backgroundColor: MuColors.primary,
        child: const Icon(LucideIcons.plus, color: Colors.white),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _BrowseTab(scrollController: _scrollController),
          const _MyCirclesTab(),
          const _MyInvitesTab(),
        ],
      ),
    );
  }
}

class _BrowseTab extends ConsumerWidget {
  const _BrowseTab({required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final circlesState = ref.watch(circlesListControllerProvider);

    return circlesState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => ErrorRetryView(
        error: error,
        onRetry: () => ref.invalidate(circlesListControllerProvider),
      ),
      data: (circles) {
        if (circles.isEmpty) {
          return const MuEmptyState(
            icon: LucideIcons.users,
            title: 'No circles yet',
            message: 'Check back soon — new learning circles show up here.',
          );
        }
        final hasMore =
            ref.read(circlesListControllerProvider.notifier).hasMore;
        return RefreshIndicator(
          onRefresh: () async => ref.invalidate(circlesListControllerProvider),
          child: ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(
              MuSpace.screenH,
              MuSpace.l,
              MuSpace.screenH,
              MuSpace.navClearance,
            ),
            itemCount: circles.length + (hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= circles.length) {
                return const Padding(
                  padding: EdgeInsets.all(MuSpace.l),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final circle = circles[index];
              return LearningCircleTile(
                circle: circle,
                onTap: () => context
                    .push(RoutePaths.learningCircleDetailPath(circle.id)),
              );
            },
          ),
        );
      },
    );
  }
}

class _MyInvitesTab extends ConsumerWidget {
  const _MyInvitesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invitesState = ref.watch(myPendingCircleInvitesProvider);
    final actionState = ref.watch(circleActionsControllerProvider);

    return invitesState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => ErrorRetryView(
        error: error,
        onRetry: () => ref.invalidate(myPendingCircleInvitesProvider),
      ),
      data: (invites) {
        if (invites.isEmpty) {
          return const MuEmptyState(
            icon: LucideIcons.mail,
            title: 'No pending invites',
            message: "You're all caught up.",
          );
        }
        return RefreshIndicator(
          onRefresh: () async => ref.invalidate(myPendingCircleInvitesProvider),
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(
              MuSpace.screenH,
              MuSpace.l,
              MuSpace.screenH,
              MuSpace.navClearance,
            ),
            itemCount: invites.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: MuSpace.m),
              child: _InviteTile(
                invite: invites[index],
                isBusy: actionState.isLoading,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _InviteTile extends ConsumerWidget {
  const _InviteTile({required this.invite, required this.isBusy});

  final CircleInvite invite;
  final bool isBusy;

  Future<void> _respond(
    BuildContext context,
    WidgetRef ref, {
    required bool accept,
  }) async {
    await ref
        .read(circleActionsControllerProvider.notifier)
        .respondToInvite(invite.linkId, accept: accept);
    if (!context.mounted) return;
    final state = ref.read(circleActionsControllerProvider);
    MuToast.show(
      context,
      message: state.hasError
          ? ApiException.messageFor(state.error!)
          : (accept ? 'Invite accepted.' : 'Invite declined.'),
      type: state.hasError ? MuToastType.error : MuToastType.success,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MuCard(
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: const BoxDecoration(
              color: MuColors.primaryTint,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(LucideIcons.mail, color: MuColors.primary, size: 20),
          ),
          const SizedBox(width: MuSpace.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invite.circleTitle ?? 'You were invited to a circle',
                  style: MuType.bodyMed,
                ),
                if (invite.isLeadInvite)
                  Text('Invited as lead', style: MuType.caption),
              ],
            ),
          ),
          MuIconButton(
            icon: LucideIcons.check,
            onPressed: isBusy ? null : () => _respond(context, ref, accept: true),
          ),
          const SizedBox(width: MuSpace.s),
          MuIconButton(
            icon: LucideIcons.x,
            onPressed: isBusy ? null : () => _respond(context, ref, accept: false),
          ),
        ],
      ),
    );
  }
}

class _MyCirclesTab extends ConsumerWidget {
  const _MyCirclesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myCirclesState = ref.watch(myCirclesProvider);

    return myCirclesState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => ErrorRetryView(
        error: error,
        onRetry: () => ref.invalidate(myCirclesProvider),
      ),
      data: (circles) {
        if (circles.isEmpty) {
          return const MuEmptyState(
            icon: LucideIcons.users,
            title: "You haven't joined any circles yet",
            message: 'Browse circles and request to join one to get started.',
          );
        }
        return RefreshIndicator(
          onRefresh: () async => ref.invalidate(myCirclesProvider),
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(
              MuSpace.screenH,
              MuSpace.l,
              MuSpace.screenH,
              MuSpace.navClearance,
            ),
            itemCount: circles.length,
            itemBuilder: (context, index) {
              final circle = circles[index];
              return LearningCircleTile(
                circle: circle,
                onTap: () => context
                    .push(RoutePaths.learningCircleDetailPath(circle.id)),
              );
            },
          ),
        );
      },
    );
  }
}
