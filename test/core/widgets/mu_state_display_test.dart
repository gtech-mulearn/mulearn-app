import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';

/// The dashboard's StateDisplay (`src/components/ui/state-display.tsx`):
/// same illustrations, same default copy (user, 2026-11-13).
void main() {
  Future<void> pump(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: SingleChildScrollView(child: child))));
    await tester.pumpAndSettle();
  }

  testWidgets('each variant shows its illustration and the dashboard default copy', (tester) async {
    const expected = {
      MuStateVariant.notFound: (
        'assets/illustrations/not-found.svg',
        'Looks like you wandered off the path.',
        "That's how new paths are discovered. But this one doesn't exist yet.",
      ),
      MuStateVariant.noResults: (
        'assets/illustrations/no-results.svg',
        'Nothing here. Yet.',
        "Curiosity doesn't always find answers on the first try. Try a different path and keep exploring.",
      ),
      MuStateVariant.noTasks: (
        'assets/illustrations/no-tasks.svg',
        'No tasks available',
        'There are currently no tasks listed in this view. New tasks will appear here once created.',
      ),
    };
    for (final entry in expected.entries) {
      await pump(tester, MuStateDisplay(variant: entry.key));

      expect(find.text(entry.value.$2), findsOneWidget, reason: '${entry.key}');
      expect(find.text(entry.value.$3), findsOneWidget, reason: '${entry.key}');
      final svg = tester.widget<SvgPicture>(find.byType(SvgPicture));
      expect((svg.bytesLoader as SvgAssetLoader).assetName, entry.value.$1);
    }
  });

  testWidgets('a screen can override the copy and add an action', (tester) async {
    var tapped = false;
    await pump(
      tester,
      MuStateDisplay(
        variant: MuStateVariant.noResults,
        title: 'No Learning Circles Yet',
        description: 'Be the first to create a Learning Circle and start collaborating with peers!',
        action: TextButton(onPressed: () => tapped = true, child: const Text('Clear filters')),
      ),
    );

    expect(find.text('No Learning Circles Yet'), findsOneWidget);
    expect(find.text('Nothing here. Yet.'), findsNothing);
    await tester.tap(find.text('Clear filters'));
    expect(tapped, isTrue);
  });

  testWidgets('the illustration is decorative; screen readers get the text', (tester) async {
    final handle = tester.ensureSemantics();
    await pump(tester, const MuStateDisplay(variant: MuStateVariant.noTasks));

    expect(find.bySemanticsLabel('No tasks available'), findsOneWidget);
    expect(
      find.descendant(of: find.byType(ExcludeSemantics), matching: find.byType(SvgPicture)),
      findsOneWidget,
    );
    handle.dispose();
  });

  testWidgets('the small size keeps the illustration narrow', (tester) async {
    await pump(tester, const MuStateDisplay(variant: MuStateVariant.noResults, size: MuStateSize.sm));

    expect(tester.getSize(find.byType(SvgPicture)).width, lessThanOrEqualTo(180));
  });
}
