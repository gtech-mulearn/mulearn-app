import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/config/flavor_config.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_analytics.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_profile_completion.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_scope.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_session.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/mentor_hub_providers.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/mentor_sessions_controller.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/persona_controller.dart';
import 'package:mulearn_app/features/mentor/presentation/widgets/acting_as_menu.dart';
import 'package:mulearn_app/features/mentor/presentation/widgets/meeting_actions.dart';
import 'package:mulearn_app/features/mentor/presentation/widgets/session_labels.dart';

/// The mentor workspace's home (M1): who you act as, New session, the next
/// session as a night slab with Join when it's time, requests and
/// availability, the profile's completeness as a bar, your totals as tiles
/// and each scope with how many of its learners are active. Loads on open
/// and on pull-to-refresh.
class MentorHubScreen extends ConsumerWidget {
  const MentorHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final canCreate =
        ref.watch(sessionTargetsProvider).value?.isNotEmpty ?? false;
    return MuWorkspacePage(
      body: MuRefresh(
        onRefresh: () => Future.wait([
          ref.refresh(mentorNextSessionsProvider.future),
          ref.refresh(mentorRequestCountProvider.future),
          ref.refresh(mentorProfileCompletionProvider.future),
          ref.refresh(mentorAnalyticsProvider.future),
          ref.refresh(mentorOverviewProvider.future),
          ref.refresh(personaControllerProvider.future),
        ]),
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: muListPadding,
          children: [
            Semantics(
              header: true,
              child: Text(
                'Mentor workspace',
                style: mu.text.display.copyWith(fontSize: 32),
              ),
            ),
            const ActingAsMenu(),
            const SizedBox(height: MuSpacing.space4),
            Row(
              children: [
                Expanded(
                  child: MuButton(
                    label: 'New session',
                    icon: LucideIcons.plus,
                    block: true,
                    // Off until the mentor has somewhere to create one.
                    onPressed: canCreate
                        ? () => context.push(RoutePaths.mentorSessionNew)
                        : null,
                  ),
                ),
                const SizedBox(width: MuSpacing.space2),
                Expanded(
                  child: MuButton(
                    label: 'All sessions',
                    variant: MuButtonVariant.outline,
                    block: true,
                    onPressed: () => context.push(RoutePaths.mentorSessions),
                  ),
                ),
              ],
            ),
            const MuSectionEyebrow('Next up'),
            ref
                .watch(mentorNextSessionsProvider)
                .when(
                  skipError: true,
                  skipLoadingOnReload: true,
                  loading: () => const SizedBox(
                    height: 96,
                    child: Center(child: MuDotsLoader()),
                  ),
                  error: (e, _) => _SectionError(
                    e,
                    () => ref.invalidate(mentorNextSessionsProvider),
                  ),
                  data: (sessions) => sessions.isEmpty
                      ? const MuEmptyLine('No upcoming sessions.')
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _NextSession(session: sessions.first),
                            if (sessions.length > 1) ...[
                              const SizedBox(height: MuSpacing.space3),
                              MuFeedGroup(
                                children: [
                                  for (final (i, s)
                                      in sessions.skip(1).take(2).indexed)
                                    _SessionRow(
                                      session: s,
                                      last:
                                          i ==
                                          sessions.skip(1).take(2).length - 1,
                                    ),
                                ],
                              ),
                            ],
                          ],
                        ),
                ),
            const SizedBox(height: MuSpacing.space4),
            MuFeedGroup(
              children: [
                _RequestsRow(
                  count: ref.watch(mentorRequestCountProvider).value,
                ),
                MuFeedRow(
                  leading: const MuFeedIcon(
                    LucideIcons.clock,
                    tone: MuFeedTone.event,
                  ),
                  subject: 'Weekly availability',
                  time: 'When learners can book you',
                  trailing: const _Chevron(),
                  divider: false,
                  onTap: () => context.push(RoutePaths.mentorAvailability),
                ),
              ],
            ),
            const SizedBox(height: MuSpacing.space4),
            ref
                .watch(mentorProfileCompletionProvider)
                .when(
                  skipError: true,
                  skipLoadingOnReload: true,
                  loading: () => const SizedBox.shrink(),
                  error: (e, _) => _SectionError(
                    e,
                    () => ref.invalidate(mentorProfileCompletionProvider),
                  ),
                  data: (c) => _CompletionCard(completion: c),
                ),
            const MuSectionEyebrow('Your mentoring'),
            ref
                .watch(mentorAnalyticsProvider)
                .when(
                  skipError: true,
                  skipLoadingOnReload: true,
                  loading: () => const SizedBox(
                    height: 96,
                    child: Center(child: MuDotsLoader()),
                  ),
                  error: (e, _) => _SectionError(
                    e,
                    () => ref.invalidate(mentorAnalyticsProvider),
                  ),
                  data: (a) => _Totals(analytics: a),
                ),
            const MuSectionEyebrow('Your scopes'),
            ref
                .watch(mentorOverviewProvider)
                .when(
                  skipError: true,
                  skipLoadingOnReload: true,
                  loading: () => const SizedBox(
                    height: 96,
                    child: Center(child: MuDotsLoader()),
                  ),
                  error: (e, _) => _SectionError(
                    e,
                    () => ref.invalidate(mentorOverviewProvider),
                  ),
                  data: (scopes) {
                    if (scopes.isEmpty) return const _NoScope();
                    // The scope you act in comes first.
                    final active = ref.watch(personaControllerProvider).value;
                    final activeId = active != null && active.isMentor
                        ? active.scopeId
                        : null;
                    final ordered = [
                      ...scopes.where((s) => s.id == activeId),
                      ...scopes.where((s) => s.id != activeId),
                    ];
                    return Column(
                      children: [
                        for (var i = 0; i < ordered.length; i++) ...[
                          if (i > 0) const SizedBox(height: MuSpacing.space3),
                          _ScopeCard(
                            scope: ordered[i],
                            active: ordered[i].id == activeId,
                          ),
                        ],
                      ],
                    );
                  },
                ),
          ],
        ),
      ),
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

class _SectionError extends StatelessWidget {
  const _SectionError(this.error, this.onRetry);

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    return Row(
      children: [
        Expanded(
          child: Text(
            ApiException.messageFor(error),
            style: mu.text.body.copyWith(color: mu.colors.ink2),
          ),
        ),
        MuButton(
          label: 'Retry',
          variant: MuButtonVariant.ghost,
          size: MuButtonSize.small,
          onPressed: onRetry,
        ),
      ],
    );
  }
}

/// The soonest session as a night slab; Join when it's time. The slab opens
/// the session.
class _NextSession extends ConsumerWidget {
  const _NextSession({required this.session});

  final MentorSession session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final now = ref.watch(clockProvider)().toLocal();
    final when = formatWhen(
      starts: session.startsAt.toLocal(),
      ends: session.endsAt.toLocal(),
      now: now,
    );
    return Semantics(
      container: true,
      button: true,
      label: '${session.title}, $when',
      explicitChildNodes: true,
      child: MuPressable(
        onTap: () =>
            context.push(RoutePaths.mentorSessionDetailPath(session.id)),
        pressedScale: 0.99,
        child: Container(
          padding: const EdgeInsets.all(MuSpacing.space5),
          decoration: BoxDecoration(
            color: c.night,
            borderRadius: BorderRadius.circular(MuRadii.card),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Flexible(
                    child: MuPill(
                      when,
                      tone: MuPillTone.volt,
                      icon: LucideIcons.clock,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    LucideIcons.chevronRight,
                    size: MuSizes.iconSm + 2,
                    color: c.onNight2,
                  ),
                ],
              ),
              const SizedBox(height: MuSpacing.space4),
              Text(
                session.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: mu.text.title2.copyWith(color: c.onNight),
              ),
              const SizedBox(height: MuSpacing.space1),
              Text(
                [
                  sessionModeLabel(session.mode),
                  if (session.entityName.isNotEmpty) session.entityName,
                ].join(' · '),
                style: mu.text.body.copyWith(color: c.onNight2),
              ),
              MeetingLinkActions(session: session, compact: true),
            ],
          ),
        ),
      ),
    );
  }
}

class _SessionRow extends ConsumerWidget {
  const _SessionRow({required this.session, required this.last});

  final MentorSession session;
  final bool last;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = ref.watch(clockProvider)().toLocal();
    return MuFeedRow(
      leading: const MuFeedIcon(
        LucideIcons.calendarDays,
        tone: MuFeedTone.event,
      ),
      subject: session.title,
      time: [
        formatWhen(
          starts: session.startsAt.toLocal(),
          ends: session.endsAt.toLocal(),
          now: now,
        ),
        sessionModeLabel(session.mode),
      ].join(' · '),
      trailing: const _Chevron(),
      divider: !last,
      onTap: () => context.push(RoutePaths.mentorSessionDetailPath(session.id)),
    );
  }
}

class _RequestsRow extends StatelessWidget {
  const _RequestsRow({required this.count});

  /// Null while loading or after a failure.
  final int? count;

  @override
  Widget build(BuildContext context) {
    final waiting = (count ?? 0) > 0;
    return MuFeedRow(
      leading: MuFeedIcon(
        LucideIcons.inbox,
        tone: waiting ? MuFeedTone.pending : MuFeedTone.neutral,
      ),
      subject: 'Session requests',
      time: count == null ? null : 'Learners asking for time with you',
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (count != null && waiting)
            MuPill(
              '$count waiting',
              tone: MuPillTone.warning,
              icon: LucideIcons.bell,
            )
          else if (count != null)
            Text('None waiting', style: context.mu.text.caption),
          const SizedBox(width: MuSpacing.space1),
          const _Chevron(),
        ],
      ),
      onTap: () => context.push(RoutePaths.mentorRequests),
    );
  }
}

const _checklistLabels = {
  'about': 'About',
  'expertise': 'Expertise',
  'linkedin': 'LinkedIn',
  'preferred_igs': 'Preferred interest groups',
};

class _CompletionCard extends ConsumerWidget {
  const _CompletionCard({required this.completion});

  final MentorProfileCompletion completion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final pct = completion.percentage.clamp(0, 100);
    final missing = [
      for (final e in completion.checklist.entries)
        if (!e.value) _checklistLabels[e.key] ?? e.key,
    ];
    return MuSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('$pct%', style: mu.text.numeral.copyWith(fontSize: 28)),
              const SizedBox(width: MuSpacing.space2),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    'of your mentor profile is done',
                    style: mu.text.caption,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: MuSpacing.space3),
          MuBar(value: pct / 100),
          if (missing.isNotEmpty) ...[
            const SizedBox(height: MuSpacing.space3),
            Text('Missing: ${missing.join(', ')}', style: mu.text.caption),
          ],
          if (pct < 100) ...[
            const SizedBox(height: MuSpacing.space2),
            MuButton(
              label: 'Finish on web',
              icon: LucideIcons.externalLink,
              variant: MuButtonVariant.ghost,
              size: MuButtonSize.small,
              // The mentor profile is edited on the web dashboard.
              onPressed: () => ref.read(openExternalProvider)(
                Uri.parse(
                  '${FlavorConfig.instance.dashboardUrl}/dashboard/profile',
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Totals extends StatelessWidget {
  const _Totals({required this.analytics});

  final MentorAnalytics analytics;

  @override
  Widget build(BuildContext context) {
    final rating = analytics.ratingAverage;
    return Row(
      children: [
        Expanded(
          child: MuStatTile(
            label: 'Sessions done',
            value: muGrouped(analytics.sessionsCompleted),
          ),
        ),
        const SizedBox(width: MuSpacing.space2),
        Expanded(
          child: MuStatTile(
            label: 'Karma earned',
            value: muGrouped(analytics.karmaEarned.toInt()),
          ),
        ),
        const SizedBox(width: MuSpacing.space2),
        Expanded(
          child: rating == null
              ? const MuStatTile(label: 'No ratings yet', value: '—')
              : MuStatTile(
                  label: 'Rating (${analytics.ratingCount})',
                  value: '★ ${rating.toStringAsFixed(1)}',
                ),
        ),
      ],
    );
  }
}

/// A scope you mentor: its name and type, how many of its learners are
/// active (a bar), its upcoming sessions and circles.
class _ScopeCard extends StatelessWidget {
  const _ScopeCard({required this.scope, this.active = false});

  final MentorScope scope;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final m = scope.metrics;
    return MuSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(scope.name, style: mu.text.title3)),
              if (active)
                const MuPill(
                  'Acting in',
                  tone: MuPillTone.success,
                  icon: LucideIcons.check,
                ),
            ],
          ),
          Text(scopeTypeLabel(scope.type), style: mu.text.caption),
          const SizedBox(height: MuSpacing.space4),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${muGrouped(m.activeIgLearners)} of ${muGrouped(m.totalIgLearners)} learners active',
                  style: mu.text.body,
                ),
              ),
            ],
          ),
          const SizedBox(height: MuSpacing.space2),
          MuBar(
            value: m.totalIgLearners <= 0
                ? 0
                : m.activeIgLearners / m.totalIgLearners,
          ),
          const SizedBox(height: MuSpacing.space3),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              MuPill(
                m.upcomingSessions == 1
                    ? '1 upcoming session'
                    : '${m.upcomingSessions} upcoming sessions',
                icon: LucideIcons.calendar,
              ),
              MuPill(
                m.igLearningCircles == 1
                    ? '1 circle'
                    : '${m.igLearningCircles} circles',
                icon: LucideIcons.users,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NoScope extends StatelessWidget {
  const _NoScope();

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    return MuSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('No mentoring scope yet', style: mu.text.title3),
          const SizedBox(height: MuSpacing.space1),
          Text(
            'An admin assigns the interest group, campus or company you mentor. '
            'You can create sessions once you have one.',
            style: mu.text.body.copyWith(color: mu.colors.ink2),
          ),
        ],
      ),
    );
  }
}
