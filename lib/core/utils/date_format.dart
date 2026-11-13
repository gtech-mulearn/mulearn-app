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

int _daysBetween(DateTime from, DateTime to) =>
    DateTime.utc(to.year, to.month, to.day).difference(DateTime.utc(from.year, from.month, from.day)).inDays;

/// "Today", "Tomorrow", "Yesterday", else "Fri 20 Nov" (both local).
String formatDayHeading(DateTime day, DateTime today) => switch (_daysBetween(today, day)) {
      0 => 'Today',
      1 => 'Tomorrow',
      -1 => 'Yesterday',
      _ => formatDay(day),
    };

/// When something happens, as people say it: "Starts in 30 min",
/// "Live now", "Today · 6:00 PM", "Tomorrow · 6:00 PM", "Fri 20 Nov ·
/// 6:00 PM", "Ended · Today". All arguments are local.
String formatWhen({required DateTime starts, required DateTime ends, required DateTime now}) {
  if (!now.isBefore(ends)) return 'Ended · ${formatDayHeading(starts, now)}';
  if (!now.isBefore(starts)) return 'Live now';
  final minutes = (starts.difference(now).inSeconds / 60).ceil();
  if (minutes < 60) return 'Starts in $minutes min';
  return '${formatDayHeading(starts, now)} · ${formatTime(starts)}';
}

/// "Fri 20 Nov · 6:00 PM – 7:30 PM"; the end's day is repeated only when it
/// differs.
String formatRange(DateTime starts, DateTime ends) => _daysBetween(starts, ends) == 0
    ? '${formatDayTime(starts)} – ${formatTime(ends)}'
    : '${formatDayTime(starts)} – ${formatDayTime(ends)}';
