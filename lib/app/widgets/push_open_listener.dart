import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/app/app_router.dart';
import 'package:mulearn_app/core/config/flavor_config.dart';
import 'package:mulearn_app/core/notifications/push/push_controller.dart';
import 'package:mulearn_app/core/notifications/push/push_messaging.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/features/notifications/domain/notification_target.dart';
import 'package:mulearn_app/features/notifications/domain/push_target.dart';
import 'package:url_launcher/url_launcher.dart';

/// Starts push handling for the whole app and routes tapped pushes: while
/// running, from the background, and the one that launched the app. A tap
/// while signed out goes through sign-in and resumes (the router's `from`).
class PushOpenListener extends ConsumerStatefulWidget {
  const PushOpenListener({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<PushOpenListener> createState() => _PushOpenListenerState();
}

class _PushOpenListenerState extends ConsumerState<PushOpenListener> {
  StreamSubscription<PushOpen>? _opens;

  @override
  void initState() {
    super.initState();
    final messaging = ref.read(pushMessagingProvider);
    if (!messaging.available) return;
    // Creates the controller: channel, listeners, token registration.
    ref.read(pushControllerProvider);
    _opens = messaging.opens.listen(_handle);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final first = await messaging.takeInitialOpen();
      if (first != null && mounted) _handle(first);
    });
  }

  void _handle(PushOpen open) {
    final key = open.dedupeKey;
    if (key != null) {
      unawaited(
        ref
            .read(pushRemoteDataSourceProvider)
            .reportOpened(key)
            .catchError(
              (Object e) => appLogger.w('push: open report failed', error: e),
            ),
      );
    }
    final target = pushTarget(
      open,
      dashboardBase: Uri.parse(FlavorConfig.instance.dashboardUrl),
    );
    final router = ref.read(goRouterProvider);
    switch (target) {
      case AppRoute(:final location):
        if (RoutePaths.tabRoots.contains(location)) {
          router.go(location);
        } else {
          unawaited(router.push(location));
        }
      case WebPage(:final uri):
        unawaited(launchUrl(uri, mode: LaunchMode.externalApplication));
      case NoTarget():
        break;
    }
  }

  @override
  void dispose() {
    unawaited(_opens?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
