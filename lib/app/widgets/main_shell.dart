import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/widgets/mu_bottom_nav.dart';

/// Bottom-navigation shell for the four signed-in top-level destinations
/// (Home, Circles, Leaderboard, Profile) — the `builder` for the router's
/// `StatefulShellRoute.indexedStack`, which preserves each branch's own
/// navigation/scroll state when switching tabs.
class MainShell extends StatelessWidget {
  const MainShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  static const _items = [
    MuNavItem(icon: LucideIcons.home, label: 'Home'),
    MuNavItem(icon: LucideIcons.listChecks, label: 'Circles'),
    MuNavItem(icon: LucideIcons.trophy, label: 'Leaderboard'),
    MuNavItem(icon: LucideIcons.user, label: 'Profile'),
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
