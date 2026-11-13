import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/widgets/mu_logo.dart';
import 'package:mulearn_app/core/widgets/profile_avatar.dart';

/// The μLearn logo is the dashboard's image (`public/logo.webp`, the
/// favicon mark), never a "μ" typed into a Text (user, 2026-11-13).
void main() {
  test('no screen draws the μ glyph as a logo', () {
    final offenders = <String>[];
    for (final file in Directory('lib').listSync(recursive: true).whereType<File>()) {
      if (!file.path.endsWith('.dart') || file.path.endsWith('.g.dart')) continue;
      final source = file.readAsStringSync();
      // A string that is only the glyph: Text('μ'), 'μ' as a fallback, ...
      if (RegExp('''['"][μµ]['"]''').hasMatch(source)) offenders.add(file.path);
    }
    expect(offenders, isEmpty, reason: 'use MuLogo instead of a typed μ');
  });

  testWidgets('the logo variants use the dashboard images and read as μLearn', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            MuLogo.mark(),
            MuLogo.wordmark(),
            MuLogo.wordmarkOnBrand(height: 24),
          ],
        ),
      ),
    ));

    final assets = tester.widgetList<Image>(find.byType(Image)).map((i) => (i.image as AssetImage).assetName).toList();
    expect(assets, [
      'assets/images/logo.png',
      'assets/images/logo_wordmark.webp',
      'assets/images/logo_wordmark_mono.webp',
    ]);
    expect(find.bySemanticsLabel('μLearn'), findsNWidgets(3));
    handle.dispose();
  });

  testWidgets('an avatar without a name shows the μLearn mark', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: ProfileAvatar(url: null, name: '  ', size: 48))));

    expect(find.byType(MuLogo), findsOneWidget);
  });
}
