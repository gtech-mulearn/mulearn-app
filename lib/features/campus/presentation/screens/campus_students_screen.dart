import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/level_label.dart';
import 'package:mulearn_app/core/utils/search_debouncer.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_paged_list.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_student.dart';
import 'package:mulearn_app/features/campus/domain/student_filter.dart';
import 'package:mulearn_app/features/campus/presentation/providers/campus_students_controller.dart';

/// The campus's students (K2): search, order, alumni; each opens its page.
class CampusStudentsScreen extends ConsumerStatefulWidget {
  const CampusStudentsScreen({super.key});

  @override
  ConsumerState<CampusStudentsScreen> createState() =>
      _CampusStudentsScreenState();
}

class _CampusStudentsScreenState extends ConsumerState<CampusStudentsScreen> {
  final _search = TextEditingController();
  late final _debouncer = SearchDebouncer((q) {
    if (mounted) setState(() => _filter = _filter.copyWith(search: q));
  });
  StudentFilter _filter = const StudentFilter();

  @override
  void dispose() {
    _debouncer.dispose();
    _search.dispose();
    super.dispose();
  }

  void _onSearch(String value) => _debouncer.onChanged(value);

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final state = ref.watch(campusStudentsControllerProvider(_filter));
    return MuWorkspacePage(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              MuSpacing.space5,
              MuSpacing.space2,
              MuSpacing.space5,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  header: true,
                  child: Text(
                    'Students',
                    style: mu.text.display.copyWith(fontSize: 32),
                  ),
                ),
                const SizedBox(height: MuSpacing.space4),
                MuSearchField(
                  controller: _search,
                  hint: 'Search by name',
                  onChanged: _onSearch,
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: MuSpacing.space5,
              vertical: MuSpacing.space3,
            ),
            child: Row(
              children: [
                for (final s in StudentSort.values) ...[
                  MuFilterChip(
                    label: s.label,
                    selected: _filter.sort == s,
                    onTap: () =>
                        setState(() => _filter = _filter.copyWith(sort: s)),
                  ),
                  const SizedBox(width: MuSpacing.space2),
                ],
                MuFilterChip(
                  label: 'Alumni',
                  selected: _filter.alumni ?? false,
                  onTap: () => setState(
                    () => _filter = _filter.copyWith(
                      alumni: (_filter.alumni ?? false) ? null : true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: state.when(
              skipError: true,
              skipLoadingOnReload: true,
              loading: () =>
                  const Center(child: MuDotsLoader(label: 'Loading students…')),
              error: (e, _) => ErrorRetryView(
                error: e,
                onRetry: () =>
                    ref.invalidate(campusStudentsControllerProvider(_filter)),
              ),
              data: (view) {
                Future<void> refresh() => ref.refresh(
                  campusStudentsControllerProvider(_filter).future,
                );
                final items = view.paged.items;
                if (items.isEmpty) {
                  return MuRefresh(
                    onRefresh: refresh,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        MuStateDisplay(
                          variant: MuStateVariant.noResults,
                          size: MuStateSize.sm,
                        ),
                      ],
                    ),
                  );
                }
                final leader = items.fold<int>(
                  0,
                  (m, s) => s.karma > m ? s.karma : m,
                );
                // A campus has thousands of students: built row by row.
                return MuPagedListView(
                  state: view.paged,
                  onRefresh: refresh,
                  grouped: true,
                  padding: const EdgeInsets.fromLTRB(
                    MuSpacing.space5,
                    0,
                    MuSpacing.space5,
                    MuSpacing.space8,
                  ),
                  header: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: MuSpacing.space2),
                      child: Text(
                        view.count == 1
                            ? '1 student'
                            : '${view.count} students',
                        style: mu.text.caption,
                      ),
                    ),
                  ],
                  onLoadMore: () => ref
                      .read(campusStudentsControllerProvider(_filter).notifier)
                      .loadMore(),
                  itemBuilder: (_, student, i) => _StudentRow(
                    student: student,
                    leader: leader,
                    last: i == items.length - 1,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StudentRow extends StatelessWidget {
  const _StudentRow({
    required this.student,
    required this.leader,
    required this.last,
  });

  final CampusStudent student;

  /// The top karma shown, for the bar.
  final int leader;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final s = student;
    String plural(int n, String one) => '$n ${n == 1 ? one : '${one}s'}';
    return MuFeedRow(
      leading: MuRankDisc(s.rank),
      subject: s.fullName.isEmpty ? s.muid : s.fullName,
      body: s.isAlumni ? '· Alumni' : null,
      time: s.muid,
      actions: [
        Text(
          [
            if (s.level.isNotEmpty) levelLabel(s.level),
            plural(s.igCount, 'group'),
            plural(s.lcCount, 'circle'),
          ].join(' · '),
          style: context.mu.text.caption,
        ),
      ],
      trailing: SizedBox(
        width: 72,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            MuFeedAmount(muGrouped(s.karma)),
            const SizedBox(height: 6),
            MuBar(value: leader <= 0 ? 0 : s.karma / leader),
          ],
        ),
      ),
      divider: !last,
      onTap: () => context.push(RoutePaths.campusStudentPath(s.muid), extra: s),
    );
  }
}
