import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/session/workspace_access.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/campus/domain/entities/approvals.dart';
import 'package:mulearn_app/features/campus/presentation/providers/approvals_providers.dart';

/// What needs the campus's decision (K4): college links and collaboration
/// invites for the Campus Lead, campus events for every campus role.
class CampusApprovalsScreen extends ConsumerWidget {
  const CampusApprovalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lead = ref.watch(workspaceAccessProvider).value?.campusLead ?? false;
    final links = lead ? ref.watch(orgLinkRequestsProvider) : const AsyncData(<OrgLinkRequest>[]);
    final events = ref.watch(pendingCampusEventsProvider);
    final invites = lead ? ref.watch(collabInvitesProvider) : const AsyncData(<CollabInvite>[]);
    final loading = links.isLoading || events.isLoading || invites.isLoading;
    final empty = (links.value?.isEmpty ?? false) && (events.value?.isEmpty ?? false) && (invites.value?.isEmpty ?? false);
    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(backgroundColor: MuColors.canvas, elevation: 0, title: const Text('Approvals')),
      body: MuRefresh(
        onRefresh: () => Future.wait([
          if (lead) ref.refresh(orgLinkRequestsProvider.future),
          ref.refresh(pendingCampusEventsProvider.future),
          if (lead) ref.refresh(collabInvitesProvider.future),
        ]),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.s, MuSpace.screenH, MuSpace.xxl),
          children: [
            if (loading && !empty) const LinearProgressIndicator(),
            if (!loading && empty)
              const MuStateDisplay(
                variant: MuStateVariant.noResults,
                title: 'Nothing to review',
                description: 'College links, campus events and invites that need you appear here.',
              ),
            if (lead)
              _Section<OrgLinkRequest>(
                title: 'College links',
                state: links,
                builder: (l) => _LinkCard(link: l),
              ),
            _Section<PendingCampusEvent>(
              title: 'Campus events',
              state: events,
              builder: (e) => _EventCard(event: e),
            ),
            if (lead)
              _Section<CollabInvite>(
                title: 'Collaboration invites',
                state: invites,
                builder: (i) => _InviteCard(invite: i),
              ),
          ],
        ),
      ),
    );
  }
}

/// A titled list; hidden when empty, an inline message when it failed.
class _Section<T> extends StatelessWidget {
  const _Section({required this.title, required this.state, required this.builder});

  final String title;
  final AsyncValue<List<T>> state;
  final Widget Function(T) builder;

  @override
  Widget build(BuildContext context) {
    if (state.hasError && !state.hasValue) {
      return Padding(
        padding: const EdgeInsets.only(top: MuSpace.l),
        child: Text('$title: ${ApiException.messageFor(state.error!)}', style: MuType.caption),
      );
    }
    final items = state.value ?? const [];
    if (items.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: MuSpace.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('${title.toUpperCase()} (${items.length})', style: MuType.eyebrow, semanticsLabel: title),
          const SizedBox(height: MuSpace.s),
          for (final item in items) builder(item),
        ],
      ),
    );
  }
}

Future<void> _act(BuildContext context, Future<String> Function() action, String fallback) async {
  try {
    final message = await action();
    if (context.mounted) MuToast.show(context, message: message.isEmpty ? fallback : message, type: MuToastType.success);
  } on Object catch (e) {
    if (context.mounted) MuToast.show(context, message: ApiException.messageFor(e), type: MuToastType.error);
  }
}

/// Asks why (required when [required]); null when dismissed.
Future<String?> _askReason(BuildContext context, {required String title, required String action, required bool required}) =>
    showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: MuColors.surface,
      builder: (_) => _ReasonSheet(title: title, action: action, required: required),
    );

class _ReasonSheet extends StatefulWidget {
  const _ReasonSheet({required this.title, required this.action, required this.required});

  final String title;
  final String action;
  final bool required;

  @override
  State<_ReasonSheet> createState() => _ReasonSheetState();
}

class _ReasonSheetState extends State<_ReasonSheet> {
  final _reason = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.fromLTRB(MuSpace.screenH, 0, MuSpace.screenH, MediaQuery.viewInsetsOf(context).bottom + MuSpace.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(widget.title, style: MuType.title),
            const SizedBox(height: MuSpace.m),
            TextField(
              controller: _reason,
              autofocus: true,
              minLines: 2,
              maxLines: 4,
              decoration: InputDecoration(labelText: 'Reason', errorText: _error),
            ),
            const SizedBox(height: MuSpace.l),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: MuColors.error),
              onPressed: () {
                final text = _reason.text.trim();
                if (widget.required && text.isEmpty) {
                  // The backend's own message.
                  setState(() => _error = 'A rejection reason is required.');
                  return;
                }
                Navigator.pop(context, text);
              },
              child: Text(widget.action),
            ),
          ],
        ),
      );
}

class _LinkCard extends ConsumerWidget {
  const _LinkCard({required this.link});

  final OrgLinkRequest link;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = link;
    final now = ref.watch(clockProvider)().toLocal();
    Future<void> verify() async {
      final ok = await showDialog<bool>(
        context: context,
        builder: (d) => AlertDialog(
          title: const Text('Verify member?'),
          content: Text('Verify ${l.fullName.isEmpty ? l.muid : l.fullName} as a member of ${l.orgTitle}?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancel')),
            TextButton(onPressed: () => Navigator.pop(d, true), child: const Text('Verify')),
          ],
        ),
      );
      if ((ok ?? false) && context.mounted) {
        await _act(context, () => ref.read(approvalActionsProvider.notifier).verifyLink(l.id), 'Verified');
      }
    }

    return _ActionCard(
      title: l.fullName.isEmpty ? l.muid : l.fullName,
      lines: [
        l.muid,
        [
          if (l.graduationYear != null) 'Class of ${l.graduationYear}',
          if (l.isAlumni) 'Alumni',
          if (l.requestedAt != null) 'Asked ${formatAgo(l.requestedAt!.toLocal(), now)}',
        ].join(' · '),
      ],
      primary: ('Verify', () => unawaited(verify())),
    );
  }
}

class _EventCard extends ConsumerWidget {
  const _EventCard({required this.event});

  final PendingCampusEvent event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final e = event;
    final start = e.start?.toLocal();
    Future<void> reject() async {
      final reason = await _askReason(context, title: 'Reject “${e.title}”?', action: 'Reject event', required: true);
      if (reason != null && context.mounted) {
        await _act(context, () => ref.read(approvalActionsProvider.notifier).rejectEvent(e.id, reason), 'Event rejected');
      }
    }

    return _ActionCard(
      title: e.title,
      lines: [
        [if (start != null) formatDayTime(start), if (e.venueCity != null) e.venueCity!].join(' · '),
        if (e.tags.isNotEmpty) e.tags.map((t) => '#$t').join(' '),
      ],
      secondary: ('Reject', () => unawaited(reject())),
      primary: (
        'Approve',
        () => unawaited(_act(context, () => ref.read(approvalActionsProvider.notifier).approveEvent(e.id), 'Event approved'))
      ),
    );
  }
}

class _InviteCard extends ConsumerWidget {
  const _InviteCard({required this.invite});

  final CollabInvite invite;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i = invite;
    Future<void> decline() async {
      final reason = await _askReason(context, title: 'Decline this invite?', action: 'Decline invite', required: false);
      if (reason != null && context.mounted) {
        await _act(context, () => ref.read(approvalActionsProvider.notifier).rejectInvite(i, reason), 'Invite declined');
      }
    }

    return _ActionCard(
      title: i.eventTitle,
      lines: [
        [if (i.roleLabel.isNotEmpty) i.roleLabel, if (i.eventStart != null) formatDayTime(i.eventStart!.toLocal())].join(' · '),
        if (i.entityName.isNotEmpty) 'For ${i.entityName}',
      ],
      secondary: ('Decline', () => unawaited(decline())),
      primary: (
        'Accept',
        () => unawaited(_act(context, () => ref.read(approvalActionsProvider.notifier).acceptInvite(i), 'Invite accepted'))
      ),
    );
  }
}

/// A decision card: what it is, then the actions on the right.
class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.title, required this.lines, required this.primary, this.secondary});

  final String title;
  final List<String> lines;
  final (String, VoidCallback) primary;
  final (String, VoidCallback)? secondary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: MuSpace.s),
      child: MuCard(
        padding: const EdgeInsets.fromLTRB(MuSpace.l, MuSpace.m, MuSpace.l, MuSpace.s),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: MuType.bodyMed),
            for (final line in lines.where((l) => l.isNotEmpty)) Text(line, style: MuType.caption),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (secondary != null) TextButton(onPressed: secondary!.$2, child: Text(secondary!.$1)),
                const SizedBox(width: MuSpace.s),
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: MuColors.primary),
                  onPressed: primary.$2,
                  child: Text(primary.$1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
