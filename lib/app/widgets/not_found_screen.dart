import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';

/// The router's page for a path the app doesn't know: the dashboard's
/// `(dashboard)/not-found.tsx` (StateDisplay "not-found" + "Back to Home").
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MuColors.canvas,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: MuStateDisplay(
              variant: MuStateVariant.notFound,
              action: MuPrimaryButton(
                label: 'Back to Home',
                expand: false,
                onPressed: () => context.go(RoutePaths.home),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
