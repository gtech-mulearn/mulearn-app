import 'package:flutter/material.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';

/// Pins a [TabBar] as a sliver header below a scrollable header — the
/// standard adapter Flutter requires to place a fixed-height widget inside
/// [NestedScrollView.headerSliverBuilder]. Shared by [ProfileScreen] and
/// [PublicProfileScreen].
class TabBarSliverDelegate extends SliverPersistentHeaderDelegate {
  const TabBarSliverDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: context.mu.colors.chalk,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant TabBarSliverDelegate oldDelegate) =>
      tabBar != oldDelegate.tabBar;
}
