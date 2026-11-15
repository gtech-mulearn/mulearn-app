import 'package:flutter/material.dart';

/// Picks a day, then a time, as one local date-time; null if either step is
/// cancelled. [first] defaults to today, [last] to a year after [initial].
Future<DateTime?> pickDateTime(
  BuildContext context, {
  required DateTime initial,
  DateTime? first,
  DateTime? last,
}) async {
  final now = DateTime.now();
  final firstDay = first ?? DateTime(now.year, now.month, now.day);
  final day = await showDatePicker(
    context: context,
    initialDate: initial.isBefore(firstDay) ? firstDay : initial,
    firstDate: firstDay,
    lastDate: last ?? initial.add(const Duration(days: 365)),
  );
  if (day == null || !context.mounted) return null;
  final time = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(initial));
  if (time == null) return null;
  return DateTime(day.year, day.month, day.day, time.hour, time.minute);
}
