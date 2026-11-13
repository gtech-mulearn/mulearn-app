import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/level_label.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/core/widgets/mu_load_more_footer.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_student.dart';
import 'package:mulearn_app/features/campus/domain/student_filter.dart';
import 'package:mulearn_app/features/campus/presentation/providers/campus_students_controller.dart';

/// The campus's students (K2): search, order, alumni; each opens its page.
class CampusStudentsScreen extends ConsumerStatefulWidget {
  const CampusStudentsScreen({super.key});

  @override
  ConsumerState<CampusStudentsScreen> createState() => _CampusStudentsScreenState();
}

class _CampusStudentsScreenState extends ConsumerState<CampusStudentsScreen> {
  final _search = TextEditingController();
  Timer? _debounce;
  StudentFilter _filter = const StudentFilter();

  @override
  void dispose() {
    _debounce?.cancel();
    _search.dispose();
    super.dispose();
  }

  void _onSearch(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _filter = _filter.copyWith(search: value.trim()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(campusStudentsControllerProvider(_filter));
    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(backgroundColor: MuColors.canvas, elevation: 0, title: const Text('Students')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(MuSpace.screenH, 0, MuSpace.screenH, MuSpace.s),
            child: TextField(
              controller: _search,
              onChanged: _onSearch,
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                hintText: 'Search by name or muID',
                prefixIcon: Icon(LucideIcons.search, size: 18),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: MuSpace.screenH),
              children: [
                for (final s in StudentSort.values) ...[
                  MuFilterChip(
                    label: s.label,
                    selected: _filter.sort == s,
                    onTap: () => setState(() => _filter = _filter.copyWith(sort: s)),
                  ),
                  const SizedBox(width: MuSpace.s),
                ],
                MuFilterChip(
                  label: 'Alumni',
                  selected: _filter.alumni ?? false,
                  onTap: () => setState(() => _filter = _filter.copyWith(alumni: (_filter.alumni ?? false) ? null : true)),
                ),
              ],
            ),
          ),
          Expanded(
            child: state.when(
              skipError: true,
              skipLoadingOnReload: true,
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => ErrorRetryView(
                error: e,
                onRetry: () => ref.invalidate(campusStudentsControllerProvider(_filter)),
              ),
              data: (view) {
                Future<void> refresh() => ref.refresh(campusStudentsControllerProvider(_filter).future);
                final items = view.paged.items;
                if (items.isEmpty) {
                  return MuRefresh(
                    onRefresh: refresh,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [MuStateDisplay(variant: MuStateVariant.noResults, size: MuStateSize.sm)],
                    ),
                  );
                }
                return MuRefresh(
                  onRefresh: refresh,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (n) {
                      if (n.metrics.extentAfter < 400 && view.paged.hasMore && view.paged.loadMoreError == null) {
                        unawaited(ref.read(campusStudentsControllerProvider(_filter).notifier).loadMore());
                      }
                      return false;
                    },
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.s, MuSpace.screenH, MuSpace.xxl),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: MuSpace.s),
                          child: Text(view.count == 1 ? '1 student' : '${view.count} students', style: MuType.caption),
                        ),
                        for (final s in items) _StudentTile(student: s),
                        if (view.paged.hasMore || view.paged.loadMoreError != null)
                          MuLoadMoreFooter(
                            isLoading: view.paged.isLoadingMore,
                            error: view.paged.loadMoreError,
                            onRetry: () => ref.read(campusStudentsControllerProvider(_filter).notifier).loadMore(),
                          ),
                      ],
                    ),
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

class _StudentTile extends StatelessWidget {
  const _StudentTile({required this.student});

  final CampusStudent student;

  @override
  Widget build(BuildContext context) {
    final s = student;
    String plural(int n, String one) => '$n ${n == 1 ? one : '${one}s'}';
    return Padding(
      padding: const EdgeInsets.only(bottom: MuSpace.s),
      child: MuCard(
        onTap: () => context.push(RoutePaths.campusStudentPath(s.muid)),
        padding: const EdgeInsets.fromLTRB(MuSpace.l, MuSpace.m, MuSpace.s, MuSpace.m),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          s.fullName.isEmpty ? s.muid : s.fullName,
                          style: MuType.bodyMed,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (s.isAlumni) ...[const SizedBox(width: MuSpace.s), const MuTagChip(label: 'Alumni')],
                    ],
                  ),
                  Text(s.muid, style: MuType.caption),
                  Text(
                    [
                      if (s.level.isNotEmpty) levelLabel(s.level),
                      plural(s.igCount, 'group'),
                      plural(s.lcCount, 'circle'),
                    ].join(' · '),
                    style: MuType.caption,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${s.karma}', style: MuType.bodyMed),
                Text('karma', style: MuType.caption),
              ],
            ),
            const SizedBox(width: MuSpace.xs),
            const Icon(LucideIcons.chevronRight, size: 18, color: MuColors.inkSecondary),
          ],
        ),
      ),
    );
  }
}
