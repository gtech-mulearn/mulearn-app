import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/widgets/mu_logo.dart';

/// The loading screen while the session is read from secure storage: the app
/// icon alone on launch navy, pixel-identical to the native launch window
/// before it (`launch_background.xml` / Android 12 `splash_icon`, iOS
/// `LaunchImage`: all a [markSize] tile), so opening the app reads as one
/// still screen with no flash or jump. The router moves on once auth state is
/// known.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  /// Shared with the native launch assets rendered by `design/logo/`.
  static const double markSize = 120;

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
            child: const MuLogo.appIcon(size: markSize),
          ),
        ),
      ),
    );
  }
}
