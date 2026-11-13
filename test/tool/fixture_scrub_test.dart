import 'package:flutter_test/flutter_test.dart';

import '../../tool/fixture_scrub.dart';

void main() {
  test('scrubs personal values and keeps keys and other values', () {
    final scrubbed = scrubFixture(
      {
        'response': {
          'full_name': 'Real Name',
          'email': 'real@person.in',
          'mobile': '9999999999',
          'muid': 'someone@mulearn',
          'karma': 10,
        },
      },
      keepMuids: const {},
    );

    final r = scrubbed['response'] as Map<String, dynamic>;
    expect(r['full_name'], 'Fixture User');
    expect(r['email'], 'user@example.com');
    expect(r['mobile'], isNull);
    expect(r['muid'], 'fixture-user@mulearn');
    expect(r['karma'], 10);
  });

  test('keeps QA muids and scrubs people nested in lists', () {
    final scrubbed = scrubFixture(
      {
        'response': {
          'members': [
            {'muid': 'qastudentone@mulearn', 'full_name': 'QA Student One'},
            {'muid': 'other@mulearn', 'profile_pic': 'https://x/y.png'},
          ],
        },
      },
      keepMuids: const {'qastudentone@mulearn'},
    );

    final members = (scrubbed['response'] as Map)['members'] as List;
    expect((members[0] as Map)['muid'], 'qastudentone@mulearn');
    expect((members[0] as Map)['full_name'], 'Fixture User');
    expect((members[1] as Map)['muid'], 'fixture-user@mulearn');
    expect((members[1] as Map)['profile_pic'], isNull);
  });

  // Plan 4: role workspaces return other people under different keys.
  test('scrubs the names and muids the role workspaces return', () {
    final scrubbed = scrubFixture(
      {
        'response': {
          'data': [
            {
              'user_full_name': 'Real Participant',
              'mu_id': 'participant@mulearn',
              'created_by_name': 'Real Mentor',
              'enabler_name': 'Real Enabler',
              'email': 'real@person.in',
              'mobile': '9999999999',
            },
            {'mu_id': 'qamentor@mulearn'},
          ],
          'lead': {'campus_lead': 'Real Lead', 'enabler': 'Real Enabler'},
        },
      },
      keepMuids: const {'qamentor@mulearn'},
    );

    final response = scrubbed['response'] as Map;
    final row = (response['data'] as List)[0] as Map;
    expect(row['user_full_name'], 'Fixture User');
    expect(row['mu_id'], 'fixture-user@mulearn');
    expect(row['created_by_name'], 'Fixture User');
    expect(row['enabler_name'], 'Fixture User');
    expect(row['email'], 'user@example.com');
    expect(row['mobile'], isNull);
    expect(((response['data'] as List)[1] as Map)['mu_id'], 'qamentor@mulearn');
    final lead = response['lead'] as Map;
    expect(lead['campus_lead'], 'Fixture User');
    expect(lead['enabler'], 'Fixture User');
  });
}
