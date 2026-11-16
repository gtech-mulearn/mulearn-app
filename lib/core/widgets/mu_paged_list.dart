import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/widgets/mu_load_more_footer.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';

/// A paged list that builds only the rows on screen, however many pages
/// have loaded (production lists run to thousands: circles, students,
/// notifications…), and asks for the next page as its last rows come into
/// view — which also works when a short first page doesn't fill the screen.
///
/// A sliver: put it in a [CustomScrollView] under any header slivers, or
/// use [MuPagedListView] for the usual header + list + pull-to-refresh.
/// [onLoadMore] is also the footer's retry; controllers guard against a
/// second call while one is in flight.
class MuPagedSliverList<T> extends StatelessWidget {
  const MuPagedSliverList({
    required this.state,
    required this.itemBuilder,
    required this.onLoadMore,
    this.gap = MuSpacing.space3,
    this.grouped = false,
    this.groupInset = MuSpacing.space4,
    this.prefetch = 5,
    super.key,
  });

  final PagedState<T> state;

  /// A row. With [grouped], rows sit on one card (see [MuFeedGroupSlice]);
  /// pass `divider: index < state.items.length - 1` to a [MuFeedRow].
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Future<void> Function() onLoadMore;

  /// Space between rows (ignored when [grouped]).
  final double gap;

  /// Rows on a single card, like [MuFeedGroup], built row by row.
  final bool grouped;

  /// The card's side padding when [grouped] ([MuFeedGroup]'s by default;
  /// `MuSpacing.space5` matches `MuOpportunityGroup`).
  final double groupInset;

  /// How many rows before the end the next page is asked for.
  final int prefetch;

  void _maybeLoadMore() {
    if (!state.hasMore || state.isLoadingMore || state.loadMoreError != null) {
      return;
    }
    // Not during build: the controller changes state when it starts.
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => unawaited(onLoadMore()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = state.items;
    final footer = state.hasMore || state.loadMoreError != null;
    return SliverList.builder(
      itemCount: items.length + (footer ? 1 : 0),
      itemBuilder: (context, i) {
        if (i >= items.length) {
          return Padding(
            padding: EdgeInsets.only(top: grouped ? MuSpacing.space3 : gap),
            child: MuLoadMoreFooter(
              isLoading: state.isLoadingMore,
              error: state.loadMoreError,
              onRetry: () => unawaited(onLoadMore()),
            ),
          );
        }
        if (i >= items.length - prefetch) _maybeLoadMore();
        final row = itemBuilder(context, items[i], i);
        if (grouped) {
          return MuFeedGroupSlice(
            first: i == 0,
            last: i == items.length - 1,
            inset: groupInset,
            child: row,
          );
        }
        return i == 0
            ? row
            : Padding(
                padding: EdgeInsets.only(top: gap),
                child: row,
              );
      },
    );
  }
}

/// One row's share of a [MuFeedGroup] card, so a long grouped list can be
/// built row by row: the card's fill and side padding, with the top
/// corners on the [first] row and the bottom ones on the [last].
class MuFeedGroupSlice extends StatelessWidget {
  const MuFeedGroupSlice({
    required this.child,
    required this.first,
    required this.last,
    this.inset = MuSpacing.space4,
    super.key,
  });

  final Widget child;
  final bool first;
  final bool last;

  /// Side padding: the card's.
  final double inset;

  @override
  Widget build(BuildContext context) {
    const r = Radius.circular(MuRadii.card);
    return Container(
      padding: EdgeInsets.fromLTRB(
        inset,
        first ? MuSpacing.space1 : 0,
        inset,
        last ? MuSpacing.space1 : 0,
      ),
      decoration: BoxDecoration(
        color: context.mu.colors.surface,
        borderRadius: BorderRadius.only(
          topLeft: first ? r : Radius.zero,
          topRight: first ? r : Radius.zero,
          bottomLeft: last ? r : Radius.zero,
          bottomRight: last ? r : Radius.zero,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}

/// The usual paged screen body: [header] widgets, then the lazily built
/// rows, with pull-to-refresh. [empty] replaces the rows when the first
/// page has none.
class MuPagedListView<T> extends StatelessWidget {
  const MuPagedListView({
    required this.state,
    required this.itemBuilder,
    required this.onLoadMore,
    this.onRefresh,
    this.header = const [],
    this.empty,
    this.padding = muListPadding,
    this.gap = MuSpacing.space3,
    this.grouped = false,
    this.controller,
    super.key,
  });

  final PagedState<T> state;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Future<void> Function() onLoadMore;
  final Future<void> Function()? onRefresh;
  final List<Widget> header;
  final Widget? empty;
  final EdgeInsets padding;
  final double gap;
  final bool grouped;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    final view = CustomScrollView(
      controller: controller,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        SliverPadding(
          padding: padding,
          sliver: SliverMainAxisGroup(
            slivers: [
              for (final h in header) SliverToBoxAdapter(child: h),
              if (state.items.isEmpty && empty != null)
                SliverToBoxAdapter(child: empty)
              else
                MuPagedSliverList<T>(
                  state: state,
                  itemBuilder: itemBuilder,
                  onLoadMore: onLoadMore,
                  gap: gap,
                  grouped: grouped,
                ),
            ],
          ),
        ),
      ],
    );
    final refresh = onRefresh;
    return refresh == null ? view : MuRefresh(onRefresh: refresh, child: view);
  }
}
