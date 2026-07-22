import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/features/interest_groups/domain/entities/interest_group_summary.dart';

/// A single card in the interest-group directory grid/list — icon, name,
/// category, member count, and a joined/not-joined indicator. Vertical
/// layout so the name gets the card's full width rather than competing with
/// the icon on one row.
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
    return MuCard(
      onTap: onTap,
      padding: const EdgeInsets.all(MuSpace.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _GroupIcon(group: group),
              const Spacer(),
              if (isJoined)
                const Icon(LucideIcons.checkCircle2, color: MuColors.limeBright, size: 18),
            ],
          ),
          const SizedBox(height: MuSpace.s),
          Text(
            group.name,
            style: MuType.bodyMed,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            group.category,
            style: MuType.caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: MuSpace.m),
          Row(
            children: [
              const Icon(LucideIcons.users, size: 12, color: MuColors.inkTertiary),
              const SizedBox(width: MuSpace.xs),
              Expanded(
                child: Text(
                  '${group.memberCount} members',
                  style: MuType.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// The group's real `icon` image when it loads; falls back to a colored
/// initial-letter avatar (same fallback [LearningCircleTile] uses) when the
/// field is missing or the image fails to load, rather than leaving a
/// broken-image glyph.
class _GroupIcon extends StatelessWidget {
  const _GroupIcon({required this.group});

  final InterestGroupSummary group;

  @override
  Widget build(BuildContext context) {
    final icon = group.icon;
    return ClipRRect(
      borderRadius: BorderRadius.circular(MuRadius.inner),
      child: SizedBox(
        height: 36,
        width: 36,
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
    final initial = group?.name.isNotEmpty ?? false ? group!.name[0].toUpperCase() : '?';
    return Container(
      decoration: const BoxDecoration(gradient: MuColors.heroGradient),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: MuType.bodyMed.copyWith(color: Colors.white),
      ),
    );
  }
}
