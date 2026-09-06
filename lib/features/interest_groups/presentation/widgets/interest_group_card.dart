import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_shadow.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/features/interest_groups/domain/entities/interest_group_summary.dart';

/// A single tile in the interest-group chooser grid (DESIGN_SPEC.md §2 "07")
/// — icon square with a short code, name, member-count meta line, and a
/// "Details →" affordance. The design's "selected" chip-flip treatment is
/// remapped onto the real membership state: a joined group flips the whole
/// tile to an ink surface with a small check badge, since this app has no
/// separate "selection" concept distinct from actually being a member.
class InterestGroupCard extends StatelessWidget {
  const InterestGroupCard({
    required this.group,
    required this.isJoined,
    required this.onTap,
    super.key,
  });

  final InterestGroupSummary group;
  final bool isJoined;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = isJoined ? MuColors.ink : MuColors.surface;
    final fg = isJoined ? MuColors.surface : MuColors.ink;
    final metaColor = isJoined ? MuColors.surface.withValues(alpha: 0.6) : MuColors.inkTertiary;
    final linkColor = isJoined ? MuColors.surface : MuColors.primary;

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(MuRadius.card),
        boxShadow: isJoined ? MuShadow.hero : MuShadow.card,
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(MuSpace.l),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _GroupIcon(group: group, isJoined: isJoined),
                    const SizedBox(height: MuSpace.m),
                    Text(
                      group.name,
                      style: MuType.bodyMed.copyWith(color: fg, fontWeight: FontWeight.w800),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(LucideIcons.users, size: 12, color: metaColor),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${group.memberCount} members',
                            style: MuType.caption.copyWith(color: metaColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Details',
                          style: MuType.chip.copyWith(color: linkColor, fontSize: 12),
                        ),
                        const SizedBox(width: 3),
                        Icon(LucideIcons.arrowRight, size: 13, color: linkColor),
                      ],
                    ),
                  ],
                ),
                if (isJoined)
                  Positioned(
                    top: -2,
                    right: -2,
                    child: Container(
                      height: 22,
                      width: 22,
                      decoration: BoxDecoration(
                        color: MuColors.success,
                        shape: BoxShape.circle,
                        border: Border.all(color: MuColors.ink, width: 2),
                      ),
                      child: const Icon(LucideIcons.check, size: 12, color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The group's real `icon` image when it loads; falls back to the `code`
/// field (short initials, e.g. "WD") on a tinted square, or a topic-guess
/// Lucide icon when neither is available. Colors invert when the parent
/// tile is on an ink surface (joined state) so the square keeps contrast.
class _GroupIcon extends StatelessWidget {
  const _GroupIcon({required this.group, required this.isJoined});

  final InterestGroupSummary group;
  final bool isJoined;

  /// Best-effort topic icon from the group's own name when there's no real
  /// `icon` image and no `code` to show — not fabricated per-category art,
  /// just a nicer generic icon than a plain "?" where the name gives an
  /// obvious clue.
  static IconData _fallbackTopicIcon(String name) {
    final n = name.toLowerCase();
    if (n.contains('cloud')) return LucideIcons.cloud;
    if (n.contains('data')) return LucideIcons.barChart3;
    if (n.contains('entrepreneur')) return LucideIcons.lightbulb;
    if (n.contains('ar/vr') || n.contains(' vr') || n.contains('vr ') || n.contains(' ar ')) {
      return LucideIcons.glasses;
    }
    if (n.contains('product') || n.contains('management')) return LucideIcons.package;
    if (n.contains('design')) return LucideIcons.palette;
    if (n.contains('security')) return LucideIcons.shield;
    if (n.contains('web')) return LucideIcons.globe;
    if (n.contains('mobile') || n.contains('app')) return LucideIcons.smartphone;
    if (n.contains('game')) return LucideIcons.gamepad2;
    if (n.contains('ai') || n.contains('machine learning') || n.contains('robot')) {
      return LucideIcons.brainCircuit;
    }
    return LucideIcons.hash;
  }

  @override
  Widget build(BuildContext context) {
    final squareBg = isJoined ? MuColors.surface : MuColors.primaryTint;
    final squareFg = isJoined ? MuColors.ink : MuColors.primary;
    final icon = group.icon;

    Widget content;
    if (icon != null && icon.isNotEmpty) {
      content = CachedNetworkImage(
        imageUrl: icon,
        fit: BoxFit.cover,
        placeholder: (_, __) => _FallbackContent(group: group, color: squareFg),
        errorWidget: (_, __, ___) => _FallbackContent(group: group, color: squareFg),
      );
    } else {
      content = _FallbackContent(group: group, color: squareFg);
    }

    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        color: squareBg,
        borderRadius: BorderRadius.circular(MuRadius.inner),
      ),
      clipBehavior: Clip.antiAlias,
      child: content,
    );
  }
}

class _FallbackContent extends StatelessWidget {
  const _FallbackContent({required this.group, required this.color});

  final InterestGroupSummary group;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final code = group.code;
    if (code != null && code.isNotEmpty) {
      return Center(
        child: Text(
          code.toUpperCase(),
          style: MuType.statSmall.copyWith(color: color, fontSize: 14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }
    return Center(
      child: Icon(_GroupIcon._fallbackTopicIcon(group.name), color: color, size: 22),
    );
  }
}
