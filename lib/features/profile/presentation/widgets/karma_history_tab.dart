import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_section_header.dart';
import 'package:mulearn_app/features/profile/domain/entities/karma_distribution_entry.dart';
import 'package:mulearn_app/features/profile/presentation/providers/public_profile_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/user_log_controller.dart';

/// Karma breakdown by task type, plus the raw activity log —
/// mirrors the reference dashboard's Karma History tab. Pass [publicMuid]
/// to view another user's log instead of the signed-in user's own.
class KarmaHistoryTab extends ConsumerWidget {
  const KarmaHistoryTab({
    required this.karmaDistribution,
    super.key,
    this.publicMuid,
  });

  final List<KarmaDistributionEntry> karmaDistribution;
  final String? publicMuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logState = publicMuid == null
        ? ref.watch(userLogProvider)
        : ref.watch(publicUserLogProvider(publicMuid!));
    final maxKarma = karmaDistribution.isEmpty
        ? 1.0
        : karmaDistribution.map((e) => e.karma).reduce((a, b) => a > b ? a : b).toDouble();

    return ListView(
      padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.screenH, MuSpace.screenH, MuSpace.navClearance),
      children: [
        const MuSectionHeader(title: 'By task type'),
        const SizedBox(height: MuSpace.m),
        if (karmaDistribution.isEmpty)
          Text('No karma earned yet.', style: MuType.body.copyWith(color: MuColors.inkSecondary))
        else
          MuCard(
            child: Column(
              children: [
                for (final entry in karmaDistribution)
                  Padding(
                    padding: const EdgeInsets.only(bottom: MuSpace.m),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(entry.taskType, style: MuType.bodyMed),
                            Text('${entry.karma}', style: MuType.statSmall.copyWith(fontSize: 15)),
                          ],
                        ),
                        const SizedBox(height: MuSpace.s),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(MuRadius.chip),
                          child: LinearProgressIndicator(
                            value: entry.karma / maxKarma,
                            minHeight: 6,
                            backgroundColor: MuColors.divider,
                            valueColor: const AlwaysStoppedAnimation(MuColors.primary),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        const SizedBox(height: MuSpace.xxl),
        const MuSectionHeader(title: 'Activity log'),
        const SizedBox(height: MuSpace.m),
        logState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Text(ApiException.messageFor(error)),
          data: (entries) {
            if (entries.isEmpty) {
              return Text('No activity yet.', style: MuType.body.copyWith(color: MuColors.inkSecondary));
            }
            return MuCard(
              child: Column(
                children: [
                  for (final entry in entries)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: MuSpace.s),
                      child: Row(
                        children: [
                          Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              color: MuColors.primaryTint,
                              borderRadius: BorderRadius.circular(MuRadius.inner),
                            ),
                            alignment: Alignment.center,
                            child: const Icon(LucideIcons.zap, size: 18, color: MuColors.primary),
                          ),
                          const SizedBox(width: MuSpace.m),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(entry.taskName, style: MuType.bodyMed),
                                Text(entry.createdDate, style: MuType.caption),
                              ],
                            ),
                          ),
                          Text(
                            '+${entry.karma}',
                            style: MuType.bodyMed.copyWith(color: MuColors.primary),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
