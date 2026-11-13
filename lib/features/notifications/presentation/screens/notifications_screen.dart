import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/config/flavor_config.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/notifications/unread_notifications.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/router/tab_navigation.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_empty_state.dart';
import 'package:mulearn_app/core/widgets/mu_load_more_footer.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/notifications/domain/entities/app_notification.dart';
import 'package:mulearn_app/features/notifications/domain/notification_target.dart';
import 'package:mulearn_app/features/notifications/presentation/providers/notifications_controller.dart';
import 'package:mulearn_app/features/notifications/presentation/widgets/notification_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';

/// Notification inbox (L16; DESIGN_SPEC.md §2 "14 — Notifications"), backed
/// by the v2 feed (`/api/v1/notification/`). Items are grouped Today /
/// Earlier; tapping marks one read and opens what it's about; swiping left
/// archives it.
///
/// Loads on open, pull-to-refresh and scroll-to-end only — nothing polls.
/// Opening the inbox also refreshes the unread badge once.
class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) unawaited(ref.read(unreadNotificationsProvider.notifier).refresh());
    });
  }

  void _toast(String message, MuToastType type) {
    if (mounted) MuToast.show(context, message: message, type: type);
  }

  Future<void> _refresh() async {
    final controller = ref.read(notificationsControllerProvider.notifier);
    final unread = ref.read(unreadNotificationsProvider.notifier);
    try {
      await Future.wait([controller.refresh(), unread.refresh()]);
    } on Object catch (e) {
      _toast(ApiException.messageFor(e), MuToastType.error);
    }
  }

  void _open(AppNotification notification) {
    final controller = ref.read(notificationsControllerProvider.notifier);
    unawaited(controller.markRead(notification.id).catchError((Object e) {
      _toast(ApiException.messageFor(e), MuToastType.error);
    }));
    final target = notificationTarget(
      notification,
      dashboardBase: Uri.parse(FlavorConfig.instance.dashboardUrl),
    );
    switch (target) {
      case AppRoute(:final location):
        if (RoutePaths.tabRoots.contains(location)) {
          context.openTab(location);
        } else {
          unawaited(context.push(location));
        }
      case WebPage(:final uri):
        unawaited(launchUrl(uri, mode: LaunchMode.externalApplication));
      case NoTarget():
        break;
    }
  }

  Future<void> _archive(AppNotification notification) async {
    try {
      await ref.read(notificationsControllerProvider.notifier).archive(notification.id);
      _toast('Notification archived', MuToastType.success);
    } on Object catch (e) {
      _toast(ApiException.messageFor(e), MuToastType.error);
    }
  }

  Future<void> _markAllRead() async {
    try {
      await ref.read(notificationsControllerProvider.notifier).markAllRead();
      _toast('All notifications marked as read', MuToastType.success);
    } on Object catch (e) {
      _toast(ApiException.messageFor(e), MuToastType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final notificationsState = ref.watch(notificationsControllerProvider);

    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(
        backgroundColor: MuColors.canvas,
        title: Text('Notifications', style: MuType.headline),
        actions: [
          TextButton(
            onPressed: _markAllRead,
            child: Text(
              'Mark all read',
              style: MuType.bodyMed.copyWith(color: MuColors.primary),
            ),
          ),
          const SizedBox(width: MuSpace.xs),
        ],
      ),
      body: SafeArea(
        child: notificationsState.when(
          skipError: true,
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ErrorRetryView(
            error: error,
            onRetry: () => ref.invalidate(notificationsControllerProvider),
          ),
          data: (paged) => RefreshIndicator(
            onRefresh: _refresh,
            child: paged.items.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: const [
                      SizedBox(height: MuSpace.xxl),
                      MuEmptyState(
                        icon: LucideIcons.bell,
                        title: "You're all caught up",
                        message: 'Notifications will show up here.',
                      ),
                    ],
                  )
                : NotificationListener<ScrollNotification>(
                    onNotification: (n) {
                      if (n.metrics.extentAfter < 400 && paged.hasMore && paged.loadMoreError == null) {
                        unawaited(ref.read(notificationsControllerProvider.notifier).loadMore());
                      }
                      return false;
                    },
                    child: _InboxList(
                      items: paged.items,
                      footer: paged.hasMore || paged.loadMoreError != null
                          ? MuLoadMoreFooter(
                              isLoading: paged.isLoadingMore,
                              error: paged.loadMoreError,
                              onRetry: () => ref.read(notificationsControllerProvider.notifier).loadMore(),
                            )
                          : null,
                      onOpen: _open,
                      onArchive: _archive,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

/// The feed as "Today" and "Earlier" sections (local dates), newest first.
class _InboxList extends StatelessWidget {
  const _InboxList({
    required this.items,
    required this.onOpen,
    required this.onArchive,
    this.footer,
  });

  final List<AppNotification> items;
  final Widget? footer;
  final ValueChanged<AppNotification> onOpen;
  final ValueChanged<AppNotification> onArchive;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    bool isToday(AppNotification n) {
      final local = n.createdAt.toLocal();
      return local.year == now.year && local.month == now.month && local.day == now.day;
    }

    final today = items.where(isToday).toList();
    final earlier = items.where((n) => !isToday(n)).toList();
    final rows = <Widget>[
      if (today.isNotEmpty) const _SectionLabel('Today'),
      for (final n in today) _row(n),
      if (earlier.isNotEmpty) const _SectionLabel('Earlier'),
      for (final n in earlier) _row(n),
      ?footer,
      const SizedBox(height: MuSpace.xl),
    ];
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: MuSpace.s),
      children: rows,
    );
  }

  Widget _row(AppNotification n) => Dismissible(
        key: ValueKey('notification-${n.id}'),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: MuSpace.xl),
          color: MuColors.hairline,
          child: const Icon(LucideIcons.archive, color: MuColors.inkSecondary),
        ),
        onDismissed: (_) => onArchive(n),
        child: Semantics(
          label: n.read ? null : 'Unread',
          child: NotificationListTile(notification: n, onTap: () => onOpen(n)),
        ),
      );
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.m, MuSpace.screenH, MuSpace.xs),
        child: Semantics(
          header: true,
          child: Text(text, style: MuType.caption.copyWith(color: MuColors.inkTertiary, fontWeight: FontWeight.w600)),
        ),
      );
}
