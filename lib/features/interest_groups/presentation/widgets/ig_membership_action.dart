import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/features/interest_groups/presentation/providers/interest_groups_controller.dart';

/// What a learner at the cap is told, before any request.
const igCapMessage =
    "You're in $maxLearnerGroups of $maxLearnerGroups groups. Leave one to join another.";

/// Joins or leaves [name] (id [id]) from anywhere it is offered: says so at
/// the cap instead of calling the backend, confirms a leave (you lose its
/// tasks and events), then reports the outcome as a toast.
Future<void> toggleIgMembership(
  BuildContext context,
  WidgetRef ref, {
  required String id,
  required String name,
  required bool join,
}) async {
  if (join) {
    final mine = ref.read(myInterestGroupIdsProvider).value ?? const <String>[];
    if (mine.length >= maxLearnerGroups) {
      MuToast.show(context, message: igCapMessage, type: MuToastType.error);
      return;
    }
  } else {
    final confirmed = await showMuConfirm(
      context,
      title: 'Leave $name?',
      body:
          "You'll stop seeing its tasks and events. You can join again later.",
      confirmLabel: 'Leave',
      destructive: true,
    );
    if (!confirmed || !context.mounted) return;
  }
  await ref
      .read(interestGroupMembershipControllerProvider.notifier)
      .toggle(id, join: join);
  if (!context.mounted) return;
  final error = ref.read(interestGroupMembershipControllerProvider).error;
  MuToast.show(
    context,
    message: error != null
        ? ApiException.messageFor(error)
        : (join ? 'You joined $name' : 'You left $name'),
    type: error != null ? MuToastType.error : MuToastType.success,
  );
}
