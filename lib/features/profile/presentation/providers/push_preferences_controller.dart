import 'package:mulearn_app/core/notifications/push/push_controller.dart';
import 'package:mulearn_app/core/notifications/push/push_preferences.dart';
import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_preferences_controller.g.dart';

/// The user's push settings (Settings → Notifications).
@Riverpod(retry: noRetry)
class PushPreferencesController extends _$PushPreferencesController {
  @override
  Future<PushPreferences> build() =>
      ref.watch(pushRemoteDataSourceProvider).fetchPreferences();

  /// Shows the change at once and saves it; on failure puts the previous
  /// value back and rethrows so the screen can say what went wrong.
  Future<void> save(PushPreferences next, Map<String, Object?> patch) async {
    final previous = state.value;
    state = AsyncData(next);
    try {
      final saved = await ref
          .read(pushRemoteDataSourceProvider)
          .updatePreferences(patch);
      state = AsyncData(saved);
    } on Object {
      if (previous != null) state = AsyncData(previous);
      rethrow;
    }
  }
}
