import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
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

/// Top-3 podium row (DESIGN_SPEC.md §2 "09 — Leaderboard") — medal-ring
/// avatars (gold/silver/bronze), name, karma, and a rank-numbered bar below
/// each slot: 1st tallest and ink-filled, 2nd/3rd shorter and light.
class LeaderboardPodium extends StatelessWidget {
  const LeaderboardPodium({required this.top3, super.key});

  final List<LeaderboardPodiumEntry> top3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MuSpace.screenH, vertical: MuSpace.l),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (top3.length > 1)
            Expanded(child: _PodiumSlot(rank: 2, entry: top3[1], avatarSize: 56)),
          const SizedBox(width: MuSpace.s),
          if (top3.isNotEmpty)
            Expanded(child: _PodiumSlot(rank: 1, entry: top3[0], avatarSize: 72)),
          const SizedBox(width: MuSpace.s),
          if (top3.length > 2)
            Expanded(child: _PodiumSlot(rank: 3, entry: top3[2], avatarSize: 56)),
        ],
      ),
    );
  }
}

class _PodiumSlot extends StatelessWidget {
  const _PodiumSlot({required this.rank, required this.entry, required this.avatarSize});

  final int rank;
  final LeaderboardPodiumEntry entry;
  final double avatarSize;

  Color get _ringColor => switch (rank) {
        1 => MuColors.rankGold,
        2 => MuColors.rankSilver,
        _ => MuColors.rankBronze,
      };

  /// 1st place bar: tall, ink-filled, karma-accent rank numeral. 2nd/3rd:
  /// shorter, white-filled, faint rank numeral.
  double get _barHeight => rank == 1 ? 64 : 46;
  Color get _barColor => rank == 1 ? MuColors.ink : MuColors.surface;
  Color get _rankTextColor => rank == 1 ? MuColors.karmaAccent : MuColors.inkFaint;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(color: _ringColor, shape: BoxShape.circle),
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(color: MuColors.canvas, shape: BoxShape.circle),
            child: ProfileAvatar(url: entry.avatarUrl, name: entry.name, size: avatarSize),
          ),
        ),
        const SizedBox(height: MuSpace.s),
        Text(
          entry.name,
          style: MuType.bodyMed.copyWith(fontSize: 13),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2),
        Text(
          '${entry.karma}',
          style: MuType.statSmall.copyWith(color: MuColors.primary, fontSize: 13),
        ),
        const SizedBox(height: MuSpace.s),
        Container(
          height: _barHeight,
          width: double.infinity,
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: _barColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(MuRadius.inner)),
            boxShadow: rank == 1
                ? [
                    const BoxShadow(
                      color: Color(0x991A1A1A),
                      blurRadius: 20,
                      offset: Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Text('$rank', style: MuType.stat.copyWith(color: _rankTextColor, fontSize: 20)),
        ),
      ],
    );
  }
}
