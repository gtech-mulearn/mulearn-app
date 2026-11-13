import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/features/notifications/data/dtos/notification_dto.dart';

import '../../support/fixtures.dart';

/// GET /api/v1/notification/ (NotificationListView): personal rows and
/// audience broadcasts merged, newest first. Broadcasts carry no type or
/// entity (recorded on dev: type null, category SYSTEM).
void main() {
  final results = ((loadFixtureResponse('dev/notifications_page1')! as Map<String, dynamic>)['results']
          as List<dynamic>)
      .cast<Map<String, dynamic>>();

  test('every recorded item parses', () {
    final items = results.map((j) => NotificationDto.fromJson(j).toDomain()).toList();

    expect(items, hasLength(results.length));
    expect(items.every((n) => n.id.isNotEmpty && n.title.isNotEmpty), isTrue);
  });

  test('a personal circle invite keeps its type and entity', () {
    final json = results.firstWhere((j) => j['type'] == 'LC_INVITE');

    final n = NotificationDto.fromJson(json).toDomain();

    expect(n.type, 'LC_INVITE');
    expect(n.category, 'LC');
    expect(n.entityType, 'learning_circle');
    expect(n.entityId, json['entity_id']);
    expect(n.isBroadcast, isFalse);
    expect(n.read, json['is_read']);
  });

  test('a broadcast has no type and is marked as a broadcast', () {
    final json = results.firstWhere((j) => j['source'] == 'broadcast');

    final n = NotificationDto.fromJson(json).toDomain();

    expect(n.type, isNull);
    expect(n.isBroadcast, isTrue);
    expect(n.redirectUrl, json['redirect_url']);
  });

  test('created_at is parsed as UTC', () {
    final n = NotificationDto.fromJson(results.first).toDomain();

    expect(n.createdAt.isUtc, isTrue);
    expect(n.createdAt, DateTime.parse(results.first['created_at'] as String));
  });
}
