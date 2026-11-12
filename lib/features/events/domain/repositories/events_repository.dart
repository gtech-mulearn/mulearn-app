import 'package:mulearn_app/features/events/domain/entities/event.dart';
import 'package:mulearn_app/features/events/domain/entities/event_page.dart';

abstract interface class EventsRepository {
  Future<EventPage> getEvents({required int pageIndex});

  Future<Event> getEventDetail(String id);

  Future<void> setInterested(String id, {required bool interested});
}
