import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

double _contrast(Color a, Color b) {
  final la = a.computeLuminance();
  final lb = b.computeLuminance();
  final hi = la > lb ? la : lb;
  final lo = la > lb ? lb : la;
  return (hi + 0.05) / (lo + 0.05);
}

/// Text pairs each colour token's usage note promises, at ≥ 4.5:1.
List<(String, Color, Color)> _textPairs(MuPalette p) => [
  ('ink/chalk', p.ink, p.chalk),
  ('ink/surface', p.ink, p.surface),
  ('ink/surfaceSunk', p.ink, p.surfaceSunk),
  ('ink2/surface', p.ink2, p.surface),
  ('ink2/chalk', p.ink2, p.chalk),
  ('ink3/surface', p.ink3, p.surface),
  ('ink3/chalk', p.ink3, p.chalk),
  ('cobaltText/surface', p.cobaltText, p.surface),
  ('cobaltText/chalk', p.cobaltText, p.chalk),
  ('cobaltText/cobaltTint', p.cobaltText, p.cobaltTint),
  ('onCobalt/cobalt', p.onCobalt, p.cobalt),
  ('onCobalt/cobaltPress', p.onCobalt, p.cobaltPress),
  ('onNight/night', p.onNight, p.night),
  ('onNight2/night', p.onNight2, p.night),
  ('onVolt/volt', p.onVolt, p.volt),
  ('voltText/surface', p.voltText, p.surface),
  ('voltText/chalk', p.voltText, p.chalk),
  ('success/successTint', p.success, p.successTint),
  ('success/surface', p.success, p.surface),
  ('warning/warningTint', p.warning, p.warningTint),
  ('warning/surface', p.warning, p.surface),
  ('danger/dangerTint', p.danger, p.dangerTint),
  ('danger/surface', p.danger, p.surface),
  ('surface/danger (danger button label)', p.surface, p.danger),
  ('inkPrint/igCoder', p.inkPrint, p.igCoder),
  ('inkPrint/igMaker', p.inkPrint, p.igMaker),
  ('inkPrint/igCreative', p.inkPrint, p.igCreative),
  ('inkPrint/igManager', p.inkPrint, p.igManager),
  ('inkPrint/igOthers', p.inkPrint, p.igOthers),
];

/// Marks that carry meaning (control borders, focus ring), at ≥ 3:1.
List<(String, Color, Color)> _markPairs(MuPalette p) => [
  ('lineStrong/surface', p.lineStrong, p.surface),
  ('focusRing/chalk', p.focusRing, p.chalk),
  ('focusRing/surface', p.focusRing, p.surface),
  ('cobalt/chalk', p.cobalt, p.chalk),
];

void main() {
  for (final (name, palette) in [
    ('light', MuPalette.light),
    ('dark', MuPalette.dark),
  ]) {
    test('$name palette: text pairs reach 4.5:1', () {
      final failing = [
        for (final (pair, fg, bg) in _textPairs(palette))
          if (_contrast(fg, bg) < 4.5)
            '$pair ${_contrast(fg, bg).toStringAsFixed(2)}',
      ];
      expect(failing, isEmpty);
    });

    test('$name palette: meaningful marks reach 3:1', () {
      final failing = [
        for (final (pair, fg, bg) in _markPairs(palette))
          if (_contrast(fg, bg) < 3)
            '$pair ${_contrast(fg, bg).toStringAsFixed(2)}',
      ];
      expect(failing, isEmpty);
    });
  }
}
