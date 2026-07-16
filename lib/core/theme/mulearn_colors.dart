import 'package:flutter/material.dart';

/// μLearn brand color tokens — single source of truth (rules.md §8).
///
/// Ported 1:1 from the landing page's CSS custom properties. Never hardcode a
/// hex value inline in a widget; reference these constants.
abstract final class MulearnColors {
  const MulearnColors._();

  /// Primary blue — `#0961F5`.
  static const Color primary = Color(0xFF0961F5);

  /// Gradient start — trusty blue `#2E85FE`.
  static const Color trustyBlue = Color(0xFF2E85FE);

  /// Gradient end — duke purple `#AF2EE6`.
  static const Color dukePurple = Color(0xFFAF2EE6);

  /// Supporting neutral — greyish `#C4C4C4`.
  static const Color greyish = Color(0xFFC4C4C4);

  /// Supporting neutral — blackish `#1A1A1A`.
  static const Color blackish = Color(0xFF1A1A1A);

  /// Supporting neutral — whitish `#FEFEFE`.
  static const Color whitish = Color(0xFFFEFEFE);

  /// Muted text — gray-600 `#666771`.
  static const Color gray600 = Color(0xFF666771);

  /// Semantic error (Material default red kept intentionally).
  static const Color error = Color(0xFFB3261E);

  /// Leaderboard rank-1 badge (not a brand token — a universal medal color).
  static const Color rankGold = Color(0xFFFFC107);

  /// Leaderboard rank-2 badge.
  static const Color rankSilver = Color(0xFFB0BEC5);

  /// Leaderboard rank-3 badge.
  static const Color rankBronze = Color(0xFFBF8A5D);
}
