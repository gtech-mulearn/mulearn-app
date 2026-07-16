import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_detail.dart';
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
      appBar: AppBar(
        title: const Text('Meeting'),
        actions: [
          if (isCreator) ...[
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () =>
                  context.push(RoutePaths.editMeetingPath(meetingId)),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _confirmDelete(context, ref),
            ),
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
        padding: const EdgeInsets.all(16),
        children: [
          Text(meeting.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 4),
          Text(meeting.ig, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 18),
              const SizedBox(width: 8),
              Text(meeting.meetTime),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.place_outlined, size: 18),
              const SizedBox(width: 8),
              Expanded(child: Text(meeting.meetPlace)),
            ],
          ),
          if (meeting.meetLink != null && meeting.meetLink!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.link, size: 18),
                const SizedBox(width: 8),
                Expanded(child: SelectableText(meeting.meetLink!)),
              ],
            ),
          ],
          if (meeting.meetCode != null) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.qr_code, size: 18),
                const SizedBox(width: 8),
                Text('Meeting code: ${meeting.meetCode}'),
              ],
            ),
          ],
          const SizedBox(height: 16),
          Text(meeting.description),
          const SizedBox(height: 16),
          if (meeting.isMember)
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: isBusy
                        ? null
                        : () => ref
                            .read(meetingActionsControllerProvider.notifier)
                            .rsvp(meetingId),
                    child: const Text('RSVP'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: isBusy
                        ? null
                        : () => ref
                            .read(meetingActionsControllerProvider.notifier)
                            .leave(meetingId),
                    child: const Text('Leave meeting'),
                  ),
                ),
              ],
            )
          else
            FilledButton(
              onPressed: isBusy ? null : () => _showJoinCodeDialog(context, ref),
              child: const Text('Join with code'),
            ),
          if (meeting.isReportNeeded) ...[
            const Divider(height: 32),
            _AttendeeReportSection(meetingId: meetingId),
          ],
          if (isCreator) ...[
            const Divider(height: 32),
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
              Text('Meeting report', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              if (report.report != null) Text(report.report!),
              const SizedBox(height: 8),
              ...report.attendees.map((a) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      child: Text(a.fullName.isNotEmpty ? a.fullName[0] : '?'),
                    ),
                    title: Text(a.fullName),
                    subtitle: a.report != null ? Text(a.report!) : null,
                    trailing: Icon(
                      a.isLcApproved ? Icons.check_circle : Icons.circle_outlined,
                      color: a.isLcApproved ? Colors.green : null,
                      size: 18,
                    ),
                  )),
            ],
          );
        }

        for (final attendee in report.attendees) {
          _approved.putIfAbsent(attendee.userId, () => attendee.isLcApproved);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Submit meeting report',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            TextField(
              controller: _reportController,
              decoration: const InputDecoration(labelText: 'Report'),
              maxLines: 3,
            ),
            const SizedBox(height: 8),
            Text('Mark attendance', style: Theme.of(context).textTheme.labelLarge),
            ...report.attendees.map((a) => CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(a.fullName),
                  subtitle: a.report != null ? Text(a.report!) : null,
                  value: _approved[a.userId] ?? false,
                  onChanged: (value) =>
                      setState(() => _approved[a.userId] = value ?? false),
                )),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: actionsState.isLoading
                  ? null
                  : () => ref
                      .read(meetingActionsControllerProvider.notifier)
                      .submitMeetingReport(
                        widget.meetingId,
                        report: _reportController.text.trim(),
                        attendees: _approved,
                      ),
              child: const Text('Submit meeting report'),
            ),
            if (actionsState.hasError) ...[
              const SizedBox(height: 8),
              Text(
                ApiException.messageFor(actionsState.error!),
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ],
        );
      },
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
              Text('Your report', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              if (report.report != null) Text(report.report!),
              if (report.reportLink != null) SelectableText(report.reportLink!),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Submit your report',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            TextField(
              controller: _reportController,
              decoration: const InputDecoration(labelText: 'Report'),
              maxLines: 3,
            ),
            TextField(
              controller: _linkController,
              decoration: const InputDecoration(labelText: 'Report link (optional)'),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: actionsState.isLoading
                  ? null
                  : () => ref
                      .read(meetingActionsControllerProvider.notifier)
                      .submitAttendeeReport(
                        widget.meetingId,
                        report: _reportController.text.trim().isEmpty
                            ? null
                            : _reportController.text.trim(),
                        reportLink: _linkController.text.trim().isEmpty
                            ? null
                            : _linkController.text.trim(),
                      ),
              child: const Text('Submit report'),
            ),
          ],
        );
      },
    );
  }
}
