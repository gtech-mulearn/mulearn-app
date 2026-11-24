import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/team/domain/entities/announcement.dart';
import 'package:mulearn_app/features/team/presentation/announcement_labels.dart';
import 'package:mulearn_app/features/team/presentation/providers/announcements_controller.dart';
import 'package:mulearn_app/features/team/presentation/widgets/fact_row.dart';

/// One announcement in full, with Edit and Delete. It reads the announcement
/// from the loaded list; one that isn't there reads as not found.
class AnnouncementDetailScreen extends ConsumerStatefulWidget {
  const AnnouncementDetailScreen({required this.announcementId, super.key});

  final String announcementId;

  @override
  ConsumerState<AnnouncementDetailScreen> createState() =>
      _AnnouncementDetailScreenState();
}

class _AnnouncementDetailScreenState
    extends ConsumerState<AnnouncementDetailScreen> {
  /// A delete is in flight. It blocks a second tap, and keeps the page from
  /// reading "Not found" in the moment between the row going and the pop.
  bool _busy = false;

  Future<void> _delete(Announcement a) async {
    final confirmed = await showMuConfirm(
      context,
      destructive: true,
      title: 'Delete this announcement?',
      body: 'Members will no longer see "${a.title}".',
      confirmLabel: 'Delete',
    );
    if (!confirmed || !mounted || _busy) return;
    setState(() => _busy = true);
    try {
      await ref.read(announcementsControllerProvider.notifier).delete(a.id);
      if (!mounted) return;
      MuToast.show(
        context,
        message: 'Announcement deleted',
        type: MuToastType.success,
      );
      if (context.canPop()) {
        context.pop();
      } else {
        context.go(RoutePaths.teamAnnouncements);
      }
    } on Object catch (e) {
      if (mounted) {
        setState(() => _busy = false);
        MuToast.show(
          context,
          message: ApiException.messageFor(e),
          type: MuToastType.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final announcementId = widget.announcementId;
    final async = ref.watch(announcementsControllerProvider);
    return async.when(
      skipError: true,
      loading: () => const MuWorkspacePage(
        title: 'Announcement',
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => MuWorkspacePage(
        title: 'Announcement',
        body: ErrorRetryView(
          error: error,
          onRetry: () => ref.invalidate(announcementsControllerProvider),
        ),
      ),
      data: (data) {
        final matches = data.page.items.where((a) => a.id == announcementId);
        if (matches.isEmpty && _busy) {
          return const MuWorkspacePage(
            title: 'Announcement',
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (matches.isEmpty) {
          return const MuWorkspacePage(
            title: 'Announcement',
            body: Center(
              child: SingleChildScrollView(
                child: MuStateDisplay(variant: MuStateVariant.notFound),
              ),
            ),
          );
        }
        final a = matches.first;
        final now = ref.watch(clockProvider)().toLocal();
        return MuWorkspacePage(
          title: 'Announcement',
          body: _Body(announcement: a, now: now),
          bottom: Row(
            children: [
              Expanded(
                child: MuButton(
                  label: 'Delete',
                  variant: MuButtonVariant.outline,
                  onPressed: _busy ? null : () => unawaited(_delete(a)),
                ),
              ),
              const SizedBox(width: MuSpacing.space3),
              Expanded(
                child: MuButton(
                  label: 'Edit',
                  onPressed: () => unawaited(
                    context.push(RoutePaths.teamAnnouncementEditPath(a.id)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.announcement, required this.now});

  final Announcement announcement;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final a = announcement;
    final expires = a.expiresAt.toLocal();
    return ListView(
      padding: muListPadding,
      children: [
        Semantics(header: true, child: Text(a.title, style: mu.text.title2)),
        const SizedBox(height: MuSpacing.space3),
        Text(a.description, style: mu.text.body.copyWith(color: c.ink2)),
        const SizedBox(height: MuSpacing.space6),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: MuSpacing.space4,
            vertical: MuSpacing.space2,
          ),
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: BorderRadius.circular(MuRadii.card),
          ),
          child: Column(
            children: [
              FactRow('Source', announcementSourceLabel(a.source)),
              FactRow('Shown to', announcementAudienceLabel(a)),
              FactRow('Created by', a.createdByName ?? 'System'),
              FactRow('Created', formatAgo(a.createdAt.toLocal(), now)),
              FactRow(
                now.isAfter(expires) ? 'Expired' : 'Expires',
                formatDayTime(expires),
                last: a.url == null || a.url!.isEmpty,
              ),
              if (a.url != null && a.url!.isNotEmpty)
                FactRow('Opens', a.url!, last: true),
            ],
          ),
        ),
      ],
    );
  }
}
