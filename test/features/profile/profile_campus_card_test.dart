import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/features/profile/data/dtos/user_profile_dto.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/profile_sheet.dart';

/// The profile's campus card. For a mentor the backend's college_id used to
/// be their company's id with no code, so the card read "No campus yet" and
/// opened "Campus not found".
void main() {
  UserProfile profile({String? code, String? collegeId, String? company}) =>
      UserProfile(
        id: 'u1',
        fullName: 'Asha',
        muid: 'asha@mulearn',
        karma: 0,
        isPublic: true,
        joined: '2026-01-01',
        collegeCode: code,
        collegeId: collegeId,
        companyName: company,
      );

  Future<List<String>> pump(
    WidgetTester tester,
    UserProfile p, {
    bool isOwn = true,
  }) async {
    final opened = <String>[];
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => Scaffold(
            body: ProfileCampusCard(
              profile: p,
              isOwn: isOwn,
              department: null,
              joinedYear: '2026',
            ),
          ),
        ),
        GoRoute(
          path: '/campuses/:id',
          builder: (_, s) {
            opened.add(s.pathParameters['id']!);
            return const SizedBox();
          },
        ),
      ],
    );
    await tester.pumpWidget(
      MaterialApp.router(theme: MuThemeData.light(), routerConfig: router),
    );
    return opened;
  }

  testWidgets('a college opens its campus page', (tester) async {
    final opened = await pump(tester, profile(code: 'CET', collegeId: 'c1'));
    expect(find.text('CET'), findsWidgets);
    await tester.tap(find.byType(MuCampusCrest));
    await tester.pumpAndSettle();
    expect(opened, ['c1']);
  });

  testWidgets('a mentor shows their company, and it opens nothing', (
    tester,
  ) async {
    final opened = await pump(tester, profile(company: 'Acme Labs'));
    expect(find.text('Acme Labs'), findsOneWidget);
    expect(find.text('No campus yet'), findsNothing);
    await tester.tap(find.byType(MuCampusCrest));
    await tester.pumpAndSettle();
    expect(opened, isEmpty);
  });

  testWidgets('no campus on your own profile asks you to add one', (
    tester,
  ) async {
    await pump(tester, profile());
    expect(find.text('Add your campus'), findsOneWidget);
  });

  testWidgets("no campus on someone else's profile just says so", (
    tester,
  ) async {
    final opened = await pump(tester, profile(), isOwn: false);
    expect(find.text('No campus yet'), findsOneWidget);
    await tester.tap(find.byType(MuCampusCrest));
    await tester.pumpAndSettle();
    expect(opened, isEmpty);
  });

  test("today's backend: a mentor's company id isn't taken for a campus", () {
    final dto = UserProfileDto.fromJson(const {
      'id': 'u1',
      'full_name': 'Asha',
      'muid': 'asha@mulearn',
      'joined': '2026-01-01',
      'college_id': 'company-uuid',
      'college_code': null,
    });
    expect(dto.toDomain().collegeId, isNull);
  });

  test('the new company fields reach the profile', () {
    final dto = UserProfileDto.fromJson(const {
      'id': 'u1',
      'full_name': 'Asha',
      'muid': 'asha@mulearn',
      'joined': '2026-01-01',
      'company_id': 'acme',
      'company_name': 'Acme Labs',
    });
    expect(dto.toDomain().companyName, 'Acme Labs');
    expect(dto.toDomain().companyId, 'acme');
  });
}
