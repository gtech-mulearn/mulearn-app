import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/core/models/event_organizer_ig.dart';

part 'event_organizer_ig_dto.freezed.dart';
part 'event_organizer_ig_dto.g.dart';

/// `organizer.organiser_ig` — `MinimalIGSerializer` in
/// api/dashboard/events/serializers.py (`{id, name, icon, cover_image,
/// icon_image}`). `icon` is the legacy emoji/code column and `cover_image`
/// isn't shown anywhere an organiser appears, so neither is kept.
@freezed
abstract class EventOrganizerIgDto with _$EventOrganizerIgDto {
  const factory EventOrganizerIgDto({
    required String id,
    required String name,
    String? iconImage,
  }) = _EventOrganizerIgDto;

  const EventOrganizerIgDto._();

  factory EventOrganizerIgDto.fromJson(Map<String, dynamic> json) =>
      _$EventOrganizerIgDtoFromJson(json);

  EventOrganizerIg toDomain() => EventOrganizerIg(id: id, name: name, iconImage: iconImage);
}
