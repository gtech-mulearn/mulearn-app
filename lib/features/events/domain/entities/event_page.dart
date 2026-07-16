import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/events/domain/entities/event.dart';

part 'event_page.freezed.dart';

/// One page of the paginated event list.
@freezed
abstract class EventPage with _$EventPage {
  const factory EventPage({
    required List<Event> events,
    required bool hasNext,
    required int totalPages,
  }) = _EventPage;
}
