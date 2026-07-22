import 'package:flutter/material.dart';

/// μLearn brand color tokens — single source of truth (rules.md §8).
///
/// 2026-07 redesign palette: calm blue foundation with a lime-green energy
/// accent. Never hardcode a hex value inline in a widget; reference these
/// constants.
abstract final class MuColors {
  const MuColors._();

  // --- Brand blues ---

  /// Core actions, links, active states.
  static const Color primary = Color(0xFF2E5BFF);

  /// Gradient start, headers.
  static const Color primaryDeep = Color(0xFF1A2FBF);

  /// Gradient end, glows.
  static const Color primaryBright = Color(0xFF3D7BFF);

  /// Tinted icon-button bg, selected chip bg.
  static const Color primaryTint = Color(0xFFE8EEFF);

  /// Tinted info cards (e.g. attachments).
  static const Color primarySoft = Color(0xFFD6E4FF);

  // --- Energy accent (lime — CTAs that reward action) ---

  static const Color lime = Color(0xFFC8F169);

  /// Success, live indicators, streaks.
  static const Color limeBright = Color(0xFF5CE65C);

  /// Text on lime.
  static const Color limeInk = Color(0xFF14210A);

  // --- Alert accent (used sparingly) ---

  static const Color coral = Color(0xFFFF4B33);

  // --- Neutrals ---

  /// Primary text, black pill nav.
  static const Color ink = Color(0xFF0B0F1A);

  /// Secondary text.
  static const Color inkSecondary = Color(0xFF5A6072);

  /// Labels, placeholders.
  static const Color inkTertiary = Color(0xFF9AA0AE);

  /// Cards.
  static const Color surface = Color(0xFFFFFFFF);

  /// Scaffold bg on light/utility screens.
  static const Color canvas = Color(0xFFF4F5F8);

  static const Color divider = Color(0xFFE7E9EF);

  /// Semantic error — matches [coral].
  static const Color error = coral;

  // --- Leaderboard medal colors (not brand tokens — universal medal hues) ---

  static const Color rankGold = Color(0xFFFFC107);
  static const Color rankSilver = Color(0xFFB0BEC5);
  static const Color rankBronze = Color(0xFFBF8A5D);

  // --- Stat-badge accents (Home dashboard's Karma/Level/Rank icon chips) ---

  static const Color statKarmaTint = Color(0xFFE9FBDA);
  static const Color statKarmaAccent = Color(0xFF2E7D1E);
  static const Color statLevelTint = Color(0xFFEDE7FF);
  static const Color statLevelAccent = Color(0xFF6C3CE9);
  static const Color statRankTint = Color(0xFFFFF3D6);

  // --- Gradients ---

  /// Full-bleed immersive-screen background (Profile, Leaderboard).
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryDeep, primaryBright],
  );

  /// Soft pastel lavender wash — Home's header background (a lighter,
  /// airier variant of [heroGradient] for the dark-text-on-light header
  /// style, opted into via `MuGradientHeader(light: true)`).
  static const LinearGradient homeHeaderGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFEDEEFB), Color(0xFFDEE1F7)],
  );
}
