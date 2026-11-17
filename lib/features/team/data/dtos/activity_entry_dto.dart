import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/team/data/dtos/campaign_status_parser.dart';
import 'package:mulearn_app/features/team/domain/entities/activity_campaign.dart';
import 'package:mulearn_app/features/team/domain/entities/activity_entry.dart';

part 'activity_entry_dto.freezed.dart';
part 'activity_entry_dto.g.dart';

/// One `data[]` item of `GET /api/v1/notification/activity-log/` (`_item`,
/// `api/notification/activity_log_view.py`). The actor is a nested
/// `{full_name, muid}`. `campaign` is the live status and counts of the
/// campaign a `push_campaign` row is about, null when it no longer exists.
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
    String? entityName,
    String? entityId,
    Map<String, dynamic>? campaign,
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
      entityName: entityName,
      entityId: entityId,
      campaign: _campaign(campaign),
      audienceSize: audienceSize,
      audienceLabel: audienceLabel,
      createdAt: DateTime.parse(createdAt).toUtc(),
      oldData: before == null ? null : Map<String, Object?>.of(before),
      newData: after == null ? null : Map<String, Object?>.of(after),
    );
  }

  static ActivityCampaign? _campaign(Map<String, dynamic>? json) {
    if (json == null) return null;
    int count(String key) => (json[key] as num?)?.toInt() ?? 0;
    return ActivityCampaign(
      status: parseCampaignStatus(json['status'] as String?),
      targetCount: count('target_count'),
      sentCount: count('sent_count'),
      skippedCount: count('skipped_count'),
      failedCount: count('failed_count'),
    );
  }
}
