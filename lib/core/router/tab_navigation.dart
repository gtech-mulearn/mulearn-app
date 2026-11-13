import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/router/route_paths.dart';

/// Opens a bottom-bar tab by switching the shell's branch. Pushing a tab
/// root instead stacks a second copy of the tab over the shell and leaves
/// the bottom bar on the old tab (UX-09/REL-06).
extension TabNavigation on BuildContext {
  void openTab(String tabRoot) {
    assert(RoutePaths.tabRoots.contains(tabRoot), '$tabRoot is not a tab root');
    go(tabRoot);
  }
}
