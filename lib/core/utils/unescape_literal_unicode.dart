final _surrogatePair =
    RegExp(r'\\u([dD][89abAB][0-9a-fA-F]{2})\\u([dD][c-fC-F][0-9a-fA-F]{2})');
final _singleEscape = RegExp(r'\\u([0-9a-fA-F]{4})');

/// Some backend-authored markdown content (task/voyage descriptions) stores
/// literal `\uXXXX` text (e.g. `→`, `📌`) instead of the
/// real characters — confirmed live, a content-authoring quirk, not a JSON
/// decoding bug (real JSON escapes are already unescaped by the time a
/// string reaches Dart). Unescape them for display so arrows/emoji render
/// correctly rather than as raw backslash sequences.
String unescapeLiteralUnicode(String input) {
  final withPairs = input.replaceAllMapped(_surrogatePair, (m) {
    final high = int.parse(m.group(1)!, radix: 16);
    final low = int.parse(m.group(2)!, radix: 16);
    final codePoint = 0x10000 + (high - 0xD800) * 0x400 + (low - 0xDC00);
    return String.fromCharCode(codePoint);
  });
  return withPairs.replaceAllMapped(
    _singleEscape,
    (m) => String.fromCharCode(int.parse(m.group(1)!, radix: 16)),
  );
}
