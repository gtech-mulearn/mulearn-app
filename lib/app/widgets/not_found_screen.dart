import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';

/// The router's page for a path the app doesn't know: the dashboard's
/// `(dashboard)/not-found.tsx` (StateDisplay "not-found" + "Back to Home").
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mu.colors.chalk,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: MuStateDisplay(
              variant: MuStateVariant.notFound,
              action: MuButton(
                label: 'Back to Home',
                onPressed: () => context.go(RoutePaths.home),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
