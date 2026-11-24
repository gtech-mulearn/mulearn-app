import 'package:flutter/material.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/utils/count_format.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/features/team/domain/entities/activity_campaign.dart';
import 'package:mulearn_app/features/team/domain/entities/activity_entry.dart';
import 'package:mulearn_app/features/team/presentation/activity_labels.dart';
import 'package:mulearn_app/features/team/presentation/campaign_labels.dart';
import 'package:mulearn_app/features/team/presentation/widgets/campaign_status_pill.dart';
import 'package:mulearn_app/features/team/presentation/widgets/fact_row.dart';

/// What one activity-log row was: a summary (title, who, when, audience), for
/// a push campaign its live status and counts with a way to open it, and
/// what changed. The counts are as of the page load; pull-to-refresh on the
/// log updates them.
class ActivityDetailSheet extends StatelessWidget {
  const ActivityDetailSheet({
    required this.entry,
    required this.now,
    required this.onOpenCampaign,
    super.key,
  });

  final ActivityEntry entry;

  /// The local time the log was last shown at, for "3h ago".
  final DateTime now;

  /// Called with the campaign's id when "Open campaign" is tapped.
  final ValueChanged<String> onOpenCampaign;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final e = entry;
    final campaign = e.campaign;
    final isCampaign = e.entityName == kCampaignEntity;
    final campaignId = e.entityId;
    final changes = activityChangeLines(e);
    final audience = activityAudience(e);
    final at = e.createdAt.toLocal();
    final who = [
      if (e.actorName.isNotEmpty) e.actorName,
      if (e.actorMuid.isNotEmpty) e.actorMuid,
      if (e.roles.isNotEmpty) rolesLabel(e.roles, separator: ' + '),
    ].join(' · ');
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        MuSpacing.space5,
        0,
        MuSpacing.space5,
        MuSpacing.space6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(header: true, child: Text(e.label, style: mu.text.title2)),
          const SizedBox(height: MuSpacing.space3),
          _Card(
            children: [
              FactRow('Title', e.title ?? '—'),
              FactRow('Who', who.isEmpty ? '—' : who),
              FactRow(
                'When',
                '${formatDayTime(at)} · ${formatAgo(at, now)}',
                last: audience == null,
              ),
              if (audience != null) FactRow('Audience', audience, last: true),
            ],
          ),
          if (isCampaign && campaign != null) ...[
            const SizedBox(height: MuSpacing.space4),
            Align(
              alignment: Alignment.centerLeft,
              child: CampaignStatusPill(campaign.status),
            ),
            const SizedBox(height: MuSpacing.space2),
            _CampaignCounts(campaign),
          ],
          if (isCampaign && campaign == null) ...[
            const SizedBox(height: MuSpacing.space4),
            Text(
              'This campaign no longer exists',
              style: mu.text.body.copyWith(color: c.ink2),
            ),
          ],
          if (changes.isNotEmpty) ...[
            const SizedBox(height: MuSpacing.space5),
            Text('What changed', style: mu.text.label.copyWith(color: c.ink3)),
            const SizedBox(height: MuSpacing.space2),
            for (final line in changes)
              Padding(
                padding: const EdgeInsets.only(bottom: MuSpacing.space1),
                child: Text(line, style: mu.text.body.copyWith(color: c.ink)),
              ),
          ],
          if (isCampaign && campaign != null && campaignId != null) ...[
            const SizedBox(height: MuSpacing.space5),
            MuButton(
              label: 'Open campaign',
              block: true,
              onPressed: () => onOpenCampaign(campaignId),
            ),
          ],
        ],
      ),
    );
  }
}

class _CampaignCounts extends StatelessWidget {
  const _CampaignCounts(this.campaign);

  final ActivityCampaign campaign;

  @override
  Widget build(BuildContext context) => _Card(
    children: [
      FactRow('Phones', formatCount(campaign.targetCount)),
      FactRow('Delivered', formatCount(campaign.sentCount)),
      FactRow('Skipped', formatCount(campaign.skippedCount)),
      FactRow('Failed', formatCount(campaign.failedCount), last: true),
    ],
  );
}

class _Card extends StatelessWidget {
  const _Card({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: MuSpacing.space4,
      vertical: MuSpacing.space2,
    ),
    decoration: BoxDecoration(
      color: context.mu.colors.surfaceSunk,
      borderRadius: BorderRadius.circular(MuRadii.card),
    ),
    child: Column(children: children),
  );
}
