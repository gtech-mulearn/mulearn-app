import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

/// Wraps [HapticFeedback] to work around a real Android platform gap:
/// `.lightImpact()/.mediumImpact()/.heavyImpact()/.selectionClick()` all go
/// through `View.performHapticFeedback()`, which respects the device's
/// system-wide "Touch feedback" / "Vibrate on tap" setting — if a user has
/// that disabled (not uncommon on some phones/OEM skins), these silently
/// no-op even with the app's `VIBRATE` permission and code both correct.
/// Confirmed by real user reports on real Android devices.
///
/// `HapticFeedback.vibrate()` instead drives the vibrator motor directly
/// and isn't gated by that setting, so on Android every level below
/// collapses to that one call (losing the light/medium/heavy distinction
/// there, in exchange for actually vibrating). iOS's Taptic Engine calls
/// already work correctly and are left untouched.
class MuHaptics {
  const MuHaptics._();

  static void light() => _fire(HapticFeedback.lightImpact);
  static void medium() => _fire(HapticFeedback.mediumImpact);
  static void heavy() => _fire(HapticFeedback.heavyImpact);
  static void selection() => _fire(HapticFeedback.selectionClick);

  static void _fire(Future<void> Function() iosCall) {
    if (!kIsWeb && Platform.isAndroid) {
      HapticFeedback.vibrate();
    } else {
      iosCall();
    }
  }
}
