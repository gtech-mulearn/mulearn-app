import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/utils/search_debouncer.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_load_more_footer.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_groups.dart';
import 'package:mulearn_app/features/campus/presentation/providers/campus_groups_controllers.dart';

enum _Tab { circles, groups }

/// The campus's circles and interest groups (K3), most members first.
/// Circles as their rings with when they meet; groups with how many of the
/// campus's learners are in each, as a bar. Rows open the circle and group
/// pages (the per-group member lists, `<id>/members/`, 500 on dev).
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
                  label: (t) =>
                      t == _Tab.circles ? 'Circles' : 'Interest groups',
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
                    builder: (items) => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (var i = 0; i < items.length; i++) ...[
                          if (i > 0) const SizedBox(height: MuSpacing.space3),
                          _CircleCard(circle: items[i]),
                        ],
                      ],
                    ),
                  )
                : _PagedList<CampusIg>(
                    state: ref.watch(campusIgsControllerProvider(_query)),
                    onRefresh: () =>
                        ref.refresh(campusIgsControllerProvider(_query).future),
                    onRetry: () =>
                        ref.invalidate(campusIgsControllerProvider(_query)),
                    onLoadMore: () => ref
                        .read(campusIgsControllerProvider(_query).notifier)
                        .loadMore(),
                    builder: (items) {
                      final peak = items.fold<int>(
                        0,
                        (m, g) =>
                            g.campusMemberCount > m ? g.campusMemberCount : m,
                      );
                      return MuFeedGroup(
                        children: [
                          for (var i = 0; i < items.length; i++)
                            _IgRow(
                              group: items[i],
                              peak: peak,
                              last: i == items.length - 1,
                            ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _PagedList<T> extends StatelessWidget {
  const _PagedList({
    required this.state,
    required this.onRefresh,
    required this.onRetry,
    required this.onLoadMore,
    required this.builder,
  });

  final AsyncValue<PagedState<T>> state;
  final Future<void> Function() onRefresh;
  final VoidCallback onRetry;
  final Future<void> Function() onLoadMore;
  final Widget Function(List<T> items) builder;

  @override
  Widget build(BuildContext context) {
    return state.when(
      skipError: true,
      skipLoadingOnReload: true,
      loading: () => const Center(child: MuDotsLoader()),
      error: (e, _) => ErrorRetryView(error: e, onRetry: onRetry),
      data: (paged) => MuRefresh(
        onRefresh: onRefresh,
        child: paged.items.isEmpty
            ? ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  MuStateDisplay(
                    variant: MuStateVariant.noResults,
                    size: MuStateSize.sm,
                  ),
                ],
              )
            : NotificationListener<ScrollNotification>(
                onNotification: (n) {
                  if (n.metrics.extentAfter < 400 &&
                      paged.hasMore &&
                      paged.loadMoreError == null) {
                    unawaited(onLoadMore());
                  }
                  return false;
                },
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
                    builder(paged.items),
                    if (paged.hasMore || paged.loadMoreError != null)
                      MuLoadMoreFooter(
                        isLoading: paged.isLoadingMore,
                        error: paged.loadMoreError,
                        onRetry: onLoadMore,
                      ),
                  ],
                ),
              ),
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

class _IgRow extends StatelessWidget {
  const _IgRow({required this.group, required this.peak, required this.last});

  final CampusIg group;

  /// The most campus members in any group shown, for the bar.
  final int peak;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final g = group;
    return MuFeedRow(
      leading: Container(
        width: MuSizes.avatarMd,
        height: MuSizes.avatarMd,
        decoration: BoxDecoration(
          color: c.surfaceSunk,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4),
        child: FittedBox(
          child: Text(
            g.code.isEmpty ? g.name.characters.first : g.code,
            style: mu.text.codeSm.copyWith(color: c.ink),
          ),
        ),
      ),
      subject: g.name,
      time: g.campusMemberCount == 1
          ? '1 member from your campus'
          : '${g.campusMemberCount} members from your campus',
      trailing: SizedBox(
        width: 56,
        child: MuBar(value: peak <= 0 ? 0 : g.campusMemberCount / peak),
      ),
      divider: !last,
      onTap: () => context.push(RoutePaths.interestGroupDetailPath(g.id)),
    );
  }
}
