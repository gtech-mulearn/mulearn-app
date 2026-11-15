import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/session/workspace_access.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/campus/domain/entities/approvals.dart';
import 'package:mulearn_app/features/campus/presentation/providers/approvals_providers.dart';
import 'package:mulearn_app/features/campus/presentation/widgets/campus_kit.dart';

/// What needs the campus's decision (K4): college links and collaboration
/// invites for the Campus Lead, campus events for every campus role. A
/// count for each up top, then each request as a row with its actions.
class CampusApprovalsScreen extends ConsumerWidget {
  const CampusApprovalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final lead = ref.watch(workspaceAccessProvider).value?.campusLead ?? false;
    final links = lead ? ref.watch(orgLinkRequestsProvider) : const AsyncData(<OrgLinkRequest>[]);
    final events = ref.watch(pendingCampusEventsProvider);
    final invites = lead ? ref.watch(collabInvitesProvider) : const AsyncData(<CollabInvite>[]);
    final loading = links.isLoading || events.isLoading || invites.isLoading;
    final empty =
        (links.value?.isEmpty ?? false) && (events.value?.isEmpty ?? false) && (invites.value?.isEmpty ?? false);

    return CampusPage(
      body: MuRefresh(
        onRefresh: () => Future.wait([
          if (lead) ref.refresh(orgLinkRequestsProvider.future),
          ref.refresh(pendingCampusEventsProvider.future),
          if (lead) ref.refresh(collabInvitesProvider.future),
        ]),
        child: ListView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: campusListPadding,
          children: [
            Semantics(header: true, child: Text('Approvals', style: mu.text.display.copyWith(fontSize: 32))),
            const SizedBox(height: MuSpacing.space4),
            if (!empty)
              Row(
                children: [
                  if (lead) ...[
                    Expanded(
                      child: CampusStatTile(label: 'Links', value: '${links.value?.length ?? '–'}'),
                    ),
                    const SizedBox(width: MuSpacing.space2),
                  ],
                  Expanded(
                    child: CampusStatTile(label: 'Events', value: '${events.value?.length ?? '–'}'),
                  ),
                  if (lead) ...[
                    const SizedBox(width: MuSpacing.space2),
                    Expanded(
                      child: CampusStatTile(label: 'Invites', value: '${invites.value?.length ?? '–'}'),
                    ),
                  ],
                ],
              ),
            if (loading && !empty)
              const Padding(
                padding: EdgeInsets.only(top: MuSpacing.space4),
                child: Center(child: MuDotsLoader()),
              ),
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
                row: (l, {required last}) => _LinkRow(link: l, last: last),
              ),
            _Section<PendingCampusEvent>(
              title: 'Campus events',
              state: events,
              row: (e, {required last}) => _EventRow(event: e, last: last),
            ),
            if (lead)
              _Section<CollabInvite>(
                title: 'Collaboration invites',
                state: invites,
                row: (i, {required last}) => _InviteRow(invite: i, last: last),
              ),
          ],
        ),
      ),
    );
  }
}

/// A titled group of rows; hidden when empty, an inline message when it
/// failed.
class _Section<T> extends StatelessWidget {
  const _Section({required this.title, required this.state, required this.row});

  final String title;
  final AsyncValue<List<T>> state;
  final Widget Function(T item, {required bool last}) row;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    if (state.hasError && !state.hasValue) {
      return Padding(
        padding: const EdgeInsets.only(top: MuSpacing.space6),
        child: Text(
          '$title: ${ApiException.messageFor(state.error!)}',
          style: mu.text.caption.copyWith(color: mu.colors.danger),
        ),
      );
    }
    final items = state.value ?? const [];
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CampusEyebrow('$title (${items.length})'),
        MuFeedGroup(children: [for (var i = 0; i < items.length; i++) row(items[i], last: i == items.length - 1)]),
      ],
    );
  }
}

Future<void> _act(BuildContext context, Future<String> Function() action, String fallback) async {
  try {
    final message = await action();
    if (context.mounted) {
      MuToast.show(context, message: message.isEmpty ? fallback : message, type: MuToastType.success);
    }
  } on Object catch (e) {
    if (context.mounted) MuToast.show(context, message: ApiException.messageFor(e), type: MuToastType.error);
  }
}

/// Asks why (required when [required]); null when dismissed.
Future<String?> _askReason(
  BuildContext context, {
  required String title,
  required String action,
  required bool required,
}) => showMuSheet<String>(
  context,
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
  Widget build(BuildContext context) {
    return MuFormSheet(
      title: widget.title,
      lead: widget.required ? 'The organiser sees this.' : 'Optional; the organiser sees it.',
      action: MuButton(
        label: widget.action,
        variant: MuButtonVariant.danger,
        block: true,
        onPressed: () {
          final text = _reason.text.trim();
          if (widget.required && text.isEmpty) {
            // The backend's own message.
            setState(() => _error = 'A rejection reason is required.');
            return;
          }
          Navigator.pop(context, text);
        },
      ),
      children: [
        MuTextField(
          label: 'Reason',
          controller: _reason,
          error: _error,
          autofocus: true,
          minLines: 2,
          maxLines: 4,
          textCapitalization: TextCapitalization.sentences,
          onChanged: (_) {
            if (_error != null) setState(() => _error = null);
          },
        ),
      ],
    );
  }
}

class _LinkRow extends ConsumerWidget {
  const _LinkRow({required this.link, required this.last});

  final OrgLinkRequest link;
  final bool last;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = link;
    final now = ref.watch(clockProvider)().toLocal();
    final name = l.fullName.isEmpty ? l.muid : l.fullName;
    Future<void> verify() async {
      final ok = await showMuConfirm(
        context,
        title: 'Verify member?',
        body: 'Verify $name as a member of ${l.orgTitle}?',
        confirmLabel: 'Verify',
      );
      if (ok && context.mounted) {
        await _act(context, () => ref.read(approvalActionsProvider.notifier).verifyLink(l.id), 'Verified');
      }
    }

    return MuFeedRow(
      leading: MuAvatar(name: name, size: MuSizes.avatarMd),
      subject: name,
      time: [
        l.muid,
        if (l.graduationYear != null) 'Class of ${l.graduationYear}',
        if (l.isAlumni) 'Alumni',
        if (l.requestedAt != null) 'Asked ${formatAgo(l.requestedAt!.toLocal(), now)}',
      ].join(' · '),
      divider: !last,
      actions: [MuButton(label: 'Verify', size: MuButtonSize.small, onPressed: () => unawaited(verify()))],
    );
  }
}

class _EventRow extends ConsumerWidget {
  const _EventRow({required this.event, required this.last});

  final PendingCampusEvent event;
  final bool last;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final e = event;
    final start = e.start?.toLocal();
    Future<void> reject() async {
      final reason = await _askReason(context, title: 'Reject “${e.title}”?', action: 'Reject event', required: true);
      if (reason != null && context.mounted) {
        await _act(
          context,
          () => ref.read(approvalActionsProvider.notifier).rejectEvent(e.id, reason),
          'Event rejected',
        );
      }
    }

    return MuFeedRow(
      leading: const MuFeedIcon(LucideIcons.ticket, tone: MuFeedTone.event),
      subject: e.title,
      time: [
        if (start != null) formatDayTime(start),
        if (e.venueCity != null) e.venueCity!,
        if (e.tags.isNotEmpty) e.tags.map((t) => '#$t').join(' '),
      ].join(' · '),
      divider: !last,
      actions: [
        MuButton(
          label: 'Approve',
          size: MuButtonSize.small,
          onPressed: () => unawaited(
            _act(context, () => ref.read(approvalActionsProvider.notifier).approveEvent(e.id), 'Event approved'),
          ),
        ),
        MuButton(
          label: 'Reject',
          variant: MuButtonVariant.outline,
          size: MuButtonSize.small,
          onPressed: () => unawaited(reject()),
        ),
      ],
    );
  }
}

class _InviteRow extends ConsumerWidget {
  const _InviteRow({required this.invite, required this.last});

  final CollabInvite invite;
  final bool last;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i = invite;
    Future<void> decline() async {
      final reason = await _askReason(
        context,
        title: 'Decline this invite?',
        action: 'Decline invite',
        required: false,
      );
      if (reason != null && context.mounted) {
        await _act(
          context,
          () => ref.read(approvalActionsProvider.notifier).rejectInvite(i, reason),
          'Invite declined',
        );
      }
    }

    return MuFeedRow(
      leading: const MuFeedIcon(LucideIcons.users, tone: MuFeedTone.pending),
      subject: i.eventTitle,
      body: i.entityName.isEmpty ? null : 'for ${i.entityName}',
      time: [
        if (i.roleLabel.isNotEmpty) i.roleLabel,
        if (i.eventStart != null) formatDayTime(i.eventStart!.toLocal()),
      ].join(' · '),
      divider: !last,
      actions: [
        MuButton(
          label: 'Accept',
          size: MuButtonSize.small,
          onPressed: () => unawaited(
            _act(context, () => ref.read(approvalActionsProvider.notifier).acceptInvite(i), 'Invite accepted'),
          ),
        ),
        MuButton(
          label: 'Decline',
          variant: MuButtonVariant.outline,
          size: MuButtonSize.small,
          onPressed: () => unawaited(decline()),
        ),
      ],
    );
  }
}
