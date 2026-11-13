import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/session/my_profile_payload.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/core/session/workspace_access.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/core/widgets/role_pending_banner.dart';

/// Wraps a role workspace route. [builder] runs only when the selected
/// workspace is open, so a pending or foreign role never builds the
/// workspace and never makes its requests (deep links included).
class WorkspaceGate extends ConsumerWidget {
  const WorkspaceGate({required this.select, required this.role, required this.builder, super.key});

  final WorkspaceState Function(WorkspaceAccess access) select;

  /// The role the pending banner names (e.g. "Mentor", "Enabler").
  final String role;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(workspaceAccessProvider).when(
          loading: () => const Scaffold(
            backgroundColor: MuColors.canvas,
            body: Center(child: CircularProgressIndicator()),
          ),
          error: (error, _) => _Shell(
            child: ErrorRetryView(
              error: error,
              // Retry the sources, not just the derived value: they keep a
              // failure until fetched again.
              onRetry: () {
                invalidateSessionState(ref.invalidate);
                ref.invalidate(myProfilePayloadProvider);
              },
            ),
          ),
          data: (access) {
            final state = access == null ? WorkspaceState.hidden : select(access);
            return switch (state) {
              WorkspaceState.open => builder(context),
              WorkspaceState.pending => _Shell(
                  child: Padding(
                    padding: const EdgeInsets.all(MuSpace.screenH),
                    // A campus gate names the role actually held (Campus
                    // Lead, Lead Enabler or Enabler).
                    child: RolePendingBanner(
                      role: role == 'Mentor' ? role : (access?.pendingCampusRole ?? role),
                    ),
                  ),
                ),
              WorkspaceState.hidden => _Shell(
                  child: SingleChildScrollView(
                    child: MuStateDisplay(
                      variant: MuStateVariant.notFound,
                      title: 'Not available',
                      description: "This workspace isn't available for your account.",
                      action: TextButton(
                        onPressed: () => context.canPop() ? context.pop() : context.go(RoutePaths.home),
                        child: const Text('Back'),
                      ),
                    ),
                  ),
                ),
            };
          },
        );
  }
}

class _Shell extends StatelessWidget {
  const _Shell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(backgroundColor: MuColors.canvas, elevation: 0),
      body: SafeArea(child: Align(alignment: Alignment.topCenter, child: child)),
    );
  }
}
