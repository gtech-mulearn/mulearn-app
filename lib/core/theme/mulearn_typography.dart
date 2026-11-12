import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';

/// μLearn type scale (rules.md §8) — 2026-09 redesign (Phase 1 of the
/// Claude Design import).
///
/// Two families: **Plus Jakarta Sans** for UI/body copy, **Bricolage
/// Grotesque** for display headings and numeric/stat accents (karma counts,
/// ranks, IDs). Headings and stat numerals are bold with tight tracking —
/// screens override `fontSize` via `.copyWith(...)` for one-off sizes rather
/// than this file growing a named style per screen.
abstract final class MuType {
  const MuType._();

  /// Screen H1s / hero greetings (e.g. "Welcome back", "Hey, Muhammed").
  /// Bricolage Grotesque 700 with tight tracking; screens `.copyWith` a
  /// different `fontSize` for the 24–34px range the design calls for.
  static final TextStyle display = GoogleFonts.bricolageGrotesque(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.15,
    letterSpacing: -0.8,
    color: MuColors.ink,
  );

  static final TextStyle headline = GoogleFonts.bricolageGrotesque(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
    color: MuColors.ink,
  );

  static final TextStyle title = GoogleFonts.plusJakartaSans(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: MuColors.ink,
  );

  static final TextStyle body = GoogleFonts.plusJakartaSans(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: MuColors.ink,
  );

  static final TextStyle bodyMed = GoogleFonts.plusJakartaSans(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.45,
    color: MuColors.ink,
  );

  /// Field labels (e.g. "ID Number").
  static final TextStyle label = GoogleFonts.plusJakartaSans(
    fontSize: 12.5,
    fontWeight: FontWeight.w500,
    height: 1.3,
    color: MuColors.inkTertiary,
  );

  static final TextStyle caption = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.35,
    color: MuColors.inkSecondary,
  );

  /// Karma counts, ranks, OTP digits — always Bricolage Grotesque. Screens
  /// `.copyWith(fontSize: ...)` for the wide range of sizes the design uses
  /// (22–52px) rather than this file defining one style per screen.
  static final TextStyle stat = GoogleFonts.bricolageGrotesque(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: MuColors.ink,
  );

  static final TextStyle statSmall = GoogleFonts.bricolageGrotesque(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: MuColors.ink,
  );

  static final TextStyle chip = GoogleFonts.plusJakartaSans(
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );

  /// Tiny all-caps pills — IG tags, difficulty/status badges, "NEW" badge.
  /// Smaller and bolder than [chip]; use this rather than mutating [chip]
  /// for pill/badge contexts. Call `.toUpperCase()` on the label text.
  static final TextStyle tag = GoogleFonts.plusJakartaSans(
    fontSize: 11,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.6,
  );

  /// UPPERCASE section markers (e.g. "PRODUCTS") — call `.toUpperCase()` on
  /// the label text; this style doesn't transform it for you.
  static final TextStyle eyebrow = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
    color: MuColors.inkSecondary,
  );

  /// Assembled [TextTheme] for [ThemeData] — maps the μLearn scale onto the
  /// closest Material slots so `Theme.of(context).textTheme.*` still works
  /// for widgets that don't reach for [MuType] directly.
  static TextTheme textTheme() => TextTheme(
        displayLarge: display,
        displayMedium: headline,
        headlineLarge: headline,
        headlineMedium: title,
        headlineSmall: title,
        titleLarge: title,
        titleMedium: bodyMed,
        titleSmall: label,
        bodyLarge: body,
        bodyMedium: body,
        bodySmall: caption,
        labelLarge: bodyMed,
        labelMedium: chip,
        labelSmall: eyebrow,
      );
}
