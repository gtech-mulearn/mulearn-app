import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_entry.freezed.dart';

/// One row of the team activity log (`api/notification/activity_log_view.py`).
@freezed
abstract class ActivityEntry with _$ActivityEntry {
  const factory ActivityEntry({
    required String id,
    required String action,
    required String label,
    required String actorName,
    required String actorMuid,
    required List<String> roles,
    required DateTime createdAt,
    String? title,
    int? audienceSize,
    String? audienceLabel,
    Map<String, Object?>? oldData,
    Map<String, Object?>? newData,
  }) = _ActivityEntry;
}

/// One page of the activity log.
typedef ActivityPage = ({List<ActivityEntry> items, bool hasNext});
