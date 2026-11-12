import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_event_bus.g.dart';

/// Profile-level events broadcast across features.
enum ProfileEvent {
  /// The signed-in user's own profile photo, cover photo, or basic info
  /// changed.
  updated,
}

/// A one-to-many bus that lets `features/profile` signal
/// `features/dashboard` (and any other feature) that the signed-in user's
/// own profile changed, without a direct cross-feature import (rules.md
/// §2) — mirrors [SessionEventBus]'s pattern. `features/dashboard`'s
/// `MyProgressSummaryController` and `features/profile`'s
/// `ProfileController` both independently cache their own read-model of
/// the same `dashboard/profile/user-profile/` endpoint, so a mutation in
/// one doesn't otherwise invalidate the other's cache.
class ProfileEventBus {
  final _controller = StreamController<ProfileEvent>.broadcast();

  Stream<ProfileEvent> get events => _controller.stream;

  void emit(ProfileEvent event) {
    if (!_controller.isClosed) _controller.add(event);
  }

  void dispose() => _controller.close();
}

@Riverpod(keepAlive: true)
ProfileEventBus profileEventBus(Ref ref) {
  final bus = ProfileEventBus();
  ref.onDispose(bus.dispose);
  return bus;
}
