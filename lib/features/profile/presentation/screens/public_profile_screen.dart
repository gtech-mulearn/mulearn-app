import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/profile/presentation/providers/public_profile_controller.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/profile_view.dart';

/// A profile set to private (`is_public: false`, toggled from
/// [ShareProfileDialog]) rejects `GET user-profile/{muid}/` for anyone but
/// the owner — surfaced as a permission-denied response (403, or a message
/// naming "private"/"permission"). Distinguishing that from a genuine
/// failure means "Retry" isn't offered for a state retrying can't fix, and
/// the reason is stated plainly instead of a generic "Something went wrong."
bool _isPrivateProfileError(Object error) {
  if (error is! ApiException) return false;
  if (error.statusCode == 403) return true;
  final message = error.message.toLowerCase();
  return message.contains('private') || message.contains('permission');
}

/// Someone else's profile by muid: the same poster, sheet and sections as
/// the own profile, without the edit, upload, share and settings tools.
class PublicProfileScreen extends ConsumerWidget {
  const PublicProfileScreen({required this.muid, super.key});

  final String muid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(publicUserProfileProvider(muid));

    return Scaffold(
      backgroundColor: context.mu.colors.chalk,
      // The hero carries its own back button; loading and errors need one.
      appBar: profileState.hasValue
          ? null
          : const PreferredSize(
              preferredSize: Size.fromHeight(56),
              child: SafeArea(child: MuTopBar.detail(title: 'Profile')),
            ),
      body: profileState.when(
        skipError: true,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _isPrivateProfileError(error)
            ? const Center(
                child: SingleChildScrollView(
                  child: MuStateDisplay(
                    variant: MuStateVariant.notFound,
                    title: 'Profile not found',
                    description: 'The requested profile could not be found or is private.',
                  ),
                ),
              )
            : ErrorRetryView(error: error, onRetry: () => ref.invalidate(publicUserProfileProvider(muid))),
        data: (profile) => MuRefresh(
          onRefresh: () => ref.refresh(publicUserProfileProvider(muid).future),
          child: ProfileView(profile: profile, isOwn: false),
        ),
      ),
    );
  }
}
