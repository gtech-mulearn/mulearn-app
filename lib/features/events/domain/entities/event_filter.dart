import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_filter.freezed.dart';

/// The backend's event types (`Event.EventType`, db/events.py) with their
/// labels.
const Map<String, String> eventTypeLabels = {
  'hackathon': 'Hackathon',
  'workshop': 'Workshop',
  'webinar': 'Webinar',
  'seminar': 'Seminar',
  'bootcamp': 'Bootcamp',
  'meetup': 'Meetup',
  'conference': 'Conference',
  'competition': 'Competition',
  'ideathon': 'Ideathon',
  'cultural_event': 'Cultural Event',
  'sports_event': 'Sports Event',
  'community_event': 'Community Event',
  'expo': 'Expo',
  'networking_event': 'Networking Event',
};

/// Event list filters (EventListAPI): [search] (title, description, city,
/// organiser), [eventType], [igId] (`ig_id`), [from] (`start_date`), and
/// [eligibleOnly] (no karma gate above the viewer's karma). Empty values
/// aren't sent.
@freezed
abstract class EventFilter with _$EventFilter {
  const factory EventFilter({
    @Default('') String search,
    String? eventType,
    String? igId,
    DateTime? from,
    @Default(false) bool eligibleOnly,
  }) = _EventFilter;

  const EventFilter._();

  Map<String, Object> get query {
    final f = from;
    String two(int n) => n.toString().padLeft(2, '0');
    return {
      if (search.trim().isNotEmpty) 'search': search.trim(),
      if (eventType != null) 'event_type': eventType!,
      if (igId != null) 'ig_id': igId!,
      if (f != null) 'start_date': '${f.year}-${two(f.month)}-${two(f.day)}',
      if (eligibleOnly) 'eligible_only': 'true',
    };
  }

  /// How many sheet filters are on (search isn't counted).
  int get activeCount => [eventType != null, igId != null, from != null, eligibleOnly].where((on) => on).length;
}
