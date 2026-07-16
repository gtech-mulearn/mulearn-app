import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/core/models/event_organizer_dto.dart';
import 'package:mulearn_app/core/models/event_venue_dto.dart';
import 'package:mulearn_app/features/events/domain/entities/event.dart';

part 'event_dto.freezed.dart';
part 'event_dto.g.dart';

/// Raw shape of one entry in `events/`'s `data` array, and of
/// `events/{id}/`'s full response — confirmed live (rules.md §3/§9) to
/// share every field the list rows have; detail adds a handful more that
/// simply aren't present on list rows.
@freezed
abstract class EventDto with _$EventDto {
  const factory EventDto({
    required String id,
    required String title,
    required String slug,
    required String status,
    required String eventScope,
    required String eventType,
    required String startDatetime,
    required String endDatetime,
    required EventVenueDto venue,
    required EventOrganizerDto organizer,
    @Default(false) bool isFeatured,
    @Default(false) bool isCollaboration,
    @Default(0) int interestCount,
    @Default('none') String viewerInterestStatus,
    @Default([]) List<String> tags,
    String? coverImage,
    String? bannerImage,
    String? description,
    String? categoryName,
    String? registrationUrl,
    String? registrationDeadline,
    int? minKarma,
    int? userLimit,
  }) = _EventDto;

  const EventDto._();

  factory EventDto.fromJson(Map<String, dynamic> json) =>
      _$EventDtoFromJson(json);

  Event toDomain() => Event(
        id: id,
        title: title,
        slug: slug,
        status: status,
        eventScope: eventScope,
        eventType: eventType,
        startDatetime: startDatetime,
        endDatetime: endDatetime,
        venue: venue.toDomain(),
        organizer: organizer.toDomain(),
        isFeatured: isFeatured,
        isCollaboration: isCollaboration,
        interestCount: interestCount,
        viewerInterestStatus: viewerInterestStatus,
        tags: tags,
        coverImage: coverImage,
        bannerImage: bannerImage,
        description: description,
        categoryName: categoryName,
        registrationUrl: registrationUrl,
        registrationDeadline: registrationDeadline,
        minKarma: minKarma,
        userLimit: userLimit,
      );
}
