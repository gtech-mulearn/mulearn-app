import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/widgets/mu_logo.dart';

/// The loading screen while the session is read from secure storage: the
/// gradient μ alone on launch navy, pixel-identical to the native launch
/// window before it (`launch_background.xml`, 88dp mark), so opening the app
/// reads as one still screen with no flash or jump. The router moves on once
/// auth state is known.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: MuColors.launchNavy,
        body: Center(
          child: Semantics(
            label: 'μLearn',
            image: true,
            child: const MuLogo.mark(size: 88),
          ),
        ),
      ),
    );
  }
}
