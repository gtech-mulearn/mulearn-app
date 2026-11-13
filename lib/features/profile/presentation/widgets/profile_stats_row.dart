import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
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
      data: (levels) => levels.fold<int>(0, (sum, level) => sum + level.tasks.where((t) => t.completed).length),
      orElse: () => null,
    );

    return Row(
      children: [
        Expanded(
          child: _StatTile(label: 'Karma', value: muGrouped(profile.karma), karma: true),
        ),
        const SizedBox(width: MuSpacing.space2),
        Expanded(
          child: _StatTile(label: 'Tasks', value: tasksDone != null ? '$tasksDone' : '—'),
        ),
        const SizedBox(width: MuSpacing.space2),
        Expanded(
          child: _StatTile(label: 'Rank', value: profile.rank != null ? '#${profile.rank}' : '—'),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value, this.karma = false});

  final String label;
  final String value;

  /// Karma reads in volt-text.
  final bool karma;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return Semantics(
      container: true,
      label: '$label $value',
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space2, vertical: 14),
        decoration: BoxDecoration(color: c.surface, borderRadius: BorderRadius.circular(MuRadii.control)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(value, style: mu.text.numeral.copyWith(fontSize: 26, color: karma ? c.voltText : c.ink)),
            ),
            const SizedBox(height: 6),
            Text(label, style: mu.text.caption),
          ],
        ),
      ),
    );
  }
}
