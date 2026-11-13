import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/features/profile/data/dtos/editable_profile_dto.dart';

import '../../support/fixtures.dart';

/// `GET /api/v1/dashboard/profile/` (UserProfileEditSerializer) is the only
/// profile endpoint that returns the user's department — `{id, title}` from
/// their college link, or null. `user-profile/` never did.
void main() {
  test('the profile recorded on dev carries the college department', () {
    final json = loadFixture('dev/editable_profile')['response'] as Map<String, dynamic>;

    final profile = EditableProfileDto.fromJson(json).toDomain();

    expect(profile.department?.title, 'Computer Science');
    expect(profile.department?.id, isNotEmpty);
    expect(profile.mobile, '', reason: 'mobile is null on dev and must not break the form');
  });

  test('a user with no college link has no department', () {
    final profile = EditableProfileDto.fromJson(const {
      'full_name': 'A',
      'email': 'a@example.com',
      'mobile': null,
      'department': null,
    }).toDomain();

    expect(profile.department, isNull);
  });
}
