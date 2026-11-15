import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_detail.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_report_attendee.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/meetings_controller.dart';
import 'package:mulearn_app/features/learning_circles/presentation/widgets/circle_membership_widgets.dart';

/// One circle meeting: status and title, when / where / link (and the code
/// for its organiser), what it's about, who's going, then the reports
/// (yours to submit, or the organiser's review). RSVP / join / leave sits
/// pinned at the bottom.
class MeetingDetailScreen extends ConsumerWidget {
  const MeetingDetailScreen({required this.meetingId, super.key, this.circleId});

  final String meetingId;

  /// Only known when reached from the circle's meetings (passed as `extra`;
  /// the route is just `/meetings/:id`), used to refresh that list after a
  /// delete. Detail responses don't carry their circle id.
  final String? circleId;

  Future<void> _delete(BuildContext context, WidgetRef ref, String title) async {
    final ok = await showMuConfirm(
      context,
      title: 'Delete $title?',
      body: "Everyone who RSVP'd loses it. This cannot be undone.",
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (!ok || !context.mounted) return;
    final deleted = await ref
        .read(meetingActionsControllerProvider.notifier)
        .deleteMeeting(meetingId, circleId: circleId);
    if (!context.mounted) return;
    if (deleted) {
      MuToast.show(context, message: 'Meeting deleted', type: MuToastType.success);
      context.pop();
    } else {
      final error = ref.read(meetingActionsControllerProvider).error;
      MuToast.show(
        context,
        message: ApiException.messageFor(error ?? "Couldn't delete the meeting"),
        type: MuToastType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(meetingDetailProvider(meetingId));
    final meeting = detailState.value;
    final isCreator = meeting?.meetCode != null;

    return Scaffold(
      backgroundColor: context.mu.colors.chalk,
      body: SafeArea(
        child: Column(
          children: [
            MuTopBar.detail(
              action: isCreator
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MuIconButton(
                          icon: LucideIcons.pencil,
                          tooltip: 'Edit meeting',
                          onPressed: () => context.push(RoutePaths.editMeetingPath(meetingId)),
                        ),
                        const SizedBox(width: MuSpacing.space2),
                        MuIconButton(
                          icon: LucideIcons.trash2,
                          tooltip: 'Delete meeting',
                          onPressed: () => _delete(context, ref, meeting!.title),
                        ),
                      ],
                    )
                  : null,
            ),
            Expanded(
              child: detailState.when(
                skipError: true,
                loading: () => const Center(child: MuDotsLoader(label: 'Loading the meeting…')),
                error: (error, _) =>
                    ErrorRetryView(error: error, onRetry: () => ref.invalidate(meetingDetailProvider(meetingId))),
                data: (m) => _Body(meetingId: meetingId, meeting: m),
              ),
            ),
            if (meeting != null && !meeting.isEnded)
              DecoratedBox(
                decoration: BoxDecoration(
                  color: context.mu.colors.chalk,
                  border: Border(top: BorderSide(color: context.mu.colors.line)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    MuSpacing.space5,
                    MuSpacing.space3,
                    MuSpacing.space5,
                    MuSpacing.space3,
                  ),
                  child: MeetingActionsBar(
                    meetingId: meetingId,
                    meeting: meeting,
                    onJoinWithCode: () =>
                        showMuSheet<void>(context, builder: (_) => _JoinCodeSheet(meetingId: meetingId)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.meetingId, required this.meeting});

  final String meetingId;
  final MeetingDetail meeting;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final m = meeting;
    final start = DateTime.tryParse(m.meetTime)?.toLocal();
    final end = start == null || m.duration <= 0 ? null : start.add(Duration(minutes: m.duration));
    final link = m.meetLink?.trim() ?? '';
    final online = link.isNotEmpty || m.mode.toLowerCase() == 'online';

    return MuRefresh(
      onRefresh: () => ref.refresh(meetingDetailProvider(meetingId).future),
      child: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.fromLTRB(MuSpacing.space5, MuSpacing.space2, MuSpacing.space5, MuSpacing.space8),
        children: [
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              if (m.isEnded)
                const MuPill('Ended')
              else if (m.isStarted)
                const MuPill('Live now', tone: MuPillTone.volt)
              else
                const MuPill('Upcoming', tone: MuPillTone.cobalt),
              MuPill(m.mode, icon: online ? LucideIcons.wifi : LucideIcons.mapPin),
              if (m.isRecurring) const MuPill('Every week', icon: LucideIcons.repeat),
              if (m.ig.isNotEmpty) MuIgChip(name: m.ig, category: IgCategory.others),
            ],
          ),
          const SizedBox(height: MuSpacing.space4),
          Semantics(header: true, child: Text(m.title, style: mu.text.display.copyWith(fontSize: 32, height: 1.05))),
          const SizedBox(height: MuSpacing.space5),
          MuFeedGroup(
            children: [
              MuFeedRow(
                leading: const MuFeedIcon(LucideIcons.calendar, tone: MuFeedTone.event),
                subject: start == null ? m.meetTime : formatDay(start),
                time: start == null
                    ? null
                    : (end == null ? formatTime(start) : '${formatTime(start)} – ${formatTime(end)}'),
              ),
              MuFeedRow(
                leading: MuFeedIcon(online ? LucideIcons.video : LucideIcons.mapPin, tone: MuFeedTone.event),
                subject: m.meetPlace.isEmpty ? (online ? 'Online' : 'Place to be announced') : m.meetPlace,
                time: link.isNotEmpty ? 'Tap to open the link' : null,
                trailing: link.isNotEmpty ? Icon(LucideIcons.arrowUpRight, size: MuSizes.iconSm, color: c.ink3) : null,
                onTap: link.isNotEmpty
                    ? () {
                        final uri = Uri.tryParse(link);
                        if (uri != null) unawaited(ref.read(openExternalProvider)(uri));
                      }
                    : null,
                divider: m.meetCode != null,
              ),
              if (m.meetCode != null)
                MuFeedRow(
                  leading: const MuFeedIcon(LucideIcons.keyRound, tone: MuFeedTone.karma),
                  subject: m.meetCode!,
                  time: 'Meeting code · share it when the meeting starts',
                  trailing: Icon(LucideIcons.copy, size: MuSizes.iconSm, color: c.ink3),
                  divider: false,
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: m.meetCode!));
                    if (context.mounted) {
                      MuToast.show(context, message: 'Code copied', type: MuToastType.success);
                    }
                  },
                ),
            ],
          ),
          if (m.description.trim().isNotEmpty) ...[
            const _Eyebrow('ABOUT'),
            Text(m.description.trim(), style: mu.text.body.copyWith(color: c.ink2, height: 1.55)),
          ],
          if (m.attendees.isNotEmpty) ...[
            _Eyebrow('GOING · ${m.attendees.length}'),
            Row(
              children: [
                MuAvatarStack(
                  names: [for (final a in m.attendees.take(5)) a.fullName],
                  urls: [for (final a in m.attendees.take(5)) a.profilePicUrl],
                  extraCount: m.attendees.length > 5 ? m.attendees.length - 5 : 0,
                  size: MuSizes.avatarMd,
                ),
                const SizedBox(width: MuSpacing.space3),
                Expanded(
                  child: Text(
                    _goingLine([for (final a in m.attendees) a.fullName]),
                    style: mu.text.body.copyWith(color: c.ink2),
                  ),
                ),
              ],
            ),
          ],
          if (m.isReportNeeded) _AttendeeReport(meetingId: meetingId),
          if (m.meetCode != null) _OrganizerReport(meetingId: meetingId),
        ],
      ),
    );
  }

  /// "Arjun, Sneha & 9 others".
  static String _goingLine(List<String> names) {
    final first = [for (final n in names.take(2)) n.split(' ').first];
    final rest = names.length - first.length;
    if (rest <= 0) return first.join(' & ');
    return '${first.join(', ')} & $rest ${rest == 1 ? 'other' : 'others'}';
  }
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: MuSpacing.space8, bottom: MuSpacing.space3),
    child: Semantics(header: true, child: Text(text, style: context.mu.text.eyebrow)),
  );
}

/// Join a live meeting with the code its organiser shares.
class _JoinCodeSheet extends ConsumerStatefulWidget {
  const _JoinCodeSheet({required this.meetingId});

  final String meetingId;

  @override
  ConsumerState<_JoinCodeSheet> createState() => _JoinCodeSheetState();
}

class _JoinCodeSheetState extends ConsumerState<_JoinCodeSheet> {
  final _code = TextEditingController();

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _join() async {
    final code = _code.text.trim();
    if (code.length != 6) return;
    await ref.read(meetingActionsControllerProvider.notifier).joinWithCode(widget.meetingId, code);
    if (!mounted) return;
    final error = ref.read(meetingActionsControllerProvider).error;
    MuToast.show(
      context,
      message: error == null ? "You're in the meeting" : ApiException.messageFor(error),
      type: error == null ? MuToastType.success : MuToastType.error,
    );
    if (error == null) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final busy = ref.watch(meetingActionsControllerProvider).isLoading;
    return MuFormSheet(
      title: 'Join with code',
      lead: 'Ask the organiser for the 6-character code.',
      action: MuButton(label: 'Join', block: true, loading: busy, onPressed: busy ? null : _join),
      children: [
        MuTextField(
          label: 'Meeting code',
          controller: _code,
          hint: 'ABC123',
          autofocus: true,
          maxLength: 6,
          textCapitalization: TextCapitalization.characters,
          textInputAction: TextInputAction.go,
          onSubmitted: (_) => _join(),
        ),
      ],
    );
  }
}

/// The organiser's view: approve who attended, write the report, submit;
/// once submitted, read it back with each attendee's own note.
class _OrganizerReport extends ConsumerStatefulWidget {
  const _OrganizerReport({required this.meetingId});

  final String meetingId;

  @override
  ConsumerState<_OrganizerReport> createState() => _OrganizerReportState();
}

class _OrganizerReportState extends ConsumerState<_OrganizerReport> {
  final _report = TextEditingController();
  final Map<String, bool> _approved = {};

  @override
  void dispose() {
    _report.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final reportState = ref.watch(meetingReportProvider(widget.meetingId));
    final actions = ref.watch(meetingActionsControllerProvider);

    return reportState.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(MuSpacing.space6),
        child: Center(child: MuDotsLoader(label: 'Loading the report…')),
      ),
      error: (error, _) => Padding(
        padding: const EdgeInsets.only(top: MuSpacing.space6),
        child: Text(ApiException.messageFor(error), style: mu.text.body.copyWith(color: c.danger)),
      ),
      data: (report) {
        if (report.isReportSubmitted) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Eyebrow('MEETING REPORT'),
              if (report.report != null && report.report!.trim().isNotEmpty) ...[
                Text(report.report!.trim(), style: mu.text.body.copyWith(color: c.ink2, height: 1.55)),
                const SizedBox(height: MuSpacing.space3),
              ],
              MuFeedGroup(
                children: [
                  for (var i = 0; i < report.attendees.length; i++)
                    _ReportAttendeeRow(attendee: report.attendees[i], last: i == report.attendees.length - 1),
                ],
              ),
            ],
          );
        }

        for (final a in report.attendees) {
          _approved.putIfAbsent(a.userId, () => a.isLcApproved);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _Eyebrow('REPORT THE MEETING'),
            MuTextField(
              label: 'What happened',
              controller: _report,
              hint: 'What you covered, what comes next',
              maxLines: 5,
              minLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: MuSpacing.space4),
            Text('Who attended', style: mu.text.label.copyWith(color: c.ink2)),
            const SizedBox(height: MuSpacing.space2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space4),
              decoration: BoxDecoration(color: c.surface, borderRadius: BorderRadius.circular(MuRadii.card)),
              child: Column(
                children: [
                  for (final a in report.attendees)
                    MuCheckboxTile(
                      label: a.fullName,
                      subtitle: a.report,
                      value: _approved[a.userId] ?? false,
                      onChanged: (v) => setState(() => _approved[a.userId] = v),
                    ),
                ],
              ),
            ),
            if (actions.hasError) ...[
              const SizedBox(height: MuSpacing.space2),
              Text(ApiException.messageFor(actions.error!), style: mu.text.caption.copyWith(color: c.danger)),
            ],
            const SizedBox(height: MuSpacing.space4),
            MuButton(
              label: 'Submit meeting report',
              block: true,
              loading: actions.isLoading,
              onPressed: actions.isLoading
                  ? null
                  : () => ref
                        .read(meetingActionsControllerProvider.notifier)
                        .submitMeetingReport(widget.meetingId, report: _report.text.trim(), attendees: _approved),
            ),
          ],
        );
      },
    );
  }
}

class _ReportAttendeeRow extends StatelessWidget {
  const _ReportAttendeeRow({required this.attendee, required this.last});

  final MeetingReportAttendee attendee;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final a = attendee;
    return MuFeedRow(
      leading: MuFeedIcon(
        a.isLcApproved ? LucideIcons.checkCircle2 : LucideIcons.circle,
        tone: a.isLcApproved ? MuFeedTone.done : MuFeedTone.neutral,
      ),
      subject: a.fullName,
      body: a.report,
      time: a.isLcApproved ? 'Attended' : 'Not marked',
      divider: !last,
    );
  }
}

/// An attendee's own report: submit it once, then read it back.
class _AttendeeReport extends ConsumerStatefulWidget {
  const _AttendeeReport({required this.meetingId});

  final String meetingId;

  @override
  ConsumerState<_AttendeeReport> createState() => _AttendeeReportState();
}

class _AttendeeReportState extends ConsumerState<_AttendeeReport> {
  final _report = TextEditingController();
  final _link = TextEditingController();

  @override
  void dispose() {
    _report.dispose();
    _link.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final reportState = ref.watch(attendeeReportProvider(widget.meetingId));
    final actions = ref.watch(meetingActionsControllerProvider);

    return reportState.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(MuSpacing.space6),
        child: Center(child: MuDotsLoader(label: 'Loading your report…')),
      ),
      error: (error, _) => Padding(
        padding: const EdgeInsets.only(top: MuSpacing.space6),
        child: Text(ApiException.messageFor(error), style: mu.text.body.copyWith(color: c.danger)),
      ),
      data: (report) {
        if (report.report != null || report.reportLink != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Eyebrow('YOUR REPORT'),
              MuFeedGroup(
                children: [
                  MuFeedRow(
                    leading: const MuFeedIcon(LucideIcons.fileText, tone: MuFeedTone.done),
                    subject: report.report ?? 'Report link',
                    time: report.reportLink,
                    divider: false,
                    onTap: report.reportLink == null
                        ? null
                        : () {
                            final uri = Uri.tryParse(report.reportLink!);
                            if (uri != null) unawaited(ref.read(openExternalProvider)(uri));
                          },
                  ),
                ],
              ),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _Eyebrow('YOUR REPORT'),
            MuTextField(
              label: 'What you learned',
              controller: _report,
              maxLines: 5,
              minLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: MuSpacing.space4),
            MuTextField(
              label: 'Link (optional)',
              controller: _link,
              hint: 'Notes, repo or slides',
              keyboardType: TextInputType.url,
            ),
            if (actions.hasError) ...[
              const SizedBox(height: MuSpacing.space2),
              Text(ApiException.messageFor(actions.error!), style: mu.text.caption.copyWith(color: c.danger)),
            ],
            const SizedBox(height: MuSpacing.space4),
            MuButton(
              label: 'Submit report',
              block: true,
              loading: actions.isLoading,
              onPressed: actions.isLoading
                  ? null
                  : () => ref
                        .read(meetingActionsControllerProvider.notifier)
                        .submitAttendeeReport(
                          widget.meetingId,
                          report: _report.text.trim().isEmpty ? null : _report.text.trim(),
                          reportLink: _link.text.trim().isEmpty ? null : _link.text.trim(),
                        ),
            ),
          ],
        );
      },
    );
  }
}
