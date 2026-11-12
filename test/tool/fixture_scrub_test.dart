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
}
