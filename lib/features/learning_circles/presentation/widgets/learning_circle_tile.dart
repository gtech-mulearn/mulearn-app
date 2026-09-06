import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/learning_circle.dart';

/// A "circles near you" card (DESIGN_SPEC.md §2 "10 — Learning circles") —
/// icon-square code, name, meta, and a join/joined state. [isMember] and
/// [onJoinTap] are supplied by the caller since membership isn't a field on
/// [LearningCircle] itself (it's derived by cross-referencing the user's own
/// circles list) — this widget only renders what it's given.
class LearningCircleTile extends StatelessWidget {
  const LearningCircleTile({
    required this.circle,
    required this.onTap,
    super.key,
    this.isMember = false,
    this.onJoinTap,
    this.isBusy = false,
  });

  final LearningCircle circle;
  final VoidCallback onTap;
  final bool isMember;
  final VoidCallback? onJoinTap;
  final bool isBusy;

  /// Short glyph for the icon-square — initials of the significant words in
  /// the circle's real title, capped at 3 letters (a display treatment only,
  /// not a fabricated data field).
  static String _code(String title) {
    const stopWords = {'of', 'the', 'a', 'an', 'and', '&', 'for', 'to', 'in'};
    final words = title
        .split(RegExp(r'\s+'))
        .map((w) => w.trim())
        .where((w) => w.isNotEmpty && !stopWords.contains(w.toLowerCase()))
        .toList();
    if (words.isEmpty) {
      return title.isNotEmpty ? title[0].toUpperCase() : '?';
    }
    return words.take(3).map((w) => w[0].toUpperCase()).join();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: MuSpace.m),
      child: MuCard(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                gradient: MuColors.karmaGradient,
                borderRadius: BorderRadius.circular(MuRadius.inner),
              ),
              alignment: Alignment.center,
              child: Text(
                _code(circle.title),
                style: MuType.tag.copyWith(color: Colors.white, fontSize: 12),
              ),
            ),
            const SizedBox(width: MuSpace.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    circle.title,
                    style: MuType.bodyMed,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    [
                      circle.ig,
                      if (circle.org != null) circle.org,
                      '${circle.totalMembers} members',
                    ].join(' · '),
                    style: MuType.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: MuSpace.s),
            _JoinButton(isMember: isMember, isBusy: isBusy, onTap: onJoinTap),
          ],
        ),
      ),
    );
  }
}

class _JoinButton extends StatelessWidget {
  const _JoinButton({required this.isMember, required this.isBusy, this.onTap});

  final bool isMember;
  final bool isBusy;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (isMember) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: MuColors.successBg,
          borderRadius: BorderRadius.circular(MuRadius.chip),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(LucideIcons.check, size: 13, color: MuColors.success),
            const SizedBox(width: 4),
            Text('Joined', style: MuType.chip.copyWith(color: MuColors.success, fontSize: 12)),
          ],
        ),
      );
    }
    return Material(
      color: MuColors.ink,
      borderRadius: BorderRadius.circular(MuRadius.chip),
      child: InkWell(
        onTap: isBusy ? null : onTap,
        borderRadius: BorderRadius.circular(MuRadius.chip),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            isBusy ? '…' : 'Request',
            style: MuType.chip.copyWith(color: MuColors.surface, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
