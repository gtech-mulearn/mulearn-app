import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_load_more_footer.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_groups.dart';
import 'package:mulearn_app/features/campus/presentation/providers/campus_groups_controllers.dart';

/// The campus's circles and interest groups (K3), most members first. Rows
/// open the existing circle and group pages; the per-group member lists
/// (`<id>/members/`) return 500 on dev and aren't used.
class CampusGroupsScreen extends ConsumerStatefulWidget {
  const CampusGroupsScreen({super.key});

  @override
  ConsumerState<CampusGroupsScreen> createState() => _CampusGroupsScreenState();
}

class _CampusGroupsScreenState extends ConsumerState<CampusGroupsScreen> {
  final _search = TextEditingController();
  Timer? _debounce;
  String _query = '';

  @override
  void dispose() {
    _debounce?.cancel();
    _search.dispose();
    super.dispose();
  }

  void _onSearch(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _query = value.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: MuColors.canvas,
        appBar: AppBar(
          backgroundColor: MuColors.canvas,
          elevation: 0,
          title: const Text('Circles and groups'),
          bottom: const TabBar(tabs: [Tab(text: 'Circles'), Tab(text: 'Interest groups')]),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.m, MuSpace.screenH, MuSpace.s),
              child: TextField(
                controller: _search,
                onChanged: _onSearch,
                textInputAction: TextInputAction.search,
                decoration: const InputDecoration(hintText: 'Search', prefixIcon: Icon(LucideIcons.search, size: 18)),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _PagedList<CampusCircle>(
                    state: ref.watch(campusCirclesControllerProvider(_query)),
                    onRefresh: () => ref.refresh(campusCirclesControllerProvider(_query).future),
                    onRetry: () => ref.invalidate(campusCirclesControllerProvider(_query)),
                    onLoadMore: () => ref.read(campusCirclesControllerProvider(_query).notifier).loadMore(),
                    itemBuilder: (c) => _CircleTile(circle: c),
                  ),
                  _PagedList<CampusIg>(
                    state: ref.watch(campusIgsControllerProvider(_query)),
                    onRefresh: () => ref.refresh(campusIgsControllerProvider(_query).future),
                    onRetry: () => ref.invalidate(campusIgsControllerProvider(_query)),
                    onLoadMore: () => ref.read(campusIgsControllerProvider(_query).notifier).loadMore(),
                    itemBuilder: (g) => _IgTile(group: g),
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
  final Widget Function(T item) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return state.when(
      skipError: true,
      skipLoadingOnReload: true,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => ErrorRetryView(error: e, onRetry: onRetry),
      data: (paged) => MuRefresh(
        onRefresh: onRefresh,
        child: paged.items.isEmpty
            ? ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [MuStateDisplay(variant: MuStateVariant.noResults, size: MuStateSize.sm)],
              )
            : NotificationListener<ScrollNotification>(
                onNotification: (n) {
                  if (n.metrics.extentAfter < 400 && paged.hasMore && paged.loadMoreError == null) unawaited(onLoadMore());
                  return false;
                },
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.s, MuSpace.screenH, MuSpace.xxl),
                  children: [
                    for (final item in paged.items) itemBuilder(item),
                    if (paged.hasMore || paged.loadMoreError != null)
                      MuLoadMoreFooter(isLoading: paged.isLoadingMore, error: paged.loadMoreError, onRetry: onLoadMore),
                  ],
                ),
              ),
      ),
    );
  }
}

class _CircleTile extends ConsumerWidget {
  const _CircleTile({required this.circle});

  final CampusCircle circle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = circle;
    final now = ref.watch(clockProvider)();
    final last = c.lastMeetingTime;
    final when = last == null
        ? 'No meetings yet'
        : last.isAfter(now)
            ? 'Next meets ${formatDayHeading(last.toLocal(), now.toLocal())}'
            : 'Last met ${formatAgo(last.toLocal(), now.toLocal())}';
    return Padding(
      padding: const EdgeInsets.only(bottom: MuSpace.s),
      child: MuCard(
        onTap: () => context.push(RoutePaths.learningCircleDetailPath(c.id)),
        padding: const EdgeInsets.fromLTRB(MuSpace.l, MuSpace.m, MuSpace.s, MuSpace.m),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(c.name, style: MuType.bodyMed, maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(
                    [
                      if (c.igName.isNotEmpty) c.igName,
                      '${c.memberCount} ${c.memberCount == 1 ? 'member' : 'members'}',
                      '${c.meetingCount} ${c.meetingCount == 1 ? 'meeting' : 'meetings'}',
                    ].join(' · '),
                    style: MuType.caption,
                  ),
                  Text(when, style: MuType.caption),
                ],
              ),
            ),
            const Icon(LucideIcons.chevronRight, size: 18, color: MuColors.inkSecondary),
          ],
        ),
      ),
    );
  }
}

class _IgTile extends StatelessWidget {
  const _IgTile({required this.group});

  final CampusIg group;

  @override
  Widget build(BuildContext context) {
    final g = group;
    return Padding(
      padding: const EdgeInsets.only(bottom: MuSpace.s),
      child: MuCard(
        onTap: () => context.push(RoutePaths.interestGroupDetailPath(g.id)),
        padding: const EdgeInsets.fromLTRB(MuSpace.l, MuSpace.m, MuSpace.s, MuSpace.m),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(child: Text(g.name, style: MuType.bodyMed, overflow: TextOverflow.ellipsis)),
                      if (g.code.isNotEmpty) ...[
                        const SizedBox(width: MuSpace.s),
                        Text(g.code, style: MuType.caption),
                      ],
                    ],
                  ),
                  Text(
                    g.campusMemberCount == 1 ? '1 member from your campus' : '${g.campusMemberCount} members from your campus',
                    style: MuType.caption,
                  ),
                ],
              ),
            ),
            const Icon(LucideIcons.chevronRight, size: 18, color: MuColors.inkSecondary),
          ],
        ),
      ),
    );
  }
}
