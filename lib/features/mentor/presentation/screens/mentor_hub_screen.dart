import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/config/flavor_config.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_progress_bars.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_skeleton.dart';
import 'package:mulearn_app/core/widgets/mu_stat_block.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_analytics.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_profile_completion.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_scope.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_session.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/mentor_hub_providers.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/mentor_sessions_controller.dart';
import 'package:mulearn_app/features/mentor/presentation/widgets/meeting_actions.dart';
import 'package:mulearn_app/features/mentor/presentation/widgets/session_labels.dart';

/// The mentor workspace's home (audit 06 "M1 Mentor home"): next sessions,
/// waiting requests, profile completion, totals and the mentor's scopes.
/// Opened from Home or Profile; loads on open and on pull-to-refresh only.
class MentorHubScreen extends ConsumerWidget {
  const MentorHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(backgroundColor: MuColors.canvas, elevation: 0, title: const Text('Mentor workspace')),
      body: MuRefresh(
        onRefresh: () => Future.wait([
          ref.refresh(mentorNextSessionsProvider.future),
          ref.refresh(mentorRequestCountProvider.future),
          ref.refresh(mentorProfileCompletionProvider.future),
          ref.refresh(mentorAnalyticsProvider.future),
          ref.refresh(mentorOverviewProvider.future),
        ]),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.m, MuSpace.screenH, MuSpace.xxl),
          children: [
            Row(
              children: [
                Expanded(
                  child: MuPrimaryButton(
                    label: 'New session',
                    icon: LucideIcons.plus,
                    // Disabled until the mentor has somewhere to create one.
                    onPressed: (ref.watch(sessionTargetsProvider).value?.isNotEmpty ?? false)
                        ? () => context.push(RoutePaths.mentorSessionNew)
                        : null,
                  ),
                ),
                const SizedBox(width: MuSpace.m),
                TextButton(onPressed: () => context.push(RoutePaths.mentorSessions), child: const Text('All sessions')),
              ],
            ),
            const SizedBox(height: MuSpace.xl),
            const _Heading('Next up'),
            ref.watch(mentorNextSessionsProvider).when(
                  skipError: true,
                  skipLoadingOnReload: true,
                  loading: () => const MuSkeleton(height: 72),
                  error: (e, _) => _SectionError(e, () => ref.invalidate(mentorNextSessionsProvider)),
                  data: (sessions) => sessions.isEmpty
                      ? Text('No upcoming sessions.', style: MuType.body.copyWith(color: MuColors.inkSecondary))
                      : Column(
                          children: [
                            _SessionRow(session: sessions.first, highlight: true),
                            for (final s in sessions.skip(1).take(2)) _SessionRow(session: s),
                          ],
                        ),
                ),
            const SizedBox(height: MuSpace.xl),
            _RequestsRow(count: ref.watch(mentorRequestCountProvider).value),
            const SizedBox(height: MuSpace.m),
            ref.watch(mentorProfileCompletionProvider).when(
                  skipError: true,
                  skipLoadingOnReload: true,
                  loading: () => const MuSkeleton(height: 96),
                  error: (e, _) => _SectionError(e, () => ref.invalidate(mentorProfileCompletionProvider)),
                  data: (c) => _CompletionCard(completion: c),
                ),
            const SizedBox(height: MuSpace.xl),
            const _Heading('Your mentoring'),
            ref.watch(mentorAnalyticsProvider).when(
                  skipError: true,
                  skipLoadingOnReload: true,
                  loading: () => const MuSkeleton(height: 64),
                  error: (e, _) => _SectionError(e, () => ref.invalidate(mentorAnalyticsProvider)),
                  data: (a) => _Totals(analytics: a),
                ),
            const SizedBox(height: MuSpace.xl),
            const _Heading('Your scopes'),
            ref.watch(mentorOverviewProvider).when(
                  skipError: true,
                  skipLoadingOnReload: true,
                  loading: () => const MuSkeleton(height: 88),
                  error: (e, _) => _SectionError(e, () => ref.invalidate(mentorOverviewProvider)),
                  data: (scopes) => scopes.isEmpty
                      ? const _NoScope()
                      : Column(children: [for (final s in scopes) _ScopeCard(scope: s)]),
                ),
          ],
        ),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: MuSpace.s),
        child: Text(text.toUpperCase(), style: MuType.eyebrow),
      );
}

class _SectionError extends StatelessWidget {
  const _SectionError(this.error, this.onRetry);

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: Text(ApiException.messageFor(error), style: MuType.body.copyWith(color: MuColors.inkSecondary)),
          ),
          TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      );
}

/// A coming session; the soonest is [highlight]ed with Join when it's time.
/// The whole card opens the session.
class _SessionRow extends ConsumerWidget {
  const _SessionRow({required this.session, this.highlight = false});

  final MentorSession session;
  final bool highlight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = ref.watch(clockProvider)().toLocal();
    final when = formatWhen(starts: session.startsAt.toLocal(), ends: session.endsAt.toLocal(), now: now);
    return Padding(
      padding: const EdgeInsets.only(bottom: MuSpace.s),
      child: MuCard(
        variant: highlight ? MuCardVariant.tinted : MuCardVariant.surface,
        onTap: () => context.push(RoutePaths.mentorSessionDetailPath(session.id)),
        padding: const EdgeInsets.all(MuSpace.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(LucideIcons.calendarDays, size: 20, color: MuColors.primary),
                const SizedBox(width: MuSpace.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(when, style: highlight ? MuType.bodyMed.copyWith(color: MuColors.primary) : MuType.caption),
                      const SizedBox(height: 2),
                      Text(session.title, style: MuType.bodyMed, maxLines: 2, overflow: TextOverflow.ellipsis),
                      Text(
                        [sessionModeLabel(session.mode), if (session.entityName.isNotEmpty) session.entityName].join(' · '),
                        style: MuType.caption,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const Icon(LucideIcons.chevronRight, size: 18, color: MuColors.inkSecondary),
              ],
            ),
            if (highlight) MeetingLinkActions(session: session, compact: true),
          ],
        ),
      ),
    );
  }
}

class _RequestsRow extends StatelessWidget {
  const _RequestsRow({required this.count});

  /// Null while loading or after a failure.
  final int? count;

  @override
  Widget build(BuildContext context) {
    final label = switch (count) {
      null => '',
      0 => 'None waiting',
      final n => '$n waiting',
    };
    return MuCard(
      onTap: () => context.push(RoutePaths.mentorRequests),
      padding: const EdgeInsets.all(MuSpace.l),
      child: Row(
        children: [
          const Icon(LucideIcons.inbox, size: 20, color: MuColors.primary),
          const SizedBox(width: MuSpace.m),
          Expanded(child: Text('Session requests', style: MuType.bodyMed)),
          Text(label, style: (count ?? 0) > 0 ? MuType.bodyMed.copyWith(color: MuColors.primary) : MuType.caption),
          const SizedBox(width: MuSpace.xs),
          const Icon(LucideIcons.chevronRight, size: 18, color: MuColors.inkSecondary),
        ],
      ),
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
    final missing = [
      for (final e in completion.checklist.entries)
        if (!e.value) _checklistLabels[e.key] ?? e.key,
    ];
    return MuCard(
      padding: const EdgeInsets.all(MuSpace.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Profile ${completion.percentage}% complete', style: MuType.bodyMed),
          const SizedBox(height: MuSpace.s),
          MuLinearProgress(value: completion.percentage.clamp(0, 100) / 100),
          if (missing.isNotEmpty) ...[
            const SizedBox(height: MuSpace.s),
            Text('Missing: ${missing.join(', ')}', style: MuType.caption),
          ],
          if (completion.percentage < 100)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                // The mentor profile is edited on the web dashboard.
                onPressed: () => ref.read(openExternalProvider)(
                  Uri.parse('${FlavorConfig.instance.dashboardUrl}/dashboard/profile'),
                ),
                child: const Text('Finish on web'),
              ),
            ),
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
    return MuCard(
      padding: const EdgeInsets.all(MuSpace.l),
      child: Row(
        children: [
          Expanded(child: MuStatBlock(label: 'Sessions completed', value: '${analytics.sessionsCompleted}')),
          Expanded(child: MuStatBlock(label: 'Karma earned', value: '${analytics.karmaEarned}')),
          Expanded(
            child: rating == null
                ? const MuStatBlock(label: 'No ratings yet', value: '—')
                : MuStatBlock(label: 'Rating (${analytics.ratingCount})', value: '★ ${rating.toStringAsFixed(1)}'),
          ),
        ],
      ),
    );
  }
}

class _ScopeCard extends StatelessWidget {
  const _ScopeCard({required this.scope});

  final MentorScope scope;

  @override
  Widget build(BuildContext context) {
    final m = scope.metrics;
    return Padding(
      padding: const EdgeInsets.only(bottom: MuSpace.s),
      child: MuCard(
        padding: const EdgeInsets.all(MuSpace.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(scope.name, style: MuType.bodyMed),
            Text(scopeTypeLabel(scope.type), style: MuType.caption),
            const SizedBox(height: MuSpace.s),
            Text(
              '${m.totalIgLearners} learners · ${m.activeIgLearners} active · '
              '${m.upcomingSessions} upcoming sessions · ${m.igLearningCircles} circles',
              style: MuType.body.copyWith(color: MuColors.inkSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoScope extends StatelessWidget {
  const _NoScope();

  @override
  Widget build(BuildContext context) => MuCard(
        padding: const EdgeInsets.all(MuSpace.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('No mentoring scope yet', style: MuType.bodyMed),
            const SizedBox(height: MuSpace.xs),
            Text(
              'An admin assigns the interest group, campus or company you mentor. '
              'You can create sessions once you have one.',
              style: MuType.body.copyWith(color: MuColors.inkSecondary),
            ),
          ],
        ),
      );
}
