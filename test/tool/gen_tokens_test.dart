import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/gen_tokens.dart';

void main() {
  test('mu_tokens.g.dart is up to date with design/tokens.json', () {
    final json = jsonDecode(File(tokensPath).readAsStringSync()) as Map<String, dynamic>;
    // Git may check the file out with CRLF line endings on Windows.
    final committed = File(outputPath).readAsStringSync().replaceAll('\r\n', '\n');
    expect(committed, generateTokens(json), reason: 'run `dart run tool/gen_tokens.dart`');
  });

  test('token names become Dart identifiers', () {
    expect(camel('on-night-2'), 'onNight2');
    expect(camel('space-0-5'), 'space0p5');
    expect(camel('radius-round', strip: 'radius-'), 'round');
  });

  test('CSS colours become ARGB literals', () {
    expect(colorLiteral('#0961f5'), 'Color(0xFF0961F5)');
    expect(colorLiteral('rgba(14,15,20,0.48)'), 'Color(0x7A0E0F14)');
  });
}
