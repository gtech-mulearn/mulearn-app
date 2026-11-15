import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme_data.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

void main() {
  testWidgets('context.mu reads the installed theme, light by default', (
    tester,
  ) async {
    late MuTheme seen;
    Widget probe() => Builder(
      builder: (context) {
        seen = context.mu;
        return const SizedBox();
      },
    );

    await tester.pumpWidget(MaterialApp(home: probe()));
    expect(seen.colors.chalk, MuPalette.light.chalk);

    await tester.pumpWidget(
      MaterialApp(theme: MuThemeData.dark(), home: probe()),
    );
    await tester.pumpAndSettle();
    expect(seen.colors.chalk, MuPalette.dark.chalk);
  });

  test('ThemeData maps the brand roles', () {
    final light = MuThemeData.light();
    expect(light.colorScheme.primary, MuPalette.light.cobalt);
    expect(light.scaffoldBackgroundColor, MuPalette.light.chalk);
    expect(light.extension<MuTheme>(), isNotNull);
  });

  test('lerp blends colours and keeps text', () {
    final mid = MuTheme.light().lerp(MuTheme.dark(), 0.25);
    expect(mid.text, same(MuTheme.light().text));
    expect(
      mid.colors.chalk,
      Color.lerp(MuPalette.light.chalk, MuPalette.dark.chalk, 0.25),
    );
  });
}
