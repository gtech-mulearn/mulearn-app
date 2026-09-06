import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/widgets/mu_bottom_nav.dart';

/// Bottom-navigation shell for the five signed-in top-level destinations
/// (Home, Tasks, Journey, Ranks, You) — the `builder` for the router's
/// `StatefulShellRoute.indexedStack`, which preserves each branch's own
/// navigation/scroll state when switching tabs. Circles was demoted from a
/// tab to a pushed route (reached from Home) and Journey was promoted from a
/// Profile-internal tab to a top-level destination, matching the redesign.
class MainShell extends StatelessWidget {
  const MainShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  static const _items = [
    MuNavItem(icon: LucideIcons.home, label: 'Home'),
    MuNavItem(icon: LucideIcons.listTodo, label: 'Tasks'),
    MuNavItem(icon: LucideIcons.flag, label: 'Journey'),
    MuNavItem(icon: LucideIcons.trophy, label: 'Ranks'),
    MuNavItem(icon: LucideIcons.user, label: 'You'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: MuBottomNav(
        items: _items,
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}
