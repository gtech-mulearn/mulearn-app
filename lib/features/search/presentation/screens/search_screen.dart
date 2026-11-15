import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/search_debouncer.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_load_more_footer.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/search/domain/entities/campus_search_result.dart';
import 'package:mulearn_app/features/search/domain/entities/user_search_result.dart';
import 'package:mulearn_app/features/search/presentation/providers/search_controller.dart';

enum _Who { people, mentors, campuses }

/// Find people, mentors or campuses, like the dashboard's search pages:
/// each tab lists everyone until you type, then what matches, 30 at a time
/// as you scroll. Typing settles before it searches ([SearchDebouncer]);
/// each tab-and-query list is kept for a while ([UserSearch],
/// [CampusSearch]), so switching back costs no request. People open their
/// public profile; campuses their public page.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _queryController = TextEditingController();
  _Who _who = _Who.people;

  /// The query last sent (typing settles through [_debouncer]).
  String _searched = '';
  late final _debouncer = SearchDebouncer((q) {
    if (mounted) setState(() => _searched = q);
  });

  @override
  void dispose() {
    _debouncer.dispose();
    _queryController.dispose();
    super.dispose();
  }

  String _emptyPeople(String query, String? role) {
    final who = role == null ? 'members' : 'mentors';
    if (query.isEmpty) return 'No $who yet.';
    // The dashboard's SearchResults copy.
    return 'No $who match "$query". Try a different path and keep exploring.';
  }

  @override
  Widget build(BuildContext context) {
    final c = context.mu.colors;
    final query = _searched;
    final role = _who == _Who.mentors ? 'mentor' : null;

    return Scaffold(
      backgroundColor: c.chalk,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space3,
                MuSpacing.space2,
                MuSpacing.space5,
                0,
              ),
              child: Row(
                children: [
                  MuIconButton(
                    icon: LucideIcons.arrowLeft,
                    tooltip: 'Back',
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                  const SizedBox(width: MuSpacing.space1),
                  Expanded(
                    child: MuSearchField(
                      controller: _queryController,
                      hint: _who == _Who.campuses
                          ? 'Campus name or code'
                          : 'Name or muid',
                      onChanged: _debouncer.onChanged,
                      onSubmitted: _debouncer.submit,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space5,
                MuSpacing.space3,
                MuSpacing.space5,
                0,
              ),
              child: MuSegmented<_Who>(
                values: _Who.values,
                selected: _who,
                label: (w) => switch (w) {
                  _Who.people => 'People',
                  _Who.mentors => 'Mentors',
                  _Who.campuses => 'Campuses',
                },
                onChanged: (w) => setState(() => _who = w),
              ),
            ),
            Expanded(
              child: _who == _Who.campuses
                  ? _Results<CampusSearchResult>(
                      key: ValueKey('campuses|$query'),
                      state: ref.watch(campusSearchProvider(query)),
                      onRefresh: () =>
                          ref.refresh(campusSearchProvider(query).future),
                      onRetry: () =>
                          ref.invalidate(campusSearchProvider(query)),
                      onLoadMore: () => ref
                          .read(campusSearchProvider(query).notifier)
                          .loadMore(),
                      empty: query.isEmpty
                          ? 'No campuses yet.'
                          : 'No campus matches "$query". Try its short code, like CET.',
                      list: (items) => [
                        for (var i = 0; i < items.length; i++) ...[
                          if (i > 0) const SizedBox(height: MuSpacing.space3),
                          _CampusRow(campus: items[i]),
                        ],
                      ],
                    )
                  : _Results<UserSearchResult>(
                      key: ValueKey('$role|$query'),
                      state: ref.watch(userSearchProvider(query, role)),
                      onRefresh: () =>
                          ref.refresh(userSearchProvider(query, role).future),
                      onRetry: () =>
                          ref.invalidate(userSearchProvider(query, role)),
                      onLoadMore: () => ref
                          .read(userSearchProvider(query, role).notifier)
                          .loadMore(),
                      empty: _emptyPeople(query, role),
                      list: (items) => [
                        MuFeedGroup(
                          children: [
                            for (var i = 0; i < items.length; i++)
                              _ResultRow(
                                result: items[i],
                                last: i == items.length - 1,
                              ),
                          ],
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

/// A search list: loading, an error with retry, the empty copy, or the rows
/// with pull to refresh and the next page loading as the end comes near.
class _Results<T> extends StatelessWidget {
  const _Results({
    required this.state,
    required this.onRefresh,
    required this.onRetry,
    required this.onLoadMore,
    required this.empty,
    required this.list,
    super.key,
  });

  final AsyncValue<PagedState<T>> state;
  final Future<void> Function() onRefresh;
  final VoidCallback onRetry;
  final Future<void> Function() onLoadMore;
  final String empty;
  final List<Widget> Function(List<T> items) list;

  @override
  Widget build(BuildContext context) => state.when(
    skipError: true,
    loading: () => const Center(child: MuDotsLoader(label: 'Searching…')),
    error: (e, _) => ErrorRetryView(error: e, onRetry: onRetry),
    data: (paged) {
      if (paged.items.isEmpty) {
        return MuRefresh(
          onRefresh: onRefresh,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              MuStateDisplay(
                variant: MuStateVariant.noResults,
                size: MuStateSize.sm,
                description: empty,
              ),
            ],
          ),
        );
      }
      return MuRefresh(
        onRefresh: onRefresh,
        child: NotificationListener<ScrollNotification>(
          onNotification: (n) {
            if (n.metrics.extentAfter < 600 &&
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
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.fromLTRB(
              MuSpacing.space5,
              MuSpacing.space4,
              MuSpacing.space5,
              MuSpacing.space8,
            ),
            children: [
              ...list(paged.items),
              if (paged.hasMore || paged.loadMoreError != null)
                MuLoadMoreFooter(
                  isLoading: paged.isLoadingMore,
                  error: paged.loadMoreError,
                  onRetry: () => unawaited(onLoadMore()),
                ),
            ],
          ),
        ),
      );
    },
  );
}

class _ResultRow extends StatelessWidget {
  const _ResultRow({required this.result, required this.last});

  final UserSearchResult result;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final org = result.organization;
    return MuFeedRow(
      leading: MuAvatar(
        name: result.fullName,
        url: result.profilePicUrl,
        size: MuSizes.avatarMd,
        ring: false,
      ),
      subject: result.fullName,
      time: [result.muid, if (org != null && org.isNotEmpty) org].join(' · '),
      trailing: MuFeedAmount(muGrouped(result.karma)),
      divider: !last,
      onTap: () => context.push(RoutePaths.publicProfilePath(result.muid)),
    );
  }
}

class _CampusRow extends StatelessWidget {
  const _CampusRow({required this.campus});

  final CampusSearchResult campus;

  @override
  Widget build(BuildContext context) {
    final c = campus;
    final place = [?c.district, ?c.zone].join(' · ');
    return MuCampusCrest(
      code: c.code.isEmpty ? null : c.code,
      name: c.title,
      caption: [
        if (c.isSchool) 'School',
        if (place.isNotEmpty) place,
        if (c.learners == 1)
          '1 learner'
        else
          '${muGrouped(c.learners)} learners',
      ].join(' · '),
      trailing: Icon(
        LucideIcons.chevronRight,
        size: MuSizes.iconSm + 2,
        color: context.mu.colors.ink3,
      ),
      onTap: () => context.push(RoutePaths.publicCampusPath(c.id)),
    );
  }
}
