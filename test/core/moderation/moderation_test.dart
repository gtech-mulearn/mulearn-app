import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/config/app_links.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/moderation/blocked_user.dart';
import 'package:mulearn_app/core/moderation/blocked_users.dart';
import 'package:mulearn_app/core/moderation/blocked_users_storage.dart';
import 'package:mulearn_app/core/moderation/moderation_sheet.dart';
import 'package:mulearn_app/core/utils/external_links.dart';

/// Guideline 1.2: report objectionable content and block abusive users.
class _MemoryStorage implements BlockedUsersStorage {
  _MemoryStorage([this.saved = const []]);

  List<BlockedUser> saved;

  @override
  Future<List<BlockedUser>> read() async => saved;

  @override
  Future<void> write(List<BlockedUser> users) async => saved = users;
}

const _ana = BlockedUser(id: 'u1', muid: 'ana@mulearn', name: 'Ana');

void main() {
  group('blocked users', () {
    test(
      'blocking saves, matches by id or muid, and unblocking removes',
      () async {
        final storage = _MemoryStorage();
        final container = ProviderContainer(
          overrides: [blockedUsersStorageProvider.overrideWithValue(storage)],
        )..listen(blockedUsersProvider, (_, _) {});
        addTearDown(container.dispose);

        await container.read(blockedUsersProvider.notifier).block(_ana);

        final list = container.read(blockedUsersProvider);
        expect(list.blocks(id: 'u1'), isTrue);
        expect(list.blocks(muid: 'ana@mulearn'), isTrue);
        expect(list.blocks(id: 'other', muid: 'other@mulearn'), isFalse);
        expect(list.blocks(), isFalse);
        expect(storage.saved.single.name, 'Ana');

        await container
            .read(blockedUsersProvider.notifier)
            .unblock(const BlockedUser(muid: 'ana@mulearn', name: ''));

        expect(container.read(blockedUsersProvider), isEmpty);
        expect(storage.saved, isEmpty);
      },
    );

    test(
      'blocking the same person twice keeps one entry and fills in both ids',
      () async {
        final container = ProviderContainer(
          overrides: [
            blockedUsersStorageProvider.overrideWithValue(_MemoryStorage()),
          ],
        )..listen(blockedUsersProvider, (_, _) {});
        addTearDown(container.dispose);
        final notifier = container.read(blockedUsersProvider.notifier);

        await notifier.block(const BlockedUser(id: 'u1', name: 'Ana'));
        await notifier.block(
          const BlockedUser(id: 'u1', muid: 'ana@mulearn', name: 'Ana'),
        );

        final list = container.read(blockedUsersProvider);
        expect(list, hasLength(1));
        expect(list.single.id, 'u1');
        expect(list.single.muid, 'ana@mulearn');
      },
    );

    test('the saved list is loaded after launch', () async {
      final container = ProviderContainer(
        overrides: [
          blockedUsersStorageProvider.overrideWithValue(_MemoryStorage([_ana])),
        ],
      )..listen(blockedUsersProvider, (_, _) {});
      addTearDown(container.dispose);

      await Future<void>.delayed(Duration.zero);

      expect(container.read(blockedUsersProvider).blocks(id: 'u1'), isTrue);
    });
  });

  group('report and block sheet', () {
    Future<(_MemoryStorage, List<Uri>)> pumpSheet(
      WidgetTester tester, {
      BlockedUser? author = _ana,
    }) async {
      final storage = _MemoryStorage();
      final opened = <Uri>[];
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            blockedUsersStorageProvider.overrideWithValue(storage),
            openExternalProvider.overrideWithValue((uri) async {
              opened.add(uri);
              return true;
            }),
          ],
          child: MaterialApp(
            theme: MuThemeData.light(),
            home: Builder(
              builder: (context) => Scaffold(
                body: Center(
                  child: TextButton(
                    onPressed: () => showModerationSheet(
                      context,
                      kind: ModerationKind.comment,
                      contentId: 'c9',
                      contentTitle: 'Nice build',
                      author: author,
                    ),
                    child: const Text('open'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      return (storage, opened);
    }

    testWidgets(
      'reporting opens an email to support with the reason and the content',
      (tester) async {
        final (_, opened) = await pumpSheet(tester);

        await tester.tap(find.text('Report this comment'));
        await tester.pumpAndSettle();
        expect(find.text('Why are you reporting this?'), findsOneWidget);
        await tester.tap(find.text('Harassment or hate'));
        await tester.pumpAndSettle();

        final mail = opened.single;
        expect(mail.scheme, 'mailto');
        expect(mail.path, AppLinks.supportEmail);
        final text = Uri.decodeComponent(mail.query);
        expect(text, contains('Report: comment'));
        expect(text, contains('Harassment or hate'));
        expect(text, contains('c9'));
        expect(text, contains('Ana'));
      },
    );

    testWidgets('blocking asks first, then saves the person', (tester) async {
      final (storage, _) = await pumpSheet(tester);

      await tester.tap(find.text('Block Ana'));
      await tester.pumpAndSettle();
      expect(find.text('Block Ana?'), findsOneWidget);
      expect(storage.saved, isEmpty);
      await tester.tap(find.widgetWithText(MuButton, 'Block'));
      await tester.pumpAndSettle();

      expect(storage.saved.single.muid, 'ana@mulearn');
    });

    testWidgets('with no known author there is only Report', (tester) async {
      await pumpSheet(tester, author: null);

      expect(find.text('Report this comment'), findsOneWidget);
      expect(find.textContaining('Block'), findsNothing);
    });
  });

  test(
    'the content report email names the content, the reason and who posted it',
    () {
      final uri = AppLinks.contentReport(
        kind: 'project',
        reason: 'Spam or misleading',
        contentId: 'p1',
        contentTitle: 'My app',
        author: 'Ana',
      );

      expect(uri.toString(), startsWith('mailto:info@mulearn.org?subject='));
      final text = Uri.decodeComponent(uri.query);
      expect(text, contains('Report: project'));
      expect(text, contains('Spam or misleading'));
      expect(text, contains('p1'));
      expect(text, contains('Ana'));
    },
  );
}
