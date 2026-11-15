import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/utils/level_label.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_load_more_footer.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_student.dart';
import 'package:mulearn_app/features/campus/domain/entities/student_activity.dart';
import 'package:mulearn_app/features/campus/presentation/providers/campus_students_controller.dart';

/// One student at the campus: who they are, their numbers and their karma
/// activity, with their public profile one tap away.
///
/// The row the lead tapped arrives as [student] (route `extra`):
/// `student-details` searches names only, so a muID can't be looked up. A
/// cold link without it shows the muID and the activity.
class CampusStudentScreen extends ConsumerWidget {
  const CampusStudentScreen({required this.muid, this.student, super.key});

  final String muid;
  final CampusStudent? student;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final activity = ref.watch(studentActivityControllerProvider(muid));
    return MuWorkspacePage(
      action: MuIconButton(
        icon: LucideIcons.user,
        tooltip: 'Public profile',
        onPressed: () => context.push(RoutePaths.publicProfilePath(muid)),
      ),
      body: MuRefresh(
        onRefresh: () => ref.refresh(studentActivityControllerProvider(muid).future),
        child: NotificationListener<ScrollNotification>(
          onNotification: (n) {
            final paged = activity.value;
            if (n.metrics.extentAfter < 400 && paged != null && paged.hasMore && paged.loadMoreError == null) {
              unawaited(ref.read(studentActivityControllerProvider(muid).notifier).loadMore());
            }
            return false;
          },
          child: ListView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            padding: muListPadding,
            children: [
              if (student case final s?) _Header(student: s) else _MuidHeader(muid: muid),
              const SizedBox(height: MuSpacing.space4),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: MuButton(
                  label: 'View public profile',
                  icon: LucideIcons.user,
                  variant: MuButtonVariant.outline,
                  size: MuButtonSize.small,
                  onPressed: () => context.push(RoutePaths.publicProfilePath(muid)),
                ),
              ),
              const MuSectionEyebrow('Activity'),
              activity.when(
                skipError: true,
                skipLoadingOnReload: true,
                loading: () => const Padding(
                  padding: EdgeInsets.all(MuSpacing.space5),
                  child: Center(child: MuDotsLoader(label: 'Loading activity…')),
                ),
                error: (e, _) =>
                    ErrorRetryView(error: e, onRetry: () => ref.invalidate(studentActivityControllerProvider(muid))),
                data: (paged) => paged.items.isEmpty
                    ? Text('No activity yet.', style: mu.text.body.copyWith(color: mu.colors.ink3))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MuFeedGroup(
                            children: [
                              for (var i = 0; i < paged.items.length; i++)
                                _ActivityRow(activity: paged.items[i], last: i == paged.items.length - 1),
                            ],
                          ),
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

/// Opened from a link, not a row: the muID, and where the numbers are.
class _MuidHeader extends StatelessWidget {
  const _MuidHeader({required this.muid});

  final String muid;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(header: true, child: Text(muid, style: mu.text.title1)),
        const SizedBox(height: MuSpacing.space1),
        Text('Open them from Students to see their karma, level and rank.', style: mu.text.caption),
      ],
    );
  }
}

class _Header extends ConsumerWidget {
  const _Header({required this.student});

  final CampusStudent student;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final s = student;
    final now = ref.watch(clockProvider)().toLocal();
    final name = s.fullName.isEmpty ? s.muid : s.fullName;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            MuAvatar(name: name, size: MuSizes.avatarLg * 0.75),
            const SizedBox(width: MuSpacing.space4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Semantics(header: true, child: Text(name, style: mu.text.title1)),
                  Text(s.muid, style: mu.text.caption),
                  if (s.department != null || s.graduationYear != null)
                    Text(
                      [
                        if (s.department != null) s.department!,
                        if (s.graduationYear != null) 'Class of ${s.graduationYear}',
                      ].join(' · '),
                      style: mu.text.caption,
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: MuSpacing.space4),
        Row(
          children: [
            Expanded(
              child: MuStatTile(label: 'Karma', value: muGrouped(s.karma)),
            ),
            const SizedBox(width: MuSpacing.space2),
            Expanded(
              child: MuStatTile(label: 'Level', value: s.level.isEmpty ? '—' : levelLabel(s.level)),
            ),
            const SizedBox(width: MuSpacing.space2),
            Expanded(
              child: MuStatTile(label: 'Rank', value: s.rank == null ? '—' : '#${s.rank}'),
            ),
          ],
        ),
        const SizedBox(height: MuSpacing.space3),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            if (s.isAlumni) const MuPill('Alumni', icon: LucideIcons.graduationCap),
            MuPill('${s.igCount} ${s.igCount == 1 ? 'group' : 'groups'}', icon: LucideIcons.layers),
            MuPill('${s.lcCount} ${s.lcCount == 1 ? 'circle' : 'circles'}', icon: LucideIcons.users),
            if (s.joinedAt != null) MuPill('Joined ${formatDay(s.joinedAt!.toLocal())}', icon: LucideIcons.calendar),
            if (s.lastKarmaAt != null)
              MuPill('Last karma ${formatAgo(s.lastKarmaAt!.toLocal(), now)}', icon: LucideIcons.zap),
          ],
        ),
      ],
    );
  }
}

class _ActivityRow extends ConsumerWidget {
  const _ActivityRow({required this.activity, required this.last});

  final StudentActivity activity;
  final bool last;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final a = activity;
    final now = ref.watch(clockProvider)().toLocal();
    final status = a.status.toLowerCase();
    return MuFeedRow(
      leading: MuFeedIcon(
        switch (status) {
          'approved' => LucideIcons.checkCircle2,
          'rejected' => LucideIcons.xCircle,
          _ => LucideIcons.clock,
        },
        tone: switch (status) {
          'approved' => MuFeedTone.done,
          'rejected' => MuFeedTone.problem,
          _ => MuFeedTone.pending,
        },
      ),
      subject: a.taskName,
      time: [if (a.igName != null) a.igName!, formatAgo(a.createdAt.toLocal(), now)].join(' · '),
      trailing: MuFeedAmount('+${a.karma}'),
      divider: !last,
      actions: [
        switch (status) {
          'approved' => MuPill(a.status, tone: MuPillTone.success, icon: LucideIcons.check),
          'rejected' => MuPill(a.status, tone: MuPillTone.danger, icon: LucideIcons.x),
          _ => MuPill(a.status, tone: MuPillTone.warning, icon: LucideIcons.clock),
        },
      ],
    );
  }
}
