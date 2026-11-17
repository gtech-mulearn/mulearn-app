import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/count_format.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_paged_list.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/team/domain/entities/announcement.dart';
import 'package:mulearn_app/features/team/presentation/announcement_labels.dart';
import 'package:mulearn_app/features/team/presentation/providers/announcements_controller.dart';

/// Every announcement the team manages, newest first, with a way to send a
/// new one and to delete them all. A row opens the announcement.
class AnnouncementsScreen extends ConsumerWidget {
  const AnnouncementsScreen({super.key});

  Future<void> _deleteAll(
    BuildContext context,
    WidgetRef ref,
    int total,
  ) async {
    final confirmed = await showMuConfirm(
      context,
      destructive: true,
      title: 'Delete all ${countOf(total, 'announcement')}?',
      body:
          'This includes ones the system created for learning circles, '
          "projects and events. This can't be undone.",
      confirmLabel: 'Delete all',
    );
    if (!confirmed || !context.mounted) return;
    try {
      await ref.read(announcementsControllerProvider.notifier).deleteAll();
      if (context.mounted) {
        MuToast.show(
          context,
          message: 'All announcements deleted',
          type: MuToastType.success,
        );
      }
    } on Object catch (e) {
      if (context.mounted) {
        MuToast.show(
          context,
          message: ApiException.messageFor(e),
          type: MuToastType.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(announcementsControllerProvider);
    final controller = ref.read(announcementsControllerProvider.notifier);
    final now = ref.watch(clockProvider)().toLocal();
    return MuWorkspacePage(
      title: 'Announcements',
      action: MuIconButton(
        icon: LucideIcons.plus,
        tooltip: 'New announcement',
        onPressed: () =>
            unawaited(context.push(RoutePaths.teamAnnouncementNew)),
      ),
      body: async.when(
        skipError: true,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorRetryView(
          error: error,
          onRetry: () => ref.invalidate(announcementsControllerProvider),
        ),
        data: (data) => MuPagedListView<Announcement>(
          state: data.page,
          grouped: true,
          onLoadMore: controller.loadMore,
          onRefresh: controller.refresh,
          header: [
            if (data.total > 0)
              Align(
                alignment: Alignment.centerRight,
                child: MuButton(
                  label: 'Delete all',
                  variant: MuButtonVariant.ghost,
                  size: MuButtonSize.small,
                  onPressed: () =>
                      unawaited(_deleteAll(context, ref, data.total)),
                ),
              ),
          ],
          empty: const MuStateDisplay(
            variant: MuStateVariant.noResults,
            title: 'No announcements',
            description:
                'Announcements you send to everyone will show up here.',
          ),
          itemBuilder: (context, a, i) => MuFeedRow(
            leading: MuFeedIcon(_icon(a.source), tone: MuFeedTone.event),
            subject: a.title,
            body:
                '${announcementSourceLabel(a.source)} · '
                "${a.createdByName ?? 'System'} · "
                '${announcementAudienceLabel(a)}',
            time: formatAgo(a.createdAt.toLocal(), now),
            divider: i < data.page.items.length - 1,
            onTap: () =>
                unawaited(context.push(RoutePaths.teamAnnouncementPath(a.id))),
          ),
        ),
      ),
    );
  }

  static IconData _icon(AnnouncementSource source) => switch (source) {
    AnnouncementSource.team => LucideIcons.megaphone,
    AnnouncementSource.learningCircle => LucideIcons.users,
    AnnouncementSource.event => LucideIcons.calendarDays,
    AnnouncementSource.project => LucideIcons.folder,
    AnnouncementSource.system => LucideIcons.bell,
  };
}
