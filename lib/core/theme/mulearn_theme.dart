import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';

/// App [ThemeData], assembled from the brand tokens (rules.md §8).
///
/// Base border radius ~10px (`0.625rem` from the web tokens) is applied to
/// buttons, inputs, and cards so surfaces match the landing page.
abstract final class MulearnTheme {
  const MulearnTheme._();

  static const double _radius = 10;
  static final BorderRadius _borderRadius = BorderRadius.circular(_radius);

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(
      seedColor: MulearnColors.primary,
      brightness: brightness,
      primary: MulearnColors.primary,
      error: MulearnColors.error,
      surface: isDark ? MulearnColors.blackish : MulearnColors.whitish,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: MulearnTypography.textTheme(brightness),
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        centerTitle: false,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: MulearnColors.primary,
          foregroundColor: MulearnColors.whitish,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: _borderRadius),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.black.withValues(alpha: 0.03),
        border: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: const BorderSide(color: MulearnColors.greyish),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: const BorderSide(color: MulearnColors.greyish),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: const BorderSide(color: MulearnColors.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.black.withValues(alpha: 0.02),
        shape: RoundedRectangleBorder(borderRadius: _borderRadius),
      ),
    );
  }
}
