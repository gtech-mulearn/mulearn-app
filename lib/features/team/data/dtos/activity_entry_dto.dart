import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/team/domain/entities/activity_entry.dart';

part 'activity_entry_dto.freezed.dart';
part 'activity_entry_dto.g.dart';

/// One `data[]` item of `GET /api/v1/notification/activity-log/` (`_item`,
/// `api/notification/activity_log_view.py`). The actor is a nested
/// `{full_name, muid}`.
@freezed
abstract class ActivityEntryDto with _$ActivityEntryDto {
  const factory ActivityEntryDto({
    required String id,
    required String action,
    required String createdAt,
    @Default('') String label,
    @Default(<String>[]) List<String> roles,
    Map<String, dynamic>? actor,
    String? title,
    int? audienceSize,
    String? audienceLabel,
    Map<String, dynamic>? oldData,
    Map<String, dynamic>? newData,
  }) = _ActivityEntryDto;

  const ActivityEntryDto._();

  factory ActivityEntryDto.fromJson(Map<String, dynamic> json) =>
      _$ActivityEntryDtoFromJson(json);

  ActivityEntry toDomain() {
    final before = oldData;
    final after = newData;
    return ActivityEntry(
      id: id,
      action: action,
      label: label,
      actorName: actor?['full_name'] as String? ?? '',
      actorMuid: actor?['muid'] as String? ?? '',
      roles: roles,
      title: title,
      audienceSize: audienceSize,
      audienceLabel: audienceLabel,
      createdAt: DateTime.parse(createdAt).toUtc(),
      oldData: before == null ? null : Map<String, Object?>.of(before),
      newData: after == null ? null : Map<String, Object?>.of(after),
    );
  }
}
