/// Lower-case joining words in a campus name ("College of Engineering").
const _smallWords = {'of', 'and', 'for', 'the', 'at', 'in', 'on', 'by', 'to'};

/// Short words that are names, not acronyms ("Sri Sai Ram", "Mar
/// Athanasius"). Every other word of three letters or fewer stays an
/// acronym (NIT, IES, APJ, IT).
const _shortWords = {
  'MAR',
  'ADI',
  'SRI',
  'SAI',
  'RAM',
  'RAJ',
  'DEV',
  'NEW',
  'OLD',
  'RAO',
  'ALI',
  'JAI',
};

final _vowel = RegExp('[AEIOU]');
final _nonLetters = RegExp('[^A-Za-z]');

/// A campus name to show: its [title] in normal capitalisation when the
/// backend stores it in ALL CAPS ("ST JOSEPHS COLLEGE OF ENGINEERING" →
/// "St Josephs College of Engineering"), else as it is. The [code],
/// consonant-only words (AWH, LBS) and words of three letters or fewer
/// (NIT, IES, IT) stay upper-case, but for a few short names (Sri, Mar). No title
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
  if (core == 'ST' || core == 'DR') {
    return word.replaceFirst(core, core[0] + core[1].toLowerCase());
  }
  final acronym =
      core == upperCode ||
      !core.contains(_vowel) ||
      (core.length <= 3 && !_shortWords.contains(core));
  if (acronym) return word;

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
