import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/features/team/presentation/providers/team_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'team_home_controller.g.dart';

/// The team home's one action: a test push to the signed-in account's own
/// phones. Loading while the request runs; the backend's message (or its
/// error) goes back to the screen, which shows it as a toast.
@Riverpod(retry: noRetry)
class TeamHomeController extends _$TeamHomeController {
  @override
  Future<void> build() async {}

  /// Returns the backend's success message; rethrows its failure.
  Future<String> sendTestPush() async {
    state = const AsyncLoading();
    try {
      final message = await ref.read(teamRepositoryProvider).sendTestPush();
      return message;
    } finally {
      if (ref.mounted) state = const AsyncData(null);
    }
  }
}
