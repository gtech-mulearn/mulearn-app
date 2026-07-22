import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/app/app_router.dart';
import 'package:mulearn_app/core/config/flavor_config.dart';
import 'package:mulearn_app/core/theme/mulearn_theme.dart';

/// Root widget. `MaterialApp.router` is driven by the go_router provider; theme
/// comes from the brand tokens (rules.md §8).
class MulearnApp extends ConsumerWidget {
  const MulearnApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'MuApp',
      debugShowCheckedModeBanner: FlavorConfig.instance.isDev,
      theme: MulearnTheme.light(),
      // The 2026-07 redesign's Mu* component library hardcodes light-theme
      // color literals (MuColors.canvas/surface, etc.) rather than resolving
      // through Theme.of(context), so it isn't dark-mode-aware. Left on
      // ThemeMode.system, a device in Dark Mode gets MulearnTheme.dark()'s
      // forced-white text over those still-light hardcoded backgrounds —
      // white-on-white. Pinning to light mode until the component library
      // gets real dark-mode variants.
      themeMode: ThemeMode.light,
      routerConfig: router,
    );
  }
}
