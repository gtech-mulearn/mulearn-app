import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/profile_header.dart';

/// The profile poster's name shrinks to fit instead of overflowing or
/// breaking a word.
void main() {
  Future<double> sizeFor(WidgetTester tester, String name) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: MuThemeData.light(),
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 240,
              child: Builder(builder: (context) => PosterName(name, style: context.mu.text.poster)),
            ),
          ),
        ),
      ),
    );
    expect(tester.takeException(), isNull, reason: name);
    final text = tester.widget<Text>(find.byType(Text));
    return text.style!.fontSize!;
  }

  testWidgets('short names are big; long names step down; nothing overflows', (tester) async {
    final short = await sizeFor(tester, 'Dev Admin');
    final long = await sizeFor(tester, 'Muhammed Abdul Rahman Kunhikannan Puthiyaveettil');
    final word = await sizeFor(tester, 'Venkataraghavanarasimhan');
    expect(short, 48);
    expect(long, lessThan(short));
    expect(word, lessThan(short), reason: 'a long single word shrinks rather than breaking');
  });
}
