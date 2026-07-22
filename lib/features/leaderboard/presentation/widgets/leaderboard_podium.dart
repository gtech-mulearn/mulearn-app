import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/profile_avatar.dart';

class LeaderboardPodiumEntry {
  const LeaderboardPodiumEntry({
    required this.name,
    required this.karma,
    this.avatarUrl,
  });

  final String name;
  final num karma;
  final String? avatarUrl;
}

/// Top-3 podium row (rules.md §8) — center is rank 1 with a lime ring and a
/// larger avatar, sides are rank 2/3.
class LeaderboardPodium extends StatelessWidget {
  const LeaderboardPodium({required this.top3, super.key});

  final List<LeaderboardPodiumEntry> top3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: MuSpace.l),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (top3.length > 1) _PodiumSlot(rank: 2, entry: top3[1], size: 56),
          const SizedBox(width: MuSpace.l),
          if (top3.isNotEmpty) _PodiumSlot(rank: 1, entry: top3[0], size: 72),
          const SizedBox(width: MuSpace.l),
          if (top3.length > 2) _PodiumSlot(rank: 3, entry: top3[2], size: 56),
        ],
      ),
    );
  }
}

class _PodiumSlot extends StatelessWidget {
  const _PodiumSlot({required this.rank, required this.entry, required this.size});

  final int rank;
  final LeaderboardPodiumEntry entry;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: rank == 1 ? const EdgeInsets.all(3) : EdgeInsets.zero,
          decoration: rank == 1
              ? const BoxDecoration(color: MuColors.lime, shape: BoxShape.circle)
              : null,
          child: ProfileAvatar(url: entry.avatarUrl, name: entry.name, size: size),
        ),
        const SizedBox(height: MuSpace.s),
        SizedBox(
          width: size + 24,
          child: Text(
            entry.name,
            style: MuType.bodyMed.copyWith(fontSize: 13),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          '${entry.karma}',
          style: MuType.statSmall.copyWith(color: MuColors.primary, fontSize: 13),
        ),
      ],
    );
  }
}
