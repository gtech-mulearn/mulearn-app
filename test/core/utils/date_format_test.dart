import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/utils/date_format.dart';

/// Times read the way people say them (user, 2026-11-13: "think about all
/// these little things like an apple ux engineer").
void main() {
  final now = DateTime(2026, 11, 13, 9);

  test('day headings say Today, Tomorrow and Yesterday', () {
    expect(formatDayHeading(DateTime(2026, 11, 13, 23, 30), now), 'Today');
    expect(formatDayHeading(DateTime(2026, 11, 14), now), 'Tomorrow');
    expect(formatDayHeading(DateTime(2026, 11, 12, 8), now), 'Yesterday');
    expect(formatDayHeading(DateTime(2026, 11, 20), now), 'Fri 20 Nov');
  });

  group('formatWhen', () {
    String when(DateTime starts, {Duration length = const Duration(hours: 1), DateTime? at}) =>
        formatWhen(starts: starts, ends: starts.add(length), now: at ?? now);

    test('soon, live and ended', () {
      expect(when(DateTime(2026, 11, 13, 9, 30)), 'Starts in 30 min');
      expect(when(DateTime(2026, 11, 13, 9, 0, 30)), 'Starts in 1 min');
      expect(when(DateTime(2026, 11, 13, 8, 30)), 'Live now');
      expect(when(DateTime(2026, 11, 13, 7)), 'Ended · Today');
    });

    test('later today, tomorrow and further out', () {
      expect(when(DateTime(2026, 11, 13, 18)), 'Today · 6:00 PM');
      expect(when(DateTime(2026, 11, 14, 18)), 'Tomorrow · 6:00 PM');
      expect(when(DateTime(2026, 11, 20, 18)), 'Fri 20 Nov · 6:00 PM');
    });
  });

  test('a time range reads on one line', () {
    expect(formatRange(DateTime(2026, 11, 20, 18), DateTime(2026, 11, 20, 19, 30)), 'Fri 20 Nov · 6:00 PM – 7:30 PM');
    expect(
      formatRange(DateTime(2026, 11, 20, 23), DateTime(2026, 11, 21, 1)),
      'Fri 20 Nov · 11:00 PM – Sat 21 Nov · 1:00 AM',
    );
  });
}
