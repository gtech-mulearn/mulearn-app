import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/notifications/unread_notifications.dart';

/// Refreshes the unread badge when the app comes back to the foreground —
/// only if it's stale ([unreadStaleAfter]). Wraps the signed-in shell.
class UnreadRefreshTriggers extends ConsumerStatefulWidget {
  const UnreadRefreshTriggers({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<UnreadRefreshTriggers> createState() => _UnreadRefreshTriggersState();
}

class _UnreadRefreshTriggersState extends ConsumerState<UnreadRefreshTriggers> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(
      onResume: () => ref.read(unreadNotificationsProvider.notifier).refreshIfStale(),
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
