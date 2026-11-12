import 'package:flutter/material.dart';

/// μLearn brand color tokens — single source of truth (rules.md §8).
///
/// 2026-09 redesign palette (Phase 1 of the Claude Design import): calm blue
/// foundation (`#2E85FE`) with a karma/reward purple energy accent
/// (`#AF2EE6`), replacing the previous lime accent family. Never hardcode a
/// hex value inline in a widget; reference these constants.
abstract final class MuColors {
  const MuColors._();

  // --- Brand blues ---

  /// Core actions, links, active states, primary CTA fill.
  static const Color primary = Color(0xFF2E85FE);

  /// Hover/pressed state of [primary] buttons and links.
  static const Color primaryHover = Color(0xFF1B6FE0);

  /// Gradient start, headers. Unchanged by the 2026-09 palette pass — still
  /// used by [heroGradient], which is out of scope for this pass.
  static const Color primaryDeep = Color(0xFF1A2FBF);

  /// Gradient end, glows. Unchanged by the 2026-09 palette pass — still used
  /// by [heroGradient], which is out of scope for this pass.
  static const Color primaryBright = Color(0xFF3D7BFF);

  /// Tinted icon-button bg, selected chip bg, IG-tag pill bg.
  static const Color primaryTint = Color(0xFFE7F0FF);

  /// Tinted info cards (e.g. attachments). Unchanged by this pass.
  static const Color primarySoft = Color(0xFFD6E4FF);

  // --- Karma / energy accent (purple — replaces the retired lime family) ---

  /// Karma icon, "NEW" badge, streak marks, energy/reward CTA accents.
  static const Color karmaAccent = Color(0xFFAF2EE6);

  /// Light tint of [karmaAccent] for pill/badge backgrounds — same
  /// saturation profile as [primaryTint].
  static const Color karmaAccentTint = Color(0xFFF6E7FC);

  // --- Neutrals ---

  /// Primary text, near-black cards (karma card, dark hero surfaces).
  static const Color ink = Color(0xFF1A1A1A);

  /// Secondary/subtitle text.
  static const Color inkSecondary = Color(0xFF55555C);

  /// Labels, placeholders, icon strokes, eyebrow/meta text.
  static const Color inkTertiary = Color(0xFF77777F);

  /// Faintest muted text — rank numbers, "Less/More" scale labels, chevrons.
  static const Color inkFaint = Color(0xFF9A9AA2);

  /// Cards, inputs, chip surfaces.
  static const Color surface = Color(0xFFFEFEFE);

  /// Scaffold bg on light/utility screens (phone-frame / main screen bg).
  static const Color canvas = Color(0xFFF2F2F4);

  /// Outer app background (app-wide body bg, filter-chip inactive border) —
  /// a step darker than [canvas].
  static const Color canvasOuter = Color(0xFFE3E3E6);

  /// Input borders, OR-divider lines.
  static const Color divider = Color(0xFFDEDEE3);

  /// Hairline dividers between list rows — lighter than [divider].
  static const Color hairline = Color(0xFFEDEDF0);

  // --- Semantic (success / warning / danger) ---

  /// Success text/icon fg — approved/completed/positive state.
  static const Color success = Color(0xFF0F7A4A);

  /// Success tinted container bg.
  static const Color successBg = Color(0xFFE4F7E9);

  /// Warning text/icon fg.
  static const Color warning = Color(0xFF9A6412);

  /// Warning tinted container bg.
  static const Color warningBg = Color(0xFFFFF2DC);

  /// Semantic error/danger fg — declined/negative/validation-error state.
  static const Color error = Color(0xFFC0362B);

  /// Error/danger tinted container bg.
  static const Color errorBg = Color(0xFFFDE7E4);

  // --- Leaderboard medal colors (not brand tokens — universal medal hues) ---

  static const Color rankGold = Color(0xFFFFC53D);
  static const Color rankSilver = Color(0xFFC9CBD4);
  static const Color rankBronze = Color(0xFFE0A472);

  // --- Stat-badge accents (Home dashboard's Karma/Level/Rank icon chips) ---
  // Unchanged by this pass — out of scope (dashboard screen restyle).

  static const Color statKarmaTint = Color(0xFFE9FBDA);
  static const Color statKarmaAccent = Color(0xFF2E7D1E);
  static const Color statLevelTint = Color(0xFFEDE7FF);
  static const Color statLevelAccent = Color(0xFF6C3CE9);
  static const Color statRankTint = Color(0xFFFFF3D6);

  // --- Cycling / scale palettes ---

  /// Avatar initials-background palette, cycled by index.
  static const List<Color> avatarPalette = [
    primary,
    karmaAccent,
    ink,
    Color(0xFF6C5CF7),
    Color(0xFF8A4FF0),
    Color(0xFF3B3B42),
  ];

  /// Activity-heatmap scale, light → dark (5 steps).
  static const List<Color> heatScale = [
    Color(0xFFEDEDF0),
    Color(0xFFCFE2FE),
    Color(0xFF9BC5FD),
    Color(0xFF5FA3FE),
    primary,
  ];

  /// Karma-distribution donut/legend palette, in category order (Web Dev,
  /// Product Management, Cyber Security, Volunteering, Collaboration,
  /// Profile Building, Communication, Everything else).
  static const List<Color> distColors = [
    primary,
    karmaAccent,
    ink,
    Color(0xFF6C5CF7),
    Color(0xFF5FA3FE),
    Color(0xFFD14FEF),
    Color(0xFF9BC5FD),
    Color(0xFFC4C4C4),
  ];

  // --- Gradients ---

  /// Full-bleed immersive-screen background (Profile, Leaderboard).
  /// Unchanged by this pass — out of scope.
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryDeep, primaryBright],
  );

  /// Soft pastel lavender wash — Home's header background (a lighter,
  /// airier variant of [heroGradient] for the dark-text-on-light header
  /// style, opted into via `MuGradientHeader(light: true)`). Unchanged by
  /// this pass — out of scope.
  static const LinearGradient homeHeaderGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFEDEEFB), Color(0xFFDEE1F7)],
  );

  /// Blue → karma-purple gradient used on progress bars/rings and CTA glows.
  static const LinearGradient karmaGradient = LinearGradient(
    colors: [primary, karmaAccent],
  );
}
