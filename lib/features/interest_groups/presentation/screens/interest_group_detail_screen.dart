import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_shadow.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/unescape_literal_unicode.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_section_header.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/core/widgets/profile_avatar.dart';
import 'package:mulearn_app/features/interest_groups/domain/entities/ig_impact_project.dart';
import 'package:mulearn_app/features/interest_groups/domain/entities/ig_person_ref.dart';
import 'package:mulearn_app/features/interest_groups/domain/entities/interest_group_summary.dart';
import 'package:mulearn_app/features/interest_groups/presentation/providers/interest_groups_controller.dart';
import 'package:url_launcher/url_launcher.dart';

/// Full detail for a single interest group — DESIGN_SPEC.md §2 "08 — IG
/// detail": dark hero card, About / Prerequisites / Career opportunities /
/// Community leads / Mentors sections (built only for the fields the real
/// `InterestGroupSummary` entity actually carries — there's no
/// office-hours/active-task data behind this endpoint, so that section from
/// the mock is dropped rather than faked), and a sticky join/leave CTA.
class InterestGroupDetailScreen extends ConsumerWidget {
  const InterestGroupDetailScreen({required this.groupId, super.key});

  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(interestGroupDetailProvider(groupId));
    final myIdsState = ref.watch(myInterestGroupIdsProvider);
    final membershipState = ref.watch(
      interestGroupMembershipControllerProvider,
    );
    final myIds = myIdsState.value ?? const <String>[];
    final isJoined = myIds.contains(groupId);
    // The backend caps learners at three groups: say so before any tap.
    final atCap = !isJoined && myIds.length >= maxLearnerGroups;
    final isBusy = membershipState.isLoading;

    return Scaffold(
      backgroundColor: MuColors.canvas,
      body: SafeArea(
        child: detailState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ErrorRetryView(
            error: error,
            onRetry: () => ref.invalidate(interestGroupDetailProvider(groupId)),
          ),
          data: (group) => Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(
                    MuSpace.screenH,
                    MuSpace.s,
                    MuSpace.screenH,
                    MuSpace.xxl,
                  ),
                  children: [
                    _BackLink(onTap: () => context.pop()),
                    const SizedBox(height: MuSpace.l),
                    _HeroCard(group: group),
                    if (group.about != null &&
                        group.about!.trim().isNotEmpty) ...[
                      const SizedBox(height: MuSpace.xxl),
                      const MuSectionHeader(title: 'About'),
                      const SizedBox(height: MuSpace.m),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: MuSpace.xs,
                        ),
                        child: MarkdownBody(
                          data: unescapeLiteralUnicode(group.about!),
                          onTapLink: (text, href, title) {
                            if (href == null) return;
                            final uri = Uri.tryParse(href);
                            if (uri != null) {
                              launchUrl(
                                uri,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                          styleSheet: MarkdownStyleSheet(
                            p: MuType.body.copyWith(
                              color: MuColors.inkSecondary,
                            ),
                            h1: MuType.headline,
                            h2: MuType.title,
                            h3: MuType.bodyMed,
                            strong: MuType.bodyMed.copyWith(
                              color: MuColors.inkSecondary,
                            ),
                            em: MuType.body.copyWith(
                              color: MuColors.inkSecondary,
                              fontStyle: FontStyle.italic,
                            ),
                            a: MuType.body.copyWith(
                              color: MuColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                            listBullet: MuType.body.copyWith(
                              color: MuColors.inkSecondary,
                            ),
                            blockquote: MuType.body.copyWith(
                              color: MuColors.inkTertiary,
                            ),
                            blockquoteDecoration: BoxDecoration(
                              color: MuColors.canvas,
                              border: const Border(
                                left: BorderSide(
                                  color: MuColors.primary,
                                  width: 3,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            blockquotePadding: const EdgeInsets.all(MuSpace.m),
                            code: MuType.body.copyWith(
                              color: MuColors.inkSecondary,
                              backgroundColor: MuColors.canvas,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                      ),
                    ],
                    if (group.officeHours != null) ...[
                      const SizedBox(height: MuSpace.xxl),
                      const MuSectionHeader(title: 'Office hours'),
                      const SizedBox(height: MuSpace.m),
                      MuCard(
                        child: Row(
                          children: [
                            const Icon(
                              LucideIcons.clock,
                              size: 18,
                              color: MuColors.primary,
                            ),
                            const SizedBox(width: MuSpace.s),
                            Expanded(
                              child: Text(
                                group.officeHours!,
                                style: MuType.body,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    _GroupCircles(groupId: groupId),
                    _GroupEvents(groupId: groupId),
                    if (group.impactProjects.isNotEmpty) ...[
                      const SizedBox(height: MuSpace.xxl),
                      const MuSectionHeader(title: 'Impact projects'),
                      const SizedBox(height: MuSpace.m),
                      for (final project in group.impactProjects) ...[
                        _ImpactProjectCard(project: project),
                        const SizedBox(height: MuSpace.s),
                      ],
                    ],
                    if (group.prerequisites.isNotEmpty) ...[
                      const SizedBox(height: MuSpace.xxl),
                      const MuSectionHeader(title: 'Prerequisites'),
                      const SizedBox(height: MuSpace.m),
                      _PillWrap(items: group.prerequisites),
                    ],
                    if (group.careerOpportunities.isNotEmpty) ...[
                      const SizedBox(height: MuSpace.xxl),
                      const MuSectionHeader(title: 'Career opportunities'),
                      const SizedBox(height: MuSpace.m),
                      _PillWrap(items: group.careerOpportunities, tinted: true),
                    ],
                    if (group.leads.isNotEmpty) ...[
                      const SizedBox(height: MuSpace.xxl),
                      const MuSectionHeader(title: 'Community leads'),
                      const SizedBox(height: MuSpace.m),
                      MuCard(child: _PersonList(people: group.leads)),
                    ],
                    if (group.mentors.isNotEmpty) ...[
                      const SizedBox(height: MuSpace.xxl),
                      const MuSectionHeader(title: 'Mentors'),
                      const SizedBox(height: MuSpace.m),
                      MuCard(child: _PersonList(people: group.mentors)),
                    ],
                    if (group.leads.isNotEmpty || group.mentors.isNotEmpty) ...[
                      const SizedBox(height: MuSpace.xl),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: MuSpace.xs,
                        ),
                        child: Text(
                          'Questions? Reach out to the leads or mentors above — '
                          "that's what they're here for.",
                          style: MuType.caption.copyWith(
                            color: MuColors.inkTertiary,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              _BottomCta(
                group: group,
                isJoined: isJoined,
                atCap: atCap,
                isBusy: isBusy,
                onToggle: () => _toggle(context, ref, group, join: !isJoined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _toggle(
  BuildContext context,
  WidgetRef ref,
  InterestGroupSummary group, {
  required bool join,
}) async {
  if (!join) {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Leave ${group.name}?'),
        content: const Text(
          "You'll stop seeing its tasks and events. You can join again later.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Leave'),
          ),
        ],
      ),
    );
    if (!(confirmed ?? false) || !context.mounted) return;
  }
  await ref
      .read(interestGroupMembershipControllerProvider.notifier)
      .toggle(group.id, join: join);
  if (!context.mounted) return;
  final error = ref.read(interestGroupMembershipControllerProvider).error;
  MuToast.show(
    context,
    message: error != null
        ? ApiException.messageFor(error)
        : (join ? 'You joined ${group.name}' : 'You left ${group.name}'),
    type: error != null ? MuToastType.error : MuToastType.success,
  );
}

/// The group's first circles (L11); hidden when it has none.
class _GroupCircles extends ConsumerWidget {
  const _GroupCircles({required this.groupId});

  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final circles =
        ref.watch(circlesInGroupProvider(groupId)).value ?? const [];
    if (circles.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: MuSpace.xxl),
        const MuSectionHeader(title: 'Circles in this group'),
        const SizedBox(height: MuSpace.m),
        MuCard(
          padding: const EdgeInsets.symmetric(vertical: MuSpace.xs),
          child: Column(
            children: [
              for (final c in circles)
                Material(
                  type: MaterialType.transparency,
                  child: ListTile(
                    leading: const Icon(
                      LucideIcons.users,
                      color: MuColors.primary,
                    ),
                    title: Text(c.title, style: MuType.bodyMed),
                    subtitle: c.totalMembers == null
                        ? null
                        : Text(
                            '${c.totalMembers} members',
                            style: MuType.caption,
                          ),
                    trailing: const Icon(
                      LucideIcons.chevronRight,
                      size: 18,
                      color: MuColors.inkTertiary,
                    ),
                    onTap: () =>
                        context.push(RoutePaths.learningCircleDetailPath(c.id)),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Events scoped to the group (L11); hidden when there are none.
class _GroupEvents extends ConsumerWidget {
  const _GroupEvents({required this.groupId});

  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventsInGroupProvider(groupId)).value ?? const [];
    if (events.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: MuSpace.xxl),
        const MuSectionHeader(title: 'Events in this group'),
        const SizedBox(height: MuSpace.m),
        MuCard(
          padding: const EdgeInsets.symmetric(vertical: MuSpace.xs),
          child: Column(
            children: [
              for (final e in events)
                Material(
                  type: MaterialType.transparency,
                  child: ListTile(
                    leading: const Icon(
                      LucideIcons.calendarDays,
                      color: MuColors.primary,
                    ),
                    title: Text(e.title, style: MuType.bodyMed),
                    subtitle: e.startsAt == null
                        ? null
                        : Text(
                            '${e.startsAt!.toLocal().day}/${e.startsAt!.toLocal().month}/${e.startsAt!.toLocal().year}',
                            style: MuType.caption,
                          ),
                    trailing: const Icon(
                      LucideIcons.chevronRight,
                      size: 18,
                      color: MuColors.inkTertiary,
                    ),
                    onTap: () => context.push(RoutePaths.eventDetailPath(e.id)),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ImpactProjectCard extends StatelessWidget {
  const _ImpactProjectCard({required this.project});

  final IgImpactProject project;

  @override
  Widget build(BuildContext context) => MuCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(project.title, style: MuType.bodyMed),
        if (project.description != null && project.description!.isNotEmpty) ...[
          const SizedBox(height: MuSpace.xs),
          Text(
            project.description!,
            style: MuType.caption.copyWith(color: MuColors.inkSecondary),
          ),
        ],
        if (project.links.isNotEmpty) ...[
          const SizedBox(height: MuSpace.s),
          Wrap(
            spacing: MuSpace.s,
            children: [
              for (final link in project.links)
                TextButton.icon(
                  onPressed: () {
                    final uri = Uri.tryParse(link.url);
                    if (uri != null) {
                      launchUrl(uri, mode: LaunchMode.externalApplication);
                    }
                  },
                  icon: const Icon(LucideIcons.externalLink, size: 14),
                  label: Text(link.label),
                ),
            ],
          ),
        ],
      ],
    ),
  );
}

class _BackLink extends StatelessWidget {
  const _BackLink({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            LucideIcons.chevronLeft,
            size: 18,
            color: MuColors.inkSecondary,
          ),
          const SizedBox(width: 2),
          Flexible(
            child: Text(
              'Back to interest groups',
              overflow: TextOverflow.ellipsis,
              style: MuType.chip.copyWith(
                color: MuColors.inkSecondary,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.group});

  final InterestGroupSummary group;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(MuSpace.xl),
      decoration: BoxDecoration(
        color: MuColors.ink,
        borderRadius: BorderRadius.circular(MuRadius.hero),
        boxShadow: MuShadow.hero,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: -40,
            top: -40,
            child: Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MuColors.karmaAccent.withValues(alpha: 0.28),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeroIcon(group: group),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: MuColors.onBrand.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(MuRadius.chip),
                      border: Border.all(
                        color: MuColors.onBrand.withValues(alpha: 0.16),
                      ),
                    ),
                    child: Text(
                      group.category.toUpperCase(),
                      style: MuType.tag.copyWith(
                        color: MuColors.surface.withValues(alpha: 0.85),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: MuSpace.l),
              Text(
                group.name,
                style: MuType.display.copyWith(
                  color: MuColors.surface,
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: MuSpace.xl),
              Container(
                height: 1,
                color: MuColors.onBrand.withValues(alpha: 0.12),
              ),
              const SizedBox(height: MuSpace.l),
              Row(
                children: [
                  const Icon(
                    LucideIcons.users,
                    size: 16,
                    color: MuColors.onBrandMuted,
                  ),
                  const SizedBox(width: MuSpace.s),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${group.memberCount}',
                        style: MuType.stat.copyWith(
                          color: MuColors.surface,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        'MEMBERS',
                        style: MuType.label.copyWith(
                          color: MuColors.onBrandMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroIcon extends StatelessWidget {
  const _HeroIcon({required this.group});

  final InterestGroupSummary group;

  @override
  Widget build(BuildContext context) {
    final icon = group.iconImage ?? group.icon;
    final code = group.code;
    final fallback = Center(
      child: Text(
        (code != null && code.isNotEmpty)
            ? code.toUpperCase()
            : group.name[0].toUpperCase(),
        style: MuType.stat.copyWith(color: MuColors.surface, fontSize: 18),
      ),
    );
    return Container(
      height: 52,
      width: 52,
      decoration: BoxDecoration(
        color: MuColors.onBrand.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(MuRadius.inner),
      ),
      clipBehavior: Clip.antiAlias,
      child: (icon != null && icon.isNotEmpty)
          ? CachedNetworkImage(
              imageUrl: icon,
              fit: BoxFit.cover,
              placeholder: (_, __) => fallback,
              errorWidget: (_, __, ___) => fallback,
            )
          : fallback,
    );
  }
}

class _PillWrap extends StatelessWidget {
  const _PillWrap({required this.items, this.tinted = false});

  final List<String> items;
  final bool tinted;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: MuSpace.s,
      runSpacing: MuSpace.s,
      children: [
        for (final item in items)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: tinted ? MuColors.primaryTint : MuColors.surface,
              borderRadius: BorderRadius.circular(MuRadius.chip),
              border: tinted ? null : Border.all(color: MuColors.divider),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 6,
                  width: 6,
                  margin: const EdgeInsets.only(right: 7),
                  decoration: const BoxDecoration(
                    color: MuColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                Text(
                  item,
                  style: MuType.chip.copyWith(
                    color: tinted ? MuColors.primary : MuColors.ink,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _PersonList extends StatelessWidget {
  const _PersonList({required this.people});

  final List<IgPersonRef> people;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < people.length; i++) ...[
          if (i > 0) ...[
            const SizedBox(height: MuSpace.m),
            Container(height: 1, color: MuColors.hairline),
            const SizedBox(height: MuSpace.m),
          ],
          _PersonTile(person: people[i]),
        ],
      ],
    );
  }
}

class _PersonTile extends StatelessWidget {
  const _PersonTile({required this.person});

  final IgPersonRef person;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(RoutePaths.publicProfilePath(person.muid)),
      child: Row(
        children: [
          ProfileAvatar(
            url: person.profilePicUrl,
            name: person.fullName,
            size: 44,
          ),
          const SizedBox(width: MuSpace.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(person.fullName, style: MuType.bodyMed),
                Text(person.muid, style: MuType.caption),
              ],
            ),
          ),
          const Icon(
            LucideIcons.chevronRight,
            size: 18,
            color: MuColors.inkTertiary,
          ),
        ],
      ),
    );
  }
}

class _BottomCta extends StatelessWidget {
  const _BottomCta({
    required this.group,
    required this.isJoined,
    required this.atCap,
    required this.isBusy,
    required this.onToggle,
  });

  final InterestGroupSummary group;
  final bool isJoined;

  /// Not a member and already in [maxLearnerGroups] groups.
  final bool atCap;
  final bool isBusy;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        MuSpace.screenH,
        MuSpace.m,
        MuSpace.screenH,
        MuSpace.l,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [MuColors.canvas.withValues(alpha: 0), MuColors.canvas],
          stops: const [0, 0.4],
        ),
      ),
      child: isJoined
          ? _JoinedButton(onTap: isBusy ? () {} : onToggle)
          : atCap
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: MuSpace.m),
              child: Text(
                "You're in $maxLearnerGroups of $maxLearnerGroups groups. Leave one to join another.",
                textAlign: TextAlign.center,
                style: MuType.body.copyWith(color: MuColors.inkSecondary),
              ),
            )
          : MuPrimaryButton(
              label: isBusy ? 'Please wait…' : 'Join ${group.name}',
              icon: isBusy ? null : LucideIcons.plus,
              onPressed: isBusy ? null : onToggle,
            ),
    );
  }
}

/// The joined-state CTA — success-green pill, distinct from [MuPrimaryButton]
/// since the design calls for a "you're already in" state visually separate
/// from the blue join action, not just a disabled blue button.
class _JoinedButton extends StatelessWidget {
  const _JoinedButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(MuRadius.chip),
      child: Container(
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          color: MuColors.successBg,
          borderRadius: BorderRadius.circular(MuRadius.chip),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              LucideIcons.checkCircle2,
              size: 20,
              color: MuColors.success,
            ),
            const SizedBox(width: MuSpace.s),
            Text(
              'Joined · Leave',
              style: MuType.bodyMed.copyWith(
                color: MuColors.success,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
