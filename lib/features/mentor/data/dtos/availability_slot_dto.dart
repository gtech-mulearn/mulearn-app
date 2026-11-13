import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/mentor/domain/availability_rules.dart';
import 'package:mulearn_app/features/mentor/domain/entities/availability_slot.dart';

part 'availability_slot_dto.freezed.dart';
part 'availability_slot_dto.g.dart';

/// One row of `GET mentor/availability/` (`AvailabilitySlotSerializer`).
@freezed
abstract class AvailabilitySlotDto with _$AvailabilitySlotDto {
  const factory AvailabilitySlotDto({
    required String id,
    required int weekday,
    required String startTime,
    required String endTime,
    @Default(defaultTimezone) String timezone,
    @Default(true) bool isActive,
    String? igId,
    String? igName,
  }) = _AvailabilitySlotDto;

  const AvailabilitySlotDto._();

  factory AvailabilitySlotDto.fromJson(Map<String, dynamic> json) => _$AvailabilitySlotDtoFromJson(json);

  AvailabilitySlot toDomain() => AvailabilitySlot(
        id: id,
        weekday: weekday,
        startMinutes: parseClock(startTime),
        endMinutes: parseClock(endTime),
        timezone: timezone,
        isActive: isActive,
        igId: igId,
        igName: (igName ?? '').isEmpty ? null : igName,
      );
}
