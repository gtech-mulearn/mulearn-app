import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_avatar_stack.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_checklist.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/core/widgets/mu_icon_button.dart';
import 'package:mulearn_app/core/widgets/mu_section_header.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_detail.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_report_attendee.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/meetings_controller.dart';

class MeetingDetailScreen extends ConsumerWidget {
  const MeetingDetailScreen({required this.meetingId, super.key, this.circleId});

  final String meetingId;

  /// Only known when reached from [LearningCircleDetailScreen]'s meetings
  /// section (passed via `extra`, since the route path itself is just
  /// `/meetings/:id`) — used to bust that screen's meeting-list cache after
  /// a delete. Detail responses don't carry their own circle id.
  final String? circleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(meetingDetailProvider(meetingId));
    final meeting = detailState.value;
    final isCreator = meeting?.meetCode != null;

    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(
        title: const Text('Meeting'),
        actions: [
          if (isCreator) ...[
            MuIconButton(
              icon: LucideIcons.pencil,
              onPressed: () => context.push(RoutePaths.editMeetingPath(meetingId)),
            ),
            const SizedBox(width: MuSpace.s),
            MuIconButton(
              icon: LucideIcons.trash2,
              onPressed: () => _confirmDelete(context, ref),
            ),
            const SizedBox(width: MuSpace.s),
          ],
        ],
      ),
      body: detailState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorRetryView(
          error: error,
          onRetry: () => ref.invalidate(meetingDetailProvider(meetingId)),
        ),
        data: (meeting) => _MeetingBody(meetingId: meetingId, meeting: meeting),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete this meeting?'),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      final ok = await ref
          .read(meetingActionsControllerProvider.notifier)
          .deleteMeeting(meetingId, circleId: circleId);
      if (ok && context.mounted) context.pop();
    }
  }
}

class _MeetingBody extends ConsumerWidget {
  const _MeetingBody({required this.meetingId, required this.meeting});

  final String meetingId;
  final MeetingDetail meeting;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actionsState = ref.watch(meetingActionsControllerProvider);
    final isCreator = meeting.meetCode != null;
    final isBusy = actionsState.isLoading;

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(meetingDetailProvider(meetingId)),
      child: ListView(
        padding: const EdgeInsets.all(MuSpace.screenH),
        children: [
          Wrap(
            spacing: MuSpace.s,
            children: [
              MuTagChip(
                label: meeting.isEnded ? 'Ended' : (meeting.isStarted ? 'Live now' : 'Upcoming'),
                style: meeting.isEnded
                    ? MuTagStyle.neutral
                    : (meeting.isStarted ? MuTagStyle.deadline : MuTagStyle.success),
              ),
              MuTagChip(label: meeting.mode),
            ],
          ),
          const SizedBox(height: MuSpace.m),
          Text(meeting.title, style: MuType.headline),
          const SizedBox(height: MuSpace.xs),
          Text(meeting.ig, style: MuType.body.copyWith(color: MuColors.inkSecondary)),
          const SizedBox(height: MuSpace.l),
          MuCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoRow(icon: LucideIcons.calendarClock, label: meeting.meetTime),
                const SizedBox(height: MuSpace.m),
                _InfoRow(icon: LucideIcons.mapPin, label: meeting.meetPlace),
                if (meeting.meetLink != null && meeting.meetLink!.isNotEmpty) ...[
                  const SizedBox(height: MuSpace.m),
                  _InfoRow(icon: LucideIcons.link, label: meeting.meetLink!, selectable: true),
                ],
                if (meeting.meetCode != null) ...[
                  const SizedBox(height: MuSpace.m),
                  _InfoRow(icon: LucideIcons.qrCode, label: 'Meeting code: ${meeting.meetCode}'),
                ],
              ],
            ),
          ),
          if (meeting.description.isNotEmpty) ...[
            const SizedBox(height: MuSpace.l),
            Text(meeting.description, style: MuType.body),
          ],
          if (meeting.attendees.isNotEmpty) ...[
            const SizedBox(height: MuSpace.xxl),
            const MuSectionHeader(title: 'Attendees'),
            const SizedBox(height: MuSpace.m),
            MuCard(
              child: Row(
                children: [
                  MuAvatarStack(
                    names: meeting.attendees.take(5).map((a) => a.fullName).toList(),
                    urls: meeting.attendees.take(5).map((a) => a.profilePicUrl).toList(),
                    extraCount: meeting.attendees.length > 5 ? meeting.attendees.length - 5 : 0,
                    size: 36,
                  ),
                  const Spacer(),
                  Text(
                    '${meeting.attendees.length} joined',
                    style: MuType.bodyMed.copyWith(color: MuColors.inkSecondary),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: MuSpace.xxl),
          if (meeting.isMember)
            Row(
              children: [
                Expanded(
                  child: MuGhostButton(
                    label: 'RSVP',
                    onPressed: isBusy
                        ? null
                        : () => ref.read(meetingActionsControllerProvider.notifier).rsvp(meetingId),
                  ),
                ),
                const SizedBox(width: MuSpace.s),
                Expanded(
                  child: MuGhostButton(
                    label: 'Leave meeting',
                    onPressed: isBusy
                        ? null
                        : () => ref.read(meetingActionsControllerProvider.notifier).leave(meetingId),
                  ),
                ),
              ],
            )
          else
            MuPrimaryButton(
              label: 'Join with code',
              onPressed: isBusy ? null : () => _showJoinCodeDialog(context, ref),
            ),
          if (meeting.isReportNeeded) ...[
            const SizedBox(height: MuSpace.xxl),
            _AttendeeReportSection(meetingId: meetingId),
          ],
          if (isCreator) ...[
            const SizedBox(height: MuSpace.xxl),
            _OrganizerReportSection(meetingId: meetingId),
          ],
        ],
      ),
    );
  }

  Future<void> _showJoinCodeDialog(BuildContext context, WidgetRef ref) async {
    final codeController = TextEditingController();
    final join = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter meeting code'),
        content: TextField(
          controller: codeController,
          maxLength: 6,
          textCapitalization: TextCapitalization.characters,
          decoration: const InputDecoration(labelText: '6-character code'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Join'),
          ),
        ],
      ),
    );
    if ((join ?? false) && codeController.text.trim().length == 6) {
      await ref
          .read(meetingActionsControllerProvider.notifier)
          .joinWithCode(meetingId, codeController.text.trim());
    }
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label, this.selectable = false});

  final IconData icon;
  final String label;
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: MuColors.inkSecondary),
        const SizedBox(width: MuSpace.s),
        Expanded(
          child: selectable
              ? SelectableText(label, style: MuType.body)
              : Text(label, style: MuType.body),
        ),
      ],
    );
  }
}

/// The organizer's view: review each attendee's self-submitted report,
/// mark them approved/not, write an overall report, and submit the
/// consolidated meeting report — confirmed live (rules.md §3/§9):
/// `learningcircle/meeting/report/{id}/` requires a minimum of 2 attendees
/// and returns each attendee's own `report`/`report_link` alongside
/// `is_lc_approved` even before the organizer's report is submitted.
class _OrganizerReportSection extends ConsumerStatefulWidget {
  const _OrganizerReportSection({required this.meetingId});

  final String meetingId;

  @override
  ConsumerState<_OrganizerReportSection> createState() =>
      _OrganizerReportSectionState();
}

class _OrganizerReportSectionState
    extends ConsumerState<_OrganizerReportSection> {
  final _reportController = TextEditingController();
  final Map<String, bool> _approved = {};

  @override
  void dispose() {
    _reportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reportState = ref.watch(meetingReportProvider(widget.meetingId));
    final actionsState = ref.watch(meetingActionsControllerProvider);

    return reportState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Text(ApiException.messageFor(error)),
      data: (report) {
        if (report.isReportSubmitted) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MuSectionHeader(title: 'Meeting report'),
              const SizedBox(height: MuSpace.m),
              MuCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (report.report != null) ...[
                      Text(report.report!, style: MuType.body),
                      const SizedBox(height: MuSpace.m),
                    ],
                    for (var i = 0; i < report.attendees.length; i++) ...[
                      if (i > 0) const Divider(height: MuSpace.l),
                      _ReportAttendeeRow(attendee: report.attendees[i]),
                    ],
                  ],
                ),
              ),
            ],
          );
        }

        for (final attendee in report.attendees) {
          _approved.putIfAbsent(attendee.userId, () => attendee.isLcApproved);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MuSectionHeader(title: 'Submit meeting report'),
            const SizedBox(height: MuSpace.m),
            TextField(
              controller: _reportController,
              decoration: const InputDecoration(labelText: 'Report'),
              maxLines: 3,
            ),
            const SizedBox(height: MuSpace.l),
            Text('Mark attendance', style: MuType.label),
            const SizedBox(height: MuSpace.s),
            MuCard(
              child: MuChecklist(
                items: [
                  for (final a in report.attendees)
                    MuChecklistItem(label: a.fullName, checked: _approved[a.userId] ?? false),
                ],
                onToggle: (index) {
                  final userId = report.attendees[index].userId;
                  setState(() => _approved[userId] = !(_approved[userId] ?? false));
                },
              ),
            ),
            const SizedBox(height: MuSpace.l),
            MuPrimaryButton(
              label: 'Submit meeting report',
              onPressed: actionsState.isLoading
                  ? null
                  : () => ref.read(meetingActionsControllerProvider.notifier).submitMeetingReport(
                        widget.meetingId,
                        report: _reportController.text.trim(),
                        attendees: _approved,
                      ),
            ),
            if (actionsState.hasError) ...[
              const SizedBox(height: MuSpace.s),
              Text(
                ApiException.messageFor(actionsState.error!),
                style: MuType.caption.copyWith(color: MuColors.coral),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _ReportAttendeeRow extends StatelessWidget {
  const _ReportAttendeeRow({required this.attendee});

  final MeetingReportAttendee attendee;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(attendee.fullName, style: MuType.bodyMed),
              if (attendee.report != null)
                Text(attendee.report!, style: MuType.caption),
            ],
          ),
        ),
        Icon(
          attendee.isLcApproved ? LucideIcons.checkCircle2 : LucideIcons.circle,
          color: attendee.isLcApproved ? MuColors.limeBright : MuColors.inkTertiary,
          size: 18,
        ),
      ],
    );
  }
}

class _AttendeeReportSection extends ConsumerStatefulWidget {
  const _AttendeeReportSection({required this.meetingId});

  final String meetingId;

  @override
  ConsumerState<_AttendeeReportSection> createState() =>
      _AttendeeReportSectionState();
}

class _AttendeeReportSectionState
    extends ConsumerState<_AttendeeReportSection> {
  final _reportController = TextEditingController();
  final _linkController = TextEditingController();

  @override
  void dispose() {
    _reportController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reportState = ref.watch(attendeeReportProvider(widget.meetingId));
    final actionsState = ref.watch(meetingActionsControllerProvider);

    return reportState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Text(ApiException.messageFor(error)),
      data: (report) {
        if (report.report != null || report.reportLink != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MuSectionHeader(title: 'Your report'),
              const SizedBox(height: MuSpace.m),
              MuCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (report.report != null) Text(report.report!, style: MuType.body),
                    if (report.reportLink != null)
                      SelectableText(report.reportLink!, style: MuType.body),
                  ],
                ),
              ),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MuSectionHeader(title: 'Submit your report'),
            const SizedBox(height: MuSpace.m),
            TextField(
              controller: _reportController,
              decoration: const InputDecoration(labelText: 'Report'),
              maxLines: 3,
            ),
            const SizedBox(height: MuSpace.s),
            TextField(
              controller: _linkController,
              decoration: const InputDecoration(labelText: 'Report link (optional)'),
            ),
            const SizedBox(height: MuSpace.l),
            MuPrimaryButton(
              label: 'Submit report',
              onPressed: actionsState.isLoading
                  ? null
                  : () => ref.read(meetingActionsControllerProvider.notifier).submitAttendeeReport(
                        widget.meetingId,
                        report: _reportController.text.trim().isEmpty
                            ? null
                            : _reportController.text.trim(),
                        reportLink: _linkController.text.trim().isEmpty
                            ? null
                            : _linkController.text.trim(),
                      ),
            ),
          ],
        );
      },
    );
  }
}
