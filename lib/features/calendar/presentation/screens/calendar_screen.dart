import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:mulearn_app/features/calendar/domain/entities/calendar_entry_kind.dart';
import 'package:mulearn_app/features/calendar/presentation/providers/calendar_controller.dart';

const _weekdayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _monthLabels = [
  'January', 'February', 'March', 'April', 'May', 'June', //
  'July', 'August', 'September', 'October', 'November', 'December',
];

/// Month-grid calendar view — mirrors the reference dashboard's full
/// calendar page, backed by the unified `calendar/events/` endpoint.
class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final month = ref.watch(calendarMonthControllerProvider);
    final gridStart = _gridStart(month);
    final gridEnd = gridStart.add(const Duration(days: 41));
    final entriesState = ref.watch(
      calendarEntriesProvider(start: gridStart, end: gridEnd),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            tooltip: 'Today',
            onPressed: () {
              ref.read(calendarMonthControllerProvider.notifier).jumpToToday();
              setState(() => _selectedDay = null);
            },
          ),
        ],
      ),
      body: entriesState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorRetryView(
          error: error,
          onRetry: () => ref.invalidate(
            calendarEntriesProvider(start: gridStart, end: gridEnd),
          ),
        ),
        data: (entries) {
          final byDay = <DateTime, List<CalendarEntry>>{};
          for (final entry in entries) {
            final start = DateTime.tryParse(entry.start)?.toLocal();
            if (start == null) continue;
            final day = DateTime(start.year, start.month, start.day);
            (byDay[day] ??= []).add(entry);
          }
          final selected = _selectedDay;
          final selectedEntries =
              selected == null ? const <CalendarEntry>[] : byDay[selected] ?? const [];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () => ref
                          .read(calendarMonthControllerProvider.notifier)
                          .previousMonth(),
                    ),
                    Expanded(
                      child: Text(
                        '${_monthLabels[month.month - 1]} ${month.year}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () => ref
                          .read(calendarMonthControllerProvider.notifier)
                          .nextMonth(),
                    ),
                  ],
                ),
              ),
              Row(
                children: _weekdayLabels
                    .map((label) => Expanded(
                          child: Center(
                            child: Text(
                              label,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: MulearnColors.gray600),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                ),
                itemCount: 42,
                itemBuilder: (context, index) {
                  final day = gridStart.add(Duration(days: index));
                  final inMonth = day.month == month.month;
                  final dayEntries = byDay[day] ?? const [];
                  final isToday = _isSameDay(day, DateTime.now());
                  final isSelected = selected != null && _isSameDay(day, selected);
                  return InkWell(
                    onTap: () => setState(() => _selectedDay = day),
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primaryContainer
                            : null,
                        border: isToday
                            ? Border.all(color: Theme.of(context).colorScheme.primary)
                            : null,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${day.day}',
                            style: TextStyle(
                              color: inMonth
                                  ? null
                                  : MulearnColors.gray600.withValues(alpha: 0.5),
                            ),
                          ),
                          if (dayEntries.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.only(top: 2),
                              height: 5,
                              width: 5,
                              decoration: const BoxDecoration(
                                color: MulearnColors.rankGold,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const Divider(height: 24),
              Expanded(
                child: selected == null
                    ? const Center(child: Text('Select a day to see events.'))
                    : selectedEntries.isEmpty
                        ? const Center(child: Text('Nothing on this day.'))
                        : ListView.builder(
                            itemCount: selectedEntries.length,
                            itemBuilder: (context, index) {
                              final entry = selectedEntries[index];
                              return ListTile(
                                leading: Icon(
                                  entry.kind == CalendarEntryKind.event
                                      ? Icons.event
                                      : Icons.groups,
                                ),
                                title: Text(entry.title),
                                subtitle: entry.organiserName != null
                                    ? Text(entry.organiserName!)
                                    : null,
                                onTap: entry.kind == CalendarEntryKind.event
                                    ? () => context
                                        .push(RoutePaths.eventDetailPath(entry.id))
                                    : null,
                              );
                            },
                          ),
              ),
            ],
          );
        },
      ),
    );
  }

  static DateTime _gridStart(DateTime month) {
    final firstOfMonth = DateTime(month.year, month.month);
    // Monday-first grid: back up to the Monday on/before the 1st.
    final leadingDays = firstOfMonth.weekday - DateTime.monday;
    return firstOfMonth.subtract(Duration(days: leadingDays));
  }

  static bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
