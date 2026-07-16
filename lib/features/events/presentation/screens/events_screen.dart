import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/features/events/presentation/providers/events_controller.dart';
import 'package:mulearn_app/features/events/presentation/widgets/event_list_tile.dart';

/// The full paginated event list — mirrors the reference dashboard's events
/// page. Calendar view is reachable from the same entry point.
class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen({super.key});

  @override
  ConsumerState<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(eventsListControllerProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventsState = ref.watch(eventsListControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month_outlined),
            tooltip: 'Calendar',
            onPressed: () => context.push(RoutePaths.calendar),
          ),
        ],
      ),
      body: eventsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorRetryView(
          error: error,
          onRetry: () => ref.invalidate(eventsListControllerProvider),
        ),
        data: (events) {
          if (events.isEmpty) {
            return const Center(child: Text('No events yet.'));
          }
          final hasMore = ref.read(eventsListControllerProvider.notifier).hasMore;
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(eventsListControllerProvider),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: events.length + (hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= events.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final event = events[index];
                return EventListTile(
                  event: event,
                  onTap: () =>
                      context.push(RoutePaths.eventDetailPath(event.id)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
