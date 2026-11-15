import 'package:flutter/material.dart';
import 'package:mulearn_app/core/design_system/theme/mu_text_styles.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// The design system's theme: palette, text styles and shadows for one
/// brightness. Read it with `context.mu`.
@immutable
class MuTheme extends ThemeExtension<MuTheme> {
  /// A theme from its parts.
  const MuTheme({required this.colors, required this.text, required this.shadows});

  /// Light theme.
  factory MuTheme.light() => _light;

  /// Dark theme.
  factory MuTheme.dark() => _dark;

  static final MuTheme _light = MuTheme(
    colors: MuPalette.light,
    text: MuTextStyles.forPalette(MuPalette.light),
    shadows: MuShadows.light,
  );
  static final MuTheme _dark = MuTheme(
    colors: MuPalette.dark,
    text: MuTextStyles.forPalette(MuPalette.dark),
    shadows: MuShadows.dark,
  );

  /// Colour tokens.
  final MuPalette colors;

  /// Type scale.
  final MuTextStyles text;

  /// Elevation tokens.
  final MuShadows shadows;

  /// Whether the page is dark (read from the page colour, so it holds
  /// mid-way through a theme change too).
  bool get isDark => colors.chalk.computeLuminance() < 0.2;

  @override
  MuTheme copyWith({MuPalette? colors, MuTextStyles? text, MuShadows? shadows}) =>
      MuTheme(colors: colors ?? this.colors, text: text ?? this.text, shadows: shadows ?? this.shadows);

  @override
  MuTheme lerp(MuTheme? other, double t) {
    if (other == null) return this;
    // Colours blend so a theme switch eases; text and shadows switch halfway.
    final half = t < 0.5;
    return MuTheme(
      colors: colors.lerp(other.colors, t),
      text: half ? text : other.text,
      shadows: half ? shadows : other.shadows,
    );
  }
}

/// `context.mu.colors.cobalt`, `context.mu.text.title3`, …
extension MuThemeContext on BuildContext {
  /// The nearest [MuTheme]; falls back to light when none is installed.
  MuTheme get mu => Theme.of(this).extension<MuTheme>() ?? MuTheme.light();
}
