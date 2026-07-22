import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_form.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/meetings_controller.dart';
import 'package:mulearn_app/features/learning_circles/presentation/widgets/meeting_form_fields.dart';

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
    if (ok && context.mounted) context.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actionState = ref.watch(meetingActionsControllerProvider);

    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(title: const Text('New Meeting')),
      body: MeetingFormFields(
        isSubmitting: actionState.isLoading,
        submitLabel: 'Create meeting',
        errorMessage:
            actionState.hasError ? ApiException.messageFor(actionState.error!) : null,
        onSubmit: (form) => _submit(context, ref, form),
      ),
    );
  }
}
