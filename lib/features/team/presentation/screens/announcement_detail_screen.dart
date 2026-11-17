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

/// One announcement in full, with Edit and Delete. It reads the announcement
/// from the loaded list; one that isn't there reads as not found.
class AnnouncementDetailScreen extends ConsumerWidget {
  const AnnouncementDetailScreen({required this.announcementId, super.key});

  final String announcementId;

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    Announcement a,
  ) async {
    final confirmed = await showMuConfirm(
      context,
      destructive: true,
      title: 'Delete this announcement?',
      body: 'Members will no longer see "${a.title}".',
      confirmLabel: 'Delete',
    );
    if (!confirmed || !context.mounted) return;
    try {
      await ref.read(announcementsControllerProvider.notifier).delete(a.id);
      if (!context.mounted) return;
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
                  onPressed: () => unawaited(_delete(context, ref, a)),
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
              _Fact('Source', announcementSourceLabel(a.source)),
              _Fact('Shown to', a.targetName ?? 'Everyone'),
              _Fact('Created by', a.createdByName ?? 'System'),
              _Fact('Created', formatAgo(a.createdAt.toLocal(), now)),
              _Fact(
                now.isAfter(expires) ? 'Expired' : 'Expires',
                formatDayTime(expires),
                last: a.url == null || a.url!.isEmpty,
              ),
              if (a.url != null && a.url!.isNotEmpty)
                _Fact('Opens', a.url!, last: true),
            ],
          ),
        ),
      ],
    );
  }
}

class _Fact extends StatelessWidget {
  const _Fact(this.label, this.value, {this.last = false});

  final String label;
  final String value;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: MuSpacing.space3),
      decoration: BoxDecoration(
        border: last ? null : Border(bottom: BorderSide(color: c.line)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 104,
            child: Text(label, style: mu.text.label.copyWith(color: c.ink3)),
          ),
          Expanded(
            child: Text(value, style: mu.text.body.copyWith(color: c.ink)),
          ),
        ],
      ),
    );
  }
}
