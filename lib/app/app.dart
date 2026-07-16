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
      title: 'μLearn',
      debugShowCheckedModeBanner: FlavorConfig.instance.isDev,
      theme: MulearnTheme.light(),
      darkTheme: MulearnTheme.dark(),
      routerConfig: router,
    );
  }
}
