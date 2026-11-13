import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/widgets/mu_load_more_footer.dart';

Widget host(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  testWidgets('shows a spinner while the next page loads', (tester) async {
    await tester.pumpWidget(host(MuLoadMoreFooter(isLoading: true, error: null, onRetry: () {})));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Try again'), findsNothing);
  });

  testWidgets('offers a retry after a failed page', (tester) async {
    var retries = 0;
    await tester.pumpWidget(host(MuLoadMoreFooter(
      isLoading: false,
      error: Exception('offline'),
      onRetry: () => retries++,
    )));

    expect(find.text("Couldn't load more."), findsOneWidget);
    await tester.tap(find.text('Try again'));
    expect(retries, 1);
  });
}
