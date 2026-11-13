import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_session.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_participant.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/mentor_sessions_controller.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/session_detail_providers.dart';
import 'package:mulearn_app/features/mentor/presentation/screens/mentor_sessions_screen.dart';
import 'package:mulearn_app/features/mentor/presentation/widgets/attendance_sheet.dart';
import 'package:mulearn_app/features/mentor/presentation/widgets/session_labels.dart';

/// One session (M3): details, participants with attendance, add a learner,
/// mark completed, edit.
class MentorSessionDetailScreen extends ConsumerWidget {
  const MentorSessionDetailScreen({required this.sessionId, super.key});

  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(mentorSessionProvider(sessionId));
    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(backgroundColor: MuColors.canvas, elevation: 0, title: const Text('Session')),
      body: session.when(
        skipError: true,
        skipLoadingOnReload: true,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorRetryView(error: e, onRetry: () => ref.invalidate(mentorSessionProvider(sessionId))),
        data: (s) => MuRefresh(
          onRefresh: () => Future.wait([
            ref.refresh(mentorSessionProvider(sessionId).future),
            ref.refresh(sessionParticipantsControllerProvider(sessionId).future),
          ]),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.m, MuSpace.screenH, MuSpace.xxl),
            children: [
              _Header(session: s),
              const SizedBox(height: MuSpace.l),
              if (s.status == SessionStatus.scheduled) ...[
                MuPrimaryButton(
                  label: 'Mark as completed',
                  icon: LucideIcons.checkCircle,
                  onPressed: () => unawaited(_complete(context, ref)),
                ),
                const SizedBox(height: MuSpace.s),
              ],
              if (const {SessionStatus.scheduled, SessionStatus.pendingApproval, SessionStatus.requested}
                  .contains(s.status))
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () => context.push(RoutePaths.mentorSessionEditPath(s.id)),
                    icon: const Icon(LucideIcons.pencil, size: 16),
                    label: const Text('Edit session'),
                  ),
                ),
              const SizedBox(height: MuSpace.l),
              _Participants(session: s),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _complete(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        // The dashboard's dialog title.
        title: const Text('Mark Session as Completed'),
        content: const Text('Your time is recorded as contributed minutes and you are marked attended.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Complete')),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    try {
      final message = await ref.read(sessionCompletionProvider.notifier).complete(sessionId);
      if (context.mounted) {
        MuToast.show(context, message: message.isEmpty ? 'Session completed' : message, type: MuToastType.success);
      }
    } on Object catch (e) {
      if (context.mounted) MuToast.show(context, message: ApiException.messageFor(e), type: MuToastType.error);
    }
  }
}

class _Header extends ConsumerWidget {
  const _Header({required this.session});

  final MentorSession session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = session;
    final starts = s.startsAt.toLocal();
    final ends = s.endsAt.toLocal();
    final link = s.meetingLink;
    return MuCard(
      padding: const EdgeInsets.all(MuSpace.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MuTagChip(label: statusLabel(s.status)),
          const SizedBox(height: MuSpace.s),
          Text(s.title, style: MuType.title),
          if (s.entityName.isNotEmpty) Text(s.entityName, style: MuType.caption),
          const SizedBox(height: MuSpace.m),
          Text('${formatDayTime(starts)} – ${formatTime(ends)}', style: MuType.bodyMed),
          Text(sessionModeLabel(s.mode), style: MuType.caption),
          if (s.venue != null) Text(s.venue!, style: MuType.body),
          if (link != null)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  final uri = Uri.tryParse(link);
                  if (uri != null && uri.scheme == 'https') unawaited(ref.read(openExternalProvider)(uri));
                },
                icon: const Icon(LucideIcons.video, size: 16),
                label: const Text('Open meeting link'),
              ),
            ),
          if (s.description.isNotEmpty) ...[
            const SizedBox(height: MuSpace.s),
            Text(s.description, style: MuType.body.copyWith(color: MuColors.inkSecondary)),
          ],
        ],
      ),
    );
  }
}

class _Participants extends ConsumerWidget {
  const _Participants({required this.session});

  final MentorSession session;

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final muid = await showDialog<String>(context: context, builder: (_) => const _MuidDialog());
    if (muid == null || muid.isEmpty || !context.mounted) return;
    try {
      final message = await ref.read(sessionParticipantsControllerProvider(session.id).notifier).add(muid);
      if (context.mounted) {
        MuToast.show(context, message: message.isEmpty ? 'Participant added' : message, type: MuToastType.success);
      }
    } on Object catch (e) {
      if (context.mounted) MuToast.show(context, message: ApiException.messageFor(e), type: MuToastType.error);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sessionParticipantsControllerProvider(session.id));
    final count = state.value?.count;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                (count == null ? 'Participants' : 'Participants ($count)').toUpperCase(),
                style: MuType.eyebrow,
              ),
            ),
            // The backend accepts participants on scheduled sessions only.
            if (session.status == SessionStatus.scheduled)
              TextButton.icon(
                onPressed: () => unawaited(_add(context, ref)),
                icon: const Icon(LucideIcons.userPlus, size: 16),
                label: const Text('Add participant'),
              ),
          ],
        ),
        state.when(
          skipError: true,
          skipLoadingOnReload: true,
          loading: () => const Padding(
            padding: EdgeInsets.all(MuSpace.l),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => ErrorRetryView(
            error: e,
            onRetry: () => ref.invalidate(sessionParticipantsControllerProvider(session.id)),
          ),
          data: (data) => data.items.isEmpty
              ? Text('No participants yet.', style: MuType.body.copyWith(color: MuColors.inkSecondary))
              : Column(children: [for (final p in data.items) _ParticipantRow(sessionId: session.id, participant: p)]),
        ),
      ],
    );
  }
}

/// Asks for a learner's muID. Owns its text controller so it outlives the
/// dialog's closing animation.
class _MuidDialog extends StatefulWidget {
  const _MuidDialog();

  @override
  State<_MuidDialog> createState() => _MuidDialogState();
}

class _MuidDialogState extends State<_MuidDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Add participant'),
        content: TextFormField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'muID', hintText: 'name@mulearn'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, _controller.text.trim()), child: const Text('Add')),
        ],
      );
}

class _ParticipantRow extends ConsumerWidget {
  const _ParticipantRow({required this.sessionId, required this.participant});

  final String sessionId;
  final SessionParticipant participant;

  Future<void> _edit(BuildContext context, WidgetRef ref) async {
    final result = await showAttendanceSheet(context, participant);
    if (result == null || !context.mounted) return;
    try {
      final message = await ref.read(sessionParticipantsControllerProvider(sessionId).notifier).setAttendance(
            participant.linkId,
            attendance: result.attendance,
            contributedMinutes: result.minutes,
            progressNote: result.note,
          );
      if (context.mounted) {
        MuToast.show(context, message: message.isEmpty ? 'Attendance saved' : message, type: MuToastType.success);
      }
    } on Object catch (e) {
      if (context.mounted) MuToast.show(context, message: ApiException.messageFor(e), type: MuToastType.error);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = participant;
    final style = switch (p.attendance) {
      AttendanceStatus.attended => MuTagStyle.success,
      AttendanceStatus.absent => MuTagStyle.warning,
      _ => MuTagStyle.neutral,
    };
    return Padding(
      padding: const EdgeInsets.only(top: MuSpace.s),
      child: MuCard(
        padding: const EdgeInsets.fromLTRB(MuSpace.l, MuSpace.m, MuSpace.xs, MuSpace.m),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.fullName.isEmpty ? p.muid : p.fullName, style: MuType.bodyMed),
                  if (p.muid.isNotEmpty) Text(p.muid, style: MuType.caption),
                  const SizedBox(height: MuSpace.xs),
                  Wrap(
                    spacing: MuSpace.s,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      MuTagChip(label: p.attendance.label, style: style),
                      if (p.role.toUpperCase() == 'MENTOR') const MuTagChip(label: 'Mentor'),
                      if (p.contributedMinutes != null) Text('${p.contributedMinutes}m', style: MuType.caption),
                    ],
                  ),
                  if (p.progressNote != null) Text('Note: ${p.progressNote}', style: MuType.caption),
                  if (p.feedback != null) Text('Feedback: ${p.feedback}', style: MuType.caption),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Edit attendance',
              icon: const Icon(LucideIcons.clipboardCheck, size: 20, color: MuColors.inkSecondary),
              onPressed: () => unawaited(_edit(context, ref)),
            ),
          ],
        ),
      ),
    );
  }
}
