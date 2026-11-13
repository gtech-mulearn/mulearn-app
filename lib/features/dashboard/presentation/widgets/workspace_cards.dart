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
import 'package:mulearn_app/features/dashboard/presentation/providers/workspace_cards_providers.dart';

/// Home's entry to the role workspaces (spec §8.2 item 5: inside Home, not
/// new tabs). Shows a card per open workspace; nothing otherwise.
class WorkspaceCards extends ConsumerWidget {
  const WorkspaceCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final access = ref.watch(workspaceAccessProvider).value;
    if (access == null || access.mentor != WorkspaceState.open) return const SizedBox.shrink();
    return const Column(
      children: [
        SizedBox(height: MuSpace.l),
        _MentorCard(),
      ],
    );
  }
}

class _MentorCard extends ConsumerWidget {
  const _MentorCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(mentorUpcomingCountProvider).value;
    final subtitle = switch (count) {
      null => 'Sessions, requests and availability',
      1 => '1 upcoming session',
      final n => '$n upcoming sessions',
    };
    return WorkspaceCard(
      icon: LucideIcons.graduationCap,
      title: 'Mentor workspace',
      subtitle: subtitle,
      onTap: () => context.push(RoutePaths.mentor),
    );
  }
}

/// One workspace entry: icon, title, a one-line summary and a chevron.
class WorkspaceCard extends StatelessWidget {
  const WorkspaceCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MuCard(
      onTap: onTap,
      padding: const EdgeInsets.all(MuSpace.l),
      child: Row(
        children: [
          Icon(icon, size: 22, color: MuColors.primary),
          const SizedBox(width: MuSpace.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: MuType.bodyMed),
                Text(subtitle, style: MuType.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const Icon(LucideIcons.chevronRight, size: 18, color: MuColors.inkSecondary),
        ],
      ),
    );
  }
}
