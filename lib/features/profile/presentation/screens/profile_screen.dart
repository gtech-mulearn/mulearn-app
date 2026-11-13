import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_qr_card.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/role_pending_banner.dart';
import 'package:mulearn_app/core/widgets/workspace_links.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/presentation/providers/editable_profile_controller.dart';
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
      backgroundColor: context.mu.colors.chalk,
      body: SafeArea(
        bottom: false,
        child: profileState.when(
          // Keep the body (and its tab and scroll) while the shared profile
          // reloads after a change (Plan 2 minor 7) or a refresh fails.
          skipLoadingOnReload: true,
          skipError: true,
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) =>
              ErrorRetryView(error: error, onRetry: () => ref.read(profileControllerProvider.notifier).refresh()),
          data: (profile) => MuRefresh(
            onRefresh: () {
              invalidateSessionState(ref.invalidate);
              return ref.read(profileControllerProvider.notifier).refresh();
            },
            child: _ProfileBody(profile: profile),
          ),
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

class _ProfileBodyState extends State<_ProfileBody> with SingleTickerProviderStateMixin {
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
            padding: const EdgeInsets.fromLTRB(MuSpacing.space4, MuSpacing.space2, MuSpacing.space4, MuSpacing.space4),
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
                // A role awaiting verification (ROLE-02).
                const PendingRoleBanners(),
                // Open role workspaces (spec §8.2 item 5).
                const WorkspaceLinks(),
                const SizedBox(height: MuSpacing.space4),
                ProfileStatsRow(profile: profile),
                const SizedBox(height: MuSpacing.space4),
                MuQrCard(
                  muid: profile.muid,
                  college: profile.collegeCode,
                  onCopy: () async {
                    await Clipboard.setData(ClipboardData(text: profile.muid));
                    if (context.mounted) {
                      MuToast.show(context, message: 'MUID copied', type: MuToastType.success);
                    }
                  },
                  onShare: () => showDialog<void>(
                    context: context,
                    builder: (_) => ShareProfileDialog(profile: profile),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: TabBarSliverDelegate(buildProfilePillTabBar(context, _tabController)),
        ),
      ],
      body: TabBarView(
        controller: _tabController,
        children: [
          BasicDetailsTab(profile: profile),
          const KarmaHistoryTab(),
          const MuVoyageTab(),
          Consumer(
            builder: (context, ref, _) {
              final email = ref.watch(editableProfileControllerProvider).value?.email;
              return AchievementsTab(
                muid: profile.muid,
                userName: profile.fullName,
                userEmail: (email?.isEmpty ?? true) ? null : email,
              );
            },
          ),
          BadgesTab(muid: profile.muid),
        ],
      ),
    );
  }
}

/// Scrollable, segmented pill-style tab row (DESIGN_SPEC.md §1 "Filter
/// chip" / §2 "12 — Profile & karma" segmented control) — confirmed against
/// the rendered mock: a white active pill with a soft shadow on the plain
/// canvas backdrop ([TabBarSliverDelegate] already paints the scaffold
/// background behind it), not a solid black fill. The design mock only
/// shows 3 sub-tabs (Basic Details / Karma History / Mu Voyage), but this
/// screen keeps all 5 real tabs (Achievements and Badges are working
/// features, not dropped), scrolling rather than trying to force 5 items
/// into a fixed 3-pill layout. Shared by [ProfileScreen] and
/// `PublicProfileScreen` so both profile views present the same chrome.
TabBar buildProfilePillTabBar(BuildContext context, TabController controller) {
  final mu = context.mu;
  final c = mu.colors;
  return TabBar(
    controller: controller,
    isScrollable: true,
    tabAlignment: TabAlignment.start,
    indicator: BoxDecoration(color: c.night, borderRadius: BorderRadius.circular(MuRadii.round)),
    indicatorSize: TabBarIndicatorSize.tab,
    dividerColor: Colors.transparent,
    labelColor: c.onNight,
    unselectedLabelColor: c.ink2,
    labelStyle: mu.text.label.copyWith(fontSize: 14),
    unselectedLabelStyle: mu.text.label.copyWith(fontSize: 14),
    padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space4, vertical: MuSpacing.space2),
    labelPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
    tabs: const [
      Tab(text: 'Basic Details'),
      Tab(text: 'Karma History'),
      Tab(text: 'Mu Voyage'),
      Tab(text: 'Achievements'),
      Tab(text: 'Badges'),
    ],
  );
}
