import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/campus/presentation/providers/enabler_providers.dart';

/// The campuses an enabler looks after (K5), with their totals.
class EnablerCampusesScreen extends ConsumerWidget {
  const EnablerCampusesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(enablerSummaryProvider).value;
    String plural(int n, String one) => '$n ${n == 1 ? one : '${one}s'}';
    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(backgroundColor: MuColors.canvas, elevation: 0, title: const Text('My campuses')),
      body: ref.watch(enablerCampusesProvider).when(
            skipError: true,
            skipLoadingOnReload: true,
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => ErrorRetryView(error: e, onRetry: () => ref.invalidate(enablerCampusesProvider)),
            data: (campuses) => MuRefresh(
              onRefresh: () => Future.wait([
                ref.refresh(enablerCampusesProvider.future),
                ref.refresh(enablerSummaryProvider.future),
              ]),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.s, MuSpace.screenH, MuSpace.xxl),
                children: [
                  if (summary != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: MuSpace.m),
                      child: Text(
                        '${plural(summary.campuses, 'campus').replaceFirst('campuss', 'campuses')} · '
                        '${plural(summary.students, 'student')} · ${summary.karma} karma',
                        style: MuType.bodyMed,
                      ),
                    ),
                  if (campuses.isEmpty)
                    const MuStateDisplay(
                      variant: MuStateVariant.noResults,
                      title: 'No campuses yet',
                      description: 'Campuses you are assigned to appear here.',
                    ),
                  for (final c in campuses)
                    Padding(
                      padding: const EdgeInsets.only(bottom: MuSpace.s),
                      child: MuCard(
                        onTap: () => context.push(RoutePaths.enablerCampusPath(c.id)),
                        padding: const EdgeInsets.fromLTRB(MuSpace.l, MuSpace.m, MuSpace.s, MuSpace.m),
                        child: Row(
                          children: [
                            const Icon(LucideIcons.school, size: 20, color: MuColors.primary),
                            const SizedBox(width: MuSpace.m),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(c.collegeName, style: MuType.bodyMed),
                                  Text(
                                    [c.campusCode, c.zone, c.orgType].where((x) => x.isNotEmpty).join(' · '),
                                    style: MuType.caption,
                                  ),
                                ],
                              ),
                            ),
                            const Icon(LucideIcons.chevronRight, size: 18, color: MuColors.inkSecondary),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
    );
  }
}
