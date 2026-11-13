import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/motion/mu_pressable.dart';
import 'package:mulearn_app/core/design_system/mulearn/mu_leaderboard.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// Karma, μLearn's currency of contribution: a `night` card with the total
/// in volt numerals, the level, and the rank.
class MuKarmaMeter extends StatelessWidget {
  /// A meter for [total] karma.
  const MuKarmaMeter({required this.total, this.level, this.rank, this.progress, this.toNext, this.onTap, super.key});

  /// Total karma.
  final int total;

  /// "Level 4".
  final String? level;

  /// "Rank #15 · Top 10%".
  final String? rank;

  /// 0–1 progress to the next level, when known.
  final double? progress;

  /// "1,520 to Level 5", when known.
  final String? toNext;

  /// Opens the journey.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final card = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(MuSpacing.space5),
      decoration: BoxDecoration(color: c.night, borderRadius: BorderRadius.circular(MuRadii.panel)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.zap, size: MuSizes.iconSm, color: c.volt),
              const SizedBox(width: 6),
              Text('TOTAL KARMA', style: mu.text.eyebrow.copyWith(color: c.onNight2)),
              const Spacer(),
              if (rank != null)
                Flexible(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: c.onNight.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(MuRadii.round),
                    ),
                    child: Text(
                      rank!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: mu.text.label.copyWith(color: c.onNight, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: MuSpacing.space4),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(muGrouped(total), style: mu.text.numeralXl.copyWith(color: c.volt)),
          ),
          const SizedBox(height: MuSpacing.space4),
          Row(
            children: [
              if (level != null) Text(level!, style: mu.text.bodyStrong.copyWith(color: c.onNight)),
              const Spacer(),
              if (toNext != null) Text(toNext!, style: mu.text.label.copyWith(color: c.onNight2)),
              if (onTap != null && toNext == null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Your journey', style: mu.text.label.copyWith(color: c.onNight2)),
                    const SizedBox(width: 4),
                    Icon(LucideIcons.arrowRight, size: 14, color: c.onNight2),
                  ],
                ),
            ],
          ),
          if (progress != null) ...[
            const SizedBox(height: MuSpacing.space2),
            ClipRRect(
              borderRadius: BorderRadius.circular(MuRadii.round),
              child: SizedBox(
                height: 8,
                child: Stack(
                  children: [
                    Positioned.fill(child: ColoredBox(color: c.onNight.withValues(alpha: 0.16))),
                    FractionallySizedBox(
                      widthFactor: progress!.clamp(0, 1),
                      child: ColoredBox(color: c.volt),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
    return Semantics(
      container: true,
      button: onTap != null,
      label: ['${muGrouped(total)} karma', ?level, ?rank, ?toNext].join(', '),
      excludeSemantics: true,
      child: onTap == null ? card : MuPressable(onTap: onTap, pressedScale: 0.98, child: card),
    );
  }
}

/// A section heading on a scrolling screen, with an optional "See all".
class MuSectionTitle extends StatelessWidget {
  /// A heading reading [title].
  const MuSectionTitle(this.title, {this.onSeeAll, this.trailing, super.key});

  /// Sentence case ("Up next").
  final String title;

  /// Shows "See all" in cobalt.
  final VoidCallback? onSeeAll;

  /// Other trailing text ("31 groups"), when there's no "See all".
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return Row(
      children: [
        Expanded(
          child: Semantics(header: true, child: Text(title, style: mu.text.title2)),
        ),
        if (onSeeAll != null)
          Semantics(
            container: true,
            button: true,
            label: 'See all $title',
            excludeSemantics: true,
            child: MuPressable(
              onTap: onSeeAll,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: MuSizes.touchMin, minWidth: MuSizes.touchMin),
                child: Center(
                  child: Text('See all', style: mu.text.label.copyWith(color: c.cobaltText)),
                ),
              ),
            ),
          )
        else if (trailing != null)
          Text(trailing!, style: mu.text.caption),
      ],
    );
  }
}
