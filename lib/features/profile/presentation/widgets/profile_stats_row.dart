import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_shadow.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/presentation/providers/public_profile_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/user_levels_controller.dart';

/// Karma/Tasks/Rank summary row shown under the header — three separate
/// tiles (DESIGN_SPEC.md §2 "12 — Profile & karma", confirmed against the
/// rendered mock: distinct cards with gaps, not one card split by
/// dividers). "Tasks" is a real count — completed [LevelTask]s summed
/// across [UserLevel]s (same feature, `userLevelsProvider`, already used
/// by this feature's Mu Voyage/Journey screens) — not the mock's
/// unavailable field. Pass [publicMuid] when showing another user's
/// profile so the count reflects their levels, not the viewer's own
/// (mirrors [MuVoyageTab]'s same signed-in-vs-public split).
class ProfileStatsRow extends ConsumerWidget {
  const ProfileStatsRow({required this.profile, super.key, this.publicMuid});

  final UserProfile profile;
  final String? publicMuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelsState = publicMuid == null
        ? ref.watch(userLevelsProvider)
        : ref.watch(publicUserLevelsProvider(publicMuid!));
    final tasksDone = levelsState.maybeWhen(
      data: (levels) => levels.fold<int>(
        0,
        (sum, level) => sum + level.tasks.where((t) => t.completed).length,
      ),
      orElse: () => null,
    );

    return Row(
      children: [
        Expanded(
          child: _StatTile(label: 'Karma', value: _formatNumber(profile.karma)),
        ),
        const SizedBox(width: MuSpace.s),
        Expanded(
          child: _StatTile(
            label: 'Tasks',
            value: tasksDone != null ? '$tasksDone' : '—',
          ),
        ),
        const SizedBox(width: MuSpace.s),
        Expanded(
          child: _StatTile(
            label: 'Rank',
            value: profile.rank != null ? '#${profile.rank}' : '—',
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
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: MuSpace.m,
        vertical: MuSpace.l,
      ),
      decoration: BoxDecoration(
        color: MuColors.surface,
        borderRadius: BorderRadius.circular(MuRadius.card),
        boxShadow: MuShadow.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label.toUpperCase(), style: MuType.eyebrow.copyWith(fontSize: 11)),
          const SizedBox(height: 6),
          Text(value, style: MuType.headline.copyWith(fontSize: 22)),
        ],
      ),
    );
  }
}

/// Thousands-comma formatting (e.g. `14919` → `14,919`) without pulling in
/// `intl` for a single call site (rules.md §9 — no new deps without
/// discussion).
String _formatNumber(int value) {
  final digits = value.abs().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
    buffer.write(digits[i]);
  }
  return (value < 0 ? '-' : '') + buffer.toString();
}
