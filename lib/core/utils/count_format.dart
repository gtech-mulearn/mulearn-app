/// Counts as people read them: "4,120", "1 phone", "2 people". The app has
/// no intl dependency.
library;

/// [n] with thousands separators: 4120 becomes "4,120".
String formatCount(int n) {
  final digits = n.abs().toString();
  final out = StringBuffer(n < 0 ? '-' : '');
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) out.write(',');
    out.write(digits[i]);
  }
  return out.toString();
}

/// "1 phone", "4,120 phones". [plural] defaults to [singular] plus "s".
String countOf(int n, String singular, [String? plural]) =>
    '${formatCount(n)} ${n == 1 ? singular : plural ?? '${singular}s'}';
