import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_paged_list.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/team/domain/entities/push_campaign.dart';
import 'package:mulearn_app/features/team/presentation/campaign_labels.dart';
import 'package:mulearn_app/features/team/presentation/providers/campaigns_controller.dart';
import 'package:mulearn_app/features/team/presentation/widgets/campaign_status_pill.dart';

/// Every push campaign, newest first, with a way to start a new one. A row
/// opens the campaign. While one is sending the list refreshes itself.
class CampaignsScreen extends ConsumerWidget {
  const CampaignsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(campaignsControllerProvider);
    final controller = ref.read(campaignsControllerProvider.notifier);
    final now = ref.watch(clockProvider)().toLocal();
    return MuWorkspacePage(
      title: 'Push campaigns',
      action: MuIconButton(
        icon: LucideIcons.plus,
        tooltip: 'New push',
        onPressed: () => unawaited(context.push(RoutePaths.teamCampaignNew)),
      ),
      body: async.when(
        skipError: true,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorRetryView(
          error: error,
          onRetry: () => ref.invalidate(campaignsControllerProvider),
        ),
        data: (campaigns) => MuPagedListView<PushCampaign>(
          state: PagedState(items: campaigns, hasMore: false),
          grouped: true,
          onLoadMore: () async {},
          onRefresh: controller.refresh,
          empty: const MuStateDisplay(
            variant: MuStateVariant.noResults,
            title: 'No push campaigns',
            description:
                "Pushes you send to learners' phones will show up here.",
          ),
          itemBuilder: (context, c, i) => MuFeedRow(
            leading: const MuFeedIcon(LucideIcons.bell, tone: MuFeedTone.event),
            subject: c.title,
            body:
                '${campaignAudienceLabel(c)} · ~${c.targetCount} phones · '
                "${c.createdBy ?? '—'}",
            time: formatAgo(
              (c.sentAt ?? c.scheduledAt ?? c.createdAt).toLocal(),
              now,
            ),
            trailing: CampaignStatusPill(c.status),
            divider: i < campaigns.length - 1,
            onTap: () =>
                unawaited(context.push(RoutePaths.teamCampaignPath(c.id))),
          ),
        ),
      ),
    );
  }
}
