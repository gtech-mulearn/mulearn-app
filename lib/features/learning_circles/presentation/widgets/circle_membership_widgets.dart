import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/auth/current_user_claims.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_detail.dart';
import 'package:mulearn_app/features/learning_circles/domain/membership_rules.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/learning_circles_controller.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/meetings_controller.dart';

/// Leaving a circle (CircleLeaveAPI): members leave after confirming; a
/// lead hands leadership over first; the creator deletes the circle instead.
class CircleLeaveSection extends ConsumerWidget {
  const CircleLeaveSection({required this.circleId, required this.circleTitle, required this.role, super.key});

  final String circleId;
  final String circleTitle;
  final CircleRole role;

  Future<void> _leave(BuildContext context, WidgetRef ref) async {
    final confirmed = await showMuConfirm(
      context,
      title: 'Leave $circleTitle?',
      body: 'You can ask to join again later.',
      confirmLabel: 'Leave',
      destructive: true,
    );
    if (!confirmed || !context.mounted) return;
    final controller = ref.read(circleActionsControllerProvider.notifier);
    final left = await controller.leaveCircle(circleId);
    if (!context.mounted) return;
    if (left) {
      MuToast.show(context, message: 'You left $circleTitle', type: MuToastType.success);
      await Navigator.of(context).maybePop();
    } else {
      final error = ref.read(circleActionsControllerProvider).error;
      MuToast.show(
        context,
        message: ApiException.messageFor(error ?? "Couldn't leave the circle"),
        type: MuToastType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    switch (role) {
      case CircleRole.member:
        return Center(
          child: MuButton(
            label: 'Leave circle',
            icon: LucideIcons.logOut,
            variant: MuButtonVariant.ghost,
            onPressed: () => _leave(context, ref),
          ),
        );
      case CircleRole.lead:
        return Text(
          'You lead this circle. Transfer leadership before leaving.',
          textAlign: TextAlign.center,
          style: mu.text.caption,
        );
      case CircleRole.creator:
      case CircleRole.visitor:
        return const SizedBox.shrink();
    }
  }
}

/// A meeting's actions for the viewer (L9), like the dashboard: RSVP before
/// it starts, cancel the RSVP until 30 minutes before, join with the code
/// once it has started, leave after joining.
class MeetingActionsBar extends ConsumerWidget {
  const MeetingActionsBar({required this.meetingId, required this.meeting, required this.onJoinWithCode, super.key});

  final String meetingId;
  final MeetingDetail meeting;
  final VoidCallback onJoinWithCode;

  Future<void> _run(
    BuildContext context,
    WidgetRef ref,
    Future<void> Function(MeetingActionsController c) action, {
    required String success,
  }) async {
    final controller = ref.read(meetingActionsControllerProvider.notifier);
    await action(controller);
    if (!context.mounted) return;
    final error = ref.read(meetingActionsControllerProvider).error;
    MuToast.show(
      context,
      message: error == null ? success : ApiException.messageFor(error),
      type: error == null ? MuToastType.success : MuToastType.error,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final myId = ref.watch(currentUserIdProvider).value;
    final now = ref.watch(clockProvider)();
    final busy = ref.watch(meetingActionsControllerProvider).isLoading;
    final s = meetingViewerState(meeting, myUserId: myId, now: now);

    if (s.membersOnly) {
      return Text(
        'Only circle members can RSVP or join this meeting.',
        textAlign: TextAlign.center,
        style: mu.text.caption,
      );
    }
    if (s.canRsvp) {
      return MuButton(
        label: "RSVP · I'll be there",
        variant: MuButtonVariant.ink,
        knob: true,
        block: true,
        loading: busy,
        onPressed: busy ? null : () => _run(context, ref, (c) => c.rsvp(meetingId), success: "You're going"),
      );
    }
    if (s.canJoinWithCode) {
      return MuButton(
        label: 'Join with code',
        icon: LucideIcons.keyRound,
        block: true,
        onPressed: busy ? null : onJoinWithCode,
      );
    }
    if (s.canLeave) {
      return MuButton(
        label: 'Leave meeting',
        variant: MuButtonVariant.outline,
        block: true,
        loading: busy,
        onPressed: busy ? null : () => _run(context, ref, (c) => c.leave(meetingId), success: 'You left the meeting'),
      );
    }
    if (s.isRsvpd && !s.hasJoined) {
      return Row(
        children: [
          Icon(LucideIcons.checkCircle2, size: MuSizes.iconMd, color: c.success),
          const SizedBox(width: MuSpacing.space2),
          Expanded(
            child: Text("You're going", style: mu.text.bodyStrong.copyWith(color: c.success)),
          ),
          if (s.canCancelRsvp)
            MuButton(
              label: 'Cancel RSVP',
              variant: MuButtonVariant.ghost,
              size: MuButtonSize.small,
              onPressed: busy
                  ? null
                  : () => _run(context, ref, (c) => c.cancelRsvp(meetingId), success: 'RSVP cancelled'),
            )
          else
            Flexible(
              child: Text(
                'RSVPs close ${rsvpCancelCutoff.inMinutes} minutes before the start.',
                textAlign: TextAlign.end,
                style: mu.text.caption,
              ),
            ),
        ],
      );
    }
    return const SizedBox(height: MuSpacing.space1);
  }
}
