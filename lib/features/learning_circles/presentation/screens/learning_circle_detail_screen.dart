import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/auth/current_user_claims.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_load_more_footer.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/circle_member.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/learning_circle_detail.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting.dart';
import 'package:mulearn_app/features/learning_circles/domain/membership_rules.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/learning_circles_controller.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/meetings_controller.dart';
import 'package:mulearn_app/features/learning_circles/presentation/widgets/circle_membership_widgets.dart';

/// "Tue 17 Nov · 6:00 PM" from the backend's meeting time, or the raw text.
String _meetingWhen(String raw) {
  final t = DateTime.tryParse(raw)?.toLocal();
  return t == null ? raw : formatDayTime(t);
}

/// Toasts what a circle action did: [success], or the backend's reason.
void _report(BuildContext context, WidgetRef ref, String success) {
  if (!context.mounted) return;
  final error = ref.read(circleActionsControllerProvider).error;
  MuToast.show(
    context,
    message: error == null ? success : ApiException.messageFor(error),
    type: error == null ? MuToastType.success : MuToastType.error,
  );
}

/// One circle: its members in the ring with the title and numbers, the
/// next meeting with RSVP, every meeting, the people, and (for leads) join
/// requests and invites. Visitors get Ask to join pinned at the bottom;
/// leads edit from the top bar.
class LearningCircleDetailScreen extends ConsumerWidget {
  const LearningCircleDetailScreen({required this.circleId, super.key});

  final String circleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(circleDetailProvider(circleId));
    final detail = detailState.value;
    final myMuid = ref.watch(currentUserMuidProvider).value;
    final members =
        ref.watch(circleMembersProvider(circleId)).value?.members ??
        const <CircleMember>[];
    final role = detail == null
        ? CircleRole.visitor
        : circleRole(
            myMuid: myMuid,
            creatorMuid: detail.createdBy.muid,
            members: members,
          );
    final isLead = role == CircleRole.lead || role == CircleRole.creator;

    return Scaffold(
      backgroundColor: context.mu.colors.chalk,
      body: SafeArea(
        child: Column(
          children: [
            MuTopBar.detail(
              action: isLead && detail != null
                  ? MuIconButton(
                      icon: LucideIcons.pencil,
                      tooltip: 'Edit circle',
                      onPressed: () => showMuSheet<void>(
                        context,
                        builder: (_) => _EditCircleSheet(
                          detail: detail,
                          canDelete: role == CircleRole.creator,
                        ),
                      ),
                    )
                  : null,
            ),
            Expanded(
              child: detailState.when(
                skipError: true,
                loading: () => const Center(
                  child: MuDotsLoader(label: 'Loading the circle…'),
                ),
                error: (error, _) => ErrorRetryView(
                  error: error,
                  onRetry: () => ref.invalidate(circleDetailProvider(circleId)),
                ),
                data: (d) => _Body(
                  circleId: circleId,
                  detail: d,
                  members: members,
                  role: role,
                  isLead: isLead,
                  myMuid: myMuid,
                ),
              ),
            ),
            // Members load first, so the bar doesn't flash for people already in.
            if (detail != null &&
                role == CircleRole.visitor &&
                members.isNotEmpty)
              _AskToJoinBar(circleId: circleId),
          ],
        ),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({
    required this.circleId,
    required this.detail,
    required this.members,
    required this.role,
    required this.isLead,
    required this.myMuid,
  });

  final String circleId;
  final LearningCircleDetail detail;
  final List<CircleMember> members;
  final CircleRole role;
  final bool isLead;
  final String? myMuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final total = detail.totalMembers ?? members.length;

    return MuRefresh(
      onRefresh: () => Future.wait([
        ref.refresh(circleDetailProvider(circleId).future),
        ref.refresh(circleMembersProvider(circleId).future),
        ref.refresh(circleMeetingsControllerProvider(circleId).future),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MuIgChip(name: detail.ig, category: IgCategory.others),
                    const SizedBox(height: MuSpacing.space3),
                    Semantics(
                      header: true,
                      child: Text(
                        detail.title,
                        style: mu.text.display.copyWith(
                          fontSize: 32,
                          height: 1.05,
                        ),
                      ),
                    ),
                    if (detail.org != null && detail.org!.isNotEmpty) ...[
                      const SizedBox(height: MuSpacing.space2),
                      Text(
                        detail.org!,
                        style: mu.text.body.copyWith(color: c.ink2),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: MuSpacing.space5),
          Row(
            children: [
              Expanded(
                child: _Stat(
                  value: muGrouped(total),
                  label: total == 1 ? 'member' : 'members',
                ),
              ),
              const SizedBox(width: MuSpacing.space2),
              Expanded(
                child: _Stat(
                  value: muGrouped(detail.totalKarma ?? 0),
                  label: 'karma',
                  volt: true,
                ),
              ),
              if ((detail.rank ?? 0) > 0) ...[
                const SizedBox(width: MuSpacing.space2),
                Expanded(
                  child: _Stat(value: '#${detail.rank}', label: 'rank'),
                ),
              ],
            ],
          ),
          if (detail.description.trim().isNotEmpty) ...[
            const SizedBox(height: MuSpacing.space5),
            Text(
              detail.description.trim(),
              style: mu.text.body.copyWith(color: c.ink2, height: 1.55),
            ),
          ],
          _Meetings(circleId: circleId, isLead: isLead),
          _Eyebrow(
            'MEMBERS · $total',
            action: isLead
                ? MuButton(
                    label: 'Invite',
                    icon: LucideIcons.userPlus,
                    variant: MuButtonVariant.ghost,
                    size: MuButtonSize.small,
                    onPressed: () => showMuSheet<void>(
                      context,
                      builder: (_) => _InviteSheet(circleId: circleId),
                    ),
                  )
                : null,
          ),
          MuFeedGroup(
            children: [
              for (var i = 0; i < members.length; i++)
                _MemberRow(
                  member: members[i],
                  circleId: circleId,
                  canMakeLead: isLead && !members[i].isLeader,
                  canRemove: canRemoveMember(
                    viewer: role,
                    member: members[i],
                    myMuid: myMuid,
                    creatorMuid: detail.createdBy.muid,
                  ),
                  last: i == members.length - 1,
                ),
            ],
          ),
          if (isLead) ...[
            _JoinRequests(circleId: circleId),
            _SentInvites(circleId: circleId),
          ],
          const SizedBox(height: MuSpacing.space6),
          CircleLeaveSection(
            circleId: circleId,
            circleTitle: detail.title,
            role: role,
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label, this.volt = false});

  final String value;
  final String label;
  final bool volt;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return Semantics(
      label: '$value $label',
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: MuSpacing.space4),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(MuRadii.control),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: mu.text.numeral.copyWith(
                fontSize: 26,
                color: volt ? c.voltText : c.ink,
              ),
            ),
            Text(label, style: mu.text.caption),
          ],
        ),
      ),
    );
  }
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow(this.text, {this.action});

  final String text;
  final Widget? action;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(
      top: MuSpacing.space8,
      bottom: action == null ? MuSpacing.space3 : MuSpacing.space1,
    ),
    child: Row(
      children: [
        Expanded(
          child: Semantics(
            header: true,
            child: Text(text, style: context.mu.text.eyebrow),
          ),
        ),
        ?action,
      ],
    ),
  );
}

/// The next meeting (a night slab with RSVP), then every meeting as rows.
class _Meetings extends ConsumerWidget {
  const _Meetings({required this.circleId, required this.isLead});

  final String circleId;
  final bool isLead;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final state = ref.watch(circleMeetingsControllerProvider(circleId));
    final newMeeting = isLead
        ? MuButton(
            label: 'New',
            icon: LucideIcons.plus,
            variant: MuButtonVariant.ghost,
            size: MuButtonSize.small,
            onPressed: () =>
                context.push(RoutePaths.createMeetingPath(circleId)),
          )
        : null;

    return state.when(
      loading: () => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Eyebrow('MEETINGS', action: newMeeting),
          const Padding(
            padding: EdgeInsets.all(MuSpacing.space4),
            child: Center(child: MuDotsLoader(label: 'Loading meetings…')),
          ),
        ],
      ),
      error: (error, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Eyebrow('MEETINGS', action: newMeeting),
          Text(
            ApiException.messageFor(error),
            style: mu.text.body.copyWith(color: mu.colors.danger),
          ),
        ],
      ),
      data: (paged) {
        final meetings = paged.items;
        final upcoming = meetings.where((m) => !m.isEnded).toList()
          ..sort((a, b) {
            final at = DateTime.tryParse(a.meetTime);
            final bt = DateTime.tryParse(b.meetTime);
            if (at == null || bt == null) return 0;
            return at.compareTo(bt);
          });
        final next = upcoming.firstOrNull;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (next != null) ...[
              const _Eyebrow('NEXT MEETING'),
              _NextMeeting(meeting: next, circleId: circleId),
            ],
            _Eyebrow(
              meetings.isEmpty ? 'MEETINGS' : 'ALL MEETINGS',
              action: newMeeting,
            ),
            if (meetings.isEmpty)
              Text(
                isLead
                    ? 'No meetings yet. Set the first one with New.'
                    : 'No meetings scheduled yet.',
                style: mu.text.body.copyWith(color: mu.colors.ink3),
              )
            else
              MuFeedGroup(
                children: [
                  for (var i = 0; i < meetings.length; i++)
                    _MeetingRow(
                      meeting: meetings[i],
                      circleId: circleId,
                      last: i == meetings.length - 1,
                    ),
                ],
              ),
            if (paged.hasMore &&
                (paged.isLoadingMore || paged.loadMoreError != null))
              MuLoadMoreFooter(
                isLoading: paged.isLoadingMore,
                error: paged.loadMoreError,
                onRetry: () => ref
                    .read(circleMeetingsControllerProvider(circleId).notifier)
                    .loadMore(),
              )
            else if (paged.hasMore)
              Center(
                child: MuButton(
                  label: 'Show more meetings',
                  variant: MuButtonVariant.ghost,
                  onPressed: () => ref
                      .read(circleMeetingsControllerProvider(circleId).notifier)
                      .loadMore(),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _NextMeeting extends ConsumerWidget {
  const _NextMeeting({required this.meeting, required this.circleId});

  final Meeting meeting;
  final String circleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final busy = ref.watch(meetingActionsControllerProvider).isLoading;
    void open() =>
        context.push(RoutePaths.meetingDetailPath(meeting.id), extra: circleId);

    return Semantics(
      container: true,
      button: true,
      label:
          '${meeting.title}, ${_meetingWhen(meeting.meetTime)}, ${meeting.mode}',
      explicitChildNodes: true,
      child: MuPressable(
        onTap: open,
        pressedScale: 0.99,
        child: Container(
          padding: const EdgeInsets.all(MuSpacing.space5),
          decoration: BoxDecoration(
            color: c.night,
            borderRadius: BorderRadius.circular(MuRadii.card),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (meeting.isStarted)
                    const MuPill('Live now', tone: MuPillTone.volt)
                  else
                    MuPill(meeting.mode, tone: MuPillTone.paper),
                  const Spacer(),
                  Text(
                    meeting.attendeesCount == 1
                        ? '1 going'
                        : '${meeting.attendeesCount} going',
                    style: mu.text.caption.copyWith(color: c.onNight2),
                  ),
                ],
              ),
              const SizedBox(height: MuSpacing.space4),
              Text(
                meeting.title,
                style: mu.text.title2.copyWith(color: c.onNight),
              ),
              const SizedBox(height: MuSpacing.space1),
              Text(
                _meetingWhen(meeting.meetTime),
                style: mu.text.body.copyWith(color: c.onNight2),
              ),
              const SizedBox(height: MuSpacing.space4),
              if (meeting.isRsvp)
                Row(
                  children: [
                    Icon(
                      LucideIcons.checkCircle2,
                      size: MuSizes.iconMd,
                      color: c.volt,
                    ),
                    const SizedBox(width: MuSpacing.space2),
                    Text(
                      "You're in",
                      style: mu.text.bodyStrong.copyWith(color: c.onNight),
                    ),
                  ],
                )
              else
                MuButton(
                  label: "I'll be there",
                  variant: MuButtonVariant.volt,
                  block: true,
                  loading: busy,
                  onPressed: busy
                      ? null
                      : () async {
                          await ref
                              .read(meetingActionsControllerProvider.notifier)
                              .rsvp(meeting.id);
                          ref.invalidate(
                            circleMeetingsControllerProvider(circleId),
                          );
                        },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MeetingRow extends StatelessWidget {
  const _MeetingRow({
    required this.meeting,
    required this.circleId,
    required this.last,
  });

  final Meeting meeting;
  final String circleId;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final m = meeting;
    return MuFeedRow(
      leading: MuFeedIcon(
        m.isStarted && !m.isEnded ? LucideIcons.radio : LucideIcons.calendar,
        tone: m.isEnded
            ? MuFeedTone.neutral
            : (m.isStarted ? MuFeedTone.karma : MuFeedTone.event),
      ),
      subject: m.title,
      time: [
        _meetingWhen(m.meetTime),
        m.mode,
        if (m.isEnded) 'Ended' else if (m.isStarted) 'Live now',
      ].join(' · '),
      trailing: Text(
        '${m.attendeesCount} going',
        style: context.mu.text.caption,
      ),
      divider: !last,
      onTap: () =>
          context.push(RoutePaths.meetingDetailPath(m.id), extra: circleId),
    );
  }
}

class _MemberRow extends ConsumerWidget {
  const _MemberRow({
    required this.member,
    required this.circleId,
    required this.canMakeLead,
    required this.canRemove,
    required this.last,
  });

  final CircleMember member;
  final String circleId;
  final bool canMakeLead;

  /// The viewer leads or created the circle, and this isn't them or the creator.
  final bool canRemove;
  final bool last;

  Future<void> _makeLead(BuildContext context, WidgetRef ref) async {
    final ok = await showMuConfirm(
      context,
      title: 'Make ${member.fullName} the lead?',
      body: 'They run the circle from now on: meetings, requests and invites.',
      confirmLabel: 'Make lead',
    );
    if (!ok || !context.mounted) return;
    await ref
        .read(circleActionsControllerProvider.notifier)
        .transferLead(circleId, muid: member.muid);
    if (context.mounted) {
      _report(context, ref, '${member.fullName} leads the circle now');
    }
  }

  Future<void> _remove(BuildContext context, WidgetRef ref) async {
    final ok = await showMuConfirm(
      context,
      title: 'Remove ${member.fullName} from the circle?',
      confirmLabel: 'Remove',
      destructive: true,
    );
    if (!ok || !context.mounted) return;
    await ref
        .read(circleActionsControllerProvider.notifier)
        .removeMember(circleId, muid: member.muid);
    if (context.mounted) {
      _report(context, ref, '${member.fullName} was removed');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MuFeedRow(
      leading: MuAvatar(
        name: member.fullName,
        url: member.profilePicUrl,
        size: MuSizes.avatarMd,
      ),
      subject: member.fullName,
      time: member.muid,
      trailing: member.isLeader
          ? const MuPill('Lead', tone: MuPillTone.volt)
          : null,
      divider: !last,
      onTap: () => context.push(RoutePaths.publicProfilePath(member.muid)),
      actions: [
        if (canMakeLead)
          MuButton(
            label: 'Make lead',
            variant: MuButtonVariant.outline,
            size: MuButtonSize.small,
            onPressed: () => _makeLead(context, ref),
          ),
        if (canRemove)
          MuButton(
            label: 'Remove',
            variant: MuButtonVariant.ghost,
            size: MuButtonSize.small,
            onPressed: () => _remove(context, ref),
          ),
      ],
    );
  }
}

class _JoinRequests extends ConsumerWidget {
  const _JoinRequests({required this.circleId});

  final String circleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final requests = ref.watch(circleJoinRequestsProvider(circleId));
    final busy = ref.watch(circleActionsControllerProvider).isLoading;
    final list = requests.value ?? const [];

    Future<void> respond(
      String linkId,
      String name, {
      required bool accept,
    }) async {
      await ref
          .read(circleActionsControllerProvider.notifier)
          .respondToJoinRequest(circleId, linkId: linkId, accept: accept);
      if (context.mounted) {
        _report(
          context,
          ref,
          accept ? '$name joined the circle' : 'Request declined',
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Eyebrow(list.isEmpty ? 'REQUESTS' : 'REQUESTS · ${list.length}'),
        if (requests.hasError)
          Text(
            ApiException.messageFor(requests.error!),
            style: mu.text.body.copyWith(color: mu.colors.danger),
          )
        else if (requests.isLoading && list.isEmpty)
          const Center(child: MuDotsLoader(label: 'Loading requests…'))
        else if (list.isEmpty)
          Text(
            'No one is waiting to join.',
            style: mu.text.body.copyWith(color: mu.colors.ink3),
          )
        else
          MuFeedGroup(
            children: [
              for (var i = 0; i < list.length; i++)
                MuFeedRow(
                  leading: MuAvatar(
                    name: list[i].fullName,
                    url: list[i].profilePicUrl,
                    size: MuSizes.avatarMd,
                  ),
                  subject: list[i].fullName,
                  body: 'wants to join.',
                  time: list[i].muid,
                  divider: i < list.length - 1,
                  onTap: () =>
                      context.push(RoutePaths.publicProfilePath(list[i].muid)),
                  actions: [
                    MuButton(
                      label: 'Accept',
                      size: MuButtonSize.small,
                      onPressed: busy
                          ? null
                          : () => respond(
                              list[i].linkId,
                              list[i].fullName,
                              accept: true,
                            ),
                    ),
                    MuButton(
                      label: 'Decline',
                      variant: MuButtonVariant.outline,
                      size: MuButtonSize.small,
                      onPressed: busy
                          ? null
                          : () => respond(
                              list[i].linkId,
                              list[i].fullName,
                              accept: false,
                            ),
                    ),
                  ],
                ),
            ],
          ),
      ],
    );
  }
}

class _SentInvites extends ConsumerWidget {
  const _SentInvites({required this.circleId});

  final String circleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final invites = ref.watch(circleSentInvitesProvider(circleId));
    final list = invites.value ?? const [];
    if (invites.isLoading && list.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _Eyebrow('INVITES SENT'),
        if (invites.hasError)
          Text(
            ApiException.messageFor(invites.error!),
            style: mu.text.body.copyWith(color: mu.colors.danger),
          )
        else if (list.isEmpty)
          Text(
            'No invites sent yet.',
            style: mu.text.body.copyWith(color: mu.colors.ink3),
          )
        else
          MuFeedGroup(
            children: [
              for (var i = 0; i < list.length; i++)
                MuFeedRow(
                  leading: MuAvatar(
                    name: list[i].fullName,
                    url: list[i].profilePicUrl,
                    size: MuSizes.avatarMd,
                  ),
                  subject: list[i].fullName,
                  time: [
                    list[i].muid,
                    if (list[i].isLeadInvite) 'as co-lead',
                  ].join(' · '),
                  trailing: list[i].status.toLowerCase() == 'accepted'
                      ? MuPill(
                          _statusLabel(list[i].status),
                          tone: MuPillTone.success,
                          icon: LucideIcons.check,
                        )
                      : MuPill(_statusLabel(list[i].status)),
                  divider: i < list.length - 1,
                  onTap: () =>
                      context.push(RoutePaths.publicProfilePath(list[i].muid)),
                ),
            ],
          ),
      ],
    );
  }

  static String _statusLabel(String raw) {
    final s = raw.trim();
    return s.isEmpty
        ? 'Sent'
        : '${s[0].toUpperCase()}${s.substring(1).toLowerCase()}';
  }
}

/// Visitors: ask the lead to let you in.
class _AskToJoinBar extends ConsumerStatefulWidget {
  const _AskToJoinBar({required this.circleId});

  final String circleId;

  @override
  ConsumerState<_AskToJoinBar> createState() => _AskToJoinBarState();
}

class _AskToJoinBarState extends ConsumerState<_AskToJoinBar> {
  bool _sent = false;

  @override
  Widget build(BuildContext context) {
    final c = context.mu.colors;
    final busy = ref.watch(circleActionsControllerProvider).isLoading;
    return DecoratedBox(
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
        child: _sent
            ? const MuButton(
                label: 'Request sent',
                icon: LucideIcons.check,
                variant: MuButtonVariant.outline,
                block: true,
                onPressed: null,
              )
            : MuButton(
                label: 'Ask to join',
                variant: MuButtonVariant.ink,
                knob: true,
                block: true,
                loading: busy,
                onPressed: busy
                    ? null
                    : () async {
                        await ref
                            .read(circleActionsControllerProvider.notifier)
                            .requestToJoin(widget.circleId);
                        if (!context.mounted) return;
                        final failed = ref
                            .read(circleActionsControllerProvider)
                            .hasError;
                        _report(
                          context,
                          ref,
                          'Request sent to the circle lead.',
                        );
                        if (!failed) setState(() => _sent = true);
                      },
              ),
      ),
    );
  }
}

/// Invite someone by muid, optionally as co-lead.
class _InviteSheet extends ConsumerStatefulWidget {
  const _InviteSheet({required this.circleId});

  final String circleId;

  @override
  ConsumerState<_InviteSheet> createState() => _InviteSheetState();
}

class _InviteSheetState extends ConsumerState<_InviteSheet> {
  final _muid = TextEditingController();
  bool _asLead = false;

  @override
  void dispose() {
    _muid.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final muid = _muid.text.trim();
    if (muid.isEmpty) return;
    await ref
        .read(circleActionsControllerProvider.notifier)
        .sendInvite(widget.circleId, muid: muid, asLead: _asLead);
    if (!mounted) return;
    final failed = ref.read(circleActionsControllerProvider).hasError;
    _report(context, ref, 'Invite sent to $muid');
    if (!failed) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final busy = ref.watch(circleActionsControllerProvider).isLoading;
    return MuFormSheet(
      title: 'Invite someone',
      lead: 'They get a notification and can accept from their circles.',
      action: MuButton(
        label: 'Send invite',
        block: true,
        loading: busy,
        onPressed: busy ? null : _send,
      ),
      children: [
        MuTextField(
          label: 'Their muid',
          controller: _muid,
          hint: 'name@mulearn',
          autofocus: true,
          keyboardType: TextInputType.emailAddress,
          onSubmitted: (_) => _send(),
        ),
        MuSwitchTile(
          label: 'Invite as co-lead',
          subtitle: 'Co-leads can schedule meetings and handle requests.',
          value: _asLead,
          onChanged: (v) => setState(() => _asLead = v),
        ),
      ],
    );
  }
}

/// Rename or describe the circle; the creator can delete it from here.
class _EditCircleSheet extends ConsumerStatefulWidget {
  const _EditCircleSheet({required this.detail, required this.canDelete});

  final LearningCircleDetail detail;
  final bool canDelete;

  @override
  ConsumerState<_EditCircleSheet> createState() => _EditCircleSheetState();
}

class _EditCircleSheetState extends ConsumerState<_EditCircleSheet> {
  late final _title = TextEditingController(text: widget.detail.title);
  late final _description = TextEditingController(
    text: widget.detail.description,
  );

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    await ref
        .read(circleActionsControllerProvider.notifier)
        .editCircle(
          widget.detail.id,
          title: _title.text.trim(),
          description: _description.text.trim(),
        );
    if (!mounted) return;
    final failed = ref.read(circleActionsControllerProvider).hasError;
    _report(context, ref, 'Circle saved');
    if (!failed) Navigator.of(context).pop();
  }

  Future<void> _delete() async {
    final ok = await showMuConfirm(
      context,
      title: 'Delete ${widget.detail.title}?',
      body: 'Its meetings and members go with it. This cannot be undone.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (!ok || !mounted) return;
    final deleted = await ref
        .read(circleActionsControllerProvider.notifier)
        .deleteCircle(widget.detail.id);
    if (!mounted) return;
    _report(context, ref, 'Circle deleted');
    if (deleted) {
      Navigator.of(context).pop(); // the sheet
      if (context.mounted) context.pop(); // the circle
    }
  }

  @override
  Widget build(BuildContext context) {
    final busy = ref.watch(circleActionsControllerProvider).isLoading;
    return MuFormSheet(
      title: 'Edit circle',
      action: MuButton(
        label: 'Save',
        block: true,
        loading: busy,
        onPressed: busy ? null : _save,
      ),
      children: [
        MuTextField(
          label: 'Title',
          controller: _title,
          textCapitalization: TextCapitalization.sentences,
        ),
        MuTextField(
          label: 'Description',
          controller: _description,
          maxLines: 5,
          minLines: 3,
          textCapitalization: TextCapitalization.sentences,
        ),
        if (widget.canDelete)
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: MuButton(
              label: 'Delete circle',
              icon: LucideIcons.trash2,
              variant: MuButtonVariant.danger,
              size: MuButtonSize.small,
              onPressed: busy ? null : () => unawaited(_delete()),
            ),
          ),
      ],
    );
  }
}
