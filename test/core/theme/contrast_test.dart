import 'dart:math' as math;

import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';

/// WCAG 2.x contrast ratio.
double contrast(Color a, Color b) {
  double channel(double c) => c <= 0.03928 ? c / 12.92 : math.pow((c + 0.055) / 1.055, 2.4).toDouble();
  double luminance(Color c) => 0.2126 * channel(c.r) + 0.7152 * channel(c.g) + 0.0722 * channel(c.b);
  final (hi, lo) = luminance(a) > luminance(b) ? (luminance(a), luminance(b)) : (luminance(b), luminance(a));
  return (hi + 0.05) / (lo + 0.05);
}

/// The dashboard palette (mulearn-dashboard/src/app/globals.css): brand blue
/// #2e85fe, brand purple #8f44ed; its success/warning/destructive fills are
/// too light for text on white, so text uses darker shades of the same hues.
void main() {
  test('brand and karma colours match the dashboard', () {
    expect(MuColors.primary, const Color(0xFF2E85FE));
    expect(MuColors.karmaAccent, const Color(0xFF8F44ED));
    expect(MuColors.successFill, const Color(0xFF4CAF50));
    expect(MuColors.warningFill, const Color(0xFFFF8D0C));
    expect(MuColors.errorFill, const Color(0xFFF44336));
  });

  test('status and karma text is readable on white (≥ 4.5:1)', () {
    for (final (name, color) in [
      ('success', MuColors.success),
      ('warning', MuColors.warning),
      ('error', MuColors.error),
      ('karmaAccent', MuColors.karmaAccent),
    ]) {
      expect(contrast(color, MuColors.paper), greaterThanOrEqualTo(4.5), reason: name);
    }
  });

  test('status text is readable on its own tint (≥ 4.5:1)', () {
    expect(contrast(MuColors.success, MuColors.successBg), greaterThanOrEqualTo(4.5));
    expect(contrast(MuColors.warning, MuColors.warningBg), greaterThanOrEqualTo(4.5));
    expect(contrast(MuColors.error, MuColors.errorBg), greaterThanOrEqualTo(4.5));
  });
}
