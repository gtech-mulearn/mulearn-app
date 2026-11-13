import 'package:flutter/material.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// Material [ThemeData] built from the design system.
///
/// Every visible component is a `Mu*` widget; this only keeps stray Material
/// widgets (text selection, dialogs, scrollbars, default text) from looking
/// foreign. Until screens are migrated the app installs [MuTheme] as an
/// extension on its existing theme instead (see `app.dart`).
abstract final class MuThemeData {
  /// Light.
  static ThemeData light() => _build(MuTheme.light(), Brightness.light);

  /// Dark.
  static ThemeData dark() => _build(MuTheme.dark(), Brightness.dark);

  static ThemeData _build(MuTheme mu, Brightness brightness) {
    final c = mu.colors;
    final t = mu.text;
    final scheme = ColorScheme(
      brightness: brightness,
      primary: c.cobalt,
      onPrimary: c.onCobalt,
      secondary: c.night,
      onSecondary: c.onNight,
      tertiary: c.volt,
      onTertiary: c.onVolt,
      error: c.danger,
      onError: c.surface,
      surface: c.surface,
      onSurface: c.ink,
      onSurfaceVariant: c.ink2,
      outline: c.lineStrong,
      outlineVariant: c.line,
      surfaceContainerHighest: c.surfaceSunk,
    );
    final controlRadius = BorderRadius.circular(MuRadii.control);
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: c.chalk,
      canvasColor: c.chalk,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      iconTheme: IconThemeData(color: c.ink, size: MuSizes.iconMd),
      dividerTheme: DividerThemeData(color: c.line, thickness: 1, space: 1),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: c.cobalt,
        selectionColor: c.cobaltTint,
        selectionHandleColor: c.cobalt,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: c.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: t.title3,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.surfaceSunk,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
        hintStyle: t.body.copyWith(color: c.ink3),
        labelStyle: t.label.copyWith(color: c.ink2),
        errorStyle: t.caption.copyWith(color: c.danger, fontWeight: FontWeight.w600),
        border: OutlineInputBorder(borderRadius: controlRadius, borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: controlRadius, borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: controlRadius,
          borderSide: BorderSide(color: c.cobalt, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: controlRadius,
          borderSide: BorderSide(color: c.danger, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: controlRadius,
          borderSide: BorderSide(color: c.danger, width: 2),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: t.poster,
        displayMedium: t.display,
        displaySmall: t.title1,
        headlineLarge: t.title1,
        headlineMedium: t.title2,
        headlineSmall: t.title3,
        titleLarge: t.title2,
        titleMedium: t.title3,
        titleSmall: t.bodyStrong,
        bodyLarge: t.bodyLg,
        bodyMedium: t.body,
        bodySmall: t.caption,
        labelLarge: t.button,
        labelMedium: t.label,
        labelSmall: t.eyebrow,
      ),
      extensions: [mu],
    );
  }
}
