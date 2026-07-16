import 'package:freezed_annotation/freezed_annotation.dart';

part 'meeting.freezed.dart';

/// A row in a circle's meeting list (`learningcircle/meeting/list/{id}/`) —
/// pure-Dart domain entity (rules.md §2).
@freezed
abstract class Meeting with _$Meeting {
  const factory Meeting({
    required String id,
    required String title,
    required String description,
    required String mode,
    required String meetPlace,
    required String meetTime,
    required String circleId,
    required String igName,
    required bool isStarted,
    required bool isEnded,
    required int attendeesCount,
    required String createdBy,
    String? org,
    String? meetLink,
    @Default(false) bool isRecurring,
    @Default(false) bool isJoined,
    @Default(false) bool isRsvp,
  }) = _Meeting;
}
