import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting.dart';

part 'meeting_page.freezed.dart';

/// One page of a circle's meetings — `GET .../meeting/list/<circle_id>/`
/// returns `{data, pagination}` since backend 5dd14fa0 (2026-08-19).
@freezed
abstract class MeetingPage with _$MeetingPage {
  const factory MeetingPage({
    required List<Meeting> meetings,
    required bool hasNext,
  }) = _MeetingPage;
}
