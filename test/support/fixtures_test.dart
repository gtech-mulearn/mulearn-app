import 'package:flutter_test/flutter_test.dart';

import 'fixtures.dart';

void main() {
  test('loadFixture returns the recorded response envelope', () {
    final body = loadFixture('serializer/example');

    expect(body['hasError'], isFalse);
    expect(body['response'], isA<Map<String, dynamic>>());
  });

  test('loadFixture fails loudly for a missing fixture', () {
    expect(() => loadFixture('serializer/does-not-exist'), throwsStateError);
  });
}
