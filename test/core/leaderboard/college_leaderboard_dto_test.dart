import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/leaderboard/data/dtos/college_leaderboard_entry_dto.dart';

import '../../support/fixtures.dart';

/// Both college boards return each college's `id`, so a row can open the
/// college's public page.
void main() {
  test('the all-time board keeps the college id', () {
    final rows = loadFixtureResponse('dev/leaderboard_college')! as List;
    final entry = CollegeLeaderboardEntryDto.fromJson(
      rows.first as Map<String, dynamic>,
    ).toDomain();

    expect(entry.id, 'ad3a3793-d780-4ec1-b03e-fac92e0faa0d');
    expect(entry.code, 'SJC');
  });

  test('the monthly shape maps students and keeps the id', () {
    final entry = CollegeLeaderboardEntryDto.fromJson(const {
      'id': 'x',
      'code': 'CHN',
      'title': 'COLLEGE OF ENGINEERING CHENGANNUR',
      'total_karma': 21145,
      'students': 18,
    }).toDomain();

    expect(entry.id, 'x');
    expect(entry.totalStudents, 18);
    expect(entry.totalKarma, 21145);
  });

  test('an entry without an id still parses', () {
    final entry = CollegeLeaderboardEntryDto.fromJson(const {
      'code': 'TLY',
      'title': 'COLLEGE OF ENGINEERING THALASSERY',
      'total_karma': 17745,
      'total_students': 70,
    }).toDomain();

    expect(entry.id, isNull);
    expect(entry.code, 'TLY');
  });
}
