import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_section_header.dart';
import 'package:mulearn_app/core/widgets/profile_avatar.dart';
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
      backgroundColor: MuColors.canvas,
      appBar: AppBar(title: const Text('Interest Group')),
      body: detailState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorRetryView(
          error: error,
          onRetry: () => ref.invalidate(interestGroupDetailProvider(groupId)),
        ),
        data: (group) => ListView(
          padding: const EdgeInsets.all(MuSpace.screenH),
          children: [
            Text(group.name, style: MuType.headline),
            const SizedBox(height: MuSpace.xs),
            Text(group.category, style: MuType.body.copyWith(color: MuColors.inkSecondary)),
            const SizedBox(height: MuSpace.s),
            Row(
              children: [
                const Icon(LucideIcons.users, size: 16, color: MuColors.inkSecondary),
                const SizedBox(width: MuSpace.xs),
                Text('${group.memberCount} members', style: MuType.body),
              ],
            ),
            const SizedBox(height: MuSpace.l),
            MuPrimaryButton(
              label: isBusy ? 'Please wait…' : (isJoined ? 'Joined' : 'Join group'),
              icon: isJoined ? LucideIcons.check : LucideIcons.plus,
              onPressed: isBusy
                  ? null
                  : () => ref
                      .read(interestGroupMembershipControllerProvider.notifier)
                      .toggle(groupId, join: !isJoined),
            ),
            if (group.about != null) ...[
              const SizedBox(height: MuSpace.xxl),
              const MuSectionHeader(title: 'About'),
              const SizedBox(height: MuSpace.m),
              Text(group.about!, style: MuType.body),
            ],
            if (group.prerequisites.isNotEmpty) ...[
              const SizedBox(height: MuSpace.xxl),
              const MuSectionHeader(title: 'Prerequisites'),
              const SizedBox(height: MuSpace.m),
              MuCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final p in group.prerequisites)
                      Padding(
                        padding: const EdgeInsets.only(bottom: MuSpace.xs),
                        child: Text('•  $p', style: MuType.body),
                      ),
                  ],
                ),
              ),
            ],
            if (group.careerOpportunities.isNotEmpty) ...[
              const SizedBox(height: MuSpace.xxl),
              const MuSectionHeader(title: 'Career opportunities'),
              const SizedBox(height: MuSpace.m),
              MuCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final c in group.careerOpportunities)
                      Padding(
                        padding: const EdgeInsets.only(bottom: MuSpace.xs),
                        child: Text('•  $c', style: MuType.body),
                      ),
                  ],
                ),
              ),
            ],
            if (group.leads.isNotEmpty) ...[
              const SizedBox(height: MuSpace.xxl),
              const MuSectionHeader(title: 'Leads'),
              const SizedBox(height: MuSpace.m),
              MuCard(
                child: Column(
                  children: [
                    for (var i = 0; i < group.leads.length; i++) ...[
                      if (i > 0) const Divider(height: MuSpace.l),
                      _PersonTile(person: group.leads[i]),
                    ],
                  ],
                ),
              ),
            ],
            if (group.mentors.isNotEmpty) ...[
              const SizedBox(height: MuSpace.xxl),
              const MuSectionHeader(title: 'Mentors'),
              const SizedBox(height: MuSpace.m),
              MuCard(
                child: Column(
                  children: [
                    for (var i = 0; i < group.mentors.length; i++) ...[
                      if (i > 0) const Divider(height: MuSpace.l),
                      _PersonTile(person: group.mentors[i]),
                    ],
                  ],
                ),
              ),
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
    return InkWell(
      onTap: () => context.push(RoutePaths.publicProfilePath(person.muid)),
      child: Row(
        children: [
          ProfileAvatar(url: person.profilePicUrl, name: person.fullName, size: 40),
          const SizedBox(width: MuSpace.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(person.fullName, style: MuType.bodyMed),
                Text(person.muid, style: MuType.caption),
              ],
            ),
          ),
          const Icon(LucideIcons.chevronRight, size: 18, color: MuColors.inkTertiary),
        ],
      ),
    );
  }
}
