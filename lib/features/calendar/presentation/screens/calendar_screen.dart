import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:mulearn_app/features/calendar/domain/entities/calendar_entry_kind.dart';
import 'package:mulearn_app/features/calendar/presentation/providers/calendar_controller.dart';

const _months = [
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

/// Calendar (artifact DateStrip on the Calendar screen): the week as a
/// date strip that swipes a week at a time, today selected to start, and
/// what happens on the chosen day below as feed rows. Events open their
/// page. Backed by the unified `calendar/events/` endpoint, a week at a
/// time.
class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _selected = _day(DateTime.now());
  late DateTime _week = muWeekStart(_selected);

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final weekEnd = _week.add(const Duration(days: 7));
    final entriesState = ref.watch(
      calendarEntriesProvider(start: _week, end: weekEnd),
    );
    final entries = entriesState.value ?? const <CalendarEntry>[];

    final byDay = <DateTime, List<CalendarEntry>>{};
    for (final entry in entries) {
      final start = DateTime.tryParse(entry.start)?.toLocal();
      if (start == null) continue;
      (byDay[_day(start)] ??= []).add(entry);
    }
    final today = _day(DateTime.now());
    final dayEntries = byDay[_selected] ?? const <CalendarEntry>[];
    // The month shown is the one most of the visible week falls in.
    final mid = _week.add(const Duration(days: 3));

    return Scaffold(
      backgroundColor: c.chalk,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space3,
                MuSpacing.space2,
                MuSpacing.space3,
                0,
              ),
              child: Row(
                children: [
                  MuIconButton(
                    icon: LucideIcons.arrowLeft,
                    tooltip: 'Back',
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                  const SizedBox(width: MuSpacing.space1),
                  Expanded(
                    child: Semantics(
                      header: true,
                      child: Text(
                        '${_months[mid.month - 1]} ${mid.year}',
                        style: mu.text.title1,
                      ),
                    ),
                  ),
                  if (_selected != today)
                    MuButton(
                      label: 'Today',
                      variant: MuButtonVariant.ghost,
                      size: MuButtonSize.small,
                      onPressed: () => setState(() {
                        _selected = today;
                        _week = muWeekStart(today);
                      }),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space5,
                MuSpacing.space4,
                MuSpacing.space5,
                0,
              ),
              child: MuDateStrip(
                selected: _selected,
                counts: {for (final e in byDay.entries) e.key: e.value.length},
                onSelect: (d) => setState(() => _selected = d),
                onWeekChanged: (w) => setState(() {
                  _week = w;
                  // Keep the same weekday selected in the new week.
                  _selected = w.add(Duration(days: _selected.weekday - 1));
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space5,
                MuSpacing.space6,
                MuSpacing.space5,
                MuSpacing.space2,
              ),
              child: Text(
                formatDayHeading(_selected, today),
                style: mu.text.title2,
              ),
            ),
            Expanded(
              child: entriesState.hasError && entries.isEmpty
                  ? ErrorRetryView(
                      error: entriesState.error!,
                      onRetry: () => ref.invalidate(
                        calendarEntriesProvider(start: _week, end: weekEnd),
                      ),
                    )
                  : entriesState.isLoading && entries.isEmpty
                  ? const Center(
                      child: MuDotsLoader(label: 'Loading your week…'),
                    )
                  : dayEntries.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: MuSpacing.space5,
                      ),
                      child: Text(
                        'Nothing on this day.',
                        style: mu.text.body.copyWith(color: c.ink3),
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(
                        MuSpacing.space5,
                        MuSpacing.space2,
                        MuSpacing.space5,
                        MuSpacing.space8,
                      ),
                      children: [
                        MuFeedGroup(
                          children: [
                            for (var i = 0; i < dayEntries.length; i++)
                              _EntryRow(
                                entry: dayEntries[i],
                                last: i == dayEntries.length - 1,
                              ),
                          ],
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EntryRow extends StatelessWidget {
  const _EntryRow({required this.entry, required this.last});

  final CalendarEntry entry;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final start = DateTime.tryParse(entry.start)?.toLocal();
    final isEvent = entry.kind == CalendarEntryKind.event;
    final where = entry.venueType == 'online' ? 'Online' : entry.organiserName;
    return MuFeedRow(
      leading: MuFeedIcon(
        isEvent ? LucideIcons.ticket : LucideIcons.users,
        tone: isEvent ? MuFeedTone.event : MuFeedTone.done,
      ),
      subject: entry.title,
      time: [
        if (start != null) formatTime(start),
        if (where != null && where.isNotEmpty) where,
      ].join(' · '),
      divider: !last,
      onTap: isEvent
          ? () => context.push(RoutePaths.eventDetailPath(entry.id))
          : null,
    );
  }
}
