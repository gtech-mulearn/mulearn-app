import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/config/flavor_config.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/features/campus_profile/domain/entities/public_campus.dart';
import 'package:mulearn_app/features/campus_profile/presentation/providers/campus_profile_providers.dart';

const _dayLetters = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

String _clusterLabel(String key) => switch (key) {
  'coder' => 'Coder',
  'maker' => 'Maker',
  'creative' => 'Creative',
  'manager' => 'Manager',
  'unclustered' => 'Not in a group yet',
  _ => key.isEmpty ? key : '${key[0].toUpperCase()}${key.substring(1)}',
};

/// A college's public page, the one the dashboard opens from campus search
/// (CampusView): the campus as a seal on night with its rank, members and
/// karma, the week's karma, its top learners, where its learners are (IG
/// categories and active chapters), who runs it, and its links. Read-only;
/// Share copies the dashboard link.
class PublicCampusScreen extends ConsumerWidget {
  const PublicCampusScreen({required this.campusId, super.key});

  final String campusId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(publicCampusProvider(campusId));
    return Scaffold(
      backgroundColor: context.mu.colors.chalk,
      body: state.when(
        skipError: true,
        skipLoadingOnReload: true,
        loading: () => const SafeArea(
          child: Center(child: MuDotsLoader(label: 'Loading the campus…')),
        ),
        error: (e, _) => SafeArea(
          child: Column(
            children: [
              const MuTopBar.detail(),
              Expanded(
                child: ErrorRetryView(
                  error: e,
                  onRetry: () => ref.invalidate(publicCampusProvider(campusId)),
                ),
              ),
            ],
          ),
        ),
        data: (campus) => MuRefresh(
          onRefresh: () => Future.wait([
            ref.refresh(publicCampusProvider(campusId).future),
            ref.refresh(publicCampusWeeklyKarmaProvider(campusId).future),
          ]),
          child: ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: EdgeInsets.zero,
            children: [
              _Hero(campus: campus),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  MuSpacing.space5,
                  MuSpacing.space5,
                  MuSpacing.space5,
                  MuSpacing.space8,
                ),
                child: _Body(campus: campus),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.campus});

  final PublicCampus campus;

  Future<void> _share(BuildContext context) async {
    await Clipboard.setData(
      ClipboardData(
        text:
            '${FlavorConfig.instance.dashboardUrl}/dashboard/campus/${campus.id}',
      ),
    );
    if (context.mounted) {
      MuToast.show(
        context,
        message: 'Campus link copied',
        type: MuToastType.success,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return Container(
      color: c.night,
      padding: EdgeInsets.fromLTRB(
        MuSpacing.space5,
        MediaQuery.paddingOf(context).top + MuSpacing.space2,
        MuSpacing.space5,
        MuSpacing.space6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MuIconButton(
                icon: LucideIcons.arrowLeft,
                tooltip: 'Back',
                variant: MuIconButtonVariant.night,
                onPressed: () => Navigator.of(context).maybePop(),
              ),
              const Spacer(),
              MuIconButton(
                icon: LucideIcons.share2,
                tooltip: 'Share campus',
                variant: MuIconButtonVariant.night,
                onPressed: () => unawaited(_share(context)),
              ),
            ],
          ),
          const SizedBox(height: MuSpacing.space5),
          Row(
            children: [
              MuCampusSeal(
                code: campus.code,
                tone: IgCategory.others,
                size: 84,
              ),
              const SizedBox(width: MuSpacing.space4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      [
                        if (campus.zone.isNotEmpty) campus.zone,
                        'Campus',
                      ].join(' · ').toUpperCase(),
                      style: mu.text.eyebrow.copyWith(color: c.onNight2),
                    ),
                    const SizedBox(height: MuSpacing.space1),
                    Semantics(
                      header: true,
                      child: Text(
                        campus.name,
                        style: mu.text.title1.copyWith(
                          color: c.onNight,
                          fontSize: 24,
                          height: 1.1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (campus.rank != null) ...[
            const SizedBox(height: MuSpacing.space4),
            MuPill(
              '#${campus.rank} on the campus leaderboard',
              tone: MuPillTone.volt,
              icon: LucideIcons.trophy,
            ),
          ],
        ],
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.campus});

  final PublicCampus campus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final clusters = [...campus.clusters]
      ..sort((a, b) => b.members.compareTo(a.members));
    final chapters = [...campus.chapters]
      ..sort((a, b) => b.members.compareTo(a.members));
    final top = campus.topLearners;
    final leaderKarma = top.isEmpty
        ? 0
        : top.map((t) => t.karma).reduce((a, b) => a > b ? a : b);
    final people = [?campus.lead, ...campus.execom];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: MuStatTile(
                label: 'Learners',
                value: muGrouped(campus.members),
              ),
            ),
            const SizedBox(width: MuSpacing.space2),
            Expanded(
              child: MuStatTile(
                label: 'Active',
                value: muGrouped(campus.activeMembers),
              ),
            ),
            const SizedBox(width: MuSpacing.space2),
            Expanded(
              child: MuStatTile(
                label: 'Karma',
                value: muGrouped(campus.totalKarma),
              ),
            ),
          ],
        ),
        const MuSectionEyebrow('This week'),
        _WeeklyKarma(campusId: campus.id),
        if (top.isNotEmpty) ...[
          const MuSectionEyebrow('Top learners'),
          MuSurfaceCard(
            padding: const EdgeInsets.symmetric(
              horizontal: MuSpacing.space4,
              vertical: MuSpacing.space1,
            ),
            child: Column(
              children: [
                for (final t in top)
                  MuRankRow(
                    rank: t.rank,
                    entry: MuRankEntry(
                      name: t.fullName,
                      karma: t.karma,
                      subtitle: t.muid,
                      photoUrl: t.profilePic,
                    ),
                    maxKarma: leaderKarma,
                    onTap: () =>
                        context.push(RoutePaths.publicProfilePath(t.muid)),
                  ),
              ],
            ),
          ),
        ],
        if (clusters.isNotEmpty) ...[
          const MuSectionEyebrow('Where its learners are'),
          MuBarList(
            items: [
              for (final cl in clusters)
                (
                  label: _clusterLabel(cl.cluster),
                  value: cl.members,
                  icon: null,
                  note: cl.karma > 0 ? '${muGrouped(cl.karma)} karma' : null,
                ),
            ],
          ),
        ],
        if (chapters.isNotEmpty) ...[
          const MuSectionEyebrow('Interest group chapters'),
          MuFeedGroup(
            children: [
              for (var i = 0; i < chapters.length; i++)
                MuFeedRow(
                  leading: const MuFeedIcon(
                    LucideIcons.layers,
                    tone: MuFeedTone.event,
                  ),
                  subject: chapters[i].name,
                  time: [
                    if (chapters[i].code.isNotEmpty) chapters[i].code,
                    if (chapters[i].members == 1)
                      '1 member'
                    else
                      '${chapters[i].members} members',
                    if (chapters[i].leadName != null)
                      'Led by ${chapters[i].leadName}',
                  ].join(' · '),
                  divider: i < chapters.length - 1,
                ),
            ],
          ),
        ],
        if (people.isNotEmpty) ...[
          const MuSectionEyebrow('Who runs it'),
          MuFeedGroup(
            children: [
              for (var i = 0; i < people.length; i++)
                MuFeedRow(
                  leading: MuAvatar(
                    name: people[i].fullName,
                    url: people[i].profilePic,
                    size: MuSizes.avatarMd,
                  ),
                  subject: people[i].fullName,
                  time: [?people[i].role, people[i].muid].join(' · '),
                  divider: i < people.length - 1,
                  onTap: () => context.push(
                    RoutePaths.publicProfilePath(people[i].muid),
                  ),
                ),
            ],
          ),
        ],
        if (campus.links.isNotEmpty) ...[
          const MuSectionEyebrow('Find the campus'),
          Wrap(
            spacing: MuSpacing.space2,
            runSpacing: MuSpacing.space2,
            children: [
              for (final l in campus.links)
                MuButton(
                  label: l.platform,
                  icon: LucideIcons.arrowUpRight,
                  variant: MuButtonVariant.outline,
                  size: MuButtonSize.small,
                  onPressed: () {
                    final uri = Uri.tryParse(l.url);
                    if (uri != null) {
                      unawaited(ref.read(openExternalProvider)(uri));
                    }
                  },
                ),
            ],
          ),
        ],
        const SizedBox(height: MuSpacing.space4),
        Text(
          'Learners with private profiles open only their name.',
          style: mu.text.caption,
        ),
      ],
    );
  }
}

/// Seven single-hue bars, the best day in volt.
class _WeeklyKarma extends ConsumerWidget {
  const _WeeklyKarma({required this.campusId});

  final String campusId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    return ref
        .watch(publicCampusWeeklyKarmaProvider(campusId))
        .when(
          skipError: true,
          skipLoadingOnReload: true,
          loading: () =>
              const SizedBox(height: 120, child: Center(child: MuDotsLoader())),
          error: (e, _) =>
              Text(ApiException.messageFor(e), style: mu.text.caption),
          data: (days) {
            final total = days.fold<int>(0, (s, d) => s + d.karma);
            if (days.isEmpty || total == 0) {
              return const MuEmptyLine(
                'No karma earned at this campus this week yet.',
              );
            }
            final peak = days
                .map((d) => d.karma)
                .reduce((a, b) => a > b ? a : b);
            return MuSurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        muGrouped(total),
                        style: mu.text.numeral.copyWith(
                          fontSize: 28,
                          color: c.voltText,
                        ),
                      ),
                      const SizedBox(width: MuSpacing.space2),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text('karma in 7 days', style: mu.text.caption),
                      ),
                    ],
                  ),
                  const SizedBox(height: MuSpacing.space4),
                  SizedBox(
                    height: 96,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (final d in days)
                          Expanded(
                            child: Semantics(
                              label: '${formatDay(d.day)}: ${d.karma} karma',
                              excludeSemantics: true,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: peak == 0
                                        ? 2
                                        : (72 * d.karma / peak)
                                              .clamp(2, 72)
                                              .toDouble(),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: d.karma == peak
                                          ? c.volt
                                          : c.cobalt,
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(4),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: MuSpacing.space2),
                                  Text(
                                    _dayLetters[d.day.weekday - 1],
                                    style: mu.text.caption,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
  }
}
