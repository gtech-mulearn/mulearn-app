import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/utils/level_label.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/core/widgets/mu_load_more_footer.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_stat_block.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_student.dart';
import 'package:mulearn_app/features/campus/domain/entities/student_activity.dart';
import 'package:mulearn_app/features/campus/presentation/providers/campus_students_controller.dart';

/// One student at the campus: who they are, their numbers and their karma
/// activity, with their public profile one tap away.
class CampusStudentScreen extends ConsumerWidget {
  const CampusStudentScreen({required this.muid, super.key});

  final String muid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final student = ref.watch(campusStudentProvider(muid));
    final activity = ref.watch(studentActivityControllerProvider(muid));
    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(backgroundColor: MuColors.canvas, elevation: 0, title: const Text('Student')),
      body: MuRefresh(
        onRefresh: () => Future.wait([
          ref.refresh(campusStudentProvider(muid).future),
          ref.refresh(studentActivityControllerProvider(muid).future),
        ]),
        child: NotificationListener<ScrollNotification>(
          onNotification: (n) {
            final paged = activity.value;
            if (n.metrics.extentAfter < 400 && paged != null && paged.hasMore && paged.loadMoreError == null) {
              unawaited(ref.read(studentActivityControllerProvider(muid).notifier).loadMore());
            }
            return false;
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.s, MuSpace.screenH, MuSpace.xxl),
            children: [
              student.when(
                skipError: true,
                skipLoadingOnReload: true,
                loading: () => const SizedBox(height: 120, child: Center(child: CircularProgressIndicator())),
                error: (e, _) => ErrorRetryView(error: e, onRetry: () => ref.invalidate(campusStudentProvider(muid))),
                data: (s) => s == null
                    ? const MuStateDisplay(
                        variant: MuStateVariant.notFound,
                        size: MuStateSize.sm,
                        title: 'Student not found',
                        description: 'This learner is not at your campus.',
                      )
                    : _Header(student: s),
              ),
              const SizedBox(height: MuSpace.s),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => context.push(RoutePaths.publicProfilePath(muid)),
                  icon: const Icon(LucideIcons.user, size: 16),
                  label: const Text('View public profile'),
                ),
              ),
              const SizedBox(height: MuSpace.m),
              Text('ACTIVITY', style: MuType.eyebrow),
              const SizedBox(height: MuSpace.s),
              activity.when(
                skipError: true,
                skipLoadingOnReload: true,
                loading: () => const Padding(
                  padding: EdgeInsets.all(MuSpace.l),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (e, _) => ErrorRetryView(
                  error: e,
                  onRetry: () => ref.invalidate(studentActivityControllerProvider(muid)),
                ),
                data: (paged) => paged.items.isEmpty
                    ? Text('No activity yet.', style: MuType.body.copyWith(color: MuColors.inkSecondary))
                    : Column(
                        children: [
                          for (final a in paged.items) _ActivityTile(activity: a),
                          if (paged.hasMore || paged.loadMoreError != null)
                            MuLoadMoreFooter(
                              isLoading: paged.isLoadingMore,
                              error: paged.loadMoreError,
                              onRetry: () => ref.read(studentActivityControllerProvider(muid).notifier).loadMore(),
                            ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  const _Header({required this.student});

  final CampusStudent student;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = student;
    final now = ref.watch(clockProvider)().toLocal();
    return MuCard(
      padding: const EdgeInsets.all(MuSpace.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(child: Text(s.fullName.isEmpty ? s.muid : s.fullName, style: MuType.title)),
              if (s.isAlumni) ...[const SizedBox(width: MuSpace.s), const MuTagChip(label: 'Alumni')],
            ],
          ),
          Text(s.muid, style: MuType.caption),
          if (s.department != null || s.graduationYear != null)
            Text(
              [if (s.department != null) s.department!, if (s.graduationYear != null) 'Class of ${s.graduationYear}']
                  .join(' · '),
              style: MuType.caption,
            ),
          const SizedBox(height: MuSpace.m),
          Row(
            children: [
              Expanded(child: MuStatBlock(label: 'Karma', value: '${s.karma}')),
              Expanded(child: MuStatBlock(label: 'Level', value: s.level.isEmpty ? '—' : levelLabel(s.level))),
              Expanded(child: MuStatBlock(label: 'Rank', value: s.rank == null ? '—' : '#${s.rank}')),
            ],
          ),
          const SizedBox(height: MuSpace.m),
          Text(
            [
              '${s.igCount} ${s.igCount == 1 ? 'group' : 'groups'}',
              '${s.lcCount} ${s.lcCount == 1 ? 'circle' : 'circles'}',
              if (s.joinedAt != null) 'Joined ${formatDay(s.joinedAt!.toLocal())}',
              if (s.lastKarmaAt != null) 'Last karma ${formatAgo(s.lastKarmaAt!.toLocal(), now)}',
            ].join(' · '),
            style: MuType.caption,
          ),
        ],
      ),
    );
  }
}

class _ActivityTile extends ConsumerWidget {
  const _ActivityTile({required this.activity});

  final StudentActivity activity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final a = activity;
    final now = ref.watch(clockProvider)().toLocal();
    final style = switch (a.status.toLowerCase()) {
      'approved' => MuTagStyle.success,
      'rejected' => MuTagStyle.deadline,
      _ => MuTagStyle.warning,
    };
    return Padding(
      padding: const EdgeInsets.only(bottom: MuSpace.s),
      child: MuCard(
        padding: const EdgeInsets.all(MuSpace.l),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(a.taskName, style: MuType.bodyMed),
                  Text(
                    [if (a.igName != null) a.igName!, formatAgo(a.createdAt.toLocal(), now)].join(' · '),
                    style: MuType.caption,
                  ),
                  const SizedBox(height: MuSpace.xs),
                  MuTagChip(label: a.status, style: style),
                ],
              ),
            ),
            Text('+${a.karma}', style: MuType.bodyMed.copyWith(color: MuColors.primary)),
          ],
        ),
      ),
    );
  }
}
