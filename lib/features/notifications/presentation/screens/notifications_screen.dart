import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/config/flavor_config.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/notifications/unread_notifications.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/router/tab_navigation.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_paged_list.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/notifications/domain/entities/app_notification.dart';
import 'package:mulearn_app/features/notifications/domain/notification_target.dart';
import 'package:mulearn_app/features/notifications/presentation/providers/notifications_controller.dart';
import 'package:url_launcher/url_launcher.dart';

enum _Filter { all, invites, karma }

/// Notifications (artifact Screen patterns → Notifications), backed by the
/// v2 feed (`/api/v1/notification/`): a title with Mark all read, All /
/// Invites / Karma, then FeedRows on cards grouped Today / Earlier. Tapping
/// marks one read and opens what it's about; swiping left archives it.
///
/// Loads on open, pull-to-refresh and scroll-to-end only; nothing polls.
/// Opening the inbox also refreshes the unread badge once.
class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  _Filter _filter = _Filter.all;

  bool _matches(AppNotification n) => switch (_filter) {
    _Filter.all => true,
    _Filter.invites => (n.type ?? '').toUpperCase().contains('INVITE'),
    _Filter.karma => n.category == 'KARMA',
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        unawaited(ref.read(unreadNotificationsProvider.notifier).refresh());
      }
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
    unawaited(
      controller.markRead(notification.id).catchError((Object e) {
        _toast(ApiException.messageFor(e), MuToastType.error);
      }),
    );
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
      await ref
          .read(notificationsControllerProvider.notifier)
          .archive(notification.id);
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
    final mu = context.mu;
    final c = mu.colors;
    final notificationsState = ref.watch(notificationsControllerProvider);

    return Scaffold(
      backgroundColor: c.chalk,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space3,
                MuSpacing.space2,
                MuSpacing.space3,
                0,
              ),
              child: Row(
                children: [
                  MuIconButton(
                    icon: LucideIcons.arrowLeft,
                    tooltip: 'Back',
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                  const SizedBox(width: MuSpacing.space1),
                  Expanded(
                    child: Semantics(
                      header: true,
                      child: Text('Notifications', style: mu.text.title1),
                    ),
                  ),
                  MuButton(
                    label: 'Mark all read',
                    variant: MuButtonVariant.ghost,
                    size: MuButtonSize.small,
                    onPressed: _markAllRead,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space5,
                MuSpacing.space3,
                MuSpacing.space5,
                0,
              ),
              child: MuSegmented<_Filter>(
                values: _Filter.values,
                selected: _filter,
                label: (f) => switch (f) {
                  _Filter.all => 'All',
                  _Filter.invites => 'Invites',
                  _Filter.karma => 'Karma',
                },
                onChanged: (f) => setState(() => _filter = f),
              ),
            ),
            Expanded(
              child: notificationsState.when(
                skipError: true,
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => ErrorRetryView(
                  error: error,
                  onRetry: () =>
                      ref.invalidate(notificationsControllerProvider),
                ),
                data: (paged) {
                  final items = paged.items.where(_matches).toList();
                  return RefreshIndicator(
                    color: c.cobalt,
                    onRefresh: _refresh,
                    child: items.isEmpty
                        ? ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              // The dashboard's notification list says "No notifications".
                              if (_filter == _Filter.all)
                                const MuStateDisplay(
                                  variant: MuStateVariant.noResults,
                                  title: 'No notifications',
                                  description:
                                      'Notifications will show up here.',
                                )
                              else
                                Padding(
                                  padding: const EdgeInsets.all(
                                    MuSpacing.space8,
                                  ),
                                  child: Text(
                                    _filter == _Filter.invites
                                        ? 'No invites right now.'
                                        : 'No karma news yet.',
                                    textAlign: TextAlign.center,
                                    style: mu.text.body.copyWith(color: c.ink3),
                                  ),
                                ),
                            ],
                          )
                        : _InboxList(
                            paged: paged.copyWith(items: items),
                            onLoadMore: () => ref
                                .read(notificationsControllerProvider.notifier)
                                .loadMore(),
                            onOpen: _open,
                            onArchive: _archive,
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The feed as "Today" and "Earlier" groups (local dates), newest first,
/// each a card of FeedRows, built row by row: "Earlier" runs to thousands
/// and carries the paging.
class _InboxList extends StatelessWidget {
  const _InboxList({
    required this.paged,
    required this.onLoadMore,
    required this.onOpen,
    required this.onArchive,
  });

  final PagedState<AppNotification> paged;
  final Future<void> Function() onLoadMore;
  final ValueChanged<AppNotification> onOpen;
  final ValueChanged<AppNotification> onArchive;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    bool isToday(AppNotification n) {
      final local = n.createdAt.toLocal();
      return local.year == now.year &&
          local.month == now.month &&
          local.day == now.day;
    }

    final today = paged.items.where(isToday).toList();
    final earlier = paged.items.where((n) => !isToday(n)).toList();

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            MuSpacing.space5,
            MuSpacing.space2,
            MuSpacing.space5,
            MuSpacing.space8,
          ),
          sliver: SliverMainAxisGroup(
            slivers: [
              if (today.isNotEmpty) ...[
                const SliverToBoxAdapter(child: _SectionLabel('Today')),
                SliverList.builder(
                  itemCount: today.length,
                  itemBuilder: (context, i) => MuFeedGroupSlice(
                    first: i == 0,
                    last: i == today.length - 1,
                    child: _row(
                      context,
                      today[i],
                      now,
                      last: i == today.length - 1,
                    ),
                  ),
                ),
              ],
              if (earlier.isNotEmpty)
                const SliverToBoxAdapter(child: _SectionLabel('Earlier')),
              MuPagedSliverList<AppNotification>(
                state: paged.copyWith(items: earlier),
                grouped: true,
                onLoadMore: onLoadMore,
                itemBuilder: (context, n, i) =>
                    _row(context, n, now, last: i == earlier.length - 1),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static (IconData, MuFeedTone) _look(AppNotification n) =>
      switch (n.category) {
        'KARMA' => (LucideIcons.zap, MuFeedTone.karma),
        'EVENTS' => (LucideIcons.calendarDays, MuFeedTone.event),
        'LC' => (LucideIcons.users, MuFeedTone.done),
        _ => (LucideIcons.megaphone, MuFeedTone.neutral),
      };

  Widget _row(
    BuildContext context,
    AppNotification n,
    DateTime now, {
    required bool last,
  }) {
    final mu = context.mu;
    final c = mu.colors;
    final (icon, tone) = _look(n);
    return Dismissible(
      key: ValueKey('notification-${n.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: MuSpacing.space5),
        color: c.night,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.archive, size: MuSizes.iconSm, color: c.onNight),
            const SizedBox(width: MuSpacing.space2),
            Text('Archive', style: mu.text.label.copyWith(color: c.onNight)),
          ],
        ),
      ),
      onDismissed: (_) => onArchive(n),
      child: MuFeedRow(
        leading: MuFeedIcon(icon, tone: tone),
        subject: n.title,
        body: n.description,
        time: formatAgo(n.createdAt.toLocal(), now),
        unread: !n.read,
        divider: !last,
        onTap: () => onOpen(n),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      MuSpacing.space1,
      MuSpacing.space5,
      0,
      MuSpacing.space2,
    ),
    child: Semantics(
      header: true,
      child: Text(
        text,
        style: context.mu.text.label.copyWith(color: context.mu.colors.ink3),
      ),
    ),
  );
}
