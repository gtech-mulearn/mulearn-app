import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/auth/current_user_claims.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
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
        padding: const EdgeInsets.all(16),
        children: [
          Text(detail.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 4),
          Text(
            [detail.ig, if (detail.org != null) detail.org].join(' · '),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 16,
            children: [
              _Stat(label: 'Members', value: '${detail.totalMembers ?? 0}'),
              _Stat(label: 'Karma', value: '${detail.totalKarma ?? 0}'),
              if (detail.rank != null)
                _Stat(label: 'Rank', value: '#${detail.rank}'),
            ],
          ),
          if (detail.description.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(detail.description),
          ],
          const SizedBox(height: 16),
          if (!isMember)
            FilledButton.icon(
              onPressed: actionState.isLoading
                  ? null
                  : () => _requestToJoin(context, ref),
              icon: const Icon(Icons.group_add),
              label: Text(
                  actionState.isLoading ? 'Sending…' : 'Request to join'),
            ),
          if (isLead) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showEditDialog(context, ref, detail),
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Edit'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _confirmDelete(context, ref),
                    icon: Icon(Icons.delete_outline,
                        color: Theme.of(context).colorScheme.error),
                    label: Text('Delete',
                        style:
                            TextStyle(color: Theme.of(context).colorScheme.error)),
                  ),
                ),
              ],
            ),
          ],
          const Divider(height: 32),
          Text('Members', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...members.map((m) => _MemberTile(
                member: m,
                isLead: isLead,
                circleId: circleId,
              )),
          if (isLead) ...[
            const Divider(height: 32),
            _JoinRequestsSection(circleId: circleId),
            const Divider(height: 32),
            _InvitesSection(circleId: circleId),
          ],
          const Divider(height: 32),
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          state.hasError
              ? ApiException.messageFor(state.error!)
              : 'Request to join sent.',
        ),
      ),
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

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.titleMedium),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
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
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        child: Text(member.fullName.isNotEmpty ? member.fullName[0] : '?'),
      ),
      title: Text(member.fullName),
      subtitle: Text(member.muid),
      trailing: member.isLeader
          ? const Chip(label: Text('Lead'), visualDensity: VisualDensity.compact)
          : (isLead
              ? TextButton(
                  onPressed: () => _confirmTransfer(context, ref),
                  child: const Text('Make lead'),
                )
              : null),
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
        Text('Pending join requests',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        requestsState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Text(ApiException.messageFor(error)),
          data: (requests) {
            if (requests.isEmpty) return const Text('No pending requests.');
            return Column(
              children: requests.map((r) => _JoinRequestTile(
                    request: r,
                    circleId: circleId,
                  )).toList(),
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
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(request.fullName),
      subtitle: Text(request.muid),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.green),
            onPressed: () => ref
                .read(circleActionsControllerProvider.notifier)
                .respondToJoinRequest(circleId,
                    linkId: request.linkId, accept: true),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: () => ref
                .read(circleActionsControllerProvider.notifier)
                .respondToJoinRequest(circleId,
                    linkId: request.linkId, accept: false),
          ),
        ],
      ),
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
            Expanded(
              child: Text('Invites', style: Theme.of(context).textTheme.titleMedium),
            ),
            TextButton.icon(
              onPressed: () => _showInviteDialog(context, ref),
              icon: const Icon(Icons.person_add_alt),
              label: const Text('Invite'),
            ),
          ],
        ),
        invitesState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Text(ApiException.messageFor(error)),
          data: (invites) {
            if (invites.isEmpty) return const Text('No invites sent yet.');
            return Column(
              children: invites
                  .map((i) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(i.fullName),
                        subtitle: Text(i.muid),
                        trailing: Chip(
                          label: Text(i.status),
                          visualDensity: VisualDensity.compact,
                        ),
                      ))
                  .toList(),
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
            Expanded(
              child: Text('Meetings', style: Theme.of(context).textTheme.titleMedium),
            ),
            if (isLead)
              TextButton.icon(
                onPressed: () => context
                    .push(RoutePaths.createMeetingPath(circleId)),
                icon: const Icon(Icons.add),
                label: const Text('New'),
              ),
          ],
        ),
        meetingsState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Text(ApiException.messageFor(error)),
          data: (meetings) {
            if (meetings.isEmpty) return const Text('No meetings scheduled.');
            return Column(
              children: meetings
                  .map((m) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.video_call_outlined),
                        title: Text(m.title),
                        subtitle: Text(m.meetTime),
                        onTap: () => context.push(
                          RoutePaths.meetingDetailPath(m.id),
                          extra: circleId,
                        ),
                      ))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
