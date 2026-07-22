import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/auth/current_user_claims.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/core/widgets/mu_icon_button.dart';
import 'package:mulearn_app/core/widgets/mu_section_header.dart';
import 'package:mulearn_app/core/widgets/mu_stat_block.dart';
import 'package:mulearn_app/core/widgets/mu_task_tile.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/circle_member.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/join_request.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/learning_circle_detail.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/learning_circles_controller.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/meetings_controller.dart';

class LearningCircleDetailScreen extends ConsumerWidget {
  const LearningCircleDetailScreen({required this.circleId, super.key});

  final String circleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(circleDetailProvider(circleId));

    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(title: const Text('Learning Circle')),
      body: detailState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorRetryView(
          error: error,
          onRetry: () => ref.invalidate(circleDetailProvider(circleId)),
        ),
        data: (detail) =>
            _CircleDetailBody(circleId: circleId, detail: detail),
      ),
    );
  }
}

class _CircleDetailBody extends ConsumerWidget {
  const _CircleDetailBody({required this.circleId, required this.detail});

  final String circleId;
  final LearningCircleDetail detail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myMuidState = ref.watch(currentUserMuidProvider);
    final membersState = ref.watch(circleMembersProvider(circleId));
    final actionState = ref.watch(circleActionsControllerProvider);
    final myMuid = myMuidState.value;
    final members = membersState.value?.members ?? const <CircleMember>[];
    final isMember = members.any((m) => m.muid == myMuid);
    final isLead = detail.createdBy.muid == myMuid ||
        members.any((m) => m.muid == myMuid && m.isLeader);

    return RefreshIndicator(
      onRefresh: () async {
        ref
          ..invalidate(circleDetailProvider(circleId))
          ..invalidate(circleMembersProvider(circleId));
      },
      child: ListView(
        padding: const EdgeInsets.all(MuSpace.screenH),
        children: [
          Text(detail.title, style: MuType.headline),
          const SizedBox(height: MuSpace.xs),
          Text(
            [detail.ig, if (detail.org != null) detail.org].join(' · '),
            style: MuType.body.copyWith(color: MuColors.inkSecondary),
          ),
          const SizedBox(height: MuSpace.l),
          MuCard(
            child: Row(
              children: [
                Expanded(
                  child: MuStatBlock(label: 'Members', value: '${detail.totalMembers ?? 0}'),
                ),
                Expanded(
                  child: MuStatBlock(label: 'Karma', value: '${detail.totalKarma ?? 0}'),
                ),
                if (detail.rank != null)
                  Expanded(child: MuStatBlock(label: 'Rank', value: '#${detail.rank}')),
              ],
            ),
          ),
          if (detail.description.isNotEmpty) ...[
            const SizedBox(height: MuSpace.l),
            Text(detail.description, style: MuType.body),
          ],
          const SizedBox(height: MuSpace.l),
          if (!isMember)
            MuPrimaryButton(
              label: actionState.isLoading ? 'Sending…' : 'Request to join',
              icon: LucideIcons.userPlus,
              onPressed: actionState.isLoading ? null : () => _requestToJoin(context, ref),
            ),
          if (isLead) ...[
            const SizedBox(height: MuSpace.s),
            Row(
              children: [
                Expanded(
                  child: MuGhostButton(
                    label: 'Edit',
                    icon: LucideIcons.pencil,
                    onPressed: () => _showEditDialog(context, ref, detail),
                  ),
                ),
                const SizedBox(width: MuSpace.s),
                Expanded(
                  child: MuGhostButton(
                    label: 'Delete',
                    icon: LucideIcons.trash2,
                    onPressed: () => _confirmDelete(context, ref),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: MuSpace.xxl),
          const MuSectionHeader(title: 'Members'),
          const SizedBox(height: MuSpace.m),
          MuCard(
            child: Column(
              children: [
                for (var i = 0; i < members.length; i++) ...[
                  if (i > 0) const Divider(height: MuSpace.l),
                  _MemberTile(member: members[i], isLead: isLead, circleId: circleId),
                ],
              ],
            ),
          ),
          if (isLead) ...[
            const SizedBox(height: MuSpace.xxl),
            _JoinRequestsSection(circleId: circleId),
            const SizedBox(height: MuSpace.xxl),
            _InvitesSection(circleId: circleId),
          ],
          const SizedBox(height: MuSpace.xxl),
          _MeetingsSection(circleId: circleId, isLead: isLead),
        ],
      ),
    );
  }

  Future<void> _requestToJoin(BuildContext context, WidgetRef ref) async {
    await ref
        .read(circleActionsControllerProvider.notifier)
        .requestToJoin(circleId);
    if (!context.mounted) return;
    final state = ref.read(circleActionsControllerProvider);
    MuToast.show(
      context,
      message: state.hasError
          ? ApiException.messageFor(state.error!)
          : 'Request to join sent.',
      type: state.hasError ? MuToastType.error : MuToastType.success,
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete this circle?'),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      final ok = await ref
          .read(circleActionsControllerProvider.notifier)
          .deleteCircle(circleId);
      if (ok && context.mounted) context.pop();
    }
  }

  Future<void> _showEditDialog(
    BuildContext context,
    WidgetRef ref,
    LearningCircleDetail detail,
  ) async {
    final titleController = TextEditingController(text: detail.title);
    final descriptionController =
        TextEditingController(text: detail.description);
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit circle'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (saved ?? false) {
      await ref.read(circleActionsControllerProvider.notifier).editCircle(
            circleId,
            title: titleController.text.trim(),
            description: descriptionController.text.trim(),
          );
    }
  }
}

class _MemberTile extends ConsumerWidget {
  const _MemberTile({
    required this.member,
    required this.isLead,
    required this.circleId,
  });

  final CircleMember member;
  final bool isLead;
  final String circleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Container(
          height: 36,
          width: 36,
          decoration: const BoxDecoration(color: MuColors.primaryTint, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text(
            member.fullName.isNotEmpty ? member.fullName[0].toUpperCase() : '?',
            style: MuType.bodyMed.copyWith(color: MuColors.primary),
          ),
        ),
        const SizedBox(width: MuSpace.m),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(member.fullName, style: MuType.bodyMed),
              Text(member.muid, style: MuType.caption),
            ],
          ),
        ),
        if (member.isLeader)
          const MuTagChip(label: 'Lead', style: MuTagStyle.success)
        else if (isLead)
          MuGhostButton(
            label: 'Make lead',
            expand: false,
            onPressed: () => _confirmTransfer(context, ref),
          ),
      ],
    );
  }

  Future<void> _confirmTransfer(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Transfer lead to ${member.fullName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Transfer'),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      await ref
          .read(circleActionsControllerProvider.notifier)
          .transferLead(circleId, muid: member.muid);
    }
  }
}

class _JoinRequestsSection extends ConsumerWidget {
  const _JoinRequestsSection({required this.circleId});

  final String circleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsState = ref.watch(circleJoinRequestsProvider(circleId));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MuSectionHeader(title: 'Pending join requests'),
        const SizedBox(height: MuSpace.m),
        requestsState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Text(ApiException.messageFor(error)),
          data: (requests) {
            if (requests.isEmpty) {
              return Text('No pending requests.', style: MuType.body.copyWith(color: MuColors.inkSecondary));
            }
            return MuCard(
              child: Column(
                children: [
                  for (var i = 0; i < requests.length; i++) ...[
                    if (i > 0) const Divider(height: MuSpace.l),
                    _JoinRequestTile(request: requests[i], circleId: circleId),
                  ],
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _JoinRequestTile extends ConsumerWidget {
  const _JoinRequestTile({required this.request, required this.circleId});

  final JoinRequest request;
  final String circleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(request.fullName, style: MuType.bodyMed),
              Text(request.muid, style: MuType.caption),
            ],
          ),
        ),
        MuIconButton(
          icon: LucideIcons.check,
          onPressed: () => ref
              .read(circleActionsControllerProvider.notifier)
              .respondToJoinRequest(circleId, linkId: request.linkId, accept: true),
        ),
        const SizedBox(width: MuSpace.s),
        MuIconButton(
          icon: LucideIcons.x,
          onPressed: () => ref
              .read(circleActionsControllerProvider.notifier)
              .respondToJoinRequest(circleId, linkId: request.linkId, accept: false),
        ),
      ],
    );
  }
}

class _InvitesSection extends ConsumerWidget {
  const _InvitesSection({required this.circleId});

  final String circleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invitesState = ref.watch(circleSentInvitesProvider(circleId));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(child: MuSectionHeader(title: 'Invites')),
            MuIconButton(
              icon: LucideIcons.userPlus,
              onPressed: () => _showInviteDialog(context, ref),
            ),
          ],
        ),
        const SizedBox(height: MuSpace.m),
        invitesState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Text(ApiException.messageFor(error)),
          data: (invites) {
            if (invites.isEmpty) {
              return Text('No invites sent yet.', style: MuType.body.copyWith(color: MuColors.inkSecondary));
            }
            return MuCard(
              child: Column(
                children: [
                  for (var i = 0; i < invites.length; i++) ...[
                    if (i > 0) const Divider(height: MuSpace.l),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(invites[i].fullName, style: MuType.bodyMed),
                              Text(invites[i].muid, style: MuType.caption),
                            ],
                          ),
                        ),
                        MuTagChip(label: invites[i].status),
                      ],
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Future<void> _showInviteDialog(BuildContext context, WidgetRef ref) async {
    final muidController = TextEditingController();
    final send = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invite a user'),
        content: TextField(
          controller: muidController,
          decoration: const InputDecoration(labelText: 'MUID'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Send'),
          ),
        ],
      ),
    );
    if ((send ?? false) && muidController.text.trim().isNotEmpty) {
      await ref
          .read(circleActionsControllerProvider.notifier)
          .sendInvite(circleId, muid: muidController.text.trim());
    }
  }
}

class _MeetingsSection extends ConsumerWidget {
  const _MeetingsSection({required this.circleId, required this.isLead});

  final String circleId;
  final bool isLead;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meetingsState = ref.watch(circleMeetingsProvider(circleId));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(child: MuSectionHeader(title: 'Meetings')),
            if (isLead)
              MuIconButton(
                icon: LucideIcons.plus,
                onPressed: () => context.push(RoutePaths.createMeetingPath(circleId)),
              ),
          ],
        ),
        const SizedBox(height: MuSpace.m),
        meetingsState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Text(ApiException.messageFor(error)),
          data: (meetings) {
            if (meetings.isEmpty) {
              return Text('No meetings scheduled.', style: MuType.body.copyWith(color: MuColors.inkSecondary));
            }
            return Column(
              children: [
                for (final m in meetings)
                  Padding(
                    padding: const EdgeInsets.only(bottom: MuSpace.m),
                    child: MuTaskTile(
                      title: m.title,
                      subtitle: m.meetTime,
                      tags: [
                        MuTagChip(
                          label: m.isEnded ? 'Ended' : (m.isStarted ? 'Live now' : 'Upcoming'),
                          style: m.isEnded
                              ? MuTagStyle.neutral
                              : (m.isStarted ? MuTagStyle.deadline : MuTagStyle.success),
                        ),
                        MuTagChip(label: m.mode),
                      ],
                      trailingLabel: '${m.attendeesCount} joined',
                      onTap: () => context.push(
                        RoutePaths.meetingDetailPath(m.id),
                        extra: circleId,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
