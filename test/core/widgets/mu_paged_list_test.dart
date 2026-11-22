import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/widgets/mu_paged_list.dart';

/// Production lists run to thousands of rows: only what's on screen may be
/// built, and the next page is asked for as the end comes into view.
void main() {
  Future<int> pump(
    WidgetTester tester,
    PagedState<int> state, {
    List<int>? built,
    bool grouped = false,
  }) async {
    var loads = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: MuThemeData.light(),
        home: Scaffold(
          body: MuPagedListView<int>(
            state: state,
            grouped: grouped,
            onLoadMore: () async => loads++,
            itemBuilder: (_, item, _) {
              built?.add(item);
              return SizedBox(height: 60, child: Text('Row $item'));
            },
          ),
        ),
      ),
    );
    await tester.pump();
    return loads;
  }

  testWidgets('a thousand loaded rows: only the visible ones are built', (
    tester,
  ) async {
    final built = <int>[];
    final loads = await pump(
      tester,
      PagedState(items: List.generate(1000, (i) => i), hasMore: true),
      built: built,
    );
    expect(built.length, lessThan(40));
    expect(find.text('Row 0'), findsOneWidget);
    expect(find.text('Row 999'), findsNothing);
    // The end isn't near: no page is asked for yet.
    expect(loads, 0);
  });

  testWidgets('a short first page asks for the next one at once', (
    tester,
  ) async {
    final loads = await pump(
      tester,
      PagedState(items: List.generate(3, (i) => i), hasMore: true),
    );
    await tester.pump();
    expect(loads, greaterThan(0));
  });

  testWidgets('scrolling near the end asks for the next page', (tester) async {
    var loads = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: MuThemeData.light(),
        home: Scaffold(
          body: MuPagedListView<int>(
            state: PagedState(
              items: List.generate(60, (i) => i),
              hasMore: true,
            ),
            onLoadMore: () async => loads++,
            itemBuilder: (_, item, _) =>
                SizedBox(height: 60, child: Text('Row $item')),
          ),
        ),
      ),
    );
    expect(loads, 0);
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -3400));
    await tester.pumpAndSettle();
    expect(loads, greaterThan(0));
  });

  testWidgets('no more pages, or a failed one: nothing is asked for', (
    tester,
  ) async {
    expect(
      await pump(
        tester,
        PagedState(items: List.generate(3, (i) => i), hasMore: false),
      ),
      0,
    );
    final loads = await pump(
      tester,
      PagedState(
        items: List.generate(3, (i) => i),
        hasMore: true,
        loadMoreError: Exception('offline'),
      ),
    );
    await tester.pump();
    expect(loads, 0);
  });

  testWidgets('grouped rows sit on one card, built row by row', (tester) async {
    await pump(
      tester,
      PagedState(items: List.generate(500, (i) => i), hasMore: false),
      grouped: true,
    );
    expect(find.byType(MuFeedGroupSlice), findsWidgets);
    expect(
      tester.widgetList(find.byType(MuFeedGroupSlice)).length,
      lessThan(40),
    );
  });
}
