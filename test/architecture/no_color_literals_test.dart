import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// docs/rules.md §8: colours come from MuColors/MuShadow, never literals in
/// widgets. Colors.transparent is allowed (it is not a colour choice).
void main() {
  test('no colour literals outside the theme', () {
    final pattern = RegExp(
      r'(?<![A-Za-z_])Colors\.(?!transparent\b)[a-zA-Z]+|(?<![A-Za-z_])Color\(0x|Color\.from(ARGB|RGBO)\(',
    );
    final offenders = <String>[];
    for (final file in Directory('lib').listSync(recursive: true).whereType<File>()) {
      final path = file.path.replaceAll(r'\', '/');
      if (!path.endsWith('.dart') ||
          path.endsWith('.g.dart') ||
          path.endsWith('.freezed.dart') ||
          path.startsWith('lib/core/theme/')) {
        continue;
      }
      final lines = file.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        if (lines[i].trimLeft().startsWith('//')) continue;
        if (pattern.hasMatch(lines[i])) offenders.add('$path:${i + 1}: ${lines[i].trim()}');
      }
    }
    expect(offenders, isEmpty, reason: '${offenders.length} literal(s):\n${offenders.join('\n')}');
  });
}
