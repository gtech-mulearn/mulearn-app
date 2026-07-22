import 'package:flutter/material.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_stat_block.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';

/// Karma/level/rank/percentile summary row shown under the header.
class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({required this.profile, super.key});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return MuCard(
      child: Row(
        children: [
          Expanded(child: MuStatBlock(label: 'Karma', value: '${profile.karma}')),
          Expanded(child: MuStatBlock(label: 'Level', value: profile.level ?? '—')),
          if (profile.rank != null)
            Expanded(child: MuStatBlock(label: 'Rank', value: '#${profile.rank}')),
          if (profile.percentile != null)
            Expanded(
              child: MuStatBlock(
                label: 'Percentile',
                value: '${profile.percentile!.toStringAsFixed(0)}%',
              ),
            ),
        ],
      ),
    );
  }
}
