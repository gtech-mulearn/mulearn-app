import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/session/workspace_access.dart';
import 'package:mulearn_app/features/dashboard/presentation/providers/workspace_cards_providers.dart';

/// Home's doors into the role workspaces (spec §8.2 item 5: inside Home,
/// not new tabs; artifact Home: workspace doors close the page). One door
/// per open workspace, decided per role; nothing when none is open.
class WorkspaceCards extends ConsumerWidget {
  const WorkspaceCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final access = ref.watch(workspaceAccessProvider).value;
    if (access == null) return const SizedBox.shrink();
    final mentor = access.mentor == WorkspaceState.open;
    final campus = access.campus == WorkspaceState.open;
    final team = access.team == WorkspaceState.open;
    if (!mentor && !campus && !team) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: MuSpacing.space10),
        const MuSectionTitle('Your workspaces'),
        if (mentor) const _MentorCard(),
        if (mentor && campus) const SizedBox(height: MuSpacing.space3),
        if (campus) const _CampusCard(),
        if ((mentor || campus) && team)
          const SizedBox(height: MuSpacing.space3),
        if (team) const _TeamCard(),
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
      tone: IgCategory.creative,
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
            if (h.statLabel != null && h.statValue != null)
              '${h.statLabel} ${h.statValue}',
          ].join(' · ');
    return WorkspaceCard(
      icon: LucideIcons.school,
      title: 'Campus workspace',
      subtitle: subtitle,
      onTap: () => context.push(RoutePaths.campus),
    );
  }
}

class _TeamCard extends StatelessWidget {
  const _TeamCard();

  @override
  Widget build(BuildContext context) => WorkspaceCard(
    icon: LucideIcons.megaphone,
    tone: IgCategory.manager,
    title: 'Team workspace',
    subtitle: 'Announcements, pushes and the log',
    onTap: () => context.push(RoutePaths.team),
  );
}

/// One workspace door: a printed-colour icon well, the workspace and a
/// one-line summary, and a chevron, on a `surface` card.
class WorkspaceCard extends StatelessWidget {
  const WorkspaceCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.tone = IgCategory.coder,
    super.key,
  });

  final IconData icon;
  final IgCategory tone;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return Semantics(
      button: true,
      label: '$title, $subtitle',
      excludeSemantics: true,
      child: MuPressable(
        onTap: onTap,
        pressedScale: 0.98,
        child: Container(
          padding: const EdgeInsets.all(MuSpacing.space4),
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: BorderRadius.circular(MuRadii.card),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: MuTones.forIgCategory(c, tone),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: MuSizes.iconMd, color: c.inkPrint),
              ),
              const SizedBox(width: MuSpacing.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: mu.text.title3),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: mu.text.caption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                LucideIcons.chevronRight,
                size: MuSizes.iconSm,
                color: c.ink3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
