import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/session/workspace_access.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';

/// "`<Role>` account pending verification" — the dashboard's
/// VerificationStatusBanner copy (Mentor and Enabler verbatim; the same
/// pattern names Campus Lead and Lead Enabler).
class RolePendingBanner extends StatelessWidget {
  const RolePendingBanner({required this.role, super.key});

  final String role;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(MuSpace.m),
        decoration: BoxDecoration(
          color: MuColors.warningBg,
          borderRadius: BorderRadius.circular(MuRadius.inner),
          border: Border.all(color: MuColors.warningFill.withValues(alpha: 0.3)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 2),
              child: Icon(LucideIcons.alertCircle, size: 18, color: MuColors.warning),
            ),
            const SizedBox(width: MuSpace.s),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$role account pending verification',
                    style: MuType.body.copyWith(color: MuColors.warning, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Your ${role.toLowerCase()} profile is awaiting admin approval. '
                    'You will be notified once your account is verified.',
                    style: MuType.body.copyWith(color: MuColors.warning),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Every pending role of the signed-in user, for Home and Profile. Nothing
/// (no space either) while loading, on error, or when nothing is pending.
class PendingRoleBanners extends ConsumerWidget {
  const PendingRoleBanners({this.spacing = MuSpace.l, super.key});

  /// Space above each banner.
  final double spacing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final access = ref.watch(workspaceAccessProvider).value;
    if (access == null) return const SizedBox.shrink();
    final roles = [
      if (access.mentor == WorkspaceState.pending) 'Mentor',
      ...access.pendingCampusRoles,
    ];
    if (roles.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        for (final role in roles) ...[
          SizedBox(height: spacing),
          RolePendingBanner(role: role),
        ],
      ],
    );
  }
}
