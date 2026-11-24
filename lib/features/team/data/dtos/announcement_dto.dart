import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/team/domain/entities/announcement.dart';

part 'announcement_dto.freezed.dart';
part 'announcement_dto.g.dart';

/// One `results[]` item of `GET /api/v1/notification/broadcast/list/all/`
/// (`BroadcastNotificationAdminSerializer`, `api/notification/serializers.py`).
/// The target's display name sits in `target_details.name`.
@freezed
abstract class AnnouncementDto with _$AnnouncementDto {
  const factory AnnouncementDto({
    required String id,
    required String createdAt,
    required String expiresAt,
    @Default('') String title,
    @Default('') String description,
    @Default('global') String targetType,
    @Default('system') String source,
    String? url,
    Map<String, dynamic>? targetDetails,
    String? createdByName,
  }) = _AnnouncementDto;

  const AnnouncementDto._();

  factory AnnouncementDto.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementDtoFromJson(json);

  Announcement toDomain() => Announcement(
    id: id,
    title: title,
    description: description,
    url: url,
    targetType: targetType,
    targetName: targetDetails?['name'] as String?,
    source: _source(source),
    createdByName: createdByName,
    createdAt: DateTime.parse(createdAt).toUtc(),
    expiresAt: DateTime.parse(expiresAt).toUtc(),
  );

  /// An unknown value is `system`, so a new backend source never breaks the
  /// list.
  static AnnouncementSource _source(String value) => switch (value) {
    'team' => AnnouncementSource.team,
    'learning_circle' => AnnouncementSource.learningCircle,
    'event' => AnnouncementSource.event,
    'project' => AnnouncementSource.project,
    _ => AnnouncementSource.system,
  };
}
