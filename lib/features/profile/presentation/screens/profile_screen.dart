import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/achievements_tab.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/badges_tab.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/basic_details_tab.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/edit_profile_dialog.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/karma_history_tab.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/mu_voyage_tab.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/profile_header.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/profile_stats_row.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/share_profile_dialog.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/tab_bar_sliver_delegate.dart';

/// Full profile screen — header, stats, and tabbed content (Basic Details,
/// Karma History, Mu Voyage, Achievements, Badges), matching the reference
/// dashboard's profile page structure.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            tooltip: 'Sign out',
            icon: const Icon(Icons.logout),
            onPressed: () =>
                ref.read(authControllerProvider.notifier).signOut(),
          ),
        ],
      ),
      body: profileState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorRetryView(
          error: error,
          onRetry: () => ref.read(profileControllerProvider.notifier).refresh(),
        ),
        data: (profile) => RefreshIndicator(
          onRefresh: () =>
              ref.read(profileControllerProvider.notifier).refresh(),
          child: _ProfileBody(profile: profile),
        ),
      ),
    );
  }
}

class _ProfileBody extends StatefulWidget {
  const _ProfileBody({required this.profile});

  final UserProfile profile;

  @override
  State<_ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<_ProfileBody>
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
    // NestedScrollView (rather than a ListView containing a fixed-height
    // TabBarView containing more ListViews/GridViews) — the nested-scrollable
    // hack was fragile: TabBarView builds all 5 tab pages up front (it isn't
    // lazy), so 5 independent Sliver viewports were laying out/painting
    // simultaneously inside a hardcoded 480px box inside an outer ListView,
    // which surfaced as a real device crash ("Null check operator used on a
    // null value" inside RenderViewportBase._paintContents). NestedScrollView
    // is Flutter's purpose-built solution for "scrollable header above a
    // TabBarView whose pages each scroll independently".
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ProfileHeader(
                  profile: profile,
                  onEdit: () => showDialog<void>(
                    context: context,
                    builder: (_) => EditProfileDialog(profile: profile),
                  ),
                  onShare: () => showDialog<void>(
                    context: context,
                    builder: (_) => ShareProfileDialog(profile: profile),
                  ),
                ),
                const SizedBox(height: 16),
                ProfileStatsRow(profile: profile),
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
          BasicDetailsTab(profile: profile),
          KarmaHistoryTab(karmaDistribution: profile.karmaDistribution),
          const MuVoyageTab(),
          AchievementsTab(
            muid: profile.muid,
            userName: profile.fullName,
            userEmail: profile.email,
          ),
          BadgesTab(muid: profile.muid),
        ],
      ),
    );
  }
}
