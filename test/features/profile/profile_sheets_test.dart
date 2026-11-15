import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/features/profile/data/dtos/user_profile_dto.dart';
import 'package:mulearn_app/features/profile/domain/entities/achievement.dart';
import 'package:mulearn_app/features/profile/domain/entities/socials.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_achievement.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/presentation/providers/achievements_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/socials_controller.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/edit_socials_sheet.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/issue_vc_sheet.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/share_profile_sheet.dart';

import '../../support/fixtures.dart';

UserProfile _profile({required bool isPublic}) => UserProfileDto.fromJson(
  loadFixtureResponse('dev/user_profile')! as Map<String, dynamic>,
).toDomain().copyWith(isPublic: isPublic);

class _FakeProfile extends ProfileController {
  _FakeProfile(this.initial);

  final UserProfile initial;
  final toggles = <bool>[];

  @override
  Future<UserProfile> build() async => initial;

  @override
  Future<void> togglePublic({required bool isPublic}) async {
    toggles.add(isPublic);
    state = AsyncData(state.value!.copyWith(isPublic: isPublic));
  }
}

class _FakeSocials extends SocialsController {
  Socials? saved;

  @override
  Future<Socials> build() async => const Socials(github: 'octo');

  @override
  Future<void> save(Socials socials) async => saved = socials;
}

/// A page with a button that opens the sheet, so pops can be observed.
Widget _host(List<Override> overrides, void Function(BuildContext) open) => ProviderScope(
  overrides: overrides,
  child: MaterialApp(
    theme: MuThemeData.light(),
    home: Builder(
      builder: (context) => Scaffold(
        body: Center(
          child: TextButton(onPressed: () => open(context), child: const Text('open')),
        ),
      ),
    ),
  ),
);

Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 6; i++) {
    await tester.pump(const Duration(milliseconds: 200));
  }
}

void main() {
  testWidgets('share: turning the profile public reveals the QR and Copy link', (tester) async {
    final fake = _FakeProfile(_profile(isPublic: false));
    final profile = fake.initial;
    await tester.pumpWidget(
      _host([profileControllerProvider.overrideWith(() => fake)], (c) => ShareProfileSheet.show(c, profile)),
    );
    await tester.tap(find.text('open'));
    await _settle(tester);

    expect(find.text('Share profile'), findsOneWidget);
    expect(find.text('Copy link'), findsNothing);

    await tester.tap(find.text('Public profile'));
    await _settle(tester);

    expect(fake.toggles, [true]);
    expect(find.bySemanticsLabel('QR code for your profile link'), findsOneWidget);
    expect(find.text('Copy link'), findsOneWidget);
    expect(find.textContaining('app.mulearn.org/profile/${profile.muid}'), findsOneWidget);
  });

  testWidgets('socials: names each network, saves what was typed and closes', (tester) async {
    final fake = _FakeSocials();
    await tester.pumpWidget(
      _host([socialsControllerProvider.overrideWith(() => fake)], (c) {
        EditSocialsSheet.show(c, const Socials(github: 'octo'));
      }),
    );
    await tester.tap(find.text('open'));
    await _settle(tester);

    expect(find.text('Social links'), findsOneWidget);
    expect(find.text('GitHub'), findsOneWidget);
    expect(find.text('octo'), findsOneWidget);

    await tester.enterText(find.widgetWithText(MuTextField, 'LinkedIn'), '  jane-doe ');
    await tester.tap(find.text('Save'));
    await _settle(tester);

    expect(fake.saved?.github, 'octo');
    expect(fake.saved?.linkedin, 'jane-doe');
    expect(find.text('Social links'), findsNothing);
  });

  testWidgets('issue credential: without a linked wallet it says how to link one', (tester) async {
    const achievement = UserAchievement(
      id: 'ua1',
      userId: 'u1',
      isIssued: false,
      achievement: Achievement(id: 'a1', achievementName: 'QA Starter Badge'),
    );
    await tester.pumpWidget(
      _host([
        connectedDidsProvider('me@mulearn').overrideWith((_) async => const <String>[]),
      ], (c) => IssueVcSheet.show(c, achievement: achievement, muid: 'me@mulearn', userName: 'Me')),
    );
    await tester.tap(find.text('open'));
    await _settle(tester);

    expect(find.text('QA Starter Badge'), findsOneWidget);
    expect(find.text('Link a wallet first'), findsOneWidget);
    expect(find.text('ISSUE CREDENTIAL'), findsOneWidget); // the eyebrow; no button yet
    expect(find.widgetWithText(MuButton, 'Issue credential'), findsNothing);
  });
}
