import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/utils/level_label.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_progress_bars.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_skeleton.dart';
import 'package:mulearn_app/core/widgets/mu_stat_block.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_student.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_summary.dart';
import 'package:mulearn_app/features/campus/presentation/providers/campus_overview_providers.dart';

/// The campus at a glance (K1, audit 06 "K1 Campus overview"): headline
/// numbers, the member funnel, circles that need attention, this week's
/// karma, recent activity and the top students. Loads on open and on
/// pull-to-refresh only.
class CampusOverviewScreen extends ConsumerWidget {
  const CampusOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(campusSummaryProvider);
    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(backgroundColor: MuColors.canvas, elevation: 0, title: const Text('Campus')),
      body: summary.when(
        skipError: true,
        skipLoadingOnReload: true,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorRetryView(error: e, onRetry: () => ref.invalidate(campusSummaryProvider)),
        data: (s) => MuRefresh(
          onRefresh: () => Future.wait([
            ref.refresh(campusSummaryProvider.future),
            ref.refresh(campusWeeklyKarmaProvider.future),
            ref.refresh(campusTopStudentsProvider.future),
          ]),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.s, MuSpace.screenH, MuSpace.xxl),
            children: [
              Text(s.collegeName, style: MuType.title),
              Text([s.campusCode, s.zone].where((x) => x.isNotEmpty).join(' · '), style: MuType.caption),
              const SizedBox(height: MuSpace.l),
              _Stats(stats: s.stats),
              const SizedBox(height: MuSpace.xl),
              if (s.funnel.isNotEmpty) ...[
                const _Heading('Members'),
                _Funnel(stages: s.funnel, max: s.funnelMax),
                const SizedBox(height: MuSpace.xl),
              ],
              const _Heading('Circles'),
              _CircleHealthSection(circles: s.circleHealth),
              const SizedBox(height: MuSpace.xl),
              const _Heading('Karma this week'),
              const _WeeklyKarma(),
              const SizedBox(height: MuSpace.xl),
              if (s.recentActivity.isNotEmpty) ...[
                const _Heading('Recent activity'),
                for (final a in s.recentActivity) _ActivityRow(activity: a),
                const SizedBox(height: MuSpace.xl),
              ],
              Row(
                children: [
                  const Expanded(child: _Heading('Top students')),
                  TextButton(
                    onPressed: () => context.push(RoutePaths.campusStudents),
                    child: const Text('All students'),
                  ),
                ],
              ),
              const _TopStudents(),
            ],
          ),
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

String _period(String? p) => switch (p) {
      '7d' => '7 days',
      '30d' => '30 days',
      '90d' => '90 days',
      null || '' => '',
      _ => p,
    };

class _Stats extends StatelessWidget {
  const _Stats({required this.stats});

  final List<StatCard> stats;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = (constraints.maxWidth - MuSpace.m) / 2;
        return Wrap(
          spacing: MuSpace.m,
          runSpacing: MuSpace.m,
          children: [
            for (final s in stats)
              SizedBox(
                width: width,
                child: MuCard(
                  padding: const EdgeInsets.all(MuSpace.l),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MuStatBlock(label: s.label, value: s.value == null ? '—' : '${s.value}'),
                      if ((s.delta ?? 0) != 0 && s.deltaType != 'neutral')
                        Text(
                          '${s.deltaType == 'decrease' ? '−' : '+'}${s.delta!.abs()} in ${_period(s.period)}',
                          style: MuType.caption.copyWith(
                            color: s.deltaType == 'decrease' ? MuColors.error : MuColors.success,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _Funnel extends StatelessWidget {
  const _Funnel({required this.stages, required this.max});

  final List<FunnelStage> stages;
  final int max;

  @override
  Widget build(BuildContext context) {
    return MuCard(
      padding: const EdgeInsets.all(MuSpace.l),
      child: Column(
        children: [
          for (final f in stages)
            Padding(
              padding: const EdgeInsets.only(bottom: MuSpace.m),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(f.label, style: MuType.body)),
                      Text('${f.count}', style: MuType.bodyMed),
                      const SizedBox(width: MuSpace.s),
                      SizedBox(
                        width: 48,
                        child: Text('${f.percentage.round()}%', style: MuType.caption, textAlign: TextAlign.end),
                      ),
                    ],
                  ),
                  const SizedBox(height: MuSpace.xs),
                  MuLinearProgress(value: max <= 0 ? 0 : (f.count / max).clamp(0, 1).toDouble()),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// How many circles are active, slow and inactive, then the slow and
/// inactive ones — each opens its page.
class _CircleHealthSection extends ConsumerWidget {
  const _CircleHealthSection({required this.circles});

  final List<CircleHealth> circles;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (circles.isEmpty) {
      return Text('No circles at this campus yet.', style: MuType.body.copyWith(color: MuColors.inkSecondary));
    }
    int count(String status) => circles.where((c) => c.status == status).length;
    final attention = [
      ...circles.where((c) => c.status == 'inactive'),
      ...circles.where((c) => c.status == 'slow'),
    ];
    final now = ref.watch(clockProvider)().toLocal();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${count('active')} active · ${count('slow')} slow · ${count('inactive')} inactive',
          style: MuType.bodyMed,
        ),
        if (attention.isNotEmpty) ...[
          const SizedBox(height: MuSpace.s),
          Text('Needs attention', style: MuType.caption),
          for (final c in attention)
            Padding(
              padding: const EdgeInsets.only(top: MuSpace.s),
              child: MuCard(
                onTap: () => context.push(RoutePaths.learningCircleDetailPath(c.circleId)),
                padding: const EdgeInsets.fromLTRB(MuSpace.l, MuSpace.m, MuSpace.s, MuSpace.m),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.circleDot,
                      size: 16,
                      color: c.status == 'inactive' ? MuColors.error : MuColors.warning,
                    ),
                    const SizedBox(width: MuSpace.m),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c.circleName, style: MuType.bodyMed, maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text(
                            [
                              if (c.igName.isNotEmpty) c.igName,
                              '${c.memberCount} ${c.memberCount == 1 ? 'member' : 'members'}',
                              if (c.lastSessionAt == null)
                                'No meetings yet'
                              else
                                'Last met ${formatAgo(c.lastSessionAt!.toLocal(), now)}',
                            ].join(' · '),
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
              ),
            ),
        ],
      ],
    );
  }
}

const _dayLetters = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

class _WeeklyKarma extends ConsumerWidget {
  const _WeeklyKarma();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(campusWeeklyKarmaProvider).when(
          skipError: true,
          skipLoadingOnReload: true,
          loading: () => const MuSkeleton(height: 96),
          error: (e, _) => Text(ApiException.messageFor(e), style: MuType.caption),
          data: (days) {
            final total = days.fold<int>(0, (sum, d) => sum + d.karma);
            if (total == 0) {
              return Text('No karma earned this week yet.', style: MuType.body.copyWith(color: MuColors.inkSecondary));
            }
            final peak = days.map((d) => d.karma).reduce((a, b) => a > b ? a : b);
            return MuCard(
              padding: const EdgeInsets.all(MuSpace.l),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$total karma in 7 days', style: MuType.bodyMed),
                  const SizedBox(height: MuSpace.m),
                  SizedBox(
                    height: 96,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (final d in days)
                          Expanded(
                            child: Semantics(
                              label: '${formatDay(d.day)}: ${d.karma} karma',
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: peak == 0 ? 2 : (72 * d.karma / peak).clamp(2, 72).toDouble(),
                                    margin: const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      color: MuColors.primary,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  const SizedBox(height: MuSpace.xs),
                                  Text(_dayLetters[d.day.weekday - 1], style: MuType.caption),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
  }
}

class _ActivityRow extends ConsumerWidget {
  const _ActivityRow({required this.activity});

  final CampusActivity activity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final a = activity;
    final now = ref.watch(clockProvider)().toLocal();
    final muid = a.actorMuid;
    return InkWell(
      onTap: muid == null || muid.isEmpty ? null : () => context.push(RoutePaths.publicProfilePath(muid)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: MuSpace.s),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 2),
              child: Icon(LucideIcons.activity, size: 16, color: MuColors.inkSecondary),
            ),
            const SizedBox(width: MuSpace.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(a.title, style: MuType.body),
                  Text(
                    [if ((a.actorName ?? '').isNotEmpty) a.actorName!, formatAgo(a.createdAt.toLocal(), now)].join(' · '),
                    style: MuType.caption,
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

class _TopStudents extends ConsumerWidget {
  const _TopStudents();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(campusTopStudentsProvider).when(
          skipError: true,
          skipLoadingOnReload: true,
          loading: () => const MuSkeleton(height: 120),
          error: (e, _) => Text(ApiException.messageFor(e), style: MuType.caption),
          data: (students) => students.isEmpty
              ? Text('No students yet.', style: MuType.body.copyWith(color: MuColors.inkSecondary))
              : MuCard(
                  padding: EdgeInsets.zero,
                  child: Column(children: [for (final s in students) _StudentRow(student: s)]),
                ),
        );
  }
}

class _StudentRow extends StatelessWidget {
  const _StudentRow({required this.student});

  final CampusStudent student;

  @override
  Widget build(BuildContext context) {
    final s = student;
    return InkWell(
      onTap: s.muid.isEmpty ? null : () => context.push(RoutePaths.campusStudentPath(s.muid)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: MuSpace.l, vertical: MuSpace.m),
        child: Row(
          children: [
            SizedBox(width: 36, child: Text(s.rank == null ? '' : '#${s.rank}', style: MuType.caption)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.fullName.isEmpty ? s.muid : s.fullName, style: MuType.bodyMed),
                  Text(s.muid, style: MuType.caption),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${s.karma} karma', style: MuType.bodyMed),
                if (s.level.isNotEmpty) Text(levelLabel(s.level), style: MuType.caption),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
