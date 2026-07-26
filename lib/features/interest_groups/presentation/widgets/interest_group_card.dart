import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/features/interest_groups/domain/entities/interest_group_summary.dart';

/// A single card in the interest-group directory grid/list — topic icon,
/// name, a big colored member-count stat, and a "Cluster · category" pill.
///
/// Each card gets a stable accent color from [_palette] (hashed off the
/// group id, so it's consistent across rebuilds but varies even between
/// groups sharing a category — real interest-group categories repeat a lot,
/// e.g. several different "coder" groups, and giving them all the exact same
/// tint made the grid look flat). The card surface itself stays plain white
/// (a first pass wrapped the whole card in an accent-tinted gradient plus
/// two oversized glow blobs, which on a card this small compounded into a
/// solid color wash rather than a subtle accent — confirmed live as too
/// much); the "wow" instead comes from a soft *colored* ambient shadow
/// floating the card off the canvas, and vivid gradient treatment on the
/// icon tile, avatar, and category pill.
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

  static const _palette = [
    Color(0xFF8B5CF6), // purple
    Color(0xFF3B82F6), // blue
    Color(0xFF22C55E), // green
    Color(0xFFF59E0B), // orange
    Color(0xFF14B8A6), // teal
    Color(0xFFEC4899), // pink
    Color(0xFF6366F1), // indigo
    Color(0xFFEF4444), // red
  ];

  Color get _accent => _palette[group.id.hashCode.abs() % _palette.length];

  /// The bottom pill's small icon — tied to the category, unlike the topic
  /// icon above (which is tied to what the group is actually about).
  static IconData _categoryIcon(String category) => switch (category.toLowerCase()) {
        'coder' => LucideIcons.code2,
        'maker' => LucideIcons.palette,
        'manager' => LucideIcons.sparkles,
        'creative' => LucideIcons.rocket,
        _ => LucideIcons.hash,
      };

  /// Best-effort topic icon from the group's own name when there's no real
  /// `icon` image to show — not fabricated per-category art, just a nicer
  /// generic icon than a plain letter where the name gives an obvious clue.
  static IconData _fallbackTopicIcon(String name, String category) {
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
    if (n.contains('ai') || n.contains('machine learning')) return LucideIcons.brainCircuit;
    return _categoryIcon(category);
  }

  @override
  Widget build(BuildContext context) {
    final accent = _accent;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(MuRadius.card),
        boxShadow: [
          BoxShadow(color: accent.withValues(alpha: 0.22), blurRadius: 22, offset: const Offset(0, 12)),
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(MuSpace.m),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _GroupIcon(group: group, accent: accent),
                    const Spacer(),
                    _AvatarBadge(group: group, accent: accent, isJoined: isJoined),
                  ],
                ),
                const SizedBox(height: MuSpace.m),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        group.name,
                        style: MuType.bodyMed.copyWith(fontWeight: FontWeight.w800),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: MuSpace.s),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${group.memberCount}',
                          style: MuType.stat.copyWith(color: accent, fontSize: 22),
                        ),
                        Row(
                          children: [
                            Icon(LucideIcons.users, size: 10, color: accent.withValues(alpha: 0.8)),
                            const SizedBox(width: 2),
                            Text(
                              'members',
                              style: MuType.caption.copyWith(color: accent.withValues(alpha: 0.8), fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                const SizedBox(height: MuSpace.s),
                Container(height: 1, color: MuColors.divider),
                const SizedBox(height: MuSpace.s),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: MuSpace.s, vertical: 7),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [accent, accent.withValues(alpha: 0.78)],
                    ),
                    borderRadius: BorderRadius.circular(MuRadius.chip),
                    boxShadow: [
                      BoxShadow(color: accent.withValues(alpha: 0.35), blurRadius: 10, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_categoryIcon(group.category), size: 13, color: Colors.white),
                      const SizedBox(width: MuSpace.xs),
                      Text(
                        'Cluster',
                        style: MuType.chip.copyWith(color: Colors.white, fontSize: 11),
                      ),
                      const SizedBox(width: MuSpace.xs),
                      Container(width: 1, height: 10, color: Colors.white.withValues(alpha: 0.5)),
                      const SizedBox(width: MuSpace.xs),
                      Flexible(
                        child: Text(
                          group.category,
                          style: MuType.chip.copyWith(color: Colors.white, fontSize: 11),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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

/// The group's real `icon` image when it loads; falls back to a topic-ish
/// Lucide icon (see [InterestGroupCard._fallbackTopicIcon]) on a vivid
/// gradient tile when the field is missing or the image fails to load.
class _GroupIcon extends StatelessWidget {
  const _GroupIcon({required this.group, required this.accent});

  final InterestGroupSummary group;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final icon = group.icon;
    return Container(
      height: 52,
      width: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MuRadius.inner),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [accent, accent.withValues(alpha: 0.7)],
        ),
        boxShadow: [
          BoxShadow(color: accent.withValues(alpha: 0.4), blurRadius: 12, offset: const Offset(0, 6)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(MuRadius.inner),
        child: (icon != null && icon.isNotEmpty)
            ? CachedNetworkImage(
                imageUrl: icon,
                fit: BoxFit.cover,
                placeholder: (_, __) => const _FallbackIcon(),
                errorWidget: (_, __, ___) => _FallbackIcon(group: group),
              )
            : _FallbackIcon(group: group),
      ),
    );
  }
}

class _FallbackIcon extends StatelessWidget {
  const _FallbackIcon({this.group});

  final InterestGroupSummary? group;

  @override
  Widget build(BuildContext context) {
    final g = group;
    return Center(
      child: Icon(
        g != null ? InterestGroupCard._fallbackTopicIcon(g.name, g.category) : LucideIcons.hash,
        color: Colors.white,
        size: 26,
      ),
    );
  }
}

/// Initial-letter avatar badge with a small "joined" check overlapping its
/// bottom-right corner — mirrors the level badge on the profile avatar
/// elsewhere in the app.
class _AvatarBadge extends StatelessWidget {
  const _AvatarBadge({required this.group, required this.accent, required this.isJoined});

  final InterestGroupSummary group;
  final Color accent;
  final bool isJoined;

  @override
  Widget build(BuildContext context) {
    final initial = group.name.isNotEmpty ? group.name[0].toUpperCase() : '?';
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [accent, accent.withValues(alpha: 0.7)],
            ),
            boxShadow: [
              BoxShadow(color: accent.withValues(alpha: 0.35), blurRadius: 8, offset: const Offset(0, 3)),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            initial,
            style: MuType.bodyMed.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
        if (isJoined)
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              height: 14,
              width: 14,
              decoration: BoxDecoration(
                color: MuColors.limeBright,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: const Icon(LucideIcons.check, size: 9, color: Colors.white),
            ),
          ),
      ],
    );
  }
}
