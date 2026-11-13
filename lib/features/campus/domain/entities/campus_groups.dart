import 'package:freezed_annotation/freezed_annotation.dart';

part 'campus_groups.freezed.dart';

/// A learning circle at the campus (`campus/learning-circles/`).
/// [lastMeetingTime] is the latest meeting, which may still be ahead.
@freezed
abstract class CampusCircle with _$CampusCircle {
  const factory CampusCircle({
    required String id,
    required String name,
    required String igName,
    required int memberCount,
    required int meetingCount,
    DateTime? lastMeetingTime,
  }) = _CampusCircle;
}

/// An interest group with how many of the campus's learners are in it
/// (`campus/igs/`).
@freezed
abstract class CampusIg with _$CampusIg {
  const factory CampusIg({
    required String id,
    required String name,
    required String code,
    required int campusMemberCount,
    String? iconImage,
  }) = _CampusIg;
}
