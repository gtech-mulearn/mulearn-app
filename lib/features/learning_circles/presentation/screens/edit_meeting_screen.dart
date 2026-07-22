import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_detail.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_form.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/meetings_controller.dart';
import 'package:mulearn_app/features/learning_circles/presentation/widgets/meeting_form_fields.dart';

class EditMeetingScreen extends ConsumerWidget {
  const EditMeetingScreen({required this.meetingId, super.key});

  final String meetingId;

  Future<void> _submit(
    BuildContext context,
    WidgetRef ref,
    MeetingForm form,
  ) async {
    await ref
        .read(meetingActionsControllerProvider.notifier)
        .editMeeting(meetingId, form);
    if (!context.mounted) return;
    final state = ref.read(meetingActionsControllerProvider);
    if (!state.hasError) context.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(meetingDetailProvider(meetingId));
    final actionState = ref.watch(meetingActionsControllerProvider);

    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(title: const Text('Edit Meeting')),
      body: detailState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorRetryView(
          error: error,
          onRetry: () => ref.invalidate(meetingDetailProvider(meetingId)),
        ),
        data: (meeting) => MeetingFormFields(
          initial: _formFromDetail(meeting),
          isSubmitting: actionState.isLoading,
          submitLabel: 'Save changes',
          errorMessage: actionState.hasError
              ? ApiException.messageFor(actionState.error!)
              : null,
          onSubmit: (form) => _submit(context, ref, form),
        ),
      ),
    );
  }

  /// The meeting-detail response doesn't carry `platform` as its own field
  /// (only `meet_place`, which the create flow sets to the platform name
  /// for online meetings by convention) — prefilling from that convention
  /// is the best available signal, not a guess made up independently.
  MeetingForm _formFromDetail(MeetingDetail meeting) => MeetingForm(
        title: meeting.title,
        description: meeting.description,
        mode: meeting.mode,
        meetPlace: meeting.meetPlace,
        meetTime: meeting.meetTime,
        duration: meeting.duration,
        isRecurring: meeting.isRecurring,
        isReportNeeded: meeting.isReportNeeded,
        platform: meeting.mode == 'online' ? meeting.meetPlace : null,
        meetLink: meeting.meetLink,
        reportDescription: meeting.reportDescription,
      );
}
