import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/count_format.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/team/domain/entities/push_campaign.dart';
import 'package:mulearn_app/features/team/presentation/campaign_labels.dart';
import 'package:mulearn_app/features/team/presentation/campaign_links.dart';
import 'package:mulearn_app/features/team/presentation/providers/campaigns_controller.dart';
import 'package:mulearn_app/features/team/presentation/widgets/campaign_status_pill.dart';
import 'package:mulearn_app/features/team/presentation/widgets/fact_row.dart';

/// One push campaign in full, with Send now and Cancel where they apply. It
/// reads the campaign from the loaded list, which updates on pull-to-refresh
/// and after the user's own send or cancel; one that isn't there reads as
/// not found.
class CampaignDetailScreen extends ConsumerStatefulWidget {
  const CampaignDetailScreen({required this.campaignId, super.key});

  final String campaignId;

  @override
  ConsumerState<CampaignDetailScreen> createState() =>
      _CampaignDetailScreenState();
}

class _CampaignDetailScreenState extends ConsumerState<CampaignDetailScreen> {
  bool _busy = false;

  Future<void> _run(PushCampaign c, CampaignAction action, String done) async {
    setState(() => _busy = true);
    try {
      await ref.read(campaignsControllerProvider.notifier).act(c.id, action);
      if (mounted) {
        MuToast.show(context, message: done, type: MuToastType.success);
      }
    } on Object catch (e) {
      if (mounted) {
        MuToast.show(
          context,
          message: ApiException.messageFor(e),
          type: MuToastType.error,
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _send(PushCampaign c) async {
    final replaces = c.status == CampaignStatus.scheduled
        ? ' It replaces the schedule.'
        : '';
    final confirmed = await showMuConfirm(
      context,
      title: 'Send now?',
      body: 'This goes to ${countOf(c.targetCount, 'phone')}.$replaces',
      confirmLabel: 'Send',
    );
    if (!confirmed || !mounted) return;
    await _run(c, CampaignAction.send, 'Sending started');
  }

  Future<void> _cancel(PushCampaign c) async {
    final confirmed = await showMuConfirm(
      context,
      destructive: true,
      title: 'Cancel this campaign?',
      body: c.status == CampaignStatus.sending
          ? 'Phones that already got it keep it. The rest will not.'
          : 'It will not be sent.',
      confirmLabel: 'Yes, cancel it',
      cancelLabel: 'Keep it',
    );
    if (!confirmed || !mounted) return;
    await _run(c, CampaignAction.cancel, 'Campaign cancelled');
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(campaignsControllerProvider);
    return async.when(
      skipError: true,
      loading: () => const MuWorkspacePage(
        title: 'Push campaign',
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => MuWorkspacePage(
        title: 'Push campaign',
        body: ErrorRetryView(
          error: error,
          onRetry: () => ref.invalidate(campaignsControllerProvider),
        ),
      ),
      data: (campaigns) {
        final matches = campaigns.where((c) => c.id == widget.campaignId);
        if (matches.isEmpty) {
          return const MuWorkspacePage(
            title: 'Push campaign',
            body: Center(
              child: SingleChildScrollView(
                child: MuStateDisplay(variant: MuStateVariant.notFound),
              ),
            ),
          );
        }
        final c = matches.first;
        final now = ref.watch(clockProvider)().toLocal();
        final canSend =
            c.status == CampaignStatus.draft ||
            c.status == CampaignStatus.scheduled;
        final canCancel = canSend || c.status == CampaignStatus.sending;
        return MuWorkspacePage(
          title: 'Push campaign',
          body: MuRefresh(
            onRefresh: ref.read(campaignsControllerProvider.notifier).refresh,
            child: _Body(campaign: c, now: now),
          ),
          bottom: canCancel
              ? Row(
                  children: [
                    Expanded(
                      child: MuButton(
                        label: 'Cancel campaign',
                        variant: MuButtonVariant.danger,
                        onPressed: _busy ? null : () => unawaited(_cancel(c)),
                      ),
                    ),
                    if (canSend) ...[
                      const SizedBox(width: MuSpacing.space3),
                      Expanded(
                        child: MuButton(
                          label: 'Send now',
                          loading: _busy,
                          onPressed: _busy ? null : () => unawaited(_send(c)),
                        ),
                      ),
                    ],
                  ],
                )
              : null,
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.campaign, required this.now});

  final PushCampaign campaign;
  final DateTime now;

  String _audience() {
    final c = campaign;
    return switch (c.audienceType) {
      AudienceType.roles => rolesLabel(c.audienceIds),
      _ => campaignAudienceLabel(c),
    };
  }

  String _when() {
    final c = campaign;
    final sent = c.sentAt;
    final scheduled = c.scheduledAt;
    if (sent != null) return 'Sent ${formatAgo(sent.toLocal(), now)}';
    if (scheduled != null) {
      final local = scheduled.toLocal();
      return local.isAfter(now)
          ? campaignScheduledLabel(local, now)
          : formatDayTime(local);
    }
    return 'Not scheduled';
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final k = campaign;
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: muListPadding,
      children: [
        Semantics(header: true, child: Text(k.title, style: mu.text.title2)),
        const SizedBox(height: MuSpacing.space2),
        Align(
          alignment: Alignment.centerLeft,
          child: CampaignStatusPill(k.status),
        ),
        const SizedBox(height: MuSpacing.space3),
        Text(k.body, style: mu.text.body.copyWith(color: c.ink2)),
        const SizedBox(height: MuSpacing.space6),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: MuSpacing.space4,
            vertical: MuSpacing.space2,
          ),
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: BorderRadius.circular(MuRadii.card),
          ),
          child: Column(
            children: [
              FactRow('Audience', _audience()),
              FactRow('Opens', campaignLinkLabel(k.route)),
              FactRow('When', _when()),
              FactRow(
                'Quiet hours',
                k.respectQuietHours ? 'Respected' : 'Ignored',
              ),
              FactRow('Phones', formatCount(k.targetCount)),
              FactRow('Delivered', formatCount(k.sentCount)),
              FactRow('Skipped', formatCount(k.skippedCount)),
              FactRow('Failed', formatCount(k.failedCount)),
              FactRow('Created by', k.createdBy ?? '—', last: true),
            ],
          ),
        ),
        if (k.status == CampaignStatus.sending) ...[
          const SizedBox(height: MuSpacing.space4),
          Text(
            'Sending now. Pull down for the latest numbers.',
            style: mu.text.body.copyWith(color: c.ink2),
          ),
        ],
      ],
    );
  }
}
