import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/profile_view.dart';

/// The You tab: the member's own profile (artifact: Screen patterns → User
/// profiles). Poster hero with edit, share and settings; the night sheet
/// with stats, interests, campus, roles, workspaces and socials; then Karma
/// and Achievements.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileControllerProvider);

    return Scaffold(
      backgroundColor: context.mu.colors.chalk,
      body: profileState.when(
        // Keep the body (and its section and scroll) while the shared
        // profile reloads after a change or a refresh fails.
        skipLoadingOnReload: true,
        skipError: true,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => SafeArea(
          child: ErrorRetryView(error: error, onRetry: () => ref.read(profileControllerProvider.notifier).refresh()),
        ),
        data: (profile) => MuRefresh(
          onRefresh: () {
            invalidateSessionState(ref.invalidate);
            return ref.read(profileControllerProvider.notifier).refresh();
          },
          child: ProfileView(profile: profile),
        ),
      ),
    );
  }
}
