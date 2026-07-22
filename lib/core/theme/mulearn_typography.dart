import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';

/// μLearn type scale (rules.md §8) — 2026-07 redesign.
///
/// Two families: **Plus Jakarta Sans** for UI/display, **Space Grotesk** for
/// numeric/stat accents (karma counts, ranks, IDs). Big text is light/mixed
/// weight; small text is medium/bold — the inverse of a default Material
/// scale, and the signature of this system's hierarchy.
abstract final class MuType {
  const MuType._();

  /// Hero names/greetings (e.g. "James Miller") — light weight is deliberate.
  static final TextStyle display = GoogleFonts.plusJakartaSans(
    fontSize: 34,
    fontWeight: FontWeight.w300,
    height: 1.15,
    letterSpacing: -0.5,
    color: MuColors.ink,
  );

  static final TextStyle headline = GoogleFonts.plusJakartaSans(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.3,
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

  /// Karma counts, ranks — always Space Grotesk.
  static final TextStyle stat = GoogleFonts.spaceGrotesk(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: MuColors.ink,
  );

  static final TextStyle statSmall = GoogleFonts.spaceGrotesk(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: MuColors.ink,
  );

  static final TextStyle chip = GoogleFonts.plusJakartaSans(
    fontSize: 13,
    fontWeight: FontWeight.w600,
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
