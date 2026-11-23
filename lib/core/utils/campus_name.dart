/// Lower-case joining words in a campus name ("College of Engineering").
const _smallWords = {'of', 'and', 'for', 'the', 'at', 'in', 'on', 'by', 'to'};

final _vowel = RegExp('[AEIOU]');
final _nonLetters = RegExp('[^A-Za-z]');

/// A campus name to show: its [title] in normal capitalisation when the
/// backend stores it in ALL CAPS ("ST JOSEPHS COLLEGE OF ENGINEERING" →
/// "St Josephs College of Engineering"), else as it is. The [code] and
/// short consonant-only words (AWH, LBS, MK) stay upper-case. No title
/// falls back to the [code] (the monthly board can omit it).
String campusDisplayName({String? title, String? code}) {
  final name = (title ?? '').trim();
  if (name.isEmpty) {
    final short = (code ?? '').trim();
    return short.isEmpty ? 'Unknown college' : short;
  }
  if (name.contains(RegExp('[a-z]'))) return name;

  final upperCode = (code ?? '').trim().toUpperCase();
  final words = name.split(RegExp(r'\s+'));
  return [
    for (var i = 0; i < words.length; i++) _word(words[i], i, upperCode),
  ].join(' ');
}

String _word(String word, int index, String upperCode) {
  final core = word.replaceAll(_nonLetters, '');
  if (core.isEmpty) return word;
  if (index > 0 && _smallWords.contains(core.toLowerCase())) {
    return word.toLowerCase();
  }
  if (core == 'ST') return word.replaceFirst('ST', 'St');
  if (core == upperCode || !core.contains(_vowel)) return word;

  // Capitalise each run of letters: "M.DASAN" → "M.Dasan".
  final out = StringBuffer();
  var startOfRun = true;
  for (final ch in word.toLowerCase().split('')) {
    final isLetter = ch.contains(RegExp('[a-z]'));
    out.write(isLetter && startOfRun ? ch.toUpperCase() : ch);
    startOfRun = !isLetter && ch != "'";
  }
  return out.toString();
}
