import 'package:flutter/material.dart';

/// Shadow tokens (rules.md §8) — 2026-09 redesign (Phase 1 of the Claude
/// Design import). Soft, large-blur only; no other shadows anywhere in the
/// app. Cards on gradient/dark backgrounds need no shadow at all — contrast
/// does the work.
abstract final class MuShadow {
  const MuShadow._();

  /// Resting card lift — task cards, resume card, circle card.
  /// CSS: `0 2px 8px rgba(26,26,26,.04)`.
  static const List<BoxShadow> card = [
    BoxShadow(color: Color(0x0A1A1A1A), blurRadius: 8, offset: Offset(0, 2)),
  ];

  /// Card hover lift (pair with `translateY(-2px)` where the widget
  /// supports a pressed/hover transform). CSS: `0 10px 26px -14px
  /// rgba(26,26,26,.3)`.
  static const List<BoxShadow> cardHover = [
    BoxShadow(color: Color(0x4D1A1A1A), blurRadius: 26, offset: Offset(0, 10), spreadRadius: -14),
  ];

  /// Deep hero shadow — dark hero cards (home karma card, IG detail hero,
  /// current-level card). CSS: `0 18px 40px -18px rgba(26,26,26,.6)`.
  static const List<BoxShadow> hero = [
    BoxShadow(color: Color(0x991A1A1A), blurRadius: 40, offset: Offset(0, 18), spreadRadius: -18),
  ];

  /// Primary button glow. CSS: `0 14px 28px -14px rgba(46,133,254,.9)`.
  static const List<BoxShadow> buttonGlow = [
    BoxShadow(color: Color(0xE62E85FE), blurRadius: 28, offset: Offset(0, 14), spreadRadius: -14),
  ];

  /// Toast shadow. CSS: `0 16px 30px -12px rgba(0,0,0,.5)`.
  static const List<BoxShadow> toast = [
    BoxShadow(color: Color(0x80000000), blurRadius: 30, offset: Offset(0, 16), spreadRadius: -12),
  ];

  /// Floating tab-bar shadow (two-layer). CSS: `0 2px 6px rgba(26,26,26,.06),
  /// 0 18px 36px -16px rgba(26,26,26,.35)`. Pair with `BackdropFilter` blur
  /// and a translucent white background on the bar itself.
  static const List<BoxShadow> nav = [
    BoxShadow(color: Color(0x0F1A1A1A), blurRadius: 6, offset: Offset(0, 2)),
    BoxShadow(color: Color(0x591A1A1A), blurRadius: 36, offset: Offset(0, 18), spreadRadius: -16),
  ];
}
