import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/app/app_router.dart';
import 'package:mulearn_app/core/config/flavor_config.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/theme/appearance.dart';
import 'package:mulearn_app/core/theme/mulearn_theme.dart';

/// Root widget. `MaterialApp.router` is driven by the go_router provider; theme
/// comes from the brand tokens (rules.md §8).
class MulearnApp extends ConsumerWidget {
  const MulearnApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Mulearn',
      debugShowCheckedModeBanner: FlavorConfig.instance.isDev,
      // The design system (core/design_system) rides on the current theme
      // as an extension, so migrated widgets read context.mu while screens
      // not yet migrated keep their look. MuThemeData replaces this once the
      // last screen moves over (plan 5).
      theme: MulearnTheme.light().copyWith(extensions: [MuTheme.light()]),
      // Follows the phone's dark mode. The Material base stays the light
      // one on purpose: screens not yet migrated hard-code light colours
      // (MuColors.canvas/surface…), and MulearnTheme.dark()'s white text over
      // them was white-on-white. Only the design system's palette switches,
      // so migrated screens go dark and old ones keep their light look until
      // they move over.
      darkTheme: MulearnTheme.light().copyWith(extensions: [MuTheme.dark()]),
      // System by default; Settings → Appearance can pin Light or Dark.
      themeMode: ref.watch(appearanceProvider),
      routerConfig: router,
    );
  }
}
