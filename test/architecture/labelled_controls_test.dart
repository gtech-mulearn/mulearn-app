import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// UX-08: an icon-only button has no text for a screen reader unless it
/// gets a tooltip (Flutter uses it as the semantics label). Every
/// `IconButton(` / `MuIconButton(` call in lib/ must pass `tooltip:`.
void main() {
  test('icon-only buttons are labelled', () {
    final call = RegExp(r'\b(IconButton|MuIconButton)\(');
    final offenders = <String>[];
    for (final file in Directory('lib').listSync(recursive: true).whereType<File>()) {
      final path = file.path.replaceAll(r'\', '/');
      if (!path.endsWith('.dart') || path.endsWith('.g.dart') || path.endsWith('.freezed.dart')) continue;
      final source = file.readAsStringSync();
      for (final match in call.allMatches(source)) {
        // The class's own constructor declaration isn't a call.
        final lineStart = source.lastIndexOf('\n', match.start) + 1;
        final line = source.substring(lineStart, source.indexOf('\n', match.start));
        if (line.trimLeft().startsWith('const ${match.group(1)}({') || line.contains('class ')) continue;
        var depth = 1;
        var i = match.end;
        while (depth > 0 && i < source.length) {
          final c = source[i];
          if (c == '(') depth++;
          if (c == ')') depth--;
          i++;
        }
        if (!source.substring(match.start, i).contains('tooltip:')) {
          final lineNo = '\n'.allMatches(source.substring(0, match.start)).length + 1;
          offenders.add('$path:$lineNo ${match.group(1)}');
        }
      }
    }
    expect(offenders, isEmpty, reason: 'add a tooltip to:\n${offenders.join('\n')}');
  });
}
