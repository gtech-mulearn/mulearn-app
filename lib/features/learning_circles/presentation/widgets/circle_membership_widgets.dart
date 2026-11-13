import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/auth/current_user_claims.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_detail.dart';
import 'package:mulearn_app/features/learning_circles/domain/membership_rules.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/learning_circles_controller.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/meetings_controller.dart';

/// Leaving a circle (CircleLeaveAPI): members leave after confirming; a
/// lead hands leadership over first; the creator deletes the circle instead.
class CircleLeaveSection extends ConsumerWidget {
  const CircleLeaveSection({
    required this.circleId,
    required this.circleTitle,
    required this.role,
    super.key,
  });

  final String circleId;
  final String circleTitle;
  final CircleRole role;

  Future<void> _leave(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Leave $circleTitle?'),
        content: const Text('You can ask to join again later.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: const Text('Leave')),
        ],
      ),
    );
    if (!(confirmed ?? false) || !context.mounted) return;
    final controller = ref.read(circleActionsControllerProvider.notifier);
    final left = await controller.leaveCircle(circleId);
    if (!context.mounted) return;
    if (left) {
      MuToast.show(context, message: 'You left $circleTitle', type: MuToastType.success);
      await Navigator.of(context).maybePop();
    } else {
      final error = ref.read(circleActionsControllerProvider).error;
      MuToast.show(context, message: ApiException.messageFor(error ?? "Couldn't leave the circle"), type: MuToastType.error);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (role) {
      case CircleRole.member:
        return Center(
          child: TextButton(
            onPressed: () => _leave(context, ref),
            child: Text('Leave circle', style: MuType.bodyMed.copyWith(color: MuColors.error)),
          ),
        );
      case CircleRole.lead:
        return Text(
          'You lead this circle. Transfer leadership before leaving.',
          textAlign: TextAlign.center,
          style: MuType.caption.copyWith(color: MuColors.inkSecondary),
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
  const MeetingActionsBar({
    required this.meetingId,
    required this.meeting,
    required this.onJoinWithCode,
    super.key,
  });

  final String meetingId;
  final MeetingDetail meeting;
  final VoidCallback onJoinWithCode;

  Future<void> _run(BuildContext context, WidgetRef ref, Future<void> Function(MeetingActionsController c) action,
      {required String success}) async {
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
    final myId = ref.watch(currentUserIdProvider).value;
    final now = ref.watch(clockProvider)();
    final busy = ref.watch(meetingActionsControllerProvider).isLoading;
    final s = meetingViewerState(meeting, myUserId: myId, now: now);

    if (s.membersOnly) {
      return Text(
        'Only circle members can RSVP or join this meeting.',
        style: MuType.caption.copyWith(color: MuColors.inkSecondary),
      );
    }
    if (s.canRsvp) {
      return MuPrimaryButton(
        label: 'RSVP',
        onPressed: busy ? null : () => _run(context, ref, (c) => c.rsvp(meetingId), success: "You're going"),
      );
    }
    if (s.canJoinWithCode) {
      return MuPrimaryButton(label: 'Join with code', onPressed: busy ? null : onJoinWithCode);
    }
    if (s.canLeave) {
      return MuGhostButton(
        label: 'Leave meeting',
        onPressed: busy ? null : () => _run(context, ref, (c) => c.leave(meetingId), success: 'You left the meeting'),
      );
    }
    if (s.isRsvpd && !s.hasJoined) {
      return Row(
        children: [
          Expanded(child: Text("You're going", style: MuType.bodyMed.copyWith(color: MuColors.success))),
          if (s.canCancelRsvp)
            TextButton(
              onPressed: busy
                  ? null
                  : () => _run(context, ref, (c) => c.cancelRsvp(meetingId), success: 'RSVP cancelled'),
              child: const Text('Cancel RSVP'),
            )
          else
            Flexible(
              child: Text(
                'RSVPs close ${rsvpCancelCutoff.inMinutes} minutes before the start.',
                textAlign: TextAlign.end,
                style: MuType.caption.copyWith(color: MuColors.inkSecondary),
              ),
            ),
        ],
      );
    }
    return const SizedBox(height: MuSpace.xs);
  }
}
