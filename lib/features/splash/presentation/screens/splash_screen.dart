import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';

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
    HapticFeedback.mediumImpact();
    Future.delayed(const Duration(milliseconds: 450), () {
      if (mounted) HapticFeedback.heavyImpact();
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
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 72,
                      ),
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
