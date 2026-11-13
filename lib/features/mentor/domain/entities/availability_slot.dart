import 'package:freezed_annotation/freezed_annotation.dart';

part 'availability_slot.freezed.dart';

/// A weekly slot learners can book (`MentorAvailabilitySlot`): [weekday]
/// 1 = Monday … 7 = Sunday, times as minutes after midnight in [timezone].
@freezed
abstract class AvailabilitySlot with _$AvailabilitySlot {
  const factory AvailabilitySlot({
    required String id,
    required int weekday,
    required int startMinutes,
    required int endMinutes,
    required String timezone,
    required bool isActive,
    String? igId,
    String? igName,
  }) = _AvailabilitySlot;
}
