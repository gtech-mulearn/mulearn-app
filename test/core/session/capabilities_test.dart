import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/session/capabilities.dart';
import 'package:mulearn_app/core/session/current_user.dart';
import 'package:mulearn_app/core/session/current_user_dto.dart';
import 'package:mulearn_app/core/session/mentor_application.dart';
import 'package:mulearn_app/core/session/mentor_application_dto.dart';

import '../../support/fixtures.dart';

/// Roles come from GET /dashboard/user/info/ (all role links, verified or
/// not); mentor approval from GET /dashboard/mentor/status/ (live on dev:
/// the QA mentor's role link is unverified while its application is APPROVED).
void main() {
  CurrentUser user(String fixture) =>
      CurrentUserDto.fromJson(loadFixture(fixture)['response'] as Map<String, dynamic>).toDomain();

  final approved = (loadFixture('dev/mentor_status')['response'] as List<dynamic>)
      .map((j) => MentorApplicationDto.fromJson(j as Map<String, dynamic>).toDomain())
      .toList();

  test('a student is a learner who still needs Discord', () {
    final c = Capabilities.derive(user('dev/user_info'), const []);

    expect(c.isLearner, isTrue);
    expect(c.needsDiscord, isTrue);
    expect([c.isMentor, c.isMentorApproved, c.isEnabler, c.isCampusLead, c.isCompany, c.canUseCampusWorkspace],
        everyElement(isFalse));
  });

  test('a mentor with an approved application is an approved mentor', () {
    final c = Capabilities.derive(user('dev/user_info_mentor'), approved);

    expect(approved.single.status, 'APPROVED');
    expect(c.isMentor, isTrue);
    expect(c.isMentorApproved, isTrue);
  });

  test('a mentor without an approved application is not approved', () {
    final c = Capabilities.derive(user('dev/user_info_mentor'), const []);

    expect(c.isMentor, isTrue);
    expect(c.isMentorApproved, isFalse);
  });

  test('an enabler can use the campus workspace and is also a learner', () {
    final c = Capabilities.derive(user('dev/user_info_enabler'), const []);

    expect(c.isEnabler && c.canUseCampusWorkspace && c.isLearner, isTrue);
  });

  test('a campus lead can use the campus workspace', () {
    final c = Capabilities.derive(user('dev/user_info_campuslead'), const []);

    expect(c.isCampusLead && c.canUseCampusWorkspace, isTrue);
  });

  test('unknown role titles grant nothing', () {
    final c = Capabilities.derive(
      const CurrentUser(muid: 'x@mulearn', fullName: 'X', roles: ['Pre Member', 'WEB IGLead', 'Admins']),
      const [MentorApplication(id: 'a', status: 'APPROVED', mentorTier: 'IG_MENTOR')],
    );

    expect(
      [c.isLearner, c.isMentor, c.isMentorApproved, c.isEnabler, c.isCampusLead, c.isCompany, c.canUseCampusWorkspace],
      everyElement(isFalse),
    );
    expect(c.needsDiscord, isTrue);
  });
}
