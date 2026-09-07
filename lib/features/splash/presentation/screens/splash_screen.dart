import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/mu_haptics.dart';

/// Branded loading screen shown while the initial session is resolved from
/// secure storage. The router redirects away from here once auth state
/// settles.
///
/// Cinematic "title card" treatment (near-black backdrop, a soft brand-color
/// glow bloom, the logo mark punching in with an overshoot then settling) —
/// the kind of bold single-mark-on-black opener streaming apps use, brought
/// to μLearn's own purple/blue brand color instead of copying anyone else's
/// literal palette. A two-stage haptic (an anticipatory tap, then a heavier
/// thud right as the logo lands) sells the "impact" moment.
///
/// Brand mark matches DESIGN_SPEC.md §2 "01 — Login"'s logo block: a 74×74
/// rounded-square [MuColors.primary] tile with a white "μ" glyph, the
/// "μLearn" wordmark below it, and the "a GTech initiative" caption — all of
/// the loading/redirect logic below is unchanged, only the mark itself
/// swapped from the flat logo asset to this tile treatment.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 900),
    vsync: this,
  );
  late final _glowOpacity = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0, 0.3, curve: Curves.easeOut),
  );
  late final _logoOpacity = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.05, 0.35, curve: Curves.easeOut),
  );
  // Punches past full size before settling — the "impact" the haptic below
  // is timed against — rather than a plain ease-in.
  late final _logoScale = TweenSequence<double>([
    TweenSequenceItem(tween: Tween(begin: 0.5, end: 1.15), weight: 70),
    TweenSequenceItem(tween: Tween(begin: 1.15, end: 1), weight: 30),
  ]).animate(CurvedAnimation(
    parent: _controller,
    curve: const Interval(0, 0.75, curve: Curves.easeOut),
  ));
  late final _spinnerOpacity = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.75, 1, curve: Curves.easeIn),
  );

  @override
  void initState() {
    super.initState();
    MuHaptics.medium();
    Future.delayed(const Duration(milliseconds: 450), () {
      if (mounted) MuHaptics.heavy();
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MuColors.ink,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  FadeTransition(
                    opacity: _glowOpacity,
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: MuColors.primaryBright.withValues(alpha: 0.45),
                            blurRadius: 60,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _logoOpacity,
                    child: ScaleTransition(
                      scale: _logoScale,
                      child: Container(
                        height: 74,
                        width: 74,
                        decoration: BoxDecoration(
                          color: MuColors.primary,
                          borderRadius: BorderRadius.circular(MuRadius.inner + 6),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'μ',
                          style: MuType.display.copyWith(
                            color: Colors.white,
                            fontSize: 36,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: MuSpace.l),
            FadeTransition(
              opacity: _logoOpacity,
              child: Column(
                children: [
                  Text(
                    'μLearn',
                    style: MuType.headline.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: MuSpace.xs),
                  Text(
                    'a GTech initiative',
                    style: MuType.caption.copyWith(
                      color: Colors.white.withValues(alpha: 0.5),
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: MuSpace.xl),
            FadeTransition(
              opacity: _spinnerOpacity,
              child: const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
