import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_event_bus.g.dart';

/// Session-level events broadcast from the network layer.
enum SessionEvent {
  /// Token refresh failed unrecoverably; the user must be signed out.
  expired,
}

/// A one-to-many bus that lets the auth interceptor (in `core/`, which must not
/// import `features/`) signal the auth controller (in `features/auth/`) without
/// a direct dependency. The interceptor emits [SessionEvent.expired]; the auth
/// controller listens and flips itself to signed-out, which the router redirect
/// then picks up (rules.md §2, §3).
class SessionEventBus {
  final _controller = StreamController<SessionEvent>.broadcast();

  Stream<SessionEvent> get events => _controller.stream;

  void emit(SessionEvent event) {
    if (!_controller.isClosed) _controller.add(event);
  }

  void dispose() => _controller.close();
}

@Riverpod(keepAlive: true)
SessionEventBus sessionEventBus(Ref ref) {
  final bus = SessionEventBus();
  ref.onDispose(bus.dispose);
  return bus;
}
