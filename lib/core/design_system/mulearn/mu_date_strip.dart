import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _weekdaysLong = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
const _monthsLong = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

/// The Monday of [d]'s week.
DateTime muWeekStart(DateTime d) => _day(d).subtract(Duration(days: d.weekday - 1));

/// Seven days as tall stadium cells (artifact DateStrip): weekday over the
/// date, a dot under it for days with something on ([counts]); the selected day in
/// `night` with a volt dot; past days faded. Swipe sideways a week at a
/// time; [onWeekChanged] reports the Monday now showing.
class MuDateStrip extends StatefulWidget {
  /// A strip around [selected].
  const MuDateStrip({
    required this.selected,
    required this.onSelect,
    this.counts = const {},
    this.onWeekChanged,
    super.key,
  });

  /// The chosen day.
  final DateTime selected;

  final ValueChanged<DateTime> onSelect;

  /// How many things happen on each day (keyed by date, time ignored).
  final Map<DateTime, int> counts;

  final ValueChanged<DateTime>? onWeekChanged;

  @override
  State<MuDateStrip> createState() => _MuDateStripState();
}

class _MuDateStripState extends State<MuDateStrip> {
  static const _origin = 5000;
  late final DateTime _anchor = muWeekStart(widget.selected);
  late final PageController _pages = PageController(initialPage: _origin);

  DateTime _weekAt(int page) => _anchor.add(Duration(days: 7 * (page - _origin)));

  @override
  void didUpdateWidget(MuDateStrip old) {
    super.didUpdateWidget(old);
    // Jump to the selected day's week when it moves outside the one shown.
    final target = _origin + muWeekStart(widget.selected).difference(_anchor).inDays ~/ 7;
    if (_pages.hasClients && (_pages.page?.round() ?? _origin) != target) {
      final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
      if (reduce) {
        _pages.jumpToPage(target);
      } else {
        _pages.animateToPage(target, duration: const Duration(milliseconds: 320), curve: Curves.easeOutCubic);
      }
    }
  }

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      child: PageView.builder(
        controller: _pages,
        onPageChanged: (p) => widget.onWeekChanged?.call(_weekAt(p)),
        itemBuilder: (context, page) {
          final start = _weekAt(page);
          // Stretch: each cell takes the strip's full height, so the dot
          // under the date has room.
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < 7; i++) ...[
                if (i > 0) const SizedBox(width: 6),
                Expanded(child: _cell(context, start.add(Duration(days: i)))),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _cell(BuildContext context, DateTime day) {
    final mu = context.mu;
    final c = mu.colors;
    final today = _day(DateTime.now());
    final on = _day(widget.selected) == day;
    final past = day.isBefore(today);
    final count = widget.counts[day] ?? 0;
    final label = [
      '${_weekdaysLong[day.weekday - 1]} ${day.day} ${_monthsLong[day.month - 1]}',
      if (day == today) 'today',
      if (count == 1) '1 item' else if (count > 1) '$count items',
    ].join(', ');

    return Semantics(
      button: true,
      selected: on,
      label: label,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          HapticFeedback.selectionClick();
          widget.onSelect(day);
        },
        child: Opacity(
          opacity: past && !on ? 0.55 : 1,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            decoration: BoxDecoration(
              color: on ? c.night : null,
              borderRadius: BorderRadius.circular(MuRadii.round),
              border: on ? null : Border.all(color: c.lineStrong),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Under the date, clear of the weekday.
                if (count > 0)
                  Positioned(
                    bottom: 8,
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(color: on ? c.volt : c.ink, shape: BoxShape.circle),
                    ),
                  ),
                // Lifted a little so the dot below has room.
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _weekdays[day.weekday - 1],
                        style: mu.text.caption.copyWith(color: on ? c.onNight2 : c.ink3),
                      ),
                      Text('${day.day}', style: mu.text.title3.copyWith(fontSize: 15, color: on ? c.onNight : c.ink)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
