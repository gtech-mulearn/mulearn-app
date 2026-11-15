import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/core/utils/unescape_literal_unicode.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/features/interest_groups/domain/entities/ig_impact_project.dart';
import 'package:mulearn_app/features/interest_groups/domain/entities/ig_person_ref.dart';
import 'package:mulearn_app/features/interest_groups/domain/entities/interest_group_summary.dart';
import 'package:mulearn_app/features/interest_groups/presentation/providers/interest_groups_controller.dart';
import 'package:mulearn_app/features/interest_groups/presentation/widgets/ig_membership_action.dart';

/// One interest group: the group as a big sticker (its category colour,
/// the peel corner, code, name, members and leads), then what it is, its
/// circles and events, impact projects, what to know first, where it leads,
/// and the people who run it. Join or leave is pinned at the bottom.
class InterestGroupDetailScreen extends ConsumerWidget {
  const InterestGroupDetailScreen({required this.groupId, super.key});

  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(interestGroupDetailProvider(groupId));
    final group = detailState.value;

    return Scaffold(
      backgroundColor: context.mu.colors.chalk,
      body: SafeArea(
        child: Column(
          children: [
            const MuTopBar.detail(),
            Expanded(
              child: detailState.when(
                skipLoadingOnRefresh: true,
                loading: () => const Center(
                  child: MuDotsLoader(label: 'Loading the group…'),
                ),
                error: (error, _) => ErrorRetryView(
                  error: error,
                  onRetry: () =>
                      ref.invalidate(interestGroupDetailProvider(groupId)),
                ),
                data: (g) => _Body(group: g),
              ),
            ),
            if (group != null) _JoinBar(id: groupId, name: group.name),
          ],
        ),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.group});

  final InterestGroupSummary group;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final about = group.about?.trim() ?? '';
    final people = group.leads.isNotEmpty || group.mentors.isNotEmpty;
    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: const EdgeInsets.fromLTRB(
        MuSpacing.space5,
        MuSpacing.space2,
        MuSpacing.space5,
        MuSpacing.space8,
      ),
      children: [
        _Hero(group: group),
        if (group.officeHours != null &&
            group.officeHours!.trim().isNotEmpty) ...[
          const SizedBox(height: MuSpacing.space4),
          MuFeedGroup(
            children: [
              MuFeedRow(
                leading: const MuFeedIcon(
                  LucideIcons.clock,
                  tone: MuFeedTone.event,
                ),
                subject: group.officeHours!,
                time: 'Office hours',
                divider: false,
              ),
            ],
          ),
        ],
        if (about.isNotEmpty) ...[const _Eyebrow('ABOUT'), _About(text: about)],
        _GroupCircles(groupId: group.id),
        _GroupEvents(groupId: group.id),
        if (group.impactProjects.isNotEmpty) ...[
          const _Eyebrow('IMPACT PROJECTS'),
          for (var i = 0; i < group.impactProjects.length; i++) ...[
            if (i > 0) const SizedBox(height: MuSpacing.space3),
            _ImpactProject(project: group.impactProjects[i]),
          ],
        ],
        if (group.prerequisites.isNotEmpty) ...[
          const _Eyebrow('BEFORE YOU START'),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [for (final p in group.prerequisites) MuPill(p)],
          ),
        ],
        if (group.careerOpportunities.isNotEmpty) ...[
          const _Eyebrow('WHERE IT LEADS'),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final p in group.careerOpportunities)
                MuPill(p, tone: MuPillTone.cobalt),
            ],
          ),
        ],
        if (group.leads.isNotEmpty) ...[
          const _Eyebrow('COMMUNITY LEADS'),
          _People(people: group.leads),
        ],
        if (group.mentors.isNotEmpty) ...[
          const _Eyebrow('MENTORS'),
          _People(people: group.mentors),
        ],
        if (people) ...[
          const SizedBox(height: MuSpacing.space4),
          Text(
            "Questions? Reach out to the leads or mentors above. That's what they're here for.",
            style: context.mu.text.caption,
          ),
        ],
      ],
    );
  }
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(
      top: MuSpacing.space8,
      bottom: MuSpacing.space3,
    ),
    child: Semantics(
      header: true,
      child: Text(text, style: context.mu.text.eyebrow),
    ),
  );
}

/// The group as a big sticker: category fill, one sharp peel corner, code
/// and category, the name in display type, members and leads at the foot.
class _Hero extends StatelessWidget {
  const _Hero({required this.group});

  final InterestGroupSummary group;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final ink = c.inkPrint;
    final category = IgCategory.parse(group.category);
    final code = group.code?.trim();
    final icon = group.iconImage ?? group.icon;
    final leads = group.leads;
    final label = [
      if (code != null && code.isNotEmpty) code.toUpperCase(),
      category.name.toUpperCase(),
    ].join(' · ');

    return Semantics(
      container: true,
      label:
          '${group.name}, ${category.name} Interest Group, ${group.memberCount} members',
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.all(MuSpacing.space5),
        decoration: BoxDecoration(
          color: MuTones.forIgCategory(c, category),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(MuRadii.panel),
            topRight: Radius.circular(MuRadii.panel),
            bottomRight: Radius.circular(MuRadii.panel),
            bottomLeft: Radius.circular(MuRadii.tag),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: mu.text.codeSm.copyWith(
                      color: ink.withValues(alpha: 0.75),
                    ),
                  ),
                ),
                if (icon != null && icon.isNotEmpty)
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: icon,
                      width: 44,
                      height: 44,
                      fit: BoxFit.cover,
                      errorWidget: (_, _, _) => const SizedBox.shrink(),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: MuSpacing.space8),
            Text(
              group.name,
              style: mu.text.display.copyWith(
                fontSize: 38,
                height: 1,
                color: ink,
              ),
            ),
            const SizedBox(height: MuSpacing.space6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        muGrouped(group.memberCount),
                        style: mu.text.numeral.copyWith(color: ink),
                      ),
                      Text(
                        group.memberCount == 1 ? 'member' : 'members',
                        style: mu.text.caption.copyWith(
                          color: ink.withValues(alpha: 0.75),
                        ),
                      ),
                    ],
                  ),
                ),
                if (leads.isNotEmpty)
                  MuAvatarStack(
                    names: [for (final p in leads.take(4)) p.fullName],
                    urls: [for (final p in leads.take(4)) p.profilePicUrl],
                    extraCount: leads.length > 4 ? leads.length - 4 : 0,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _About extends ConsumerWidget {
  const _About({required this.text});

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final body = mu.text.body.copyWith(color: c.ink2, height: 1.55);
    return MarkdownBody(
      data: unescapeLiteralUnicode(text),
      onTapLink: (_, href, _) {
        final uri = href == null ? null : Uri.tryParse(href);
        if (uri != null) unawaited(ref.read(openExternalProvider)(uri));
      },
      styleSheet: MarkdownStyleSheet(
        p: body,
        h1: mu.text.title1,
        h2: mu.text.title2,
        h3: mu.text.title3,
        strong: body.copyWith(color: c.ink, fontWeight: FontWeight.w700),
        em: body.copyWith(fontStyle: FontStyle.italic),
        a: body.copyWith(
          color: c.cobaltText,
          decoration: TextDecoration.underline,
        ),
        listBullet: body,
        blockquote: body.copyWith(color: c.ink3),
        blockquoteDecoration: BoxDecoration(
          color: c.surfaceSunk,
          borderRadius: BorderRadius.circular(MuRadii.tag),
          border: Border(left: BorderSide(color: c.cobalt, width: 3)),
        ),
        blockquotePadding: const EdgeInsets.all(MuSpacing.space3),
        code: mu.text.codeSm.copyWith(
          color: c.ink,
          backgroundColor: c.surfaceSunk,
        ),
      ),
    );
  }
}

/// The group's first circles; hidden when it has none.
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
        const _Eyebrow('CIRCLES IN THIS GROUP'),
        MuFeedGroup(
          children: [
            for (var i = 0; i < circles.length; i++)
              MuFeedRow(
                leading: const MuFeedIcon(
                  LucideIcons.users,
                  tone: MuFeedTone.done,
                ),
                subject: circles[i].title,
                time: circles[i].totalMembers == null
                    ? null
                    : (circles[i].totalMembers == 1
                          ? '1 member'
                          : '${circles[i].totalMembers} members'),
                trailing: const _Chevron(),
                divider: i < circles.length - 1,
                onTap: () => context.push(
                  RoutePaths.learningCircleDetailPath(circles[i].id),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

/// Events scoped to the group; hidden when there are none.
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
        const _Eyebrow('EVENTS IN THIS GROUP'),
        MuFeedGroup(
          children: [
            for (var i = 0; i < events.length; i++)
              MuFeedRow(
                leading: const MuFeedIcon(
                  LucideIcons.ticket,
                  tone: MuFeedTone.event,
                ),
                subject: events[i].title,
                time: events[i].startsAt == null
                    ? null
                    : formatDayTime(events[i].startsAt!.toLocal()),
                trailing: const _Chevron(),
                divider: i < events.length - 1,
                onTap: () =>
                    context.push(RoutePaths.eventDetailPath(events[i].id)),
              ),
          ],
        ),
      ],
    );
  }
}

class _Chevron extends StatelessWidget {
  const _Chevron();

  @override
  Widget build(BuildContext context) => Icon(
    LucideIcons.chevronRight,
    size: MuSizes.iconSm + 2,
    color: context.mu.colors.ink3,
  );
}

class _ImpactProject extends ConsumerWidget {
  const _ImpactProject({required this.project});

  final IgImpactProject project;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final description = project.description?.trim() ?? '';
    return Container(
      padding: const EdgeInsets.all(MuSpacing.space4),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(MuRadii.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(project.title, style: mu.text.title3),
          if (description.isNotEmpty) ...[
            const SizedBox(height: MuSpacing.space1),
            Text(description, style: mu.text.body.copyWith(color: c.ink2)),
          ],
          if (project.links.isNotEmpty) ...[
            const SizedBox(height: MuSpacing.space3),
            Wrap(
              spacing: MuSpacing.space2,
              runSpacing: MuSpacing.space2,
              children: [
                for (final link in project.links)
                  MuButton(
                    label: link.label,
                    icon: LucideIcons.arrowUpRight,
                    variant: MuButtonVariant.outline,
                    size: MuButtonSize.small,
                    onPressed: () {
                      final uri = Uri.tryParse(link.url);
                      if (uri != null) {
                        unawaited(ref.read(openExternalProvider)(uri));
                      }
                    },
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _People extends StatelessWidget {
  const _People({required this.people});

  final List<IgPersonRef> people;

  @override
  Widget build(BuildContext context) {
    return MuFeedGroup(
      children: [
        for (var i = 0; i < people.length; i++)
          MuFeedRow(
            leading: MuAvatar(
              name: people[i].fullName,
              url: people[i].profilePicUrl,
              size: MuSizes.avatarMd,
            ),
            subject: people[i].fullName,
            time: people[i].muid,
            trailing: const _Chevron(),
            divider: i < people.length - 1,
            onTap: () =>
                context.push(RoutePaths.publicProfilePath(people[i].muid)),
          ),
      ],
    );
  }
}

/// Join (ink with the knob), or Joined · Leave once in; at the cap, the
/// reason in place of the button.
class _JoinBar extends ConsumerWidget {
  const _JoinBar({required this.id, required this.name});

  /// The group's id from the route (what membership is keyed by).
  final String id;
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final myIds =
        ref.watch(myInterestGroupIdsProvider).value ?? const <String>[];
    final busy = ref.watch(interestGroupMembershipControllerProvider).isLoading;
    final joined = myIds.contains(id);
    final atCap = !joined && myIds.length >= maxLearnerGroups;

    void toggle() => unawaited(
      toggleIgMembership(context, ref, id: id, name: name, join: !joined),
    );

    final Widget child;
    if (joined) {
      child = MuButton(
        label: 'Joined · Leave',
        icon: LucideIcons.check,
        variant: MuButtonVariant.outline,
        block: true,
        loading: busy,
        onPressed: busy ? null : toggle,
      );
    } else if (atCap) {
      child = Padding(
        padding: const EdgeInsets.symmetric(vertical: MuSpacing.space2),
        child: Text(
          igCapMessage,
          textAlign: TextAlign.center,
          style: mu.text.body.copyWith(color: c.ink2),
        ),
      );
    } else {
      child = MuButton(
        label: 'Join $name',
        variant: MuButtonVariant.ink,
        knob: true,
        block: true,
        loading: busy,
        onPressed: busy ? null : toggle,
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: c.chalk,
        border: Border(top: BorderSide(color: c.line)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          MuSpacing.space5,
          MuSpacing.space3,
          MuSpacing.space5,
          MuSpacing.space3,
        ),
        child: child,
      ),
    );
  }
}
