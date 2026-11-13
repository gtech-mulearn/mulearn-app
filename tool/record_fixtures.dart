// Records real responses from the dev backend as test fixtures.
//
//   dart run tool/record_fixtures.dart            # every target
//   dart run tool/record_fixtures.dart slug1 slug2 # only these
//
// Reads QA account credentials from `.env.qa` (gitignored; see
// `.env.qa.example`), signs in through the same auth endpoint the app uses,
// fetches a fixed list of endpoints, scrubs personal data, and writes
// `test/fixtures/dev/<slug>.json`. Tokens and passwords are never printed.
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'fixture_scrub.dart';

const _baseUrl = 'https://dev.mulearn.org';
const _roles = ['student', 'mentor', 'enabler', 'campuslead'];

/// One fixture to record: [account] is null for unauthenticated endpoints.
/// Non-GET targets must be side-effect free on dev (e.g. a foreign id that
/// 404s, or a request the backend rejects).
class _Target {
  const _Target(this.slug, this.path, {this.account = 'student', this.method = 'GET', this.data});
  final String slug;
  final String path;
  final String? account;
  final String method;
  final Object? data;
}

List<_Target> _targets() {
  final now = DateTime.now();
  final first = DateTime(now.year, now.month);
  final last = DateTime(now.year, now.month + 1, 0);
  String d(DateTime x) =>
      '${x.year}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}';
  final calendar =
      '/api/v1/dashboard/calendar/events/?start_date=${d(first)}&end_date=${d(last)}';

  return [
    const _Target('user_info', '/api/v1/dashboard/user/info/'),
    const _Target('user_info_mentor', '/api/v1/dashboard/user/info/', account: 'mentor'),
    const _Target('user_info_enabler', '/api/v1/dashboard/user/info/', account: 'enabler'),
    const _Target('user_info_campuslead', '/api/v1/dashboard/user/info/', account: 'campuslead'),
    const _Target('mentor_status', '/api/v1/dashboard/mentor/status/', account: 'mentor'),
    const _Target('user_profile', '/api/v1/dashboard/profile/user-profile/'),
    // lvl1…lvl7; every level has 0 tasks on dev (2026-11-13).
    const _Target('get_user_levels', '/api/v1/dashboard/profile/get-user-levels/'),
    const _Target('editable_profile', '/api/v1/dashboard/profile/'),
    const _Target('task_list', '/api/v1/dashboard/task/list/'),
    const _Target('events_page1', '/api/v1/dashboard/events/?pageIndex=1&perPage=20'),
    const _Target('events_page2', '/api/v1/dashboard/events/?pageIndex=2&perPage=20'),
    const _Target('events_featured', '/api/v1/dashboard/events/featured/'),
    const _Target('circles_page1', '/api/v1/dashboard/learningcircle/list/?pageIndex=1&perPage=20'),
    const _Target('user_circles', '/api/v1/dashboard/learningcircle/user-circles/'),
    // Discover filters: circles the student hasn't joined, titled like "Club".
    const _Target('circles_filtered', '/api/v1/dashboard/learningcircle/list/?status=not_joined&search=Club&pageIndex=1&perPage=20'),
    // A seeded circle the QA student belongs to as a plain member.
    const _Target('circle_detail', '/api/v1/dashboard/learningcircle/info/463e9e4a-7255-431d-95f9-5bd181a48d12/'),
    const _Target('circle_members', '/api/v1/dashboard/learningcircle/members/463e9e4a-7255-431d-95f9-5bd181a48d12/'),
    // An upcoming meeting in another of the student's circles.
    const _Target('meeting_detail', '/api/v1/dashboard/learningcircle/meeting/info/d3510fbd-acc6-4c11-8833-dc159c61b6f7/'),
    const _Target('my_invites', '/api/v1/dashboard/learningcircle/invite/status/'),
    _Target('calendar_student', calendar),
    _Target('calendar_mentor', calendar, account: 'mentor'),
    const _Target('leaderboard_students', '/api/v1/leaderboard/students/', account: null),
    const _Target('leaderboard_students_monthly', '/api/v1/leaderboard/students-monthly/', account: null),
    const _Target('leaderboard_college', '/api/v1/leaderboard/college/', account: null),
    const _Target('leaderboard_college_monthly', '/api/v1/leaderboard/college-monthly/', account: null),
    const _Target('ig_list', '/api/v1/dashboard/ig/list/', account: null),
    const _Target('notifications_page1', '/api/v1/notification/?page=1&page_size=20'),
    const _Target('notifications_unread_count', '/api/v1/notification/unread-count/'),
    const _Target('learner_summary', '/api/v1/dashboard/home/learner/summary/'),
    // A published, global, admin-organised event with no linked tasks.
    const _Target('event_detail', '/api/v1/dashboard/events/3d2eba4f-915d-40b9-bc28-dc04c98ed4a9/'),
    const _Target('learner_streak', '/api/v1/dashboard/home/learner/streak/'),
    // A random, unowned id: the backend answers 404 and changes nothing.
    const _Target(
      'notification_read_foreign',
      '/api/v1/notification/00000000-0000-4000-8000-000000000000/read/',
      method: 'PATCH',
    ),
    // A made-up Discord code: Discord refuses it, nothing is linked.
    const _Target('connect_discord_bad_code', '/api/v1/register/connect-discord/?code=not-a-real-code'),
    // A wrong current password: rejected before anything changes.
    const _Target(
      'change_password_wrong_current',
      '/api/v1/dashboard/profile/change-password/',
      method: 'POST',
      data: {'current_password': 'not-the-current-password', 'password': 'unused-new-password-1'},
    ),
  ];
}

Map<String, String> _readEnv(String path) {
  final file = File(path);
  if (!file.existsSync()) {
    stderr.writeln('Missing $path — copy .env.qa.example and fill in the QA accounts.');
    exit(64);
  }
  final env = <String, String>{};
  for (final line in file.readAsLinesSync()) {
    final trimmed = line.trim();
    if (trimmed.isEmpty || trimmed.startsWith('#') || !trimmed.contains('=')) continue;
    final i = trimmed.indexOf('=');
    env[trimmed.substring(0, i).trim()] = trimmed.substring(i + 1).trim();
  }
  return env;
}

String? _muidFromJwt(String jwt) {
  final parts = jwt.split('.');
  if (parts.length != 3) return null;
  final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
  return (jsonDecode(payload) as Map<String, dynamic>)['muid'] as String?;
}

Future<void> main(List<String> only) async {
  final env = _readEnv('.env.qa');
  final dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 60),
    validateStatus: (_) => true,
    headers: {'User-Agent': 'mulearn-app-fixture-recorder'},
  ));

  final tokens = <String, String>{};
  final keepMuids = <String>{};
  for (final role in _roles) {
    final email = env['QA_${role.toUpperCase()}_EMAIL'];
    final password = env['QA_${role.toUpperCase()}_PASSWORD'];
    if (email == null || password == null) continue;
    final res = await dio.post<dynamic>(
      '/api/v1/auth/user-authentication/',
      data: {'emailOrMuid': email, 'password': password},
    );
    final body = res.data as Map<String, dynamic>;
    final token = (body['response'] as Map?)?['accessToken'] as String?;
    if (body['hasError'] == true || token == null) {
      stderr.writeln('Sign-in failed for $role: ${body['message']}');
      continue;
    }
    tokens[role] = token;
    final muid = _muidFromJwt(token);
    if (muid != null) keepMuids.add(muid);
  }

  final outDir = Directory('test/fixtures/dev')..createSync(recursive: true);
  final recordedAt = DateTime.now().toUtc().toIso8601String();
  for (final target in _targets()) {
    if (only.isNotEmpty && !only.contains(target.slug)) continue;
    final account = target.account;
    if (account != null && !tokens.containsKey(account)) {
      print('skip ${target.slug}: no $account session');
      continue;
    }
    final res = await dio.request<dynamic>(
      target.path,
      data: target.data,
      options: Options(method: target.method, headers: {
        if (account != null) 'Authorization': 'Bearer ${tokens[account]}',
      }),
    );
    final fixture = {
      '_meta': {
        'source': 'dev',
        'endpoint': target.method == 'GET' ? target.path : '${target.method} ${target.path}',
        'account': account,
        'status': res.statusCode,
        'recorded_at': recordedAt,
      },
      'body': scrubFixture(res.data, keepMuids: keepMuids),
    };
    File('${outDir.path}/${target.slug}.json')
        .writeAsStringSync('${const JsonEncoder.withIndent('  ').convert(fixture)}\n');
    print('recorded ${target.slug} (${res.statusCode})');
  }
}
