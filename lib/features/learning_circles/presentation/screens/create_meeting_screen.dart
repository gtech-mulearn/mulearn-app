import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_form.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/meetings_controller.dart';
import 'package:mulearn_app/features/learning_circles/presentation/widgets/meeting_form_fields.dart';

/// Schedule a meeting for a circle.
class CreateMeetingScreen extends ConsumerWidget {
  const CreateMeetingScreen({required this.circleId, super.key});

  final String circleId;

  Future<void> _submit(
    BuildContext context,
    WidgetRef ref,
    MeetingForm form,
  ) async {
    final ok = await ref
        .read(meetingActionsControllerProvider.notifier)
        .createMeeting(circleId, form);
    if (ok && context.mounted) {
      MuToast.show(
        context,
        message: 'Meeting scheduled',
        type: MuToastType.success,
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actionState = ref.watch(meetingActionsControllerProvider);
    return Scaffold(
      backgroundColor: context.mu.colors.chalk,
      body: SafeArea(
        child: Column(
          children: [
            const MuTopBar.detail(),
            Expanded(
              child: MeetingFormFields(
                title: 'New meeting',
                isSubmitting: actionState.isLoading,
                submitLabel: 'Schedule meeting',
                errorMessage: actionState.hasError
                    ? ApiException.messageFor(actionState.error!)
                    : null,
                onSubmit: (form) => _submit(context, ref, form),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
