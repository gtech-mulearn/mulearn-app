import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/features/profile/domain/entities/badges_data.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_log_entry.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/presentation/providers/badges_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/user_log_controller.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/profile_karma_tab.dart';

/// The karma history comes in one response (the endpoint isn't paged) and
/// runs to thousands for a long-time learner: only the newest are built,
/// "Show more" adds the next ones.
void main() {
  testWidgets('the ledger builds the newest 30 and offers the rest', (
    tester,
  ) async {
    final entries = [
      for (var i = 0; i < 100; i++)
        UserLogEntry(
          taskName: 'Task $i',
          karma: 10,
          createdDate: DateTime.utc(
            2026,
            1,
            1,
          ).add(Duration(days: i)).toIso8601String(),
        ),
    ];
    await tester.binding.setSurfaceSize(const Size(420, 20000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userLogProvider.overrideWith((ref) async => entries),
          badgesProvider.overrideWith(
            (ref, muid) async => const BadgesData(fullName: 'Asha'),
          ),
        ],
        child: MaterialApp(
          theme: MuThemeData.light(),
          home: const Scaffold(
            body: SingleChildScrollView(
              child: ProfileKarmaTab(
                profile: UserProfile(
                  id: 'u1',
                  fullName: 'Asha',
                  muid: 'asha@mulearn',
                  karma: 1000,
                  isPublic: true,
                  joined: '2025-01-01',
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Newest first: Task 99 down to Task 70.
    expect(find.text('Task 99'), findsOneWidget);
    expect(find.text('Task 70'), findsOneWidget);
    expect(find.text('Task 69'), findsNothing);
    expect(find.text('Show 30 more of 70'), findsOneWidget);

    await tester.tap(find.text('Show 30 more of 70'));
    await tester.pumpAndSettle();
    expect(find.text('Task 40'), findsOneWidget);
    expect(find.text('Show 30 more of 40'), findsOneWidget);
  });
}
