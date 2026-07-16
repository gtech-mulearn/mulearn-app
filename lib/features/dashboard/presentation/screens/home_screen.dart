import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/features/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:mulearn_app/features/dashboard/presentation/widgets/featured_events_list.dart';
import 'package:mulearn_app/features/dashboard/presentation/widgets/karma_feed_card.dart';
import 'package:mulearn_app/features/dashboard/presentation/widgets/progress_summary_card.dart';

/// Home dashboard — the landing screen after sign-in. Shows the signed-in
/// user's own progress summary, the karma-feed highlight, and featured
/// events, mirroring the reference dashboard's home page.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _refreshAll(WidgetRef ref) => Future.wait([
        ref.read(myProgressSummaryControllerProvider.notifier).refresh(),
        ref.read(karmaFeedControllerProvider.notifier).refresh(),
        ref.read(featuredEventsControllerProvider.notifier).refresh(),
      ]);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryState = ref.watch(myProgressSummaryControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.event_outlined),
            tooltip: 'Events',
            onPressed: () => context.push(RoutePaths.events),
          ),
          IconButton(
            icon: const Icon(Icons.diversity_3_outlined),
            tooltip: 'Learning Circles',
            onPressed: () => context.push(RoutePaths.learningCircles),
          ),
          IconButton(
            icon: const Icon(Icons.groups_outlined),
            tooltip: 'Interest Groups',
            onPressed: () => context.push(RoutePaths.interestGroups),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () => context.push(RoutePaths.search),
          ),
        ],
      ),
      body: summaryState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorRetryView(
          error: error,
          onRetry: () => ref
              .read(myProgressSummaryControllerProvider.notifier)
              .refresh(),
        ),
        data: (summary) => RefreshIndicator(
          onRefresh: () => _refreshAll(ref),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ProgressSummaryCard(summary: summary),
              const SizedBox(height: 16),
              Consumer(
                builder: (context, ref, _) {
                  final karmaFeedState = ref.watch(karmaFeedControllerProvider);
                  return karmaFeedState.when(
                    loading: () => const SizedBox(
                      height: 80,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    error: (error, _) =>
                        Text(ApiException.messageFor(error)),
                    data: (karmaFeed) => KarmaFeedCard(karmaFeed: karmaFeed),
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Featured events',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Consumer(
                builder: (context, ref, _) {
                  final eventsState =
                      ref.watch(featuredEventsControllerProvider);
                  return eventsState.when(
                    loading: () => const SizedBox(
                      height: 168,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    error: (error, _) =>
                        Text(ApiException.messageFor(error)),
                    data: (events) => FeaturedEventsList(events: events),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
