import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';

/// Promo/announcement banner (rules.md §8) — hackathon announcements,
/// Launchpad, karma events. Max one per screen.
class MuBanner extends StatelessWidget {
  const MuBanner({
    required this.eyebrow,
    required this.title,
    required this.ctaLabel,
    required this.onTap,
    super.key,
    this.caption,
    this.dark = false,
    this.live = false,
  });

  final String eyebrow;
  final String title;
  final String? caption;
  final String ctaLabel;
  final VoidCallback onTap;

  /// Use `ink` bg instead of `primary` for special events.
  final bool dark;

  final bool live;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(MuSpace.xl),
      decoration: BoxDecoration(
        color: dark ? MuColors.ink : MuColors.primary,
        borderRadius: BorderRadius.circular(MuRadius.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  eyebrow.toUpperCase(),
                  style: MuType.eyebrow.copyWith(color: MuColors.lime),
                ),
              ),
              if (live)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: MuColors.coral,
                    borderRadius: BorderRadius.circular(MuRadius.chip),
                  ),
                  child: Text(
                    'LIVE ●',
                    style: MuType.chip.copyWith(color: MuColors.surface, fontSize: 11),
                  ),
                ),
            ],
          ),
          const SizedBox(height: MuSpace.s),
          Text(title, style: MuType.headline.copyWith(color: MuColors.surface)),
          if (caption != null) ...[
            const SizedBox(height: MuSpace.xs),
            Text(
              caption!,
              style: MuType.caption.copyWith(color: Colors.white.withValues(alpha: 0.7)),
            ),
          ],
          const SizedBox(height: MuSpace.l),
          MuLimeButton(label: ctaLabel, onPressed: onTap, expand: false, compact: true),
        ],
      ),
    );
  }
}
