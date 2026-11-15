import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show ProviderOrFamily;
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/mu_date_time_picker.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/features/mentor/domain/entities/learner_sessions.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_session.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/learner_sessions_providers.dart';
import 'package:mulearn_app/features/mentor/presentation/widgets/meeting_actions.dart';
import 'package:mulearn_app/features/mentor/presentation/widgets/session_labels.dart';

enum _Tab { available, requests, history }

/// Mentor sessions for learners, as on the dashboard's "My Sessions":
/// sessions open to join, the ones you asked mentors for, and your history
/// (with feedback once you've attended). "Ask for a session" is pinned at
/// the bottom.
class LearnerSessionsScreen extends ConsumerStatefulWidget {
  const LearnerSessionsScreen({super.key});

  @override
  ConsumerState<LearnerSessionsScreen> createState() =>
      _LearnerSessionsScreenState();
}

class _LearnerSessionsScreenState extends ConsumerState<LearnerSessionsScreen> {
  _Tab _tab = _Tab.available;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return Scaffold(
      backgroundColor: c.chalk,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: MuRefresh(
                onRefresh: () => Future.wait([
                  ref.refresh(availableSessionsProvider.future),
                  ref.refresh(mySessionHistoryProvider.future),
                  ref.refresh(mySessionRequestsProvider.future),
                ]),
                child: ListView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: const EdgeInsets.fromLTRB(
                    MuSpacing.space5,
                    MuSpacing.space2,
                    MuSpacing.space5,
                    MuSpacing.space8,
                  ),
                  children: [
                    if (Navigator.of(context).canPop()) ...[
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: MuIconButton(
                          icon: LucideIcons.arrowLeft,
                          tooltip: 'Back',
                          onPressed: () => context.pop(),
                        ),
                      ),
                      const SizedBox(height: MuSpacing.space3),
                    ],
                    Semantics(
                      header: true,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Learn with\n',
                              style: mu.text.displayLight.copyWith(
                                fontSize: 36,
                              ),
                            ),
                            TextSpan(
                              text: 'mentors',
                              style: mu.text.display.copyWith(fontSize: 36),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: MuSpacing.space2),
                    Text(
                      'Join a session a mentor is running, or ask for one in your interest groups.',
                      style: mu.text.body.copyWith(color: c.ink2),
                    ),
                    const SizedBox(height: MuSpacing.space5),
                    MuSegmented<_Tab>(
                      values: _Tab.values,
                      selected: _tab,
                      label: (t) => switch (t) {
                        _Tab.available => 'Available',
                        _Tab.requests => 'Requests',
                        _Tab.history => 'History',
                      },
                      onChanged: (t) => setState(() => _tab = t),
                    ),
                    const SizedBox(height: MuSpacing.space2),
                    ...switch (_tab) {
                      _Tab.available => _available(),
                      _Tab.requests => _requests(),
                      _Tab.history => _history(),
                    },
                  ],
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: c.chalk,
                border: Border(top: BorderSide(color: c.line)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  MuSpacing.space5,
                  MuSpacing.space3,
                  MuSpacing.space5,
                  MuSpacing.space3,
                ),
                child: MuButton(
                  label: 'Ask for a session',
                  icon: LucideIcons.messageSquarePlus,
                  block: true,
                  onPressed: () => _RequestSheet.show(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _states<T>(
    AsyncValue<T> value,
    ProviderOrFamily provider,
    List<Widget> Function(T data) data,
  ) => value.when(
    skipError: true,
    loading: () => const [
      Padding(
        padding: EdgeInsets.symmetric(vertical: MuSpacing.space8),
        child: Center(child: MuDotsLoader()),
      ),
    ],
    error: (e, _) => [
      const SizedBox(height: MuSpacing.space4),
      Row(
        children: [
          Expanded(child: MuEmptyLine(ApiException.messageFor(e))),
          MuButton(
            label: 'Retry',
            variant: MuButtonVariant.ghost,
            size: MuButtonSize.small,
            onPressed: () => ref.invalidate(provider),
          ),
        ],
      ),
    ],
    data: data,
  );

  List<Widget> _available() {
    final joined =
        ref.watch(joinedSessionIdsProvider).value ?? const <String>{};
    final today = ref.watch(clockProvider)().toLocal();
    return _states(
      ref.watch(availableSessionsProvider),
      availableSessionsProvider,
      (items) {
        if (items.isEmpty) {
          return const [
            SizedBox(height: MuSpacing.space4),
            MuEmptyLine(
              'No sessions open right now. Ask for one below and a mentor can pick it up.',
            ),
          ];
        }
        final days = <DateTime, List<AvailableSession>>{};
        for (final a in items) {
          final s = a.session.startsAt.toLocal();
          days.putIfAbsent(DateTime(s.year, s.month, s.day), () => []).add(a);
        }
        return [
          for (final MapEntry(key: day, value: list) in days.entries) ...[
            MuSectionEyebrow(
              formatDayHeading(day, today),
              top: MuSpacing.space4,
            ),
            MuFeedGroup(
              children: [
                for (var i = 0; i < list.length; i++)
                  _AvailableRow(
                    item: list[i],
                    joined: joined.contains(list[i].session.id),
                    last: i == list.length - 1,
                  ),
              ],
            ),
          ],
        ];
      },
    );
  }

  List<Widget> _requests() => _states(
    ref.watch(mySessionRequestsProvider),
    mySessionRequestsProvider,
    (items) {
      if (items.isEmpty) {
        return const [
          SizedBox(height: MuSpacing.space4),
          MuEmptyLine(
            "You haven't asked for a session yet. Need help with something? Ask below.",
          ),
        ];
      }
      return [
        const SizedBox(height: MuSpacing.space4),
        MuFeedGroup(
          children: [
            for (var i = 0; i < items.length; i++)
              MuFeedRow(
                leading: const MuFeedIcon(
                  LucideIcons.messageSquare,
                  tone: MuFeedTone.event,
                ),
                subject: items[i].title,
                time: [
                  formatDayTime(items[i].startsAt.toLocal()),
                  items[i].groupName,
                ].join(' · '),
                actions: [_requestPill(items[i].status)],
                divider: i < items.length - 1,
              ),
          ],
        ),
      ];
    },
  );

  List<Widget> _history() => _states(
    ref.watch(mySessionHistoryProvider),
    mySessionHistoryProvider,
    (items) {
      if (items.isEmpty) {
        return const [
          SizedBox(height: MuSpacing.space4),
          MuEmptyLine(
            'Sessions you join show up here, with a way to rate them after.',
          ),
        ];
      }
      final now = ref.watch(clockProvider)();
      return [
        const SizedBox(height: MuSpacing.space4),
        MuFeedGroup(
          children: [
            for (var i = 0; i < items.length; i++)
              MuFeedRow(
                leading: MuFeedIcon(
                  items[i].attendance == LearnerAttendance.attended
                      ? LucideIcons.checkCircle2
                      : LucideIcons.calendar,
                  tone: items[i].attendance == LearnerAttendance.attended
                      ? MuFeedTone.karma
                      : MuFeedTone.event,
                ),
                subject: items[i].session.title,
                time: [
                  formatDay(items[i].session.startsAt.toLocal()),
                  if (items[i].session.entityName.isNotEmpty)
                    items[i].session.entityName,
                ].join(' · '),
                actions: [
                  _recordPill(items[i], now),
                  if (items[i].feedback != null)
                    const MuPill(
                      'Feedback sent',
                      icon: LucideIcons.messageCircle,
                    ),
                ],
                trailing: items[i].canGiveFeedback
                    ? MuButton(
                        label: 'Rate it',
                        size: MuButtonSize.small,
                        variant: MuButtonVariant.outline,
                        onPressed: () =>
                            _FeedbackSheet.show(context, items[i].session),
                      )
                    : null,
                divider: i < items.length - 1,
                onTap: () =>
                    _SessionSheet.show(context, items[i].session, joined: true),
              ),
          ],
        ),
      ];
    },
  );
}

Widget _requestPill(SessionStatus s) => switch (s) {
  SessionStatus.requested => const MuPill(
    'Waiting for a mentor',
    tone: MuPillTone.warning,
    icon: LucideIcons.clock,
  ),
  SessionStatus.scheduled || SessionStatus.pendingApproval => const MuPill(
    'Approved',
    tone: MuPillTone.success,
    icon: LucideIcons.check,
  ),
  SessionStatus.completed => const MuPill('Done', icon: LucideIcons.check),
  SessionStatus.rejected => const MuPill(
    'Declined',
    tone: MuPillTone.danger,
    icon: LucideIcons.x,
  ),
  SessionStatus.cancelled => const MuPill('Cancelled', icon: LucideIcons.x),
  SessionStatus.unknown => const MuPill('Unknown'),
};

Widget _recordPill(SessionRecord r, DateTime now) {
  switch (r.session.status) {
    case SessionStatus.requested:
      return const MuPill(
        'Requested',
        tone: MuPillTone.warning,
        icon: LucideIcons.clock,
      );
    case SessionStatus.rejected:
      return const MuPill(
        'Declined',
        tone: MuPillTone.danger,
        icon: LucideIcons.x,
      );
    case SessionStatus.cancelled:
      return const MuPill('Cancelled', icon: LucideIcons.x);
    case _:
  }
  return switch (r.attendance) {
    LearnerAttendance.attended => const MuPill(
      'Attended',
      tone: MuPillTone.success,
      icon: LucideIcons.check,
    ),
    LearnerAttendance.absent => const MuPill(
      'Missed',
      tone: MuPillTone.danger,
      icon: LucideIcons.x,
    ),
    _ when now.isBefore(r.session.endsAt) => const MuPill(
      'Coming up',
      tone: MuPillTone.cobalt,
    ),
    _ => const MuPill('Joined'),
  };
}

/// An open session: its times on the left, title, mentor and group, and
/// Join (or Joined). Opens the session.
class _AvailableRow extends ConsumerWidget {
  const _AvailableRow({
    required this.item,
    required this.joined,
    required this.last,
  });

  final AvailableSession item;
  final bool joined;
  final bool last;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final s = item.session;
    return MuFeedRow(
      leading: SizedBox(
        width: 64,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formatTime(s.startsAt.toLocal()),
              style: mu.text.bodyStrong.copyWith(fontSize: 14),
            ),
            Text(formatTime(s.endsAt.toLocal()), style: mu.text.caption),
          ],
        ),
      ),
      subject: s.title,
      time: [
        item.mentorName,
        if (s.entityName.isNotEmpty) s.entityName,
      ].join(' · '),
      actions: [MuPill(sessionModeLabel(s.mode))],
      trailing: joined
          ? const MuPill(
              'Joined',
              tone: MuPillTone.success,
              icon: LucideIcons.check,
            )
          : _JoinButton(sessionId: s.id, title: s.title),
      divider: !last,
      onTap: () => _SessionSheet.show(
        context,
        s,
        mentorName: item.mentorName,
        joined: joined,
      ),
    );
  }
}

class _JoinButton extends ConsumerStatefulWidget {
  const _JoinButton({
    required this.sessionId,
    required this.title,
    this.block = false,
  });

  final String sessionId;
  final String title;
  final bool block;

  @override
  ConsumerState<_JoinButton> createState() => _JoinButtonState();
}

class _JoinButtonState extends ConsumerState<_JoinButton> {
  bool _busy = false;

  Future<void> _join() async {
    setState(() => _busy = true);
    final message = await ref
        .read(learnerSessionActionsProvider.notifier)
        .join(widget.sessionId);
    if (!mounted) return;
    setState(() => _busy = false);
    final error = ref.read(learnerSessionActionsProvider).error;
    MuToast.show(
      context,
      message: message ?? ApiException.messageFor(error ?? "Couldn't join"),
      type: message != null ? MuToastType.success : MuToastType.error,
    );
    if (message != null && widget.block) Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) => MuButton(
    label: 'Join',
    size: widget.block ? MuButtonSize.regular : MuButtonSize.small,
    variant: MuButtonVariant.volt,
    block: widget.block,
    loading: _busy,
    onPressed: _busy ? null : _join,
  );
}

/// A session's details in a sheet: when, who, where, what it's about, and
/// the link once you're in (or Join).
class _SessionSheet extends ConsumerWidget {
  const _SessionSheet({
    required this.session,
    required this.joined,
    this.mentorName,
  });

  final MentorSession session;
  final String? mentorName;
  final bool joined;

  static Future<void> show(
    BuildContext context,
    MentorSession session, {
    required bool joined,
    String? mentorName,
  }) => showMuSheet<void>(
    context,
    builder: (_) =>
        _SessionSheet(session: session, mentorName: mentorName, joined: joined),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final s = session;
    final starts = s.startsAt.toLocal();
    final ends = s.endsAt.toLocal();
    final venue = s.venue;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        MuSpacing.space5,
        0,
        MuSpacing.space5,
        MuSpacing.space5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(header: true, child: Text(s.title, style: mu.text.title2)),
          const SizedBox(height: MuSpacing.space2),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              MuPill(sessionModeLabel(s.mode)),
              if (s.entityName.isNotEmpty)
                MuPill(s.entityName, tone: MuPillTone.cobalt),
            ],
          ),
          const SizedBox(height: MuSpacing.space4),
          MuFeedGroup(
            children: [
              MuFeedRow(
                leading: const MuFeedIcon(
                  LucideIcons.calendar,
                  tone: MuFeedTone.event,
                ),
                subject: formatDay(starts),
                time: '${formatTime(starts)} – ${formatTime(ends)}',
                divider: mentorName != null,
              ),
              if (mentorName != null)
                MuFeedRow(
                  leading: MuAvatar(
                    name: mentorName!,
                    size: MuSizes.avatarMd,
                    ring: false,
                  ),
                  subject: mentorName!,
                  time: 'Mentor',
                  divider: false,
                ),
            ],
          ),
          if (s.description.isNotEmpty) ...[
            const SizedBox(height: MuSpacing.space4),
            Text(
              s.description,
              style: mu.text.body.copyWith(color: mu.colors.ink2),
            ),
          ],
          if (joined && venue != null) ...[
            const SizedBox(height: MuSpacing.space4),
            VenueRow(venue: venue),
          ],
          if (joined && s.meetingLink != null) ...[
            const SizedBox(height: MuSpacing.space4),
            MeetingLinkActions(session: s),
          ],
          if (!joined && s.status == SessionStatus.scheduled) ...[
            const SizedBox(height: MuSpacing.space5),
            _JoinButton(sessionId: s.id, title: s.title, block: true),
          ],
        ],
      ),
    );
  }
}

/// Rate an attended session (1–5) and say what helped. One of the two is
/// enough; the backend takes it once.
class _FeedbackSheet extends ConsumerStatefulWidget {
  const _FeedbackSheet({required this.session});

  final MentorSession session;

  static Future<void> show(BuildContext context, MentorSession session) =>
      showMuSheet<void>(
        context,
        builder: (_) => _FeedbackSheet(session: session),
      );

  @override
  ConsumerState<_FeedbackSheet> createState() => _FeedbackSheetState();
}

class _FeedbackSheetState extends ConsumerState<_FeedbackSheet> {
  final _text = TextEditingController();
  int? _rating;
  String? _error;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (_rating == null && _text.text.trim().isEmpty) {
      setState(() => _error = 'Pick a rating or write a line.');
      return;
    }
    final message = await ref
        .read(learnerSessionActionsProvider.notifier)
        .feedback(widget.session.id, rating: _rating, text: _text.text);
    if (!mounted) return;
    if (message == null) {
      setState(
        () => _error = ApiException.messageFor(
          ref.read(learnerSessionActionsProvider).error ?? 'Not sent',
        ),
      );
      return;
    }
    MuToast.show(context, message: message, type: MuToastType.success);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.mu.colors;
    final busy = ref.watch(learnerSessionActionsProvider).isLoading;
    return MuFormSheet(
      title: 'How was it?',
      lead: widget.session.title,
      action: MuButton(
        label: 'Send feedback',
        block: true,
        loading: busy,
        onPressed: busy ? null : _send,
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var n = 1; n <= 5; n++)
              Semantics(
                button: true,
                selected: _rating == n,
                label: 'Rate $n out of 5',
                excludeSemantics: true,
                child: InkResponse(
                  onTap: () => setState(() {
                    _rating = n;
                    _error = null;
                  }),
                  radius: 28,
                  child: Padding(
                    padding: const EdgeInsets.all(MuSpacing.space2),
                    child: Icon(
                      LucideIcons.star,
                      size: 34,
                      color: (_rating ?? 0) >= n ? c.warning : c.ink3,
                      fill: (_rating ?? 0) >= n ? 1 : 0,
                    ),
                  ),
                ),
              ),
          ],
        ),
        MuTextField(
          label: 'What helped? (optional)',
          controller: _text,
          hint: 'What you took away, or what could be better',
          maxLines: 5,
          minLines: 3,
          textCapitalization: TextCapitalization.sentences,
          onChanged: (_) {
            if (_error != null) setState(() => _error = null);
          },
        ),
        if (_error != null)
          Text(
            _error!,
            style: context.mu.text.caption.copyWith(color: c.danger),
          ),
      ],
    );
  }
}

/// Ask mentors for a session in one of your interest groups: what you need,
/// when, and how (online, in person or both).
class _RequestSheet extends ConsumerStatefulWidget {
  const _RequestSheet();

  static Future<void> show(BuildContext context) =>
      showMuSheet<void>(context, builder: (_) => const _RequestSheet());

  @override
  ConsumerState<_RequestSheet> createState() => _RequestSheetState();
}

class _RequestSheetState extends ConsumerState<_RequestSheet> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _about = TextEditingController();
  final _link = TextEditingController();
  final _venue = TextEditingController();
  String? _ig;
  SessionMode _mode = SessionMode.online;
  late DateTime _starts = () {
    final t = DateTime.now().add(const Duration(days: 1));
    return DateTime(t.year, t.month, t.day, 18);
  }();
  late DateTime _ends = _starts.add(const Duration(hours: 1));
  String? _timeError;

  @override
  void dispose() {
    for (final c in [_title, _about, _link, _venue]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pick({required bool start}) async {
    final picked = await pickDateTime(
      context,
      initial: start ? _starts : _ends,
    );
    if (picked == null || !mounted) return;
    setState(() {
      _timeError = null;
      if (start) {
        final length = _ends.difference(_starts);
        _starts = picked;
        _ends = picked.add(
          length.isNegative ? const Duration(hours: 1) : length,
        );
      } else {
        _ends = picked;
      }
    });
  }

  Future<void> _send() async {
    final valid = _formKey.currentState?.validate() ?? false;
    final timeError = !_starts.isAfter(DateTime.now())
        ? 'Pick a start time in the future.'
        : !_ends.isAfter(_starts)
        ? 'It has to end after it starts.'
        : null;
    setState(() => _timeError = timeError);
    if (!valid || timeError != null) return;
    final link = _link.text.trim();
    final message = await ref
        .read(learnerSessionActionsProvider.notifier)
        .request(
          SessionRequestDraft(
            igId: _ig!,
            title: _title.text.trim(),
            description: _about.text.trim(),
            mode: _mode,
            startsAt: _starts,
            endsAt: _ends,
            meetingLink: link.isEmpty || link.startsWith('http')
                ? link
                : 'https://$link',
            venue: _venue.text.trim(),
          ),
        );
    if (!mounted) return;
    final error = ref.read(learnerSessionActionsProvider).error;
    MuToast.show(
      context,
      message:
          message ??
          ApiException.messageFor(error ?? "Couldn't send the request"),
      type: message != null ? MuToastType.success : MuToastType.error,
    );
    if (message != null) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final igs = ref.watch(myIgChoicesProvider);
    final busy = ref.watch(learnerSessionActionsProvider).isLoading;
    final groups = igs.value ?? const <IgChoice>[];
    if (igs.hasValue && groups.isEmpty) {
      return MuFormSheet(
        title: 'Ask for a session',
        lead:
            'Mentors take requests in interest groups. Join one first, then ask here.',
        action: MuButton(
          label: 'Find interest groups',
          block: true,
          onPressed: () {
            Navigator.of(context).pop();
            unawaited(context.push(RoutePaths.interestGroups));
          },
        ),
        children: const [],
      );
    }
    return Form(
      key: _formKey,
      child: MuFormSheet(
        title: 'Ask for a session',
        lead: 'Mentors in the group see your request and can schedule it.',
        action: MuButton(
          label: 'Send request',
          block: true,
          loading: busy,
          onPressed: busy ? null : _send,
        ),
        children: [
          MuSelectField(
            label: 'Interest group',
            hint: 'Pick one of yours',
            options: [for (final g in groups) MuOption(g.id, g.name)],
            loading: igs.isLoading,
            value: _ig,
            onChanged: (v) => setState(() => _ig = v),
            validator: (_) => _ig == null ? 'Pick the group to ask in.' : null,
          ),
          MuTextField(
            label: 'What do you need help with?',
            controller: _title,
            hint: 'E.g. Getting started with React hooks',
            maxLength: 150,
            textCapitalization: TextCapitalization.sentences,
            validator: (v) =>
                (v ?? '').trim().isEmpty ? 'Give it a short title.' : null,
          ),
          MuTextField(
            label: 'Details',
            controller: _about,
            hint: 'Where you are and what you want to get out of it',
            maxLines: 5,
            minLines: 3,
            textCapitalization: TextCapitalization.sentences,
            validator: (v) =>
                (v ?? '').trim().isEmpty ? 'Add a line or two.' : null,
          ),
          MuFieldChrome(
            label: 'Starts',
            onTap: () => _pick(start: true),
            trailing: Icon(
              LucideIcons.calendar,
              size: MuSizes.iconSm,
              color: mu.colors.ink3,
            ),
            child: Text(formatDayTime(_starts), style: mu.text.body),
          ),
          MuFieldChrome(
            label: 'Ends',
            onTap: () => _pick(start: false),
            error: _timeError,
            trailing: Icon(
              LucideIcons.clock,
              size: MuSizes.iconSm,
              color: mu.colors.ink3,
            ),
            child: Text(formatDayTime(_ends), style: mu.text.body),
          ),
          MuSegmented<SessionMode>(
            values: const [
              SessionMode.online,
              SessionMode.offline,
              SessionMode.hybrid,
            ],
            selected: _mode,
            label: sessionModeLabel,
            onChanged: (m) => setState(() => _mode = m),
          ),
          if (_mode != SessionMode.offline)
            MuTextField(
              label: _mode == SessionMode.hybrid
                  ? 'Meeting link'
                  : 'Meeting link (optional)',
              controller: _link,
              hint: 'The mentor can add one when they approve',
              keyboardType: TextInputType.url,
              validator: (v) =>
                  _mode == SessionMode.hybrid && (v ?? '').trim().isEmpty
                  ? 'Hybrid sessions need a link.'
                  : null,
            ),
          if (_mode != SessionMode.online)
            MuTextField(
              label: _mode == SessionMode.hybrid ? 'Venue' : 'Venue (optional)',
              controller: _venue,
              hint: 'Where to meet',
              validator: (v) =>
                  _mode == SessionMode.hybrid && (v ?? '').trim().isEmpty
                  ? 'Hybrid sessions need a venue.'
                  : null,
            ),
        ],
      ),
    );
  }
}
