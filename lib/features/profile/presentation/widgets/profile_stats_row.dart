import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';

/// Karma/level/rank/percentile summary row shown under the header.
class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({required this.profile, super.key});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatTile(label: 'Karma', value: '${profile.karma}'),
        ),
        Expanded(
          child: _StatTile(label: 'Level', value: profile.level ?? '—'),
        ),
        if (profile.rank != null)
          Expanded(
            child: _StatTile(label: 'Rank', value: '#${profile.rank}'),
          ),
        if (profile.percentile != null)
          Expanded(
            child: _StatTile(
              label: 'Percentile',
              value: '${profile.percentile!.toStringAsFixed(0)}%',
            ),
          ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        child: Column(
          children: [
            Text(
              value,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: theme.textTheme.labelSmall
                  ?.copyWith(color: MulearnColors.gray600),
            ),
          ],
        ),
      ),
    );
  }
}
