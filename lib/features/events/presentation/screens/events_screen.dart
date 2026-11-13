import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/session/my_profile_payload.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_empty_state.dart';
import 'package:mulearn_app/core/widgets/mu_icon_button.dart';
import 'package:mulearn_app/core/widgets/mu_load_more_footer.dart';
import 'package:mulearn_app/features/events/domain/entities/event_filter.dart';
import 'package:mulearn_app/features/events/presentation/providers/events_controller.dart';
import 'package:mulearn_app/features/events/presentation/widgets/event_list_tile.dart';

/// The full paginated event list (L14) — search, filters (type, one of the
/// user's interest groups, from date, only events they can join), and the
/// calendar from the same entry point.
class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen({super.key});

  @override
  ConsumerState<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  Timer? _searchDebounce;
  EventFilter _filter = const EventFilter();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final paged = ref.read(eventsListControllerProvider(_filter)).value;
    // After a failed page, only the explicit "Try again" retries — otherwise
    // every scroll frame would fire another request while offline.
    if (paged == null || paged.loadMoreError != null) return;
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(eventsListControllerProvider(_filter).notifier).loadMore();
    }
  }

  /// Typing searches once, 300 ms after the last keystroke.
  void _onSearchChanged(String text) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _filter = _filter.copyWith(search: text));
    });
  }

  void _clearFilters() {
    _searchDebounce?.cancel();
    _searchController.clear();
    setState(() => _filter = const EventFilter());
  }

  Future<void> _openFilters() async {
    final next = await showModalBottomSheet<EventFilter>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: MuColors.surface,
      builder: (_) => _EventFiltersSheet(initial: _filter),
    );
    if (next != null && mounted) setState(() => _filter = next);
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventsState = ref.watch(eventsListControllerProvider(_filter));
    final filtersOn = _filter.activeCount;

    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(
        title: Text('Events', style: MuType.headline.copyWith(fontSize: 24)),
        actions: [
          MuIconButton(
            icon: LucideIcons.calendarDays,
            tooltip: 'Calendar',
            onPressed: () => context.push(RoutePaths.calendar),
          ),
          const SizedBox(width: MuSpace.s),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.s, MuSpace.screenH, 0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      hintText: 'Search events',
                      prefixIcon: Icon(LucideIcons.search, size: 18),
                    ),
                  ),
                ),
                const SizedBox(width: MuSpace.s),
                TextButton.icon(
                  onPressed: _openFilters,
                  icon: const Icon(LucideIcons.slidersHorizontal, size: 16),
                  label: Text(filtersOn == 0 ? 'Filters' : 'Filters ($filtersOn)'),
                ),
              ],
            ),
          ),
          Expanded(
            child: eventsState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => ErrorRetryView(
                error: error,
                onRetry: () => ref.invalidate(eventsListControllerProvider(_filter)),
              ),
              data: (paged) {
                final events = paged.items;
                if (events.isEmpty) {
                  final filtered = _filter != const EventFilter();
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MuEmptyState(
                        icon: LucideIcons.calendarDays,
                        title: filtered ? 'No events match these filters' : 'No events yet',
                        message: filtered ? 'Try fewer filters or another search.' : 'Check back soon for upcoming events.',
                      ),
                      if (filtered) TextButton(onPressed: _clearFilters, child: const Text('Clear filters')),
                    ],
                  );
                }
                final hasMore = paged.hasMore;
                return RefreshIndicator(
                  onRefresh: () async => ref.invalidate(eventsListControllerProvider(_filter)),
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.l, MuSpace.screenH, MuSpace.l),
                    itemCount: events.length + (hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= events.length) {
                        return MuLoadMoreFooter(
                          isLoading: paged.isLoadingMore,
                          error: paged.loadMoreError,
                          onRetry: () => ref.read(eventsListControllerProvider(_filter).notifier).loadMore(),
                        );
                      }
                      final event = events[index];
                      return EventListTile(
                        event: event,
                        gradientIndex: index,
                        onTap: () => context.push(RoutePaths.eventDetailPath(event.id)),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// The filter sheet: type, one of the user's interest groups (from the
/// shared profile), from date, and only events the user can join.
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
    final payload = ref.watch(myProfilePayloadProvider).value;
    final groups = [
      for (final g in (payload?['interest_groups'] as List<dynamic>? ?? const []).whereType<Map<String, dynamic>>())
        if (g['id'] is String) (id: g['id'] as String, name: g['name'] as String? ?? ''),
    ];
    final from = _draft.from;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          MuSpace.screenH,
          0,
          MuSpace.screenH,
          MuSpace.xl + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Filter events', style: MuType.headline),
            const SizedBox(height: MuSpace.l),
            DropdownButtonFormField<String?>(
              initialValue: _draft.eventType,
              decoration: const InputDecoration(labelText: 'Type'),
              items: [
                const DropdownMenuItem(child: Text('Any type')),
                for (final e in eventTypeLabels.entries) DropdownMenuItem(value: e.key, child: Text(e.value)),
              ],
              onChanged: (v) => setState(() => _draft = _draft.copyWith(eventType: v)),
            ),
            if (groups.isNotEmpty) ...[
              const SizedBox(height: MuSpace.m),
              DropdownButtonFormField<String?>(
                initialValue: groups.any((g) => g.id == _draft.igId) ? _draft.igId : null,
                decoration: const InputDecoration(labelText: 'My interest groups'),
                items: [
                  const DropdownMenuItem(child: Text('Any group')),
                  for (final g in groups) DropdownMenuItem(value: g.id, child: Text(g.name)),
                ],
                onChanged: (v) => setState(() => _draft = _draft.copyWith(igId: v)),
              ),
            ],
            const SizedBox(height: MuSpace.s),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('From date'),
              subtitle: Text(from == null ? 'Any date' : '${from.day}/${from.month}/${from.year}'),
              trailing: from == null
                  ? const Icon(LucideIcons.calendar)
                  : IconButton(
                      tooltip: 'Clear date',
                      icon: const Icon(LucideIcons.x),
                      onPressed: () => setState(() => _draft = _draft.copyWith(from: null)),
                    ),
              onTap: () async {
                final now = DateTime.now();
                final picked = await showDatePicker(
                  context: context,
                  initialDate: from ?? now,
                  firstDate: DateTime(now.year - 1),
                  lastDate: DateTime(now.year + 2),
                );
                if (picked != null) setState(() => _draft = _draft.copyWith(from: picked));
              },
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Only events I can join'),
              subtitle: const Text('Hide events that need more karma than you have'),
              value: _draft.eligibleOnly,
              onChanged: (v) => setState(() => _draft = _draft.copyWith(eligibleOnly: v)),
            ),
            const SizedBox(height: MuSpace.l),
            Row(
              children: [
                Expanded(
                  child: MuGhostButton(
                    label: 'Clear',
                    onPressed: () => Navigator.of(context).pop(EventFilter(search: widget.initial.search)),
                  ),
                ),
                const SizedBox(width: MuSpace.s),
                Expanded(child: MuPrimaryButton(label: 'Apply', onPressed: () => Navigator.of(context).pop(_draft))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
