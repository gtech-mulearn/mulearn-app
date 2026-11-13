import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/mentor/domain/entities/availability_slot.dart';

part 'availability_rules.freezed.dart';

/// Zones offered for a slot. The app can't read the device's IANA zone
/// without a package; a slot in another zone keeps its own.
const mentorTimezones = ['Asia/Kolkata', 'UTC', 'Asia/Dubai', 'Asia/Singapore', 'Europe/London', 'America/New_York'];
const defaultTimezone = 'Asia/Kolkata';

const _weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

/// 1 → "Monday" … 7 → "Sunday".
String weekdayName(int weekday) => _weekdays[(weekday - 1).clamp(0, 6)];

/// "18:00[:00]" → 1080.
int parseClock(String value) {
  final parts = value.split(':');
  return int.parse(parts[0]) * 60 + int.parse(parts.length > 1 ? parts[1] : '0');
}

/// 425 → "07:05", the backend's `HH:MM`.
String formatClock(int minutes) =>
    '${(minutes ~/ 60).toString().padLeft(2, '0')}:${(minutes % 60).toString().padLeft(2, '0')}';

/// 1080 → "6:00 PM".
String clockLabel(int minutes) {
  final h = minutes ~/ 60;
  final m = (minutes % 60).toString().padLeft(2, '0');
  return '${h % 12 == 0 ? 12 : h % 12}:$m ${h < 12 ? 'AM' : 'PM'}';
}

/// What the mentor fills in for a slot.
@freezed
abstract class SlotInput with _$SlotInput {
  const factory SlotInput({
    required int weekday,
    required int startMinutes,
    required int endMinutes,
    required String timezone,
    String? igId,
    @Default(true) bool isActive,
  }) = _SlotInput;

  const SlotInput._();

  factory SlotInput.from(AvailabilitySlot s) => SlotInput(
        weekday: s.weekday,
        startMinutes: s.startMinutes,
        endMinutes: s.endMinutes,
        timezone: s.timezone,
        igId: s.igId,
        isActive: s.isActive,
      );

  /// The backend's own message when it would refuse the slot.
  String? problem() => endMinutes <= startMinutes ? 'Start time must be before end time.' : null;

  /// `POST availability/` or `PATCH availability/<id>/`.
  Map<String, Object?> toJson() => {
        if (igId != null) 'ig': igId,
        'weekday': weekday,
        'start_time': formatClock(startMinutes),
        'end_time': formatClock(endMinutes),
        'timezone': timezone,
        'is_active': isActive,
      };

  /// The first slot on the same day this one overlaps (touching ends don't),
  /// ignoring the slot being edited.
  AvailabilitySlot? overlapWith(List<AvailabilitySlot> slots, {String? editingId}) {
    for (final s in slots) {
      if (s.id == editingId || s.weekday != weekday) continue;
      if (startMinutes < s.endMinutes && s.startMinutes < endMinutes) return s;
    }
    return null;
  }
}
