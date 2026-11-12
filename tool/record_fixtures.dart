// Records real responses from the dev backend as test fixtures.
//
//   dart run tool/record_fixtures.dart
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
class _Target {
  const _Target(this.slug, this.path, {this.account = 'student'});
  final String slug;
  final String path;
  final String? account;
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
    const _Target('user_profile', '/api/v1/dashboard/profile/user-profile/'),
    const _Target('editable_profile', '/api/v1/dashboard/profile/'),
    const _Target('task_list', '/api/v1/dashboard/task/list/'),
    const _Target('events_page1', '/api/v1/dashboard/events/?pageIndex=1&perPage=20'),
    const _Target('events_page2', '/api/v1/dashboard/events/?pageIndex=2&perPage=20'),
    const _Target('events_featured', '/api/v1/dashboard/events/featured/'),
    const _Target('circles_page1', '/api/v1/dashboard/learningcircle/list/?pageIndex=1&perPage=20'),
    const _Target('user_circles', '/api/v1/dashboard/learningcircle/user-circles/'),
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
    const _Target('learner_streak', '/api/v1/dashboard/home/learner/streak/'),
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

Future<void> main() async {
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
    final account = target.account;
    if (account != null && !tokens.containsKey(account)) {
      print('skip ${target.slug}: no $account session');
      continue;
    }
    final res = await dio.get<dynamic>(
      target.path,
      options: Options(headers: {
        if (account != null) 'Authorization': 'Bearer ${tokens[account]}',
      }),
    );
    final fixture = {
      '_meta': {
        'source': 'dev',
        'endpoint': target.path,
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
