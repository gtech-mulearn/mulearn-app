import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
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
    final theme = Theme.of(context);
    final logState = publicMuid == null
        ? ref.watch(userLogProvider)
        : ref.watch(publicUserLogProvider(publicMuid!));
    final maxKarma = karmaDistribution.isEmpty
        ? 1.0
        : karmaDistribution.map((e) => e.karma).reduce((a, b) => a > b ? a : b).toDouble();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('By task type', style: theme.textTheme.titleSmall),
        const SizedBox(height: 12),
        if (karmaDistribution.isEmpty)
          const Text('No karma earned yet.',
              style: TextStyle(color: MulearnColors.gray600))
        else
          for (final entry in karmaDistribution)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(entry.taskType),
                      Text('${entry.karma}'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: entry.karma / maxKarma,
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ),
        const SizedBox(height: 24),
        Text('Activity log', style: theme.textTheme.titleSmall),
        const SizedBox(height: 12),
        logState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Text(ApiException.messageFor(error)),
          data: (entries) {
            if (entries.isEmpty) {
              return const Text('No activity yet.',
                  style: TextStyle(color: MulearnColors.gray600));
            }
            return Column(
              children: [
                for (final entry in entries)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.bolt, color: MulearnColors.primary),
                    title: Text(entry.taskName),
                    subtitle: Text(entry.createdDate),
                    trailing: Text('+${entry.karma}'),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
