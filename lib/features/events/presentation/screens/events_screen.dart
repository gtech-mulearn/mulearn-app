import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/session/my_profile_payload.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/core/utils/search_debouncer.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_load_more_footer.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/events/domain/entities/event.dart';
import 'package:mulearn_app/features/events/domain/entities/event_filter.dart';
import 'package:mulearn_app/features/events/presentation/providers/events_controller.dart';

/// Which events the list shows: from today on, or every event.
enum _When { upcoming, all }

const _monthNames = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

/// "17 Nov · Palai", "17–19 Nov · Online".
String _whenLine(Event e) {
  final start = DateTime.tryParse(e.startDatetime)?.toLocal();
  final end = DateTime.tryParse(e.endDatetime)?.toLocal();
  final place = e.venue.venueType == 'online'
      ? 'Online'
      : (e.venue.venueCity ?? 'Venue TBA');
  if (start == null) return place;
  final day = '${start.day} ${_monthNames[start.month - 1]}';
  final multiDay =
      end != null && (end.day != start.day || end.month != start.month);
  final String range;
  if (!multiDay) {
    range = day;
  } else if (end.month == start.month) {
    range = '${start.day}–${end.day} ${_monthNames[end.month - 1]}';
  } else {
    range = '$day – ${end.day} ${_monthNames[end.month - 1]}';
  }
  return '$range · $place';
}

/// Events (artifact: Screen patterns → Events): a title with the calendar,
/// search and filters as on the dashboard, Upcoming / All segments, and
/// each event as a ticket whose stub holds the one action, interest.
class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen({super.key});

  @override
  ConsumerState<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  late final _debouncer = SearchDebouncer((q) {
    if (mounted) setState(() => _filter = _filter.copyWith(search: q));
  });
  EventFilter _filter = const EventFilter();
  _When _when = _When.upcoming;

  /// What is asked of the server: Upcoming starts today unless the sheet
  /// set its own start date.
  EventFilter get _query {
    if (_when == _When.all || _filter.from != null) return _filter;
    final now = DateTime.now();
    return _filter.copyWith(from: DateTime(now.year, now.month, now.day));
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final paged = ref.read(eventsListControllerProvider(_query)).value;
    // After a failed page, only the explicit "Try again" retries.
    if (paged == null || paged.loadMoreError != null) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      unawaited(
        ref.read(eventsListControllerProvider(_query).notifier).loadMore(),
      );
    }
  }

  /// Typing searches once it pauses (see [SearchDebouncer]).
  void _onSearchChanged(String text) => _debouncer.onChanged(text);

  void _clearFilters() {
    _debouncer.reset();
    _searchController.clear();
    setState(() => _filter = const EventFilter());
  }

  Future<void> _openFilters() async {
    final next = await showMuSheet<EventFilter>(
      context,
      builder: (_) => _EventFiltersSheet(initial: _filter),
    );
    if (next != null && mounted) setState(() => _filter = next);
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final query = _query;
    final eventsState = ref.watch(eventsListControllerProvider(query));
    final filtersOn = _filter.activeCount;

    return Scaffold(
      backgroundColor: c.chalk,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space5 - 4,
                MuSpacing.space2,
                MuSpacing.space5,
                0,
              ),
              child: Row(
                children: [
                  if (ModalRoute.of(context)?.canPop ?? false)
                    MuIconButton(
                      icon: LucideIcons.arrowLeft,
                      tooltip: 'Back',
                      onPressed: () => Navigator.of(context).maybePop(),
                    )
                  else
                    const SizedBox(width: 4),
                  const SizedBox(width: MuSpacing.space1),
                  Expanded(
                    child: Semantics(
                      header: true,
                      child: Text('Events', style: mu.text.title1),
                    ),
                  ),
                  MuIconButton(
                    icon: LucideIcons.radio,
                    tooltip: 'Weekly Twitches',
                    onPressed: () => context.push(RoutePaths.weeklyTwitches),
                  ),
                  const SizedBox(width: MuSpacing.space2),
                  if (ref.watch(capabilitiesProvider).value?.canBrowseJobs ??
                      false) ...[
                    MuIconButton(
                      icon: LucideIcons.briefcase,
                      tooltip: 'Opportunities',
                      onPressed: () => context.push(RoutePaths.opportunities),
                    ),
                    const SizedBox(width: MuSpacing.space2),
                  ],
                  MuIconButton(
                    icon: LucideIcons.calendarDays,
                    tooltip: 'Calendar',
                    variant: MuIconButtonVariant.night,
                    onPressed: () => context.push(RoutePaths.calendar),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space5,
                MuSpacing.space3,
                MuSpacing.space5,
                0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: MuSearchField(
                      controller: _searchController,
                      hint: 'Search events',
                      onChanged: _onSearchChanged,
                    ),
                  ),
                  const SizedBox(width: MuSpacing.space2),
                  MuFilterChip(
                    label: filtersOn == 0 ? 'Filters' : 'Filters ($filtersOn)',
                    icon: LucideIcons.slidersHorizontal,
                    selected: filtersOn > 0,
                    onTap: _openFilters,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space5,
                MuSpacing.space3,
                MuSpacing.space5,
                0,
              ),
              child: MuSegmented<_When>(
                values: _When.values,
                selected: _when,
                label: (w) => w == _When.upcoming ? 'Upcoming' : 'All events',
                onChanged: (w) => setState(() => _when = w),
              ),
            ),
            Expanded(
              child: eventsState.when(
                skipError: true,
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => ErrorRetryView(
                  error: error,
                  onRetry: () =>
                      ref.invalidate(eventsListControllerProvider(query)),
                ),
                data: (paged) {
                  final events = paged.items;
                  if (events.isEmpty) {
                    final filtered = _filter != const EventFilter();
                    // The dashboard's events grid: StateDisplay "no-results".
                    return Center(
                      child: SingleChildScrollView(
                        child: MuStateDisplay(
                          variant: MuStateVariant.noResults,
                          action: filtered
                              ? MuButton(
                                  label: 'Clear filters',
                                  variant: MuButtonVariant.outline,
                                  size: MuButtonSize.small,
                                  onPressed: _clearFilters,
                                )
                              : null,
                        ),
                      ),
                    );
                  }
                  final hasMore = paged.hasMore;
                  return MuRefresh(
                    onRefresh: () =>
                        ref.refresh(eventsListControllerProvider(query).future),
                    child: ListView.separated(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      padding: const EdgeInsets.fromLTRB(
                        MuSpacing.space5,
                        MuSpacing.space5,
                        MuSpacing.space5,
                        MuSpacing.navClearance,
                      ),
                      itemCount: events.length + (hasMore ? 1 : 0),
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: MuSpacing.space5),
                      itemBuilder: (context, index) {
                        if (index >= events.length) {
                          return MuLoadMoreFooter(
                            isLoading: paged.isLoadingMore,
                            error: paged.loadMoreError,
                            onRetry: () => ref
                                .read(
                                  eventsListControllerProvider(query).notifier,
                                )
                                .loadMore(),
                          );
                        }
                        return Center(
                          child: _EventTicket(event: events[index]),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventTicket extends ConsumerWidget {
  const _EventTicket({required this.event});

  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busy = ref.watch(eventInterestControllerProvider).isLoading;
    final interested = event.isInterested;
    final kind = eventTypeLabels[event.eventType] ?? event.categoryName;
    return MuEventTicket(
      title: event.title,
      when: _whenLine(event),
      posterUrl: event.coverImage ?? event.bannerImage,
      capacity: MuPill(
        '${event.interestCount} interested',
        tone: MuPillTone.night,
      ),
      kind: kind == null ? null : MuPill(kind, tone: MuPillTone.paper),
      pills: [
        if (event.minKarma != null && event.minKarma! > 0)
          MuPill('${muGrouped(event.minKarma!)}+ karma', tone: MuPillTone.volt),
        if (event.isFeatured)
          const MuPill(
            'Featured',
            tone: MuPillTone.cobalt,
            icon: LucideIcons.sparkles,
          ),
      ],
      onTap: () => context.push(RoutePaths.eventDetailPath(event.id)),
      stub: MuButton(
        label: interested ? 'Interested' : "I'm interested",
        icon: interested ? LucideIcons.check : LucideIcons.star,
        variant: interested ? MuButtonVariant.outline : MuButtonVariant.ink,
        block: true,
        loading: busy,
        onPressed: () => ref
            .read(eventInterestControllerProvider.notifier)
            .toggle(event.id, interested: !interested),
      ),
    );
  }
}

/// The filter sheet: type and one of the user's interest groups as chips, a
/// start date, and only events the user can join.
class _EventFiltersSheet extends ConsumerStatefulWidget {
  const _EventFiltersSheet({required this.initial});

  final EventFilter initial;

  @override
  ConsumerState<_EventFiltersSheet> createState() => _EventFiltersSheetState();
}

class _EventFiltersSheetState extends ConsumerState<_EventFiltersSheet> {
  late EventFilter _draft = widget.initial;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final payload = ref.watch(myProfilePayloadProvider).value;
    final groups = [
      for (final g
          in (payload?['interest_groups'] as List<dynamic>? ?? const [])
              .whereType<Map<String, dynamic>>())
        if (g['id'] is String)
          (id: g['id'] as String, name: g['name'] as String? ?? ''),
    ];
    final from = _draft.from;

    Widget label(String text) => Padding(
      padding: const EdgeInsets.only(
        top: MuSpacing.space5,
        bottom: MuSpacing.space2,
      ),
      child: Text(
        text.toUpperCase(),
        style: mu.text.eyebrow.copyWith(color: c.ink3),
      ),
    );

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          MuSpacing.space5,
          0,
          MuSpacing.space5,
          MuSpacing.space5 + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Filter events', style: mu.text.title2),
              label('Type'),
              Wrap(
                spacing: MuSpacing.space2,
                runSpacing: MuSpacing.space2,
                children: [
                  for (final e in eventTypeLabels.entries)
                    MuFilterChip(
                      label: e.value,
                      selected: _draft.eventType == e.key,
                      onTap: () => setState(
                        () => _draft = _draft.copyWith(
                          eventType: _draft.eventType == e.key ? null : e.key,
                        ),
                      ),
                    ),
                ],
              ),
              if (groups.isNotEmpty) ...[
                label('My interest groups'),
                Wrap(
                  spacing: MuSpacing.space2,
                  runSpacing: MuSpacing.space2,
                  children: [
                    for (final g in groups)
                      MuFilterChip(
                        label: g.name,
                        selected: _draft.igId == g.id,
                        onTap: () => setState(
                          () => _draft = _draft.copyWith(
                            igId: _draft.igId == g.id ? null : g.id,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
              label('From date'),
              Row(
                children: [
                  MuFilterChip(
                    label: from == null
                        ? 'Any date'
                        : '${from.day} ${_monthNames[from.month - 1]} ${from.year}',
                    icon: LucideIcons.calendar,
                    selected: from != null,
                    onTap: () async {
                      final now = DateTime.now();
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: from ?? now,
                        firstDate: DateTime(now.year - 1),
                        lastDate: DateTime(now.year + 2),
                      );
                      if (picked != null) {
                        setState(() => _draft = _draft.copyWith(from: picked));
                      }
                    },
                  ),
                  if (from != null) ...[
                    const SizedBox(width: MuSpacing.space1),
                    MuIconButton(
                      icon: LucideIcons.x,
                      tooltip: 'Clear date',
                      onPressed: () =>
                          setState(() => _draft = _draft.copyWith(from: null)),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: MuSpacing.space3),
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                activeTrackColor: c.cobalt,
                title: Text(
                  'Only events I can join',
                  style: mu.text.bodyStrong,
                ),
                subtitle: Text(
                  'Hide events that need more karma than you have',
                  style: mu.text.caption,
                ),
                value: _draft.eligibleOnly,
                onChanged: (v) =>
                    setState(() => _draft = _draft.copyWith(eligibleOnly: v)),
              ),
              const SizedBox(height: MuSpacing.space5),
              Row(
                children: [
                  Expanded(
                    child: MuButton(
                      label: 'Clear',
                      variant: MuButtonVariant.outline,
                      onPressed: () => Navigator.of(
                        context,
                      ).pop(EventFilter(search: widget.initial.search)),
                    ),
                  ),
                  const SizedBox(width: MuSpacing.space3),
                  Expanded(
                    child: MuButton(
                      label: 'Apply',
                      onPressed: () => Navigator.of(context).pop(_draft),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
