import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
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
                    Badge(label: Text('$pendingCount')),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RoutePaths.createLearningCircle),
        child: const Icon(Icons.add),
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
          return const Center(child: Text('No circles yet.'));
        }
        final hasMore =
            ref.read(circlesListControllerProvider.notifier).hasMore;
        return RefreshIndicator(
          onRefresh: () async => ref.invalidate(circlesListControllerProvider),
          child: ListView.builder(
            controller: scrollController,
            itemCount: circles.length + (hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= circles.length) {
                return const Padding(
                  padding: EdgeInsets.all(16),
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
          return const Center(child: Text('No pending invites.'));
        }
        return RefreshIndicator(
          onRefresh: () async => ref.invalidate(myPendingCircleInvitesProvider),
          child: ListView.builder(
            itemCount: invites.length,
            itemBuilder: (context, index) => _InviteTile(
              invite: invites[index],
              isBusy: actionState.isLoading,
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          state.hasError
              ? ApiException.messageFor(state.error!)
              : (accept ? 'Invite accepted.' : 'Invite declined.'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.mail_outline),
      title: Text(invite.circleTitle ?? 'You were invited to a circle'),
      subtitle: invite.isLeadInvite ? const Text('Invited as lead') : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.green),
            onPressed: isBusy ? null : () => _respond(context, ref, accept: true),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed:
                isBusy ? null : () => _respond(context, ref, accept: false),
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
          return const Center(child: Text("You haven't joined any circles yet."));
        }
        return RefreshIndicator(
          onRefresh: () async => ref.invalidate(myCirclesProvider),
          child: ListView.builder(
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
