import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/models/event_organizer_dto.dart';
import 'package:mulearn_app/features/dashboard/data/dtos/featured_event_dto.dart';
import 'package:mulearn_app/features/events/data/dtos/event_dto.dart';

import '../../support/fixtures.dart';

/// Backend contract (api/dashboard/events/serializers.py OrganizerInfoSerializer):
/// organiser_ig → MinimalIGSerializer {id, name, icon, cover_image, icon_image} | null;
/// organiser_campus / organiser_company → MinimalCampusSerializer {id, title, org_type} | null.
void main() {
  List<Map<String, dynamic>> events(String fixture) =>
      ((loadFixture(fixture)['response'] as Map<String, dynamic>)['data'] as List<dynamic>)
          .cast<Map<String, dynamic>>();

  Map<String, dynamic> firstOrganisedBy(String type) => [
        ...events('dev/events_page1'),
        ...events('dev/events_page2'),
      ].firstWhere(
        (e) => (e['organizer'] as Map<String, dynamic>)['organiser_type'] == type,
      );

  test('every event recorded on dev parses, whatever its organiser type', () {
    for (final fixture in ['dev/events_page1', 'dev/events_page2']) {
      for (final json in events(fixture)) {
        expect(() => EventDto.fromJson(json).toDomain(), returnsNormally, reason: json['title'] as String?);
      }
    }
    for (final json in events('dev/events_featured')) {
      expect(() => FeaturedEventDto.fromJson(json).toDomain(), returnsNormally, reason: json['title'] as String?);
    }
  });

  test('an IG organiser keeps the IG id and name', () {
    final json = firstOrganisedBy('global_ig');
    final ig = (json['organizer'] as Map<String, dynamic>)['organiser_ig'] as Map<String, dynamic>;

    final organizer = EventDto.fromJson(json).toDomain().organizer;

    expect(organizer.organiserIg?.id, ig['id']);
    expect(organizer.organiserIg?.name, ig['name']);
    expect(organizer.organiserCampus, isNull);
  });

  test('a campus organiser keeps the campus id and title', () {
    final json = firstOrganisedBy('campus');
    final campus = (json['organizer'] as Map<String, dynamic>)['organiser_campus'] as Map<String, dynamic>;

    final organizer = EventDto.fromJson(json).toDomain().organizer;

    expect(organizer.organiserCampus?.id, campus['id']);
    expect(organizer.organiserCampus?.title, campus['title']);
    expect(organizer.organiserIg, isNull);
  });

  test('an admin event has no organiser entity', () {
    final organizer = EventDto.fromJson(firstOrganisedBy('admin')).toDomain().organizer;

    expect(organizer.organiserType, 'admin');
    expect(organizer.organiserIg, isNull);
    expect(organizer.organiserCampus, isNull);
    expect(organizer.organiserCompany, isNull);
  });

  test('a company organiser uses the same {id, title, org_type} shape as a campus', () {
    final organizer = EventOrganizerDto.fromJson({
      'organiser_type': 'company',
      'organiser_ig': null,
      'organiser_campus': null,
      'organiser_company': {'id': 'c1', 'title': 'Acme Labs', 'org_type': 'Company'},
      'organiser_ci_id': null,
    }).toDomain();

    expect(organizer.organiserCompany?.title, 'Acme Labs');
    expect(organizer.organiserCompany?.orgType, 'Company');
  });
}
