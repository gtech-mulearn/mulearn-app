import 'package:flutter/material.dart';

/// Shadow tokens (rules.md §8) — 2026-07 redesign. Soft, large-blur only; no
/// other shadows anywhere in the app. Cards on gradient backgrounds need no
/// shadow at all — contrast does the work.
abstract final class MuShadow {
  const MuShadow._();

  static const List<BoxShadow> card = [
    BoxShadow(color: Color(0x140B0F1A), blurRadius: 24, offset: Offset(0, 8)),
  ];

  static const List<BoxShadow> nav = [
    BoxShadow(color: Color(0x260B0F1A), blurRadius: 32, offset: Offset(0, 12)),
  ];
}
