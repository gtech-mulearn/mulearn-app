import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// docs/rules.md §2: features never import each other; core never imports a
/// feature; domain code is pure Dart (no Flutter, no Dio).
void main() {
  test('module boundaries hold', () {
    final importPattern = RegExp(r'''^import\s+['"]([^'"]+)['"]''');
    final violations = <String>[];
    for (final file in Directory('lib').listSync(recursive: true).whereType<File>()) {
      final path = file.path.replaceAll(r'\', '/');
      if (!path.endsWith('.dart') || path.endsWith('.g.dart') || path.endsWith('.freezed.dart')) continue;
      final feature = RegExp('^lib/features/([^/]+)/').firstMatch(path)?.group(1);
      final isCore = path.startsWith('lib/core/');
      final isDomain = path.contains('/domain/');
      for (final line in file.readAsLinesSync()) {
        final uri = importPattern.firstMatch(line.trim())?.group(1);
        if (uri == null) continue;
        final imported = RegExp('^package:mulearn_app/features/([^/]+)/').firstMatch(uri)?.group(1);
        if (feature != null && imported != null && imported != feature) {
          violations.add('$path → features/$imported (features must not import each other)');
        }
        if (isCore && imported != null) violations.add('$path → features/$imported (core must not import features)');
        if (isDomain && (uri.startsWith('package:flutter/') || uri.startsWith('package:dio/'))) {
          violations.add('$path → $uri (domain must be pure Dart)');
        }
      }
    }
    expect(violations, isEmpty, reason: violations.join('\n'));
  });
}
