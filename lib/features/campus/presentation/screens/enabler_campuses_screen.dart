import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/campus/presentation/providers/enabler_providers.dart';

/// The campuses an enabler looks after (K5): the totals as tiles, then each
/// campus as its crest.
class EnablerCampusesScreen extends ConsumerWidget {
  const EnablerCampusesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final summary = ref.watch(enablerSummaryProvider).value;
    return MuWorkspacePage(
      body: ref
          .watch(enablerCampusesProvider)
          .when(
            skipError: true,
            skipLoadingOnReload: true,
            loading: () => const Center(
              child: MuDotsLoader(label: 'Loading your campuses…'),
            ),
            error: (e, _) => ErrorRetryView(
              error: e,
              onRetry: () => ref.invalidate(enablerCampusesProvider),
            ),
            data: (campuses) => MuRefresh(
              onRefresh: () => Future.wait([
                ref.refresh(enablerCampusesProvider.future),
                ref.refresh(enablerSummaryProvider.future),
              ]),
              child: ListView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: muListPadding,
                children: [
                  Semantics(
                    header: true,
                    child: Text(
                      'My campuses',
                      style: mu.text.display.copyWith(fontSize: 32),
                    ),
                  ),
                  if (summary != null) ...[
                    const SizedBox(height: MuSpacing.space4),
                    Row(
                      children: [
                        Expanded(
                          child: MuStatTile(
                            label: 'Campuses',
                            value: muGrouped(summary.campuses),
                          ),
                        ),
                        const SizedBox(width: MuSpacing.space2),
                        Expanded(
                          child: MuStatTile(
                            label: 'Students',
                            value: muGrouped(summary.students),
                          ),
                        ),
                        const SizedBox(width: MuSpacing.space2),
                        Expanded(
                          child: MuStatTile(
                            label: 'Karma',
                            value: muGrouped(summary.karma),
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: MuSpacing.space5),
                  if (campuses.isEmpty)
                    const MuStateDisplay(
                      variant: MuStateVariant.noResults,
                      title: 'No campuses yet',
                      description: 'Campuses you are assigned to appear here.',
                    ),
                  for (var i = 0; i < campuses.length; i++) ...[
                    if (i > 0) const SizedBox(height: MuSpacing.space3),
                    MuCampusCrest(
                      code: campuses[i].campusCode,
                      name: campuses[i].collegeName,
                      caption: [
                        campuses[i].campusCode,
                        campuses[i].zone,
                        campuses[i].orgType,
                      ].where((x) => x.isNotEmpty).join(' · '),
                      trailing: Icon(
                        LucideIcons.chevronRight,
                        size: MuSizes.iconSm + 2,
                        color: mu.colors.ink3,
                      ),
                      onTap: () => context.push(
                        RoutePaths.enablerCampusPath(campuses[i].id),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
    );
  }
}
