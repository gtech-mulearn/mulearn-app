import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/features/team/domain/entities/push_campaign.dart';
import 'package:mulearn_app/features/team/presentation/campaign_labels.dart';

/// A campaign's status as a pill: sending, sent and failed carry an icon.
class CampaignStatusPill extends StatelessWidget {
  const CampaignStatusPill(this.status, {super.key});

  final CampaignStatus status;

  @override
  Widget build(BuildContext context) {
    final (tone, icon) = switch (status) {
      CampaignStatus.draft => (MuPillTone.neutral, null),
      CampaignStatus.scheduled => (MuPillTone.cobalt, null),
      CampaignStatus.sending => (MuPillTone.warning, LucideIcons.send),
      CampaignStatus.sent => (MuPillTone.success, LucideIcons.checkCircle2),
      CampaignStatus.cancelled => (MuPillTone.neutral, null),
      CampaignStatus.failed => (MuPillTone.danger, LucideIcons.alertCircle),
    };
    return MuPill(campaignStatusLabel(status), tone: tone, icon: icon);
  }
}
