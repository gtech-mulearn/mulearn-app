import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_icon_button.dart';
import 'package:mulearn_app/features/interest_groups/presentation/providers/interest_groups_controller.dart';
import 'package:mulearn_app/features/interest_groups/presentation/widgets/interest_group_card.dart';

/// Browsable catalog of every interest group — mirrors DESIGN_SPEC.md §2
/// "07 — Interest groups chooser". The mock's "UNLOCKED AT LEVEL 4" gating
/// pill is dropped: this screen has no level-gate data behind it (unlike the
/// mock's fictional level system), it's a plain always-open directory.
class InterestGroupsScreen extends ConsumerWidget {
  const InterestGroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogState = ref.watch(interestGroupsCatalogProvider);
    final myIdsState = ref.watch(myInterestGroupIdsProvider);
    final myIds = myIdsState.value ?? const <String>[];

    return Scaffold(
      backgroundColor: MuColors.canvas,
      body: SafeArea(
        bottom: false,
        child: catalogState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ErrorRetryView(
            error: error,
            onRetry: () => ref.invalidate(interestGroupsCatalogProvider),
          ),
          data: (groups) => RefreshIndicator(
            onRefresh: () async {
              ref
                ..invalidate(interestGroupsCatalogProvider)
                ..invalidate(myInterestGroupIdsProvider);
            },
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                const SliverToBoxAdapter(child: _Header()),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    MuSpace.screenH,
                    MuSpace.l,
                    MuSpace.screenH,
                    MuSpace.xxl,
                  ),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: MuSpace.m,
                      crossAxisSpacing: MuSpace.m,
                      childAspectRatio: 0.8,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final group = groups[index];
                        return InterestGroupCard(
                          group: group,
                          isJoined: myIds.contains(group.id),
                          onTap: () => context.push(RoutePaths.interestGroupDetailPath(group.id)),
                        );
                      },
                      childCount: groups.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.s, MuSpace.screenH, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Navigator.of(context).canPop())
            Padding(
              padding: const EdgeInsets.only(bottom: MuSpace.l),
              child: MuIconButton(icon: LucideIcons.arrowLeft, onPressed: () => context.pop()),
            ),
          Text('Interest groups', style: MuType.display.copyWith(fontSize: 30)),
          const SizedBox(height: MuSpace.s),
          Text(
            'Join the groups that match what you want to build — your tasks '
            'and mentors specialise around them.',
            style: MuType.body.copyWith(color: MuColors.inkSecondary),
          ),
        ],
      ),
    );
  }
}
