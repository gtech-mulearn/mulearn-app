import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/profile_avatar.dart';

/// Full-bleed immersive header (rules.md §8) — used on Home, Profile,
/// Leaderboard. Extends under the status bar; the caller's scroll view
/// should pull its first white card up over the bottom edge for the
/// signature overlapping-sheet look.
class MuGradientHeader extends StatelessWidget {
  const MuGradientHeader({
    required this.title,
    super.key,
    this.subtitle,
    this.avatarUrl,
    this.avatarName,
    this.onAvatarTap,
    this.trailing = const [],
    this.bottom,
    this.showDecoration = false,
    this.light = false,
    this.avatarSize = 44,
  });

  final String title;
  final String? subtitle;
  final String? avatarUrl;
  final String? avatarName;
  final VoidCallback? onAvatarTap;
  final List<Widget> trailing;
  final double avatarSize;

  /// Extra content below the title/subtitle (e.g. a filter chip row).
  final Widget? bottom;

  /// Layers soft blurred-circle shapes + sparkle dots over the gradient —
  /// opt-in so Profile/Leaderboard's header stays exactly as before; only
  /// Home turns this on.
  final bool showDecoration;

  /// Swaps the bold [MuColors.heroGradient] + white text for the soft
  /// [MuColors.homeHeaderGradient] + dark text — Home-only; Profile and
  /// Leaderboard never pass this, so they're pixel-identical to before.
  final bool light;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.fromLTRB(
        MuSpace.screenH,
        MediaQuery.of(context).padding.top + MuSpace.l,
        MuSpace.screenH,
        MuSpace.xxl,
      ),
      decoration: BoxDecoration(
        gradient: light ? MuColors.homeHeaderGradient : MuColors.heroGradient,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (showDecoration) Positioned.fill(child: _HeaderDecoration(light: light)),
          _HeaderContent(
            title: title,
            subtitle: subtitle,
            avatarUrl: avatarUrl,
            avatarName: avatarName,
            onAvatarTap: onAvatarTap,
            trailing: trailing,
            bottom: bottom,
            light: light,
            avatarSize: avatarSize,
          ),
        ],
      ),
    );
  }
}

class _HeaderContent extends StatelessWidget {
  const _HeaderContent({
    required this.title,
    required this.subtitle,
    required this.avatarUrl,
    required this.avatarName,
    required this.onAvatarTap,
    required this.trailing,
    required this.bottom,
    required this.light,
    required this.avatarSize,
  });

  final String title;
  final String? subtitle;
  final String? avatarUrl;
  final String? avatarName;
  final VoidCallback? onAvatarTap;
  final List<Widget> trailing;
  final Widget? bottom;
  final bool light;
  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    final titleColor = light ? MuColors.ink : MuColors.surface;
    final subtitleColor = light ? MuColors.inkSecondary : Colors.white.withValues(alpha: 0.7);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (avatarName != null)
              GestureDetector(
                onTap: onAvatarTap,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: light
                        ? null
                        : Border.all(color: MuColors.surface, width: 2),
                  ),
                  child: ProfileAvatar(url: avatarUrl, name: avatarName!, size: avatarSize),
                ),
              ),
            const Spacer(),
            for (final action in trailing) ...[
              action,
              const SizedBox(width: MuSpace.s),
            ],
          ],
        ),
        const SizedBox(height: MuSpace.l),
        Text(title, style: MuType.display.copyWith(color: titleColor)),
        if (subtitle != null) ...[
          const SizedBox(height: MuSpace.xs),
          Text(subtitle!, style: MuType.label.copyWith(color: subtitleColor)),
        ],
        if (bottom != null) ...[
          const SizedBox(height: MuSpace.l),
          bottom!,
        ],
      ],
    );
  }
}

/// Soft blurred-circle shapes + sparkle dots layered over the gradient —
/// purely decorative, token-driven (no image assets).
class _HeaderDecoration extends StatelessWidget {
  const _HeaderDecoration({required this.light});

  final bool light;

  @override
  Widget build(BuildContext context) {
    final tint = light ? MuColors.primary : Colors.white;
    final sparkleTint = light ? MuColors.primary.withValues(alpha: 0.35) : Colors.white;
    return IgnorePointer(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // One large soft blob bleeding off the bottom-right corner —
          // matches the reference's dominant shape rather than two smaller,
          // more evenly balanced ones.
          Positioned(
            right: -70,
            bottom: -110,
            child: _blurCircle(260, tint, light ? 0.09 : 0.10),
          ),
          Positioned(
            left: -60,
            top: -50,
            child: _blurCircle(110, tint, light ? 0.05 : 0.06),
          ),
          Positioned(right: 60, top: 20, child: _Sparkle(6, sparkleTint)),
          Positioned(left: 130, bottom: 22, child: _Sparkle(4, sparkleTint)),
          Positioned(right: 24, bottom: 60, child: _Sparkle(3, sparkleTint)),
        ],
      ),
    );
  }

  Widget _blurCircle(double size, Color color, double alpha) => Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: alpha),
        ),
      );
}

class _Sparkle extends StatelessWidget {
  const _Sparkle(this.size, this.color);

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
