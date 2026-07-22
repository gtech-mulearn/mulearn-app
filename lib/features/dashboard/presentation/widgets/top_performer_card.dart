import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_shadow.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/profile_avatar.dart';

/// Half-width "Top Learner"/"Top College" card for the Home dashboard —
/// the all-time #1 row from the leaderboard. Tinted background + a large,
/// low-opacity decorative icon standing in for illustrated artwork, since
/// no image-generation tool/asset pipeline is available.
class TopPerformerCard extends StatelessWidget {
  const TopPerformerCard({
    required this.icon,
    required this.tint,
    required this.accent,
    required this.eyebrow,
    required this.name,
    required this.karma,
    required this.onTap,
    super.key,
    this.avatarUrl,
  });

  final IconData icon;
  final Color tint;
  final Color accent;
  final String eyebrow;
  final String name;
  final int karma;
  final VoidCallback onTap;

  /// Only meaningful for a person (student leaderboard) — colleges don't
  /// have a real logo/image field, so this stays null there.
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: tint,
      borderRadius: BorderRadius.circular(MuRadius.card),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          decoration: const BoxDecoration(boxShadow: MuShadow.card),
          child: Stack(
            children: [
              Positioned(
                right: -14,
                bottom: -14,
                child: Icon(icon, size: 84, color: accent.withValues(alpha: 0.16)),
              ),
              Padding(
                padding: const EdgeInsets.all(MuSpace.l),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
                          alignment: Alignment.center,
                          child: Icon(icon, size: 14, color: Colors.white),
                        ),
                        const SizedBox(width: MuSpace.s),
                        Expanded(
                          child: Text(
                            eyebrow.toUpperCase(),
                            style: MuType.eyebrow.copyWith(color: accent),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: MuSpace.m),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                name,
                                style: MuType.bodyMed,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Icon(LucideIcons.zap, size: 12, color: MuColors.primary),
                                  const SizedBox(width: MuSpace.xs),
                                  Text(
                                    '$karma karma',
                                    style: MuType.caption.copyWith(color: MuColors.primary),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (avatarUrl != null) ...[
                          const SizedBox(width: MuSpace.s),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: ProfileAvatar(url: avatarUrl, name: name, size: 36),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
