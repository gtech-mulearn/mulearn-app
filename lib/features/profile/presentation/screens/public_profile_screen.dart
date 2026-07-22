import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_qr_card.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/presentation/providers/public_profile_controller.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/achievements_tab.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/badges_tab.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/basic_details_tab.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/karma_history_tab.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/mu_voyage_tab.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/profile_stats_row.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/public_profile_header.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/tab_bar_sliver_delegate.dart';

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
      appBar: AppBar(title: const Text('Profile')),
      body: profileState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorRetryView(
          error: error,
          onRetry: () => ref.invalidate(publicUserProfileProvider(muid)),
        ),
        data: (profile) => RefreshIndicator(
          onRefresh: () async => ref.invalidate(publicUserProfileProvider(muid)),
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
                ProfileStatsRow(profile: profile),
                const SizedBox(height: MuSpace.l),
                MuQrCard(muid: profile.muid, college: profile.collegeCode),
              ],
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: TabBarSliverDelegate(
            TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: const [
                Tab(text: 'Basic Details'),
                Tab(text: 'Karma History'),
                Tab(text: 'Mu Voyage'),
                Tab(text: 'Achievements'),
                Tab(text: 'Badges'),
              ],
            ),
          ),
        ),
      ],
      body: TabBarView(
        controller: _tabController,
        children: [
          BasicDetailsTab(profile: profile, publicMuid: profile.muid),
          KarmaHistoryTab(
            karmaDistribution: profile.karmaDistribution,
            publicMuid: profile.muid,
          ),
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
