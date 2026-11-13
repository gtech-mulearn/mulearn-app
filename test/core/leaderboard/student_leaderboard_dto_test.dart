import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/leaderboard/data/dtos/student_leaderboard_entry_dto.dart';

import '../../support/fixtures.dart';

void main() {
  final rows = (loadFixtureResponse('serializer/students_leaderboard')! as List)
      .cast<Map<String, dynamic>>();

  test('a student without a college is kept, with no institution', () {
    final entries = rows.map((r) => StudentLeaderboardEntryDto.fromJson(r).toDomain()).toList();

    expect(entries, hasLength(3));
    expect(entries[2].institution, isNull);
    expect(entries[0].institution, 'St. Josephs Colege of Engineering and Technology');
  });

  test('every row carries the muid so it can open the profile', () {
    final entries = rows.map((r) => StudentLeaderboardEntryDto.fromJson(r).toDomain()).toList();

    expect(entries.map((e) => e.muid), ['fixture-a@mulearn', 'fixture-b@mulearn', 'fixture-c@mulearn']);
  });
}
