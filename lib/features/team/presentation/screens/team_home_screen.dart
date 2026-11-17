import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/features/team/presentation/providers/team_home_controller.dart';

/// The team workspace's home: announcements, push campaigns and the activity
/// log, plus a test push to the signed-in account's own phone.
class TeamHomeScreen extends ConsumerWidget {
  const TeamHomeScreen({super.key});

  Future<void> _sendTestPush(BuildContext context, WidgetRef ref) async {
    try {
      final message = await ref
          .read(teamHomeControllerProvider.notifier)
          .sendTestPush();
      if (context.mounted) {
        MuToast.show(context, message: message, type: MuToastType.success);
      }
    } on Object catch (e) {
      if (context.mounted) {
        MuToast.show(
          context,
          message: ApiException.messageFor(e),
          type: MuToastType.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sending = ref.watch(teamHomeControllerProvider).isLoading;
    return MuWorkspacePage(
      title: 'Team',
      body: ListView(
        padding: muListPadding,
        children: [
          MuFeedGroup(
            children: [
              MuFeedRow(
                leading: const MuFeedIcon(
                  LucideIcons.megaphone,
                  tone: MuFeedTone.event,
                ),
                subject: 'Announcements',
                time: "In-app messages in everyone's bell",
                trailing: const _Chevron(),
                onTap: () => context.push(RoutePaths.teamAnnouncements),
              ),
              MuFeedRow(
                leading: const MuFeedIcon(
                  LucideIcons.smartphone,
                  tone: MuFeedTone.event,
                ),
                subject: 'Push campaigns',
                time: "Pushes to learners' phones",
                trailing: const _Chevron(),
                onTap: () => context.push(RoutePaths.teamCampaigns),
              ),
              MuFeedRow(
                leading: const MuFeedIcon(
                  LucideIcons.history,
                  tone: MuFeedTone.event,
                ),
                subject: 'Activity log',
                time: 'Who sent, edited or deleted what',
                trailing: const _Chevron(),
                divider: false,
                onTap: () => context.push(RoutePaths.teamLog),
              ),
            ],
          ),
          const SizedBox(height: MuSpacing.space6),
          MuButton(
            label: 'Send me a test push',
            variant: MuButtonVariant.outline,
            block: true,
            loading: sending,
            onPressed: sending
                ? null
                : () => unawaited(_sendTestPush(context, ref)),
          ),
        ],
      ),
    );
  }
}

class _Chevron extends StatelessWidget {
  const _Chevron();

  @override
  Widget build(BuildContext context) => Icon(
    LucideIcons.chevronRight,
    size: MuSizes.iconSm + 2,
    color: context.mu.colors.ink3,
  );
}
