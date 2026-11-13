import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/session/workspace_access.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';

/// Profile's "Workspaces" rows: one per open role workspace, nothing when
/// the user has none.
class WorkspaceLinks extends ConsumerWidget {
  const WorkspaceLinks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final access = ref.watch(workspaceAccessProvider).value;
    if (access == null) return const SizedBox.shrink();
    final links = [
      if (access.mentor == WorkspaceState.open) (LucideIcons.graduationCap, 'Mentor workspace', RoutePaths.mentor),
    ];
    if (links.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: MuSpace.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Workspaces'.toUpperCase(), style: MuType.eyebrow, semanticsLabel: 'Workspaces'),
          const SizedBox(height: MuSpace.s),
          MuCard(
            padding: EdgeInsets.zero,
            child: Material(
              type: MaterialType.transparency,
              child: Column(
                children: [
                  for (final (icon, label, path) in links)
                    ListTile(
                      leading: Icon(icon, color: MuColors.primary),
                      title: Text(label, style: MuType.bodyMed),
                      trailing: const Icon(LucideIcons.chevronRight, size: 18, color: MuColors.inkSecondary),
                      onTap: () => context.push(path),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
