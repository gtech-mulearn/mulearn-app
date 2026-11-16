import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/api_paths.dart';
import 'package:mulearn_app/core/session/mentor_application.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_application_form.dart';
import 'package:mulearn_app/features/mentor/domain/repositories/mentor_applications_repository.dart';

/// `api/dashboard/mentor/urls.py` §14, and the pickers the dashboard's
/// `MentorOnboardingForm` uses.
abstract final class MentorApplicationPaths {
  const MentorApplicationPaths._();

  /// `POST` a new application; `PATCH {id, …}` a pending one.
  static const String register = '/api/v1/dashboard/mentor/register/';

  /// `GET` the mentor profile (about, expertise, hours, linkedin) and every
  /// application's answers; 404 before the first application.
  static const String profile = '/api/v1/dashboard/mentor/profile/';

  /// `GET ?search=&perPage=` — colleges under `response.data`.
  static const String colleges =
      '/api/v1/dashboard/organisation/institutes/college/';
}

class MentorApplicationsRemoteDataSource {
  const MentorApplicationsRemoteDataSource(this._dio);

  final Dio _dio;

  Future<String?> submit(Map<String, Object?> body) async =>
      ApiEnvelope.unwrapMessage(
        await _dio.post<dynamic>(MentorApplicationPaths.register, data: body),
      );

  Future<String?> update(Map<String, Object?> body) async =>
      ApiEnvelope.unwrapMessage(
        await _dio.patch<dynamic>(MentorApplicationPaths.register, data: body),
      );

  Future<Map<String, dynamic>> fetchProfile() async => ApiEnvelope.unwrapObject(
    await _dio.get<dynamic>(MentorApplicationPaths.profile),
  );

  Future<Map<String, dynamic>> fetchInterestGroups() async =>
      ApiEnvelope.unwrapObject(
        await _dio.get<dynamic>(ApiPaths.interestGroupsList),
      );

  Future<Map<String, dynamic>> fetchCompanies() async =>
      ApiEnvelope.unwrapObject(
        await _dio.get<dynamic>(ApiPaths.registerCompanies),
      );

  Future<Map<String, dynamic>> searchColleges(String query) async =>
      ApiEnvelope.unwrapObject(
        await _dio.get<dynamic>(
          MentorApplicationPaths.colleges,
          queryParameters: {'search': query, 'perPage': 20},
        ),
      );
}

class MentorApplicationsRepositoryImpl implements MentorApplicationsRepository {
  const MentorApplicationsRepositoryImpl(this._remote);

  final MentorApplicationsRemoteDataSource _remote;

  static String? _str(Object? v) {
    if (v == null) return null;
    final s = '$v'.trim();
    return s.isEmpty ? null : s;
  }

  static List<MentorChoice> _choices(Object? rows, {String name = 'title'}) => [
    if (rows is List)
      for (final r in rows.whereType<Map<String, dynamic>>())
        if (_str(r['id']) case final id?)
          if (_str(r[name]) case final label?) (id: id, name: label),
  ]..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

  /// `GET /mentor/profile/`: `{about, expertise: "a, b", hours, linkedin,
  /// applications: [{id, mentor_tier, org, org_name, reason,
  /// preferred_ig_ids}]}` — confirmed live on dev 2026-11-16.
  static MentorProfileSnapshot parseSnapshot(Map<String, dynamic> json) {
    final apps = json['applications'];
    return MentorProfileSnapshot(
      about: _str(json['about']) ?? '',
      expertise: [
        for (final e in (_str(json['expertise']) ?? '').split(','))
          if (e.trim().isNotEmpty) e.trim(),
      ],
      hours: mentorHoursChoices.contains(_str(json['hours']))
          ? _str(json['hours'])
          : null,
      linkedin: _str(json['linkedin']) ?? '',
      applications: [
        if (apps is List)
          for (final a in apps.whereType<Map<String, dynamic>>())
            if (_str(a['id']) case final id?)
              MentorApplicationAnswers(
                id: id,
                tier: MentorTier.parse(_str(a['mentor_tier'])),
                organization: switch ((_str(a['org']), _str(a['org_name']))) {
                  (final orgId?, final name?) => (id: orgId, name: name),
                  _ => null,
                },
                reason: _str(a['reason']) ?? '',
                preferredIgIds: [
                  if (a['preferred_ig_ids'] case final List<dynamic> ids)
                    for (final i in ids)
                      if (_str(i) case final s?) s,
                ],
              ),
      ],
    );
  }

  Future<T> _guard<T>(Future<T> Function() body) async {
    try {
      return await body();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<String> submit(MentorApplicationDraft draft) => _guard(
    () async =>
        await _remote.submit(draft.toBody()) ?? 'Application sent for review.',
  );

  @override
  Future<String> update(String applicationId, MentorApplicationDraft draft) =>
      _guard(
        () async =>
            await _remote.update(draft.toBody(applicationId: applicationId)) ??
            'Application updated.',
      );

  @override
  Future<MentorProfileSnapshot?> snapshot() async {
    try {
      return parseSnapshot(await _remote.fetchProfile());
    } on DioException catch (e) {
      // No profile before the first application (404), or not a Mentor
      // (403): start blank.
      final code = e.response?.statusCode;
      if (code == 404 || code == 403) return null;
      throw ApiException.fromDioException(e);
    } on ApiException catch (e) {
      if (e.statusCode == 404 || e.statusCode == 403) return null;
      rethrow;
    }
  }

  @override
  Future<List<MentorChoice>> interestGroups() => _guard(
    () async => _choices(
      (await _remote.fetchInterestGroups())['interestGroup'],
      name: 'name',
    ),
  );

  @override
  Future<List<MentorChoice>> companies() => _guard(
    () async => _choices((await _remote.fetchCompanies())['companies']),
  );

  @override
  Future<List<MentorChoice>> searchColleges(String query) => _guard(
    () async => _choices((await _remote.searchColleges(query))['data']),
  );
}
