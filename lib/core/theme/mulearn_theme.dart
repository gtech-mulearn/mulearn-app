import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';

/// App [ThemeData], assembled from the μLearn design tokens (rules.md §8).
///
/// 2026-07 redesign: no default Material elevation/splash, no default
/// `Card`/`AppBar` styling — those are provided by the bespoke `Mu*`
/// component library instead. This theme only supplies the fallback surface
/// for anything that still touches default Material widgets (inputs, base
/// button geometry, icon color).
abstract final class MulearnTheme {
  const MulearnTheme._();

  static final BorderRadius _innerRadius = BorderRadius.circular(MuRadius.inner);
  static final BorderRadius _chipRadius = BorderRadius.circular(MuRadius.chip);

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final canvas = isDark ? MuColors.ink : MuColors.canvas;
    final surface = isDark ? const Color(0xFF15192B) : MuColors.surface;
    final onSurface = isDark ? MuColors.surface : MuColors.ink;

    final scheme = ColorScheme.fromSeed(
      seedColor: MuColors.primary,
      brightness: brightness,
      primary: MuColors.primary,
      error: MuColors.error,
      surface: surface,
    );

    final textTheme = MuType.textTheme();
    final adjustedTextTheme =
        isDark ? textTheme.apply(bodyColor: MuColors.surface, displayColor: MuColors.surface) : textTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: canvas,
      textTheme: adjustedTextTheme,
      splashFactory: NoSplash.splashFactory,
      highlightColor: MuColors.primaryTint.withValues(alpha: 0.4),
      iconTheme: IconThemeData(color: onSurface),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: MuColors.primary,
          foregroundColor: MuColors.surface,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(borderRadius: _chipRadius),
          textStyle: MuType.bodyMed.copyWith(color: MuColors.surface),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: onSurface,
          minimumSize: const Size.fromHeight(48),
          side: const BorderSide(color: MuColors.divider, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: _chipRadius),
          textStyle: MuType.bodyMed,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: MuColors.primary,
          textStyle: MuType.chip,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? Colors.white.withValues(alpha: 0.06) : canvas,
        border: OutlineInputBorder(
          borderRadius: _innerRadius,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _innerRadius,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: _innerRadius,
          borderSide: const BorderSide(color: MuColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: _innerRadius,
          borderSide: const BorderSide(color: MuColors.coral, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        hintStyle: MuType.body.copyWith(color: MuColors.inkTertiary),
        labelStyle: MuType.label,
      ),
      textSelectionTheme: const TextSelectionThemeData(cursorColor: MuColors.primary),
      cardTheme: CardThemeData(
        elevation: 0,
        color: surface,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MuRadius.card),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: MuColors.divider,
        thickness: 1,
        space: 1,
      ),
      tabBarTheme: TabBarThemeData(
        dividerColor: Colors.transparent,
        indicatorColor: MuColors.primary,
        labelColor: MuColors.primary,
        unselectedLabelColor: MuColors.inkTertiary,
        labelStyle: MuType.bodyMed,
        unselectedLabelStyle: MuType.body,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: MuColors.primaryTint,
        labelStyle: MuType.chip.copyWith(color: MuColors.primary),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: _chipRadius),
      ),
    );
  }
}
