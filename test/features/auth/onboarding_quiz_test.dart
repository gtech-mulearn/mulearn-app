import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/features/auth/data/interests_quiz_data.dart';
import 'package:mulearn_app/features/auth/domain/entities/pathway.dart';
import 'package:mulearn_app/features/auth/domain/repositories/register_repository.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_providers.dart';
import 'package:mulearn_app/features/auth/presentation/screens/onboarding_interests_screen.dart';

class _MockRepo extends Mock implements RegisterRepository {}

/// The interests step follows the dashboard's `/onboarding/interests`:
/// its PathFinder questions, pick-then-Next, back takes an answer back,
/// a results screen, and saving only on "Begin your journey".
void main() {
  group('recommendPathways (the dashboard getRecommendedPathways)', () {
    test('the two most-picked pathways', () {
      expect(
        recommendPathways([
          Pathway.creative,
          Pathway.maker,
          Pathway.creative,
          Pathway.maker,
          Pathway.creative,
        ]),
        [Pathway.creative, Pathway.maker],
      );
    });

    test('always two: ties keep coder, maker, manager, creative', () {
      expect(recommendPathways(List.filled(5, Pathway.manager)), [
        Pathway.manager,
        Pathway.coder,
      ]);
    });
  });

  test('the questions are the dashboard ones, one option per pathway', () {
    expect(kPathfinderQuizQuestions, hasLength(5));
    expect(
      kPathfinderQuizQuestions.first.question,
      'What kind of activities do you enjoy the most?',
    );
    for (final q in kPathfinderQuizQuestions) {
      expect(q.options.map((o) => o.pathway).toSet(), Pathway.values.toSet());
    }
  });

  group('the quiz screen', () {
    late _MockRepo repo;

    setUp(() {
      repo = _MockRepo();
      when(() => repo.selectDomains(any())).thenAnswer((_) async {});
    });

    Future<void> pump(WidgetTester tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) => const OnboardingInterestsScreen(),
          ),
          GoRoute(path: '/home', builder: (_, __) => const Text('HOME')),
        ],
      );
      await tester.binding.setSurfaceSize(const Size(420, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            registerRepositoryProvider.overrideWithValue(repo),
            currentUserProvider.overrideWith((ref) async => null),
          ],
          child: MaterialApp.router(
            theme: MuThemeData.light(),
            routerConfig: router,
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    /// Taps the option for [p] on whichever question is showing.
    Future<void> pick(WidgetTester tester, Pathway p) async {
      for (final q in kPathfinderQuizQuestions) {
        if (find.text(q.question).evaluate().isNotEmpty) {
          final option = q.options.firstWhere((o) => o.pathway == p);
          await tester.tap(find.text(option.text));
          await tester.pumpAndSettle();
          return;
        }
      }
      fail('No quiz question on screen');
    }

    Future<void> next(WidgetTester tester, [String label = 'Next']) async {
      await tester.tap(find.text(label));
      await tester.pumpAndSettle();
    }

    testWidgets('pick, then Next; results first; saving waits for Begin', (
      tester,
    ) async {
      await pump(tester);
      expect(
        find.textContaining('discover your path?', findRichText: true),
        findsOneWidget,
      );
      await tester.tap(find.text('Take the PathFinder quiz'));
      await tester.pumpAndSettle();

      // Nothing picked: Next does nothing.
      final firstQuestion = kPathfinderQuizQuestions
          .firstWhere((q) => find.text(q.question).evaluate().isNotEmpty)
          .question;
      await next(tester);
      expect(find.text(firstQuestion), findsOneWidget);

      for (var i = 0; i < 5; i++) {
        await pick(tester, Pathway.creative);
        await next(tester, i == 4 ? 'See my paths' : 'Next');
      }
      expect(
        find.textContaining('community!', findRichText: true),
        findsOneWidget,
      );
      expect(find.text('Creative'), findsOneWidget);
      expect(find.text('Coder'), findsOneWidget);
      verifyNever(() => repo.selectDomains(any()));

      await tester.tap(find.text('Begin your journey'));
      await tester.pumpAndSettle();
      verify(() => repo.selectDomains(['creative', 'coder'])).called(1);
      expect(find.text('HOME'), findsOneWidget);
    });

    testWidgets('back takes the last answer back, so it never counts twice', (
      tester,
    ) async {
      await pump(tester);
      await tester.tap(find.text('Take the PathFinder quiz'));
      await tester.pumpAndSettle();

      // Answer maker, go back, change it to manager.
      await pick(tester, Pathway.maker);
      await next(tester);
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      await pick(tester, Pathway.manager);
      await next(tester);
      for (var i = 1; i < 5; i++) {
        await pick(tester, i.isEven ? Pathway.manager : Pathway.coder);
        await next(tester, i == 4 ? 'See my paths' : 'Next');
      }
      // manager 3, coder 2, maker 0 (the taken-back answer isn't counted).
      expect(find.text('Manager'), findsOneWidget);
      expect(find.text('Coder'), findsOneWidget);
      expect(find.text('Maker'), findsNothing);
    });
  });
}
