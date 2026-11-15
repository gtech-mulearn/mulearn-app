import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollCacheExtent;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/utils/level_label.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_student.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_summary.dart';
import 'package:mulearn_app/features/campus/presentation/providers/campus_overview_providers.dart';
import 'package:mulearn_app/features/campus/presentation/widgets/campus_kit.dart';

/// The campus at a glance (K1): the campus seal and name, headline
/// numbers, what's waiting for review, the member funnel, circles that
/// need attention, this week's karma, recent activity and the top
/// students. Loads on open and on pull-to-refresh.
class CampusOverviewScreen extends ConsumerWidget {
  const CampusOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(campusSummaryProvider);
    return CampusPage(
      body: summary.when(
        skipError: true,
        skipLoadingOnReload: true,
        loading: () => const Center(child: MuDotsLoader(label: 'Loading your campus…')),
        error: (e, _) => ErrorRetryView(error: e, onRetry: () => ref.invalidate(campusSummaryProvider)),
        data: (s) => MuRefresh(
          onRefresh: () => Future.wait([
            ref.refresh(campusSummaryProvider.future),
            ref.refresh(campusWeeklyKarmaProvider.future),
            ref.refresh(campusTopStudentsProvider.future),
          ]),
          child: ListView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            padding: campusListPadding,
            // Keep every section built while scrolling, so the karma chart and
            // top students don't refetch each time they come back into view.
            scrollCacheExtent: const ScrollCacheExtent.pixels(4000),
            children: [
              _Header(summary: s),
              const SizedBox(height: MuSpacing.space5),
              CampusStatGrid(
                tiles: [
                  for (final st in s.stats)
                    CampusStatTile(
                      label: st.label,
                      value: st.value == null ? '—' : '${st.value}',
                      change: (st.delta ?? 0) != 0 && st.deltaType != 'neutral'
                          ? '${st.deltaType == 'decrease' ? '−' : '+'}${st.delta!.abs()} in ${_period(st.period)}'
                          : null,
                      up: st.deltaType != 'decrease',
                    ),
                ],
              ),
              const SizedBox(height: MuSpacing.space4),
              MuFeedGroup(
                children: [
                  MuFeedRow(
                    leading: const MuFeedIcon(LucideIcons.checkSquare, tone: MuFeedTone.pending),
                    subject: 'Review approvals',
                    time: 'Student links, campus events and collaboration invites',
                    trailing: const _Chevron(),
                    divider: false,
                    onTap: () => context.push(RoutePaths.campusApprovals),
                  ),
                ],
              ),
              if (s.funnel.isNotEmpty) ...[
                const CampusEyebrow('Members'),
                CampusBarList(
                  items: [
                    for (final f in s.funnel)
                      (label: f.label, value: f.count, icon: null, note: '${f.percentage.round()}%'),
                  ],
                ),
              ],
              CampusEyebrow(
                'Circles',
                action: 'All circles and groups',
                onAction: () => context.push(RoutePaths.campusGroups),
              ),
              _CircleHealthSection(circles: s.circleHealth),
              const CampusEyebrow('Karma this week'),
              const _WeeklyKarma(),
              if (s.recentActivity.isNotEmpty) ...[
                const CampusEyebrow('Recent activity'),
                MuFeedGroup(
                  children: [
                    for (var i = 0; i < s.recentActivity.length; i++)
                      _ActivityRow(activity: s.recentActivity[i], last: i == s.recentActivity.length - 1),
                  ],
                ),
              ],
              CampusEyebrow(
                'Top students',
                action: 'All students',
                onAction: () => context.push(RoutePaths.campusStudents),
              ),
              const _TopStudents(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.summary});

  final CampusSummary summary;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    return Row(
      children: [
        MuCampusSeal(code: summary.campusCode, size: 64),
        const SizedBox(width: MuSpacing.space4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(header: true, child: Text(summary.collegeName, style: mu.text.title1)),
              const SizedBox(height: 2),
              Text([summary.campusCode, summary.zone].where((x) => x.isNotEmpty).join(' · '), style: mu.text.caption),
            ],
          ),
        ),
      ],
    );
  }
}

class _Chevron extends StatelessWidget {
  const _Chevron();

  @override
  Widget build(BuildContext context) =>
      Icon(LucideIcons.chevronRight, size: MuSizes.iconSm + 2, color: context.mu.colors.ink3);
}

String _period(String? p) => switch (p) {
  '7d' => '7 days',
  '30d' => '30 days',
  '90d' => '90 days',
  null || '' => '',
  _ => p,
};

/// How many circles are active, slow and inactive, then the slow and
/// inactive ones; each opens its page.
class _CircleHealthSection extends ConsumerWidget {
  const _CircleHealthSection({required this.circles});

  final List<CircleHealth> circles;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    if (circles.isEmpty) return const CampusEmptyLine('No circles at this campus yet.');
    int count(String status) => circles.where((c) => c.status == status).length;
    final attention = [...circles.where((c) => c.status == 'inactive'), ...circles.where((c) => c.status == 'slow')];
    final now = ref.watch(clockProvider)().toLocal();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CampusBarList(
          items: [
            (label: 'Meeting regularly', value: count('active'), icon: LucideIcons.checkCircle2, note: null),
            (label: 'Going slow', value: count('slow'), icon: LucideIcons.clock, note: null),
            (label: 'Inactive', value: count('inactive'), icon: LucideIcons.pauseCircle, note: null),
          ],
        ),
        if (attention.isNotEmpty) ...[
          const SizedBox(height: MuSpacing.space4),
          Text('Needs attention', style: mu.text.label.copyWith(color: mu.colors.ink2)),
          const SizedBox(height: MuSpacing.space2),
          MuFeedGroup(
            children: [
              for (var i = 0; i < attention.length; i++)
                MuFeedRow(
                  leading: MuFeedIcon(
                    LucideIcons.users,
                    tone: attention[i].status == 'inactive' ? MuFeedTone.problem : MuFeedTone.pending,
                  ),
                  subject: attention[i].circleName,
                  time: [
                    if (attention[i].igName.isNotEmpty) attention[i].igName,
                    '${attention[i].memberCount} ${attention[i].memberCount == 1 ? 'member' : 'members'}',
                    if (attention[i].lastSessionAt == null)
                      'No meetings yet'
                    else
                      'Last met ${formatAgo(attention[i].lastSessionAt!.toLocal(), now)}',
                  ].join(' · '),
                  trailing: const _Chevron(),
                  divider: i < attention.length - 1,
                  onTap: () => context.push(RoutePaths.learningCircleDetailPath(attention[i].circleId)),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

const _dayLetters = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

/// Seven bars of one hue; the best day in volt. Tap a day to read its
/// karma in the line above (the total until one is picked).
class _WeeklyKarma extends ConsumerStatefulWidget {
  const _WeeklyKarma();

  @override
  ConsumerState<_WeeklyKarma> createState() => _WeeklyKarmaState();
}

class _WeeklyKarmaState extends ConsumerState<_WeeklyKarma> {
  int? _picked;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return ref
        .watch(campusWeeklyKarmaProvider)
        .when(
          skipError: true,
          skipLoadingOnReload: true,
          loading: () => const SizedBox(height: 120, child: Center(child: MuDotsLoader())),
          error: (e, _) => Text(ApiException.messageFor(e), style: mu.text.caption),
          data: (days) {
            final total = days.fold<int>(0, (sum, d) => sum + d.karma);
            if (total == 0) return const CampusEmptyLine('No karma earned this week yet.');
            final peak = days.map((d) => d.karma).reduce((a, b) => a > b ? a : b);
            final picked = _picked != null && _picked! < days.length ? days[_picked!] : null;
            return CampusCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        muGrouped(picked?.karma ?? total),
                        style: mu.text.numeral.copyWith(fontSize: 28, color: c.voltText),
                      ),
                      const SizedBox(width: MuSpacing.space2),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          picked == null ? 'karma in 7 days' : 'karma on ${formatDay(picked.day)}',
                          style: mu.text.caption,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: MuSpacing.space4),
                  SizedBox(
                    height: 104,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (var i = 0; i < days.length; i++)
                          Expanded(
                            child: Semantics(
                              button: true,
                              selected: _picked == i,
                              label: '${formatDay(days[i].day)}: ${days[i].karma} karma',
                              excludeSemantics: true,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => setState(() => _picked = _picked == i ? null : i),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 180),
                                      height: peak == 0 ? 2 : (76 * days[i].karma / peak).clamp(2, 76).toDouble(),
                                      // 2px surface gap each side between bars.
                                      margin: const EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: (days[i].karma == peak ? c.volt : c.cobalt).withValues(
                                          alpha: _picked == null || _picked == i ? 1 : 0.35,
                                        ),
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                                      ),
                                    ),
                                    const SizedBox(height: MuSpacing.space2),
                                    Text(
                                      _dayLetters[days[i].day.weekday - 1],
                                      style: mu.text.caption.copyWith(
                                        color: _picked == i ? c.ink : c.ink3,
                                        fontWeight: _picked == i ? FontWeight.w700 : null,
                                      ),
                                    ),
                                  ],
                                ),
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
  const _ActivityRow({required this.activity, required this.last});

  final CampusActivity activity;
  final bool last;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final a = activity;
    final now = ref.watch(clockProvider)().toLocal();
    final muid = a.actorMuid;
    return MuFeedRow(
      leading: const MuFeedIcon(LucideIcons.activity),
      subject: a.title,
      time: [if ((a.actorName ?? '').isNotEmpty) a.actorName!, formatAgo(a.createdAt.toLocal(), now)].join(' · '),
      divider: !last,
      onTap: muid == null || muid.isEmpty ? null : () => context.push(RoutePaths.publicProfilePath(muid)),
    );
  }
}

class _TopStudents extends ConsumerWidget {
  const _TopStudents();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    return ref
        .watch(campusTopStudentsProvider)
        .when(
          skipError: true,
          skipLoadingOnReload: true,
          loading: () => const SizedBox(height: 120, child: Center(child: MuDotsLoader())),
          error: (e, _) => Text(ApiException.messageFor(e), style: mu.text.caption),
          data: (students) => students.isEmpty
              ? const CampusEmptyLine('No students yet.')
              : MuFeedGroup(
                  children: [
                    for (var i = 0; i < students.length; i++)
                      _StudentRow(student: students[i], leader: students.first.karma, last: i == students.length - 1),
                  ],
                ),
        );
  }
}

class _StudentRow extends StatelessWidget {
  const _StudentRow({required this.student, required this.leader, required this.last});

  final CampusStudent student;

  /// The top karma in the list, for the bar.
  final int leader;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final s = student;
    return MuFeedRow(
      leading: CampusRankDisc(s.rank),
      subject: s.fullName.isEmpty ? s.muid : s.fullName,
      body: s.level.isEmpty ? null : levelLabel(s.level),
      time: s.muid,
      trailing: SizedBox(
        width: 84,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            MuFeedAmount(muGrouped(s.karma)),
            const SizedBox(height: 6),
            CampusBar(value: leader <= 0 ? 0 : s.karma / leader),
          ],
        ),
      ),
      divider: !last,
      onTap: s.muid.isEmpty ? null : () => context.push(RoutePaths.campusStudentPath(s.muid), extra: s),
    );
  }
}
