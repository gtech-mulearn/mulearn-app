import 'package:freezed_annotation/freezed_annotation.dart';

part 'enabler.freezed.dart';

/// A campus an enabler looks after (`enabler/campuses/`).
@freezed
abstract class EnablerCampus with _$EnablerCampus {
  const factory EnablerCampus({
    required String id,
    required String collegeName,
    required String campusCode,
    required String zone,
    required String orgType,
  }) = _EnablerCampus;
}

/// An enabler's note about a campus. [priority] is `low`, `medium` or
/// `high` as the app writes it (the backend stores free text; default
/// `medium`); [status] defaults to `open`. Notes can't be edited or deleted.
@freezed
abstract class CampusNote with _$CampusNote {
  const factory CampusNote({
    required String id,
    required String note,
    required String priority,
    required String status,
    required DateTime createdAt,
    String? author,
    DateTime? followUp,
  }) = _CampusNote;
}

/// `enabler/home-summary/`.
typedef EnablerSummary = ({int campuses, int students, int karma});
