import 'package:mulearn_app/features/auth/presentation/providers/register_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'interests_controller.g.dart';

/// Submits the pathway/endgoal selections from the post-registration
/// interests onboarding step. Exposes `AsyncValue<void>` for automatic
/// loading/error state (rules.md §4).
@riverpod
class InterestsController extends _$InterestsController {
  @override
  FutureOr<void> build() {}

  /// Quiz mode: only pathways are submitted (matches the reference — no
  /// endgoal step in quiz mode).
  Future<void> submitPathwaysOnly(List<String> pathways) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(
      () => ref.read(registerRepositoryProvider).selectDomains(pathways),
    );
    if (ref.mounted) state = result;
    if (result.hasError) {
      Error.throwWithStackTrace(result.error!, result.stackTrace ?? StackTrace.current);
    }
  }

  /// Direct mode: both pathways and endgoals are submitted, sequentially.
  Future<void> submitPathwaysAndEndgoals(
    List<String> pathways,
    List<String> endgoals,
  ) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      final repo = ref.read(registerRepositoryProvider);
      await repo.selectDomains(pathways);
      await repo.selectEndgoals(endgoals);
    });
    if (ref.mounted) state = result;
    if (result.hasError) {
      Error.throwWithStackTrace(result.error!, result.stackTrace ?? StackTrace.current);
    }
  }
}
