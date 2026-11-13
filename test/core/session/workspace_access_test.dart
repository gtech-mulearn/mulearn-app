import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/mentor_application.dart';
import 'package:mulearn_app/core/session/workspace_access.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _userInfo = 'GET /api/v1/dashboard/user/info/';
const _mentorStatus = 'GET /api/v1/dashboard/mentor/status/';
const _profile = 'GET /api/v1/dashboard/profile/user-profile/';

/// Plan 4, Task 1: who sees which workspace, decided once from the roles,
/// the mentor applications and the profile's `role_verification`.
void main() {
  MentorApplication app(String status) => MentorApplication(id: 'm1', status: status, mentorTier: 'IG');

  WorkspaceAccess derive(List<String> roles, {List<String> apps = const [], Map<String, bool> verified = const {}}) =>
      deriveWorkspaceAccess(
        roles: roles,
        mentorApplications: [for (final s in apps) app(s)],
        roleVerified: verified,
      );

  group('deriveWorkspaceAccess', () {
    test('a learner has no workspace', () {
      final a = derive(['Student'], verified: {'student': true});
      expect([a.mentor, a.campus, a.enablerCampuses], everyElement(WorkspaceState.hidden));
      expect(a.campusLead, isFalse);
      expect(a.pendingCampusRole, isNull);
    });

    test('mentor: approved opens, pending waits, rejected and revoked show nothing', () {
      expect(derive(['Mentor'], apps: ['APPROVED']).mentor, WorkspaceState.open);
      expect(derive(['Mentor'], apps: ['PENDING']).mentor, WorkspaceState.pending);
      expect(derive(['Mentor'], apps: ['REJECTED']).mentor, WorkspaceState.hidden);
      expect(derive(['Mentor'], apps: ['GRANT_REVOKED']).mentor, WorkspaceState.hidden);
      expect(derive(['Mentor']).mentor, WorkspaceState.hidden, reason: 'no application yet');
      expect(derive(['Mentor'], apps: ['REJECTED', 'APPROVED']).mentor, WorkspaceState.open);
    });

    test('an approved application without the Mentor role opens nothing', () {
      expect(derive(['Student'], apps: ['APPROVED']).mentor, WorkspaceState.hidden);
    });

    test('an unverified Enabler is pending and named for the banner', () {
      final a = derive(['Student', 'Enabler'], verified: {'student': true, 'enabler': false});
      expect(a.campus, WorkspaceState.pending);
      expect(a.enablerCampuses, WorkspaceState.pending);
      expect(a.pendingCampusRole, 'Enabler');
    });

    test('a campus role with no verification row is pending', () {
      expect(derive(['Lead Enabler']).campus, WorkspaceState.pending);
    });

    test('Zonal and District Campus Leads have no campus workspace (backend campus_staff_required)', () {
      final a = derive(['Zonal Campus Lead', 'District Campus Lead'],
          verified: {'zonal campus lead': true, 'district campus lead': true});
      expect(a.campus, WorkspaceState.hidden);
      expect(a.campusLead, isFalse);
    });

    test('a verified Campus Lead opens the campus workspace and its approvals', () {
      final a = derive(['Student', 'Campus Lead'], verified: {'student': true, 'campus lead': true});
      expect(a.campus, WorkspaceState.open);
      expect(a.campusLead, isTrue);
      expect(a.enablerCampuses, WorkspaceState.hidden);
    });

    test('an unverified Campus Lead gets no approvals', () {
      final a = derive(['Campus Lead'], verified: {'campus lead': false});
      expect(a.campus, WorkspaceState.pending);
      expect(a.campusLead, isFalse);
      expect(a.pendingCampusRole, 'Campus Lead');
    });
  });

  test('role_verification parses case-insensitively and ignores bad rows', () {
    expect(
      parseRoleVerification([
        {'role': 'Enabler', 'is_verified': true},
        {'role': 'Student', 'is_verified': false},
        {'role': null, 'is_verified': true},
        'junk',
      ]),
      {'enabler': true, 'student': false},
    );
    expect(parseRoleVerification(null), isEmpty);
  });

  group('workspaceAccessProvider on the recorded role accounts', () {
    Future<WorkspaceAccess?> accessFor(String who, {bool expectProfileCall = true}) async {
      final adapter = FakeHttpAdapter({
        _userInfo: (_) => FakeResponse(200, loadFixture('dev/user_info_$who')),
        _mentorStatus: (_) => FakeResponse(200, loadFixture('dev/mentor_status')),
        _profile: (_) => FakeResponse(200, loadFixture('dev/user_profile_$who')),
      });
      final tokens = TokenStorage(FakeSecureStorage());
      await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
      final c = ProviderContainer(retry: (_, __) => null, overrides: [
        dioProvider.overrideWithValue(fakeDio(adapter)),
        tokenStorageProvider.overrideWithValue(tokens),
      ]);
      addTearDown(c.dispose);
      final access = await c.read(workspaceAccessProvider.future);
      final profileCalls = adapter.requests.where((r) => r.path == '/api/v1/dashboard/profile/user-profile/').length;
      expect(profileCalls, expectProfileCall ? 1 : 0);
      return access;
    }

    test('mentor: workspace open, no campus, and no profile fetch for it', () async {
      final a = (await accessFor('mentor', expectProfileCall: false))!;
      expect(a.mentor, WorkspaceState.open);
      expect(a.campus, WorkspaceState.hidden);
    });

    test('enabler: campus and campuses open, not a campus lead', () async {
      final a = (await accessFor('enabler'))!;
      expect(a.campus, WorkspaceState.open);
      expect(a.enablerCampuses, WorkspaceState.open);
      expect(a.campusLead, isFalse);
    });

    test('campus lead: campus open with approvals', () async {
      final a = (await accessFor('campuslead'))!;
      expect(a.campus, WorkspaceState.open);
      expect(a.campusLead, isTrue);
      expect(a.enablerCampuses, WorkspaceState.hidden);
    });
  });
}
