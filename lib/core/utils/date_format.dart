/// Short local date and time labels, e.g. "Fri 20 Nov · 6:00 PM". The app
/// has no intl dependency; these cover the workspace screens.
library;

const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

/// "6:00 PM".
String formatTime(DateTime t) {
  final hour = t.hour % 12 == 0 ? 12 : t.hour % 12;
  return '$hour:${t.minute.toString().padLeft(2, '0')} ${t.hour < 12 ? 'AM' : 'PM'}';
}

/// "Fri 20 Nov".
String formatDay(DateTime t) => '${_weekdays[t.weekday - 1]} ${t.day} ${_months[t.month - 1]}';

/// "Fri 20 Nov · 6:00 PM".
String formatDayTime(DateTime t) => '${formatDay(t)} · ${formatTime(t)}';
