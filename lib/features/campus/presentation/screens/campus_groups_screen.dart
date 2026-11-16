import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/session/workspace_access.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/utils/search_debouncer.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_paged_list.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_groups.dart';
import 'package:mulearn_app/features/campus/presentation/providers/campus_chapters_providers.dart';
import 'package:mulearn_app/features/campus/presentation/providers/campus_groups_controllers.dart';
import 'package:mulearn_app/features/campus/presentation/widgets/campus_chapter_widgets.dart';

enum _Tab { circles, chapters }

/// The campus's circles and IG chapters (K3), most members first.
/// Circles as their rings with when they meet; chapters (the campus's own
/// chapters of μLearn interest groups, `ig-chapters/`, as on the dashboard's
/// Campus Manage IG tab) with their lead and how many learners each has.
/// The Campus Lead and Lead Enabler start, edit and remove chapters.
class CampusGroupsScreen extends ConsumerStatefulWidget {
  const CampusGroupsScreen({super.key});

  @override
  ConsumerState<CampusGroupsScreen> createState() => _CampusGroupsScreenState();
}

class _CampusGroupsScreenState extends ConsumerState<CampusGroupsScreen> {
  final _search = TextEditingController();
  late final _debouncer = SearchDebouncer((q) {
    if (mounted) setState(() => _query = q);
  });
  String _query = '';
  _Tab _tab = _Tab.circles;

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
    return MuWorkspacePage(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              MuSpacing.space5,
              MuSpacing.space2,
              MuSpacing.space5,
              MuSpacing.space3,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Semantics(
                  header: true,
                  child: Text(
                    'Circles and groups',
                    style: mu.text.display.copyWith(fontSize: 32),
                  ),
                ),
                const SizedBox(height: MuSpacing.space4),
                MuSegmented<_Tab>(
                  values: _Tab.values,
                  selected: _tab,
                  label: (t) => t == _Tab.circles ? 'Circles' : 'IG chapters',
                  onChanged: (t) => setState(() => _tab = t),
                ),
                const SizedBox(height: MuSpacing.space3),
                MuSearchField(
                  controller: _search,
                  hint: 'Search',
                  onChanged: _onSearch,
                ),
              ],
            ),
          ),
          Expanded(
            child: _tab == _Tab.circles
                ? _PagedList<CampusCircle>(
                    state: ref.watch(campusCirclesControllerProvider(_query)),
                    onRefresh: () => ref.refresh(
                      campusCirclesControllerProvider(_query).future,
                    ),
                    onRetry: () =>
                        ref.invalidate(campusCirclesControllerProvider(_query)),
                    onLoadMore: () => ref
                        .read(campusCirclesControllerProvider(_query).notifier)
                        .loadMore(),
                    itemBuilder: (_, circle, _) => _CircleCard(circle: circle),
                  )
                : _Chapters(query: _query),
          ),
        ],
      ),
    );
  }
}

/// A paged list built row by row (a campus has hundreds of circles).
class _PagedList<T> extends StatelessWidget {
  const _PagedList({
    required this.state,
    required this.onRefresh,
    required this.onRetry,
    required this.onLoadMore,
    required this.itemBuilder,
  });

  final AsyncValue<PagedState<T>> state;
  final Future<void> Function() onRefresh;
  final VoidCallback onRetry;
  final Future<void> Function() onLoadMore;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return state.when(
      skipError: true,
      skipLoadingOnReload: true,
      loading: () => const Center(child: MuDotsLoader()),
      error: (e, _) => ErrorRetryView(error: e, onRetry: onRetry),
      data: (paged) => MuPagedListView<T>(
        state: paged,
        onRefresh: onRefresh,
        onLoadMore: onLoadMore,
        padding: const EdgeInsets.fromLTRB(
          MuSpacing.space5,
          0,
          MuSpacing.space5,
          MuSpacing.space8,
        ),
        empty: const MuStateDisplay(
          variant: MuStateVariant.noResults,
          size: MuStateSize.sm,
        ),
        itemBuilder: itemBuilder,
      ),
    );
  }
}

class _CircleCard extends ConsumerWidget {
  const _CircleCard({required this.circle});

  final CampusCircle circle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = circle;
    final now = ref.watch(clockProvider)();
    final last = c.lastMeetingTime;
    final upcoming = last != null && last.isAfter(now);
    final when = last == null
        ? 'No meetings yet'
        : upcoming
        ? 'Next meets ${formatDayHeading(last.toLocal(), now.toLocal())}'
        : 'Last met ${formatAgo(last.toLocal(), now.toLocal())}';
    return MuCircleCard(
      title: c.name,
      total: c.memberCount,
      caption: [
        if (c.igName.isNotEmpty) c.igName,
        '${c.memberCount} ${c.memberCount == 1 ? 'member' : 'members'}',
        '${c.meetingCount} ${c.meetingCount == 1 ? 'meeting' : 'meetings'}',
      ].join(' · '),
      action: MuPill(
        when,
        tone: upcoming
            ? MuPillTone.cobalt
            : (last == null ? MuPillTone.warning : MuPillTone.neutral),
        icon: upcoming
            ? LucideIcons.calendar
            : (last == null ? LucideIcons.alertCircle : LucideIcons.history),
      ),
      onTap: () => context.push(RoutePaths.learningCircleDetailPath(c.id)),
    );
  }
}

/// The campus's IG chapters, filtered by the search on this device (the
/// list isn't paginated). Campus Leads and Lead Enablers can start one.
class _Chapters extends ConsumerWidget {
  const _Chapters({required this.query});

  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canManage =
        ref.watch(workspaceAccessProvider).value?.campusChapters ?? false;
    final state = ref.watch(campusChaptersProvider);
    return state.when(
      skipLoadingOnReload: true,
      loading: () => const Center(child: MuDotsLoader()),
      error: (e, _) => ErrorRetryView(
        error: e,
        onRetry: () => ref.invalidate(campusChaptersProvider),
      ),
      data: (all) {
        final q = query.toLowerCase();
        final items = q.isEmpty
            ? all
            : [
                for (final c in all)
                  if ('${c.igName} ${c.igCode} ${c.leadName ?? ''} ${c.coLeadName ?? ''}'
                      .toLowerCase()
                      .contains(q))
                    c,
              ];
        final peak = items.fold<int>(
          0,
          (m, c) => c.members > m ? c.members : m,
        );
        final taken = {
          for (final c in all)
            if (c.isActive) c.igId,
        };
        return MuRefresh(
          onRefresh: () => ref.refresh(campusChaptersProvider.future),
          child: ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.fromLTRB(
              MuSpacing.space5,
              0,
              MuSpacing.space5,
              MuSpacing.space8,
            ),
            children: [
              if (canManage) ...[
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: MuButton(
                    label: 'Start a chapter',
                    icon: LucideIcons.plus,
                    size: MuButtonSize.small,
                    variant: MuButtonVariant.outline,
                    onPressed: () =>
                        CampusChapterForm.show(context, taken: taken),
                  ),
                ),
                const SizedBox(height: MuSpacing.space3),
              ],
              if (items.isEmpty)
                MuEmptyLine(
                  all.isEmpty
                      ? (canManage
                            ? 'No IG chapters yet. Start one for an interest group your campus is active in.'
                            : 'No IG chapters at your campus yet.')
                      : 'No chapter matches "$query".',
                )
              else
                MuFeedGroup(
                  children: [
                    for (var i = 0; i < items.length; i++)
                      CampusChapterRow(
                        chapter: items[i],
                        peak: peak,
                        canManage: canManage,
                        last: i == items.length - 1,
                      ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
