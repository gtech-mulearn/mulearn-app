import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';

/// Heading weight hierarchy ported from the web app: h1 heaviest (black, w900)
/// down to h5 medium (w500) — rules.md §8. Body styles fill out the rest of the
/// Material [TextTheme].
abstract final class MulearnTypography {
  const MulearnTypography._();

  static TextTheme textTheme(Brightness brightness) {
    final base = brightness == Brightness.dark
        ? Typography.material2021().white
        : Typography.material2021().black;

    final onSurface =
        brightness == Brightness.dark ? MulearnColors.whitish : MulearnColors.blackish;

    return GoogleFonts.interTextTheme(base).copyWith(
      // h1 — heaviest
      displayLarge: _h(base.displayLarge, FontWeight.w900, onSurface),
      // h2
      displayMedium: _h(base.displayMedium, FontWeight.w800, onSurface),
      headlineLarge: _h(base.headlineLarge, FontWeight.w800, onSurface),
      // h3
      headlineMedium: _h(base.headlineMedium, FontWeight.w700, onSurface),
      titleLarge: _h(base.titleLarge, FontWeight.w700, onSurface),
      // h4
      headlineSmall: _h(base.headlineSmall, FontWeight.w600, onSurface),
      titleMedium: _h(base.titleMedium, FontWeight.w600, onSurface),
      // h5 — medium
      titleSmall: _h(base.titleSmall, FontWeight.w500, onSurface),
      bodyLarge: _body(base.bodyLarge, onSurface),
      bodyMedium: _body(base.bodyMedium, onSurface),
      bodySmall: _body(base.bodySmall, MulearnColors.gray600),
      labelLarge: _h(base.labelLarge, FontWeight.w600, onSurface),
    );
  }

  static TextStyle? _h(TextStyle? base, FontWeight weight, Color color) =>
      GoogleFonts.inter(textStyle: base).copyWith(fontWeight: weight, color: color);

  static TextStyle? _body(TextStyle? base, Color color) =>
      GoogleFonts.inter(textStyle: base).copyWith(color: color);
}
