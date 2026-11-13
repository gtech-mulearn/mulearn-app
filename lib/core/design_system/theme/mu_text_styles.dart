import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// The type scale as ready-to-use [TextStyle]s, coloured for one palette.
///
/// Plus Jakarta Sans for display and text, JetBrains Mono for codes
/// (hashtags, muids, karma amounts). Styles default to `ink`; recolour with
/// `.copyWith(color: ...)` from the same palette.
class MuTextStyles {
  const MuTextStyles._({
    required this.poster,
    required this.display,
    required this.displayLight,
    required this.title1,
    required this.title2,
    required this.title3,
    required this.numeralXl,
    required this.numeral,
    required this.bodyLg,
    required this.body,
    required this.bodyStrong,
    required this.button,
    required this.label,
    required this.caption,
    required this.eyebrow,
    required this.code,
    required this.codeSm,
  });

  /// Builds every style in [palette]'s `ink`.
  factory MuTextStyles.forPalette(MuPalette palette) {
    TextStyle s(MuTypeSpec spec, {bool tabular = false}) => style(spec, color: palette.ink, tabular: tabular);
    return MuTextStyles._(
      poster: s(MuTypeTokens.poster),
      display: s(MuTypeTokens.display),
      displayLight: s(MuTypeTokens.displayLight),
      title1: s(MuTypeTokens.title1),
      title2: s(MuTypeTokens.title2),
      title3: s(MuTypeTokens.title3),
      numeralXl: s(MuTypeTokens.numeralXl, tabular: true),
      numeral: s(MuTypeTokens.numeral, tabular: true),
      bodyLg: s(MuTypeTokens.bodyLg),
      body: s(MuTypeTokens.body),
      bodyStrong: s(MuTypeTokens.bodyStrong),
      button: s(MuTypeTokens.button),
      label: s(MuTypeTokens.label),
      caption: s(MuTypeTokens.caption).copyWith(color: palette.ink3),
      eyebrow: s(MuTypeTokens.eyebrow).copyWith(color: palette.ink3),
      code: s(MuTypeTokens.code, tabular: true),
      codeSm: s(MuTypeTokens.codeSm, tabular: true),
    );
  }

  /// One token spec as a [TextStyle].
  static TextStyle style(MuTypeSpec spec, {required Color color, bool tabular = false}) {
    return GoogleFonts.getFont(
      spec.family.familyName,
      fontSize: spec.size,
      height: spec.height,
      fontWeight: FontWeight.values[(spec.weight ~/ 100).clamp(1, 9) - 1],
      letterSpacing: spec.letterSpacing,
      color: color,
      fontFeatures: tabular ? const [FontFeature.tabularFigures()] : null,
    );
  }

  /// One poster moment per screen; set the string in capitals.
  final TextStyle poster;
  final TextStyle display;
  final TextStyle displayLight;
  final TextStyle title1;
  final TextStyle title2;
  final TextStyle title3;
  final TextStyle numeralXl;
  final TextStyle numeral;
  final TextStyle bodyLg;
  final TextStyle body;
  final TextStyle bodyStrong;
  final TextStyle button;
  final TextStyle label;

  /// In `ink-3`.
  final TextStyle caption;

  /// In `ink-3`; set the string in capitals.
  final TextStyle eyebrow;
  final TextStyle code;
  final TextStyle codeSm;
}
