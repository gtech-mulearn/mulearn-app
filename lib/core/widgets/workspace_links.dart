import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/motion/mu_pressable.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/session/workspace_access.dart';

/// Profile's "Workspaces" rows: one per open role workspace, nothing when
/// the user has none. Drawn for the profile's night sheet.
class WorkspaceLinks extends ConsumerWidget {
  const WorkspaceLinks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final access = ref.watch(workspaceAccessProvider).value;
    if (access == null) return const SizedBox.shrink();
    final links = [
      if (access.mentor == WorkspaceState.open)
        (LucideIcons.graduationCap, 'Mentor workspace', RoutePaths.mentor),
      if (access.campus == WorkspaceState.open)
        (LucideIcons.school, 'Campus workspace', RoutePaths.campus),
      if (access.enablerCampuses == WorkspaceState.open)
        (LucideIcons.building2, 'My campuses', RoutePaths.enablerCampuses),
    ];
    if (links.isEmpty) return const SizedBox.shrink();
    final mu = context.mu;
    final c = mu.colors;
    return Padding(
      padding: const EdgeInsets.only(top: MuSpacing.space6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            child: Text(
              'WORKSPACES',
              style: mu.text.eyebrow.copyWith(color: c.onNight2),
              semanticsLabel: 'Workspaces',
            ),
          ),
          const SizedBox(height: MuSpacing.space2),
          for (final (icon, label, path) in links)
            Semantics(
              container: true,
              button: true,
              label: label,
              excludeSemantics: true,
              child: MuPressable(
                onTap: () => context.push(path),
                pressedScale: 0.98,
                child: Container(
                  margin: const EdgeInsets.only(top: MuSpacing.space2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: MuSpacing.space4,
                    vertical: MuSpacing.space3,
                  ),
                  decoration: BoxDecoration(
                    color: c.onNight.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(MuRadii.control),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: c.volt,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          icon,
                          size: MuSizes.iconSm,
                          color: c.onVolt,
                        ),
                      ),
                      const SizedBox(width: MuSpacing.space3),
                      Expanded(
                        child: Text(
                          label,
                          style: mu.text.bodyStrong.copyWith(color: c.onNight),
                        ),
                      ),
                      Icon(
                        LucideIcons.chevronRight,
                        size: MuSizes.iconSm,
                        color: c.onNight2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
