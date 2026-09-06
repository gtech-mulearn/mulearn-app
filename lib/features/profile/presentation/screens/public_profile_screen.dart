import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_empty_state.dart';
import 'package:mulearn_app/core/widgets/mu_qr_card.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/presentation/providers/public_profile_controller.dart';
import 'package:mulearn_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/achievements_tab.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/badges_tab.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/basic_details_tab.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/karma_history_tab.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/mu_voyage_tab.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/profile_stats_row.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/public_profile_header.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/tab_bar_sliver_delegate.dart';

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

/// Read-only view of another user's profile by muid — same tabbed layout as
/// [ProfileScreen] with every edit/upload/share affordance stripped out.
class PublicProfileScreen extends ConsumerWidget {
  const PublicProfileScreen({required this.muid, super.key});

  final String muid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(publicUserProfileProvider(muid));

    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(
        backgroundColor: MuColors.canvas,
        elevation: 0,
        title: const Text('Profile'),
      ),
      body: profileState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _isPrivateProfileError(error)
            ? const MuEmptyState(
                icon: LucideIcons.lock,
                title: 'This profile is private',
                message: 'Only the account owner can view this profile.',
              )
            : ErrorRetryView(
                error: error,
                onRetry: () => ref.invalidate(publicUserProfileProvider(muid)),
              ),
        data: (profile) => RefreshIndicator(
          onRefresh: () async =>
              ref.invalidate(publicUserProfileProvider(muid)),
          child: _PublicProfileBody(profile: profile),
        ),
      ),
    );
  }
}

class _PublicProfileBody extends StatefulWidget {
  const _PublicProfileBody({required this.profile});

  final UserProfile profile;

  @override
  State<_PublicProfileBody> createState() => _PublicProfileBodyState();
}

class _PublicProfileBodyState extends State<_PublicProfileBody>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 5, vsync: this);

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = widget.profile;
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                PublicProfileHeader(profile: profile),
                const SizedBox(height: MuSpace.l),
                ProfileStatsRow(profile: profile, publicMuid: profile.muid),
                const SizedBox(height: MuSpace.l),
                MuQrCard(muid: profile.muid, college: profile.collegeCode),
              ],
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: TabBarSliverDelegate(
            buildProfilePillTabBar(_tabController),
          ),
        ),
      ],
      body: TabBarView(
        controller: _tabController,
        children: [
          BasicDetailsTab(profile: profile, publicMuid: profile.muid),
          KarmaHistoryTab(publicMuid: profile.muid),
          MuVoyageTab(publicMuid: profile.muid),
          AchievementsTab(
            muid: profile.muid,
            userName: profile.fullName,
            userEmail: profile.email,
            isOwnProfile: false,
          ),
          BadgesTab(muid: profile.muid),
        ],
      ),
    );
  }
}
