import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/navigation/mu_nav_capsule.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/notifications/unread_notifications.dart';
import 'package:mulearn_app/core/notifications/unread_refresh_triggers.dart';
import 'package:mulearn_app/core/session/discord_resume_check.dart';

/// Bottom-navigation shell for the five signed-in top-level destinations
/// (Home, Tasks, Journey, Ranks, You) — the `builder` for the router's
/// `StatefulShellRoute.indexedStack`, which preserves each branch's own
/// navigation/scroll state when switching tabs. Circles was demoted from a
/// tab to a pushed route (reached from Home) and Journey was promoted from a
/// Profile-internal tab to a top-level destination, matching the redesign.
///
/// Also where the unread badge's refresh triggers live: app resume
/// ([UnreadRefreshTriggers]) and selecting the Home tab, both only when the
/// count is stale — nothing polls.
class MainShell extends ConsumerWidget {
  const MainShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  static const _items = [
    MuNavItem(icon: LucideIcons.home, label: 'Home'),
    MuNavItem(icon: LucideIcons.checkSquare, label: 'Tasks'),
    MuNavItem(icon: LucideIcons.milestone, label: 'Journey'),
    MuNavItem(icon: LucideIcons.trophy, label: 'Ranks'),
    MuNavItem(icon: LucideIcons.user, label: 'You'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Status-bar icons follow the design system palette (dark on light
    // chalk, light on dark chalk).
    final dark = context.mu.colors.chalk.computeLuminance() < 0.5;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        extendBody: true,
        body: UnreadRefreshTriggers(
          child: DiscordResumeCheck(child: navigationShell),
        ),
        bottomNavigationBar: MuNavCapsule(
          items: _items,
          currentIndex: navigationShell.currentIndex,
          onSelect: (index) {
            if (index == 0) {
              unawaited(
                ref.read(unreadNotificationsProvider.notifier).refreshIfStale(),
              );
            }
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
        ),
      ),
    );
  }
}
