import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/features/profile/data/dtos/user_profile_dto.dart';

void main() {
  // Exact `response` payload from a live GET
  // https://dev.mulearn.org/api/v1/dashboard/profile/user-profile/ call
  // (rules.md §3/§9) — `roles`/`interest_groups` are arrays and `rank` is an
  // int. A prior version of this DTO typed all three as nullable `String`,
  // which threw a type error during parsing for any account with an actual
  // role assigned, crashing the whole profile screen after a successful
  // sign-in.
  const realResponseJson = {
    'id': '5bfc4600-8bf8-477e-8f3e-7819c7c3126e',
    'joined': '2026-07-16T05:03:49Z',
    'full_name': 'Muhammed',
    'gender': null,
    'muid': 'muhammed@mulearn',
    'roles': ['Student'],
    'role_verification': [
      {'role': 'Student', 'is_verified': true},
    ],
    'lead_enabler_verified': false,
    'college_id': null,
    'college_code': null,
    'org_district_id': null,
    'karma': 0,
    'rank': 86,
    'karma_distribution': <Object?>[],
    'level': 'lvl1',
    'profile_pic': null,
    'cover_pic': null,
    'interest_groups': <Object?>[],
    'is_public': false,
    'percentile': 100.0,
  };

  test('parses a real user-profile response without throwing', () {
    final dto = UserProfileDto.fromJson(realResponseJson);

    expect(dto.fullName, 'Muhammed');
    expect(dto.muid, 'muhammed@mulearn');
    expect(dto.roles, ['Student']);
    expect(dto.rank, 86);
    expect(dto.interestGroups, isEmpty);
  });

  test('toDomain keeps selected interest groups and drops deselected ones',
      () {
    final dto = UserProfileDto.fromJson({
      ...realResponseJson,
      'interest_groups': [
        {'id': 'ig-1', 'name': 'Web Development', 'karma': 120},
        {'id': 'ig-2', 'name': 'AI', 'karma': 40, 'selected': false},
      ],
    });

    final domain = dto.toDomain();

    expect(domain.roles, ['Student']);
    expect(domain.interestGroups, hasLength(1));
    expect(domain.interestGroups.single.name, 'Web Development');
    expect(domain.rank, 86);
  });
}
