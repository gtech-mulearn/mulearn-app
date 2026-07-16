import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/features/interest_groups/domain/entities/ig_person_ref.dart';
import 'package:mulearn_app/features/interest_groups/presentation/providers/interest_groups_controller.dart';

/// Full detail for a single interest group — about, prerequisites, career
/// opportunities, leads/mentors (tappable through to their public profile),
/// and a join/leave action for the signed-in user.
class InterestGroupDetailScreen extends ConsumerWidget {
  const InterestGroupDetailScreen({required this.groupId, super.key});

  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(interestGroupDetailProvider(groupId));
    final myIdsState = ref.watch(myInterestGroupIdsProvider);
    final membershipState = ref.watch(interestGroupMembershipControllerProvider);
    final isJoined = (myIdsState.value ?? const <String>[]).contains(groupId);
    final isBusy = membershipState.isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Interest Group')),
      body: detailState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorRetryView(
          error: error,
          onRetry: () => ref.invalidate(interestGroupDetailProvider(groupId)),
        ),
        data: (group) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(group.name, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(group.category, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.people_outline, size: 16),
                const SizedBox(width: 4),
                Text('${group.memberCount} members'),
              ],
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: isBusy
                  ? null
                  : () => ref
                      .read(interestGroupMembershipControllerProvider.notifier)
                      .toggle(groupId, join: !isJoined),
              icon: Icon(isJoined ? Icons.check : Icons.add),
              label: Text(isBusy
                  ? 'Please wait…'
                  : (isJoined ? 'Joined' : 'Join group')),
            ),
            if (group.about != null) ...[
              const SizedBox(height: 24),
              Text('About', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(group.about!),
            ],
            if (group.prerequisites.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text('Prerequisites',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              ...group.prerequisites.map((p) => Text('•  $p')),
            ],
            if (group.careerOpportunities.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text('Career opportunities',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              ...group.careerOpportunities.map((c) => Text('•  $c')),
            ],
            if (group.leads.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text('Leads', style: Theme.of(context).textTheme.titleMedium),
              ...group.leads.map((p) => _PersonTile(person: p)),
            ],
            if (group.mentors.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text('Mentors', style: Theme.of(context).textTheme.titleMedium),
              ...group.mentors.map((p) => _PersonTile(person: p)),
            ],
          ],
        ),
      ),
    );
  }
}

class _PersonTile extends StatelessWidget {
  const _PersonTile({required this.person});

  final IgPersonRef person;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundImage: person.profilePicUrl != null
            ? CachedNetworkImageProvider(person.profilePicUrl!)
            : null,
        child:
            person.profilePicUrl == null ? Text(person.fullName[0]) : null,
      ),
      title: Text(person.fullName),
      subtitle: Text(person.muid),
      onTap: () =>
          context.push(RoutePaths.publicProfilePath(person.muid)),
    );
  }
}
