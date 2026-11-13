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
    if (access == null) return const SizedBox.shrink();
    final mentor = access.mentor == WorkspaceState.open;
    final campus = access.campus == WorkspaceState.open;
    if (!mentor && !campus) return const SizedBox.shrink();
    return Column(
      children: [
        if (mentor) ...[const SizedBox(height: MuSpace.l), const _MentorCard()],
        if (campus) ...[const SizedBox(height: MuSpace.l), const _CampusCard()],
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

class _CampusCard extends ConsumerWidget {
  const _CampusCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final h = ref.watch(campusHeadlineProvider).value;
    final subtitle = h == null
        ? 'Students, circles and approvals'
        : [
            if (h.code.isNotEmpty) h.code else h.college,
            if (h.statLabel != null && h.statValue != null) '${h.statLabel} ${h.statValue}',
          ].join(' · ');
    return WorkspaceCard(
      icon: LucideIcons.school,
      title: 'Campus workspace',
      subtitle: subtitle,
      onTap: () => context.push(RoutePaths.campus),
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
