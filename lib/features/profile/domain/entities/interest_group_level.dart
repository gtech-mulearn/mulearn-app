import 'package:freezed_annotation/freezed_annotation.dart';

part 'interest_group_level.freezed.dart';

/// An interest group's level progress, e.g. `{unit: "level", count: 3}` →
/// "Level 3" — pure-Dart domain entity (rules.md §2).
@freezed
abstract class InterestGroupLevel with _$InterestGroupLevel {
  const factory InterestGroupLevel({
    required String unit,
    required int count,
  }) = _InterestGroupLevel;
}
