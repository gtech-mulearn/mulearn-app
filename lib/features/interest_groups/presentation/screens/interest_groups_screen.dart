import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/features/interest_groups/presentation/providers/interest_groups_controller.dart';
import 'package:mulearn_app/features/interest_groups/presentation/widgets/interest_group_card.dart';

/// Browsable catalog of every interest group — mirrors the reference
/// dashboard's IG directory page.
class InterestGroupsScreen extends ConsumerWidget {
  const InterestGroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogState = ref.watch(interestGroupsCatalogProvider);
    final myIdsState = ref.watch(myInterestGroupIdsProvider);
    final myIds = myIdsState.value ?? const <String>[];

    return Scaffold(
      appBar: AppBar(title: const Text('Interest Groups')),
      body: catalogState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorRetryView(
          error: error,
          onRetry: () => ref.invalidate(interestGroupsCatalogProvider),
        ),
        data: (groups) => RefreshIndicator(
          onRefresh: () async {
            ref
              ..invalidate(interestGroupsCatalogProvider)
              ..invalidate(myInterestGroupIdsProvider);
          },
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              return InterestGroupCard(
                group: group,
                isJoined: myIds.contains(group.id),
                onTap: () => context
                    .push(RoutePaths.interestGroupDetailPath(group.id)),
              );
            },
          ),
        ),
      ),
    );
  }
}
