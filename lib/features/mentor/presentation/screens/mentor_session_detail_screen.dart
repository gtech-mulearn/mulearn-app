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
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_session.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_participant.dart';
import 'package:mulearn_app/features/mentor/domain/session_rules.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/mentor_sessions_controller.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/session_detail_providers.dart';
import 'package:mulearn_app/features/mentor/presentation/screens/mentor_sessions_screen.dart';
import 'package:mulearn_app/features/mentor/presentation/widgets/attendance_sheet.dart';
import 'package:mulearn_app/features/mentor/presentation/widgets/meeting_actions.dart';
import 'package:mulearn_app/features/mentor/presentation/widgets/session_labels.dart';

/// One session (M3). What the mentor came for is on top: when it is, the
/// meeting link (Join from 15 minutes before, Copy, Open) or the venue with
/// Directions. Edit and Delete sit in the app bar; participants are rows
/// you tap to record attendance.
class MentorSessionDetailScreen extends ConsumerWidget {
  const MentorSessionDetailScreen({required this.sessionId, super.key});

  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(mentorSessionProvider(sessionId));
    final loaded = session.value;
    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(
        backgroundColor: MuColors.canvas,
        elevation: 0,
        title: const Text('Session'),
        actions: [
          if (loaded != null && editableStatuses.contains(loaded.status))
            IconButton(
              tooltip: 'Edit session',
              icon: const Icon(LucideIcons.pencil, size: 20),
              onPressed: () => context.push(RoutePaths.mentorSessionEditPath(sessionId)),
            ),
          if (loaded != null)
            PopupMenuButton<String>(
              tooltip: 'More',
              icon: const Icon(LucideIcons.moreVertical, size: 20),
              onSelected: (_) => unawaited(_delete(context, ref, loaded)),
              itemBuilder: (_) => const [PopupMenuItem(value: 'delete', child: Text('Delete session'))],
            ),
        ],
      ),
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
              if (s.status == SessionStatus.scheduled) ...[
                const SizedBox(height: MuSpace.l),
                OutlinedButton.icon(
                  onPressed: () => unawaited(_complete(context, ref, s)),
                  icon: const Icon(LucideIcons.checkCircle, size: 18),
                  label: const Text('Mark as completed'),
                ),
              ],
              const SizedBox(height: MuSpace.xl),
              _Participants(session: s),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _delete(BuildContext context, WidgetRef ref, MentorSession s) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete this session?'),
        content: Text('“${s.title}” will be removed for everyone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Delete')),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    try {
      final message = await ref.read(sessionActionsProvider.notifier).delete(s.id);
      if (!context.mounted) return;
      MuToast.show(context, message: message.isEmpty ? 'Session deleted' : message, type: MuToastType.success);
      context.canPop() ? context.pop() : context.go(RoutePaths.mentorSessions);
    } on Object catch (e) {
      if (context.mounted) MuToast.show(context, message: ApiException.messageFor(e), type: MuToastType.error);
    }
  }

  Future<void> _complete(BuildContext context, WidgetRef ref, MentorSession s) async {
    final now = ref.read(clockProvider)();
    final early = !hasStarted(s, now);
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        // The dashboard's dialog title.
        title: const Text('Mark Session as Completed'),
        content: Text(
          early
              ? "This session hasn't started yet (${formatDayTime(s.startsAt.toLocal())}). Mark it completed anyway?"
              : 'Your time is recorded as contributed minutes and you are marked attended.',
        ),
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
    final now = ref.watch(clockProvider)();
    final starts = s.startsAt.toLocal();
    final ends = s.endsAt.toLocal();
    final scheduled = s.status == SessionStatus.scheduled;
    return MuCard(
      padding: const EdgeInsets.all(MuSpace.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              MuTagChip(label: statusLabel(s.status)),
              const SizedBox(width: MuSpace.s),
              Flexible(
                child: Text(sessionModeLabel(s.mode), style: MuType.caption, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          const SizedBox(height: MuSpace.s),
          Text(s.title, style: MuType.title),
          if (s.entityName.isNotEmpty) Text(s.entityName, style: MuType.caption),
          const SizedBox(height: MuSpace.m),
          // Relative first ("Starts in 10 min", "Live now"), then the exact time.
          if (scheduled)
            Text(formatWhen(starts: starts, ends: ends, now: now.toLocal()), style: MuType.bodyMed),
          Text(formatRange(starts, ends), style: scheduled ? MuType.caption : MuType.bodyMed),
          if (s.meetingLink != null) ...[
            const SizedBox(height: MuSpace.m),
            MeetingLinkActions(session: s),
          ],
          if (s.venue != null) ...[
            const SizedBox(height: MuSpace.s),
            VenueRow(venue: s.venue!),
          ],
          if (s.description.isNotEmpty) ...[
            const SizedBox(height: MuSpace.m),
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
          data: (data) {
            // Learners first; the mentor's own row last.
            final rows = [
              ...data.items.where((p) => !_isMentor(p)),
              ...data.items.where(_isMentor),
            ];
            if (rows.isEmpty) {
              return Text(
                'No participants yet. Learners who join appear here.',
                style: MuType.body.copyWith(color: MuColors.inkSecondary),
              );
            }
            return Column(children: [for (final p in rows) _ParticipantRow(sessionId: session.id, participant: p)]);
          },
        ),
      ],
    );
  }
}

bool _isMentor(SessionParticipant p) => p.role.toUpperCase() == 'MENTOR';

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
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(labelText: 'muID', hintText: 'name@mulearn'),
          onFieldSubmitted: (v) => Navigator.pop(context, v.trim()),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, _controller.text.trim()), child: const Text('Add')),
        ],
      );
}

/// A participant. The whole row opens the attendance sheet.
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
    final mentor = _isMentor(p);
    final style = switch (p.attendance) {
      AttendanceStatus.attended => MuTagStyle.success,
      AttendanceStatus.absent => MuTagStyle.warning,
      _ => MuTagStyle.neutral,
    };
    return Padding(
      padding: const EdgeInsets.only(top: MuSpace.s),
      child: MuCard(
        onTap: () => unawaited(_edit(context, ref)),
        padding: const EdgeInsets.fromLTRB(MuSpace.l, MuSpace.m, MuSpace.xs, MuSpace.m),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(mentor ? 'You' : (p.fullName.isEmpty ? p.muid : p.fullName), style: MuType.bodyMed),
                  if (!mentor && p.muid.isNotEmpty) Text(p.muid, style: MuType.caption),
                  const SizedBox(height: MuSpace.xs),
                  Wrap(
                    spacing: MuSpace.s,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      MuTagChip(label: p.attendance.label, style: style),
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
              icon: const Icon(LucideIcons.chevronRight, size: 18, color: MuColors.inkSecondary),
              onPressed: () => unawaited(_edit(context, ref)),
            ),
          ],
        ),
      ),
    );
  }
}
