import 'package:freezed_annotation/freezed_annotation.dart';

part 'meeting_form.freezed.dart';

/// Fields for creating or editing a meeting — confirmed live (rules.md
/// §3/§9): `platform` is required whenever `mode == 'online'` ("platform is
/// required for online meetings. Choices: Zoom, Google Meet, Microsoft
/// Teams, Discord, Other"), and `meet_place` may not be blank even for
/// online meetings.
@freezed
abstract class MeetingForm with _$MeetingForm {
  const factory MeetingForm({
    required String title,
    required String description,
    required String mode,
    required String meetPlace,
    required String meetTime,
    required int duration,
    required bool isRecurring,
    required bool isReportNeeded,
    String? platform,
    String? meetLink,
    double? coordX,
    double? coordY,
    String? recurrenceType,
    int? recurrence,
    String? reportDescription,
  }) = _MeetingForm;
}
