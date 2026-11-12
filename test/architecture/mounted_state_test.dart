import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// A provider's `state` must not be assigned after an `await` unless the
/// provider is still mounted: once its screen has closed, Riverpod throws.
/// The safe pattern is `final result = await AsyncValue.guard(...);
/// if (ref.mounted) state = result;`.
void main() {
  test('no provider assigns state straight from an awaited guard', () {
    final pattern = RegExp(r'state\s*=\s*await\s+AsyncValue\.guard');
    final offenders = <String>[];
    for (final file in Directory('lib').listSync(recursive: true).whereType<File>()) {
      final path = file.path.replaceAll(r'\', '/');
      if (!path.endsWith('.dart') || path.endsWith('.g.dart') || path.endsWith('.freezed.dart')) continue;
      final lines = file.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        if (pattern.hasMatch(lines[i])) offenders.add('$path:${i + 1}');
      }
    }
    expect(offenders, isEmpty, reason: offenders.join('\n'));
  });
}
