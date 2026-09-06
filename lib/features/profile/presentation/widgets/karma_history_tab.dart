import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_empty_state.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_log_entry.dart';
import 'package:mulearn_app/features/profile/presentation/providers/public_profile_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/user_log_controller.dart';

/// The raw karma activity log, restyled as a card list (DESIGN_SPEC.md §2
/// "12 — Profile & karma" → "Tab: Karma History") — task/tag, karma amount
/// with a `+`/`-` sign and success/error coloring, relative timestamp. The
/// by-task-type breakdown that used to live here moved to Basic Details'
/// karma-distribution donut, which already covers that same real
/// `karmaDistribution` data. Pass [publicMuid] to view another user's log
/// instead of the signed-in user's own.
class KarmaHistoryTab extends ConsumerWidget {
  const KarmaHistoryTab({super.key, this.publicMuid});

  final String? publicMuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logState = publicMuid == null
        ? ref.watch(userLogProvider)
        : ref.watch(publicUserLogProvider(publicMuid!));

    return logState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => ErrorRetryView(
        error: error,
        onRetry: () {
          if (publicMuid == null) {
            ref.invalidate(userLogProvider);
          } else {
            ref.invalidate(publicUserLogProvider(publicMuid!));
          }
        },
      ),
      data: (entries) {
        if (entries.isEmpty) {
          return const MuEmptyState(
            icon: LucideIcons.zap,
            title: 'No karma yet',
            message: 'Complete tasks to start building your karma history.',
          );
        }
        return ListView(
          padding: const EdgeInsets.fromLTRB(
            MuSpace.screenH,
            MuSpace.screenH,
            MuSpace.screenH,
            MuSpace.navClearance,
          ),
          children: [
            Row(
              children: [
                Expanded(child: Text('KARMA HISTORY', style: MuType.eyebrow)),
                Text(
                  '${entries.length} ${entries.length == 1 ? 'entry' : 'entries'}',
                  style: MuType.caption,
                ),
              ],
            ),
            const SizedBox(height: MuSpace.m),
            for (final entry in entries) _HistoryCard(entry: entry),
          ],
        );
      },
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.entry});

  final UserLogEntry entry;

  @override
  Widget build(BuildContext context) {
    final isNegative = entry.karma < 0;
    final amount = entry.karma.round();
    final tint = isNegative ? MuColors.errorBg : MuColors.primaryTint;
    final accent = isNegative ? MuColors.error : MuColors.primary;

    return Padding(
      padding: const EdgeInsets.only(bottom: MuSpace.s),
      child: MuCard(
        padding: const EdgeInsets.all(MuSpace.m),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: tint,
                borderRadius: BorderRadius.circular(MuRadius.inner),
              ),
              alignment: Alignment.center,
              child: Icon(LucideIcons.zap, size: 18, color: accent),
            ),
            const SizedBox(width: MuSpace.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.taskName,
                    style: MuType.bodyMed,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(_relativeTime(entry.createdDate), style: MuType.caption),
                ],
              ),
            ),
            const SizedBox(width: MuSpace.s),
            Text(
              '${isNegative ? '' : '+'}$amount ϰ',
              style: MuType.statSmall.copyWith(fontSize: 15, color: accent),
            ),
          ],
        ),
      ),
    );
  }
}

/// Formats a `created_date` string as a relative timestamp ("Today", "3
/// days ago", ...). Falls back to the raw string when it isn't a
/// parseable date, rather than guessing at an unconfirmed backend format.
String _relativeTime(String raw) {
  final parsed = DateTime.tryParse(raw);
  if (parsed == null) return raw;
  final diff = DateTime.now().difference(parsed);
  if (diff.inDays <= 0) return 'Today';
  if (diff.inDays == 1) return 'Yesterday';
  if (diff.inDays < 7) return '${diff.inDays} days ago';
  if (diff.inDays < 30) {
    final weeks = (diff.inDays / 7).floor();
    return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
  }
  if (diff.inDays < 365) {
    final months = (diff.inDays / 30).floor();
    return '$months ${months == 1 ? 'month' : 'months'} ago';
  }
  final years = (diff.inDays / 365).floor();
  return '$years ${years == 1 ? 'year' : 'years'} ago';
}
