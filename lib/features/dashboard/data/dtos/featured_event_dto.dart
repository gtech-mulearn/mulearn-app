import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/core/models/event_organizer_dto.dart';
import 'package:mulearn_app/core/models/event_venue_dto.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/featured_event.dart';

part 'featured_event_dto.freezed.dart';
part 'featured_event_dto.g.dart';

@freezed
abstract class FeaturedEventDto with _$FeaturedEventDto {
  const factory FeaturedEventDto({
    required String id,
    required String title,
    required String slug,
    required String status,
    required String eventScope,
    required String startDatetime,
    required String endDatetime,
    required EventVenueDto venue,
    required EventOrganizerDto organizer,
    @Default(false) bool isCollaboration,
    @Default(0) int interestCount,
    @Default([]) List<String> tags,
    String? coverImage,
    int? minKarma,
  }) = _FeaturedEventDto;

  const FeaturedEventDto._();

  factory FeaturedEventDto.fromJson(Map<String, dynamic> json) =>
      _$FeaturedEventDtoFromJson(json);

  FeaturedEvent toDomain() => FeaturedEvent(
        id: id,
        title: title,
        slug: slug,
        status: status,
        eventScope: eventScope,
        startDatetime: startDatetime,
        endDatetime: endDatetime,
        venue: venue.toDomain(),
        organizer: organizer.toDomain(),
        isCollaboration: isCollaboration,
        interestCount: interestCount,
        tags: tags,
        coverImage: coverImage,
        minKarma: minKarma,
      );
}
