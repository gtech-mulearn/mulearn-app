import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/features/mentor/data/mentor_repository_provider.dart';
import 'package:mulearn_app/features/mentor/domain/availability_rules.dart';
import 'package:mulearn_app/features/mentor/domain/entities/availability_slot.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'availability_controller.g.dart';

/// The mentor's weekly slots, Monday first, earliest first. Errors from the
/// actions are rethrown for the screen to show.
@Riverpod(retry: noRetry)
class AvailabilityController extends _$AvailabilityController {
  @override
  Future<List<AvailabilitySlot>> build() async {
    final slots = await ref.watch(mentorRepositoryProvider).getAvailability();
    return [...slots]..sort((a, b) => (a.weekday, a.startMinutes).compareTo((b.weekday, b.startMinutes)));
  }

  /// Creates a slot, then reloads (the create reply has no id).
  Future<String> add(SlotInput input) async {
    final repository = ref.read(mentorRepositoryProvider);
    final message = await repository.createSlot(input);
    if (ref.mounted) ref.invalidateSelf();
    return message;
  }

  Future<String> edit(String id, SlotInput input) async {
    final repository = ref.read(mentorRepositoryProvider);
    final message = await repository.updateSlot(id, input.toJson());
    if (ref.mounted) ref.invalidateSelf();
    return message;
  }

  /// Pauses or resumes at once; restores the switch if refused.
  Future<String> setActive(String id, {required bool active}) async {
    final repository = ref.read(mentorRepositoryProvider);
    final before = state.value;
    if (before != null) {
      AvailabilitySlot toggled(AvailabilitySlot s) => s.id == id ? s.copyWith(isActive: active) : s;
      state = AsyncData(before.map(toggled).toList());
    }
    try {
      return await repository.updateSlot(id, {'is_active': active});
    } on Object {
      if (ref.mounted && before != null) state = AsyncData(before);
      rethrow;
    }
  }

  Future<String> delete(String id) async {
    final repository = ref.read(mentorRepositoryProvider);
    final message = await repository.deleteSlot(id);
    final current = state.value;
    if (ref.mounted && current != null) state = AsyncData([for (final s in current) if (s.id != id) s]);
    return message;
  }
}

extension on (int, int) {
  int compareTo((int, int) other) => $1 != other.$1 ? $1.compareTo(other.$1) : $2.compareTo(other.$2);
}
