import 'package:dio/dio.dart';
import 'package:mulearn_app/core/models/reference_option.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/network/tolerant_parse.dart';
import 'package:mulearn_app/features/team/data/datasources/team_remote_datasource.dart';
import 'package:mulearn_app/features/team/data/dtos/activity_entry_dto.dart';
import 'package:mulearn_app/features/team/data/dtos/announcement_dto.dart';
import 'package:mulearn_app/features/team/data/dtos/push_campaign_dto.dart';
import 'package:mulearn_app/features/team/domain/entities/activity_entry.dart';
import 'package:mulearn_app/features/team/domain/entities/announcement.dart';
import 'package:mulearn_app/features/team/domain/entities/campaign_draft.dart';
import 'package:mulearn_app/features/team/domain/entities/push_campaign.dart';
import 'package:mulearn_app/features/team/domain/repositories/team_repository.dart';

class TeamRepositoryImpl implements TeamRepository {
  const TeamRepositoryImpl(this._remote);

  final TeamRemoteDataSource _remote;

  static const _testPushDone = 'Test push sent to your devices.';

  @override
  Future<AnnouncementPage> announcements(int page) => _guard(() async {
    final body = await _remote.fetchBroadcasts(page);
    final info = PagePaging.parse(body);
    final items = parseEachOrReport(
      body['results'] as List<dynamic>? ?? const [],
      (json) => AnnouncementDto.fromJson(json).toDomain(),
      what: 'AnnouncementDto',
    );
    return (items: items, hasNext: info.hasNext, total: info.count);
  });

  @override
  Future<void> sendToEveryone({
    required String title,
    required String description,
    String? redirectUrl,
    int? expiresInDays,
  }) => _guard(
    () => _remote.sendToEveryone({
      'title': title,
      'description': description,
      if (redirectUrl != null) 'redirect_url': redirectUrl,
      if (expiresInDays != null) 'expires_in_days': expiresInDays,
    }),
  );

  @override
  Future<Announcement> updateAnnouncement(
    String id, {
    String? title,
    String? description,
    String? url,
    DateTime? expiresAt,
  }) => _guard(() async {
    final row = await _remote.updateBroadcast(id, {
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (url != null) 'url': url,
      if (expiresAt != null) 'expires_at': expiresAt.toUtc().toIso8601String(),
    });
    return AnnouncementDto.fromJson(row).toDomain();
  });

  @override
  Future<void> deleteAnnouncement(String id) =>
      _guard(() => _remote.deleteBroadcast(id));

  @override
  Future<void> deleteAllAnnouncements() => _guard(_remote.deleteAllBroadcasts);

  @override
  Future<List<PushCampaign>> campaigns() => _guard(() async {
    final body = await _remote.fetchCampaigns();
    return parseEachOrReport(
      body['campaigns'] as List<dynamic>? ?? const [],
      (json) => PushCampaignDto.fromJson(json).toDomain(),
      what: 'PushCampaignDto',
    );
  });

  @override
  Future<PushCampaign> createCampaign(CampaignDraft draft) => _guard(() async {
    final scheduledAt = draft.scheduledAt;
    final row = await _remote.createCampaign({
      'title': draft.title,
      'body': draft.body,
      'route': draft.route,
      'audience': {'type': draft.audienceType.name, 'ids': draft.audienceIds},
      if (scheduledAt != null)
        'scheduled_at': scheduledAt.toUtc().toIso8601String(),
      'respect_quiet_hours': draft.respectQuietHours,
    });
    return PushCampaignDto.fromJson(row).toDomain();
  });

  @override
  Future<void> campaignAction(String id, CampaignAction action) =>
      _guard(() => _remote.campaignAction(id, action.name));

  @override
  Future<String> sendTestPush() =>
      _guard(() async => await _remote.sendTestPush() ?? _testPushDone);

  @override
  Future<ActivityPage> activity(int pageIndex, {String? action}) =>
      _guard(() async {
        final body = await _remote.fetchActivity(pageIndex, action: action);
        final items = parseEachOrReport(
          body['data'] as List<dynamic>? ?? const [],
          (json) => ActivityEntryDto.fromJson(json).toDomain(),
          what: 'ActivityEntryDto',
        );
        final info = PageIndexPaging.parse(
          body['pagination'] as Map<String, dynamic>?,
        );
        return (items: items, hasNext: info.hasNext);
      });

  @override
  Future<List<ReferenceOption>> roles() => _guard(
    () async =>
        _options((await _remote.fetchRoles())['roles'], titleKey: 'title'),
  );

  @override
  Future<List<ReferenceOption>> interestGroups() => _guard(
    () async => _options(
      (await _remote.fetchInterestGroups())['interestGroup'],
      titleKey: 'name',
    ),
  );

  @override
  Future<List<ReferenceOption>> searchColleges(String query) {
    final term = query.trim();
    if (term.length < 2) return Future.value(const []);
    return _guard(
      () async => _options(
        (await _remote.searchColleges(term))['data'],
        titleKey: 'title',
      ),
    );
  }

  static List<ReferenceOption> _options(
    Object? rows, {
    required String titleKey,
  }) => [
    if (rows is List)
      for (final row in rows.whereType<Map<String, dynamic>>())
        if (row['id'] != null && row[titleKey] != null)
          ReferenceOption(id: '${row['id']}', title: '${row[titleKey]}'),
  ];

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
