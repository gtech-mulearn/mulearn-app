import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:mulearn_app/features/profile/domain/entities/karma_distribution_entry.dart';
import 'package:mulearn_app/features/profile/domain/entities/socials.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_log_entry.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/presentation/providers/public_profile_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/socials_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/user_log_controller.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/edit_socials_dialog.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/share_profile_dialog.dart';

/// Interest groups, activity overview, karma distribution and quick
/// actions — mirrors DESIGN_SPEC.md §2 "12 — Profile & karma" → "Tab: Basic
/// Details", plus the pre-existing Roles / Social links / College sections
/// (real working features the mock doesn't show but which this app already
/// has — kept rather than dropped). Pass [publicMuid] to view another
/// user's details read-only instead of the signed-in user's own (hides the
/// edit affordances on interest groups/socials and the quick-actions list,
/// none of which make sense on someone else's profile).
class BasicDetailsTab extends ConsumerWidget {
  const BasicDetailsTab({required this.profile, super.key, this.publicMuid});

  final UserProfile profile;
  final String? publicMuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOwnProfile = publicMuid == null;
    final socialsState = isOwnProfile
        ? ref.watch(socialsControllerProvider)
        : ref.watch(publicSocialsProvider(publicMuid!));
    final logState = isOwnProfile
        ? ref.watch(userLogProvider)
        : ref.watch(publicUserLogProvider(publicMuid!));

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        MuSpace.screenH,
        MuSpace.screenH,
        MuSpace.screenH,
        MuSpace.navClearance,
      ),
      children: [
        _SectionCard(
          title: 'Your interest groups',
          editLabel: isOwnProfile ? 'Edit' : null,
          onEdit: isOwnProfile
              ? () => context.push(RoutePaths.interestGroups)
              : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: MuSpace.s,
                runSpacing: MuSpace.s,
                children: [
                  for (final group in profile.interestGroups)
                    MuTagChip(label: group.name),
                  if (profile.interestGroups.isEmpty)
                    Text(
                      '—',
                      style: MuType.body.copyWith(color: MuColors.inkSecondary),
                    ),
                ],
              ),
              const SizedBox(height: MuSpace.s),
              Text(
                'Your tasks, mentors and leaderboard are filtered to these. '
                'Level 4+ can hold two.',
                style: MuType.caption,
              ),
            ],
          ),
        ),
        _SectionCard(
          title: 'Activity overview',
          child: logState.when(
            loading: () => const SizedBox(
              height: 140,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, _) => Text(ApiException.messageFor(error)),
            data: (entries) => _ActivityHeatmap(entries: entries),
          ),
        ),
        _SectionCard(
          title: 'Karma distribution',
          child: _KarmaDonut(entries: profile.karmaDistribution),
        ),
        if (isOwnProfile) ...[
          Padding(
            padding: const EdgeInsets.only(
              bottom: MuSpace.s,
              top: MuSpace.xs,
              left: 2,
            ),
            child: Text('QUICK ACTIONS', style: MuType.eyebrow),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: MuSpace.m),
            child: _QuickActionsList(profile: profile),
          ),
        ],
        _SectionCard(
          title: 'Roles',
          child: Wrap(
            spacing: MuSpace.s,
            runSpacing: MuSpace.s,
            children: [
              for (final role in profile.roles)
                MuTagChip(
                  label: role,
                  style:
                      profile.roleVerification
                              .where((r) => r.role == role)
                              .firstOrNull
                              ?.isVerified ??
                          false
                      ? MuTagStyle.success
                      : MuTagStyle.neutral,
                ),
              if (profile.roles.isEmpty)
                Text(
                  '—',
                  style: MuType.body.copyWith(color: MuColors.inkSecondary),
                ),
            ],
          ),
        ),
        _SectionCard(
          title: 'Social links',
          onEdit: (!isOwnProfile || socialsState.value == null)
              ? null
              : () => showDialog<void>(
                  context: context,
                  builder: (_) =>
                      EditSocialsDialog(initial: socialsState.value!),
                ),
          child: socialsState.when(
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text(ApiException.messageFor(error)),
            data: (socials) => _SocialsList(socials: socials),
          ),
        ),
        _SectionCard(
          title: 'College',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(profile.collegeCode ?? '—', style: MuType.bodyMed),
              if (profile.departmentName != null)
                Text(profile.departmentName!, style: MuType.caption),
            ],
          ),
        ),
      ],
    );
  }
}

class _SocialsList extends StatelessWidget {
  const _SocialsList({required this.socials});

  final Socials socials;

  @override
  Widget build(BuildContext context) {
    final entries = <String, String?>{
      'GitHub': socials.github,
      'LinkedIn': socials.linkedin,
      'Instagram': socials.instagram,
      'Facebook': socials.facebook,
      'Dribble': socials.dribble,
      'Behance': socials.behance,
      'Stack Overflow': socials.stackoverflow,
      'Medium': socials.medium,
      'HackerRank': socials.hackerrank,
    }..removeWhere((_, value) => value == null || value.isEmpty);

    if (entries.isEmpty) {
      return Text(
        '—',
        style: MuType.body.copyWith(color: MuColors.inkSecondary),
      );
    }

    return Wrap(
      spacing: MuSpace.s,
      runSpacing: MuSpace.s,
      children: [
        for (final entry in entries.entries) MuTagChip(label: entry.key),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.child,
    this.onEdit,
    this.editLabel,
  });

  final String title;
  final Widget child;
  final VoidCallback? onEdit;

  /// When set, [onEdit] renders as a text link (e.g. "Edit") instead of a
  /// pencil icon button.
  final String? editLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: MuSpace.m),
      child: MuCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(title.toUpperCase(), style: MuType.eyebrow),
                ),
                if (onEdit != null)
                  GestureDetector(
                    onTap: onEdit,
                    child: editLabel != null
                        ? Text(
                            editLabel!,
                            style: MuType.chip.copyWith(
                              color: MuColors.primary,
                            ),
                          )
                        : const Icon(
                            LucideIcons.pencil,
                            size: 16,
                            color: MuColors.primary,
                          ),
                  ),
              ],
            ),
            const SizedBox(height: MuSpace.m),
            child,
          ],
        ),
      ),
    );
  }
}

/// GitHub-style contribution heatmap over the real `userLog` activity —
/// aggregated by day into a day→total-karma map, bucketed into
/// [MuColors.heatScale]'s 5 steps. A 52-week rolling window, horizontally
/// scrollable and auto-scrolled to the most recent week.
class _ActivityHeatmap extends StatefulWidget {
  const _ActivityHeatmap({required this.entries});

  final List<UserLogEntry> entries;

  @override
  State<_ActivityHeatmap> createState() => _ActivityHeatmapState();
}

class _ActivityHeatmapState extends State<_ActivityHeatmap> {
  final _scrollController = ScrollController();

  static const _monthAbbr = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', //
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  static const _weeks = 52;
  static const _cellSize = 10.0;
  static const _cellGap = 3.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totals = <DateTime, num>{};
    for (final entry in widget.entries) {
      final parsed = DateTime.tryParse(entry.createdDate);
      if (parsed == null) continue;
      final day = DateTime(parsed.year, parsed.month, parsed.day);
      totals.update(
        day,
        (value) => value + entry.karma,
        ifAbsent: () => entry.karma,
      );
    }

    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);
    final rangeStart = todayOnly.subtract(const Duration(days: _weeks * 7 - 1));
    // Align to the Monday on/before rangeStart so full weeks stack cleanly.
    final gridStart = rangeStart.subtract(
      Duration(days: (rangeStart.weekday - 1) % 7),
    );

    final maxDaily = totals.values.isEmpty
        ? 0
        : totals.values.reduce((a, b) => a > b ? a : b);
    final periodTotal = totals.values.fold<num>(0, (a, b) => a + b);

    int bucketFor(num value) {
      if (value <= 0 || maxDaily <= 0) return 0;
      final ratio = value / maxDaily;
      if (ratio <= 0.25) return 1;
      if (ratio <= 0.5) return 2;
      if (ratio <= 0.75) return 3;
      return 4;
    }

    final columns = <List<DateTime>>[];
    var cursor = gridStart;
    while (!cursor.isAfter(todayOnly)) {
      final week = <DateTime>[];
      for (var i = 0; i < 7; i++) {
        week.add(cursor);
        cursor = cursor.add(const Duration(days: 1));
      }
      columns.add(week);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${periodTotal.round()} karma in the last year',
          style: MuType.bodyMed,
        ),
        const SizedBox(height: MuSpace.m),
        SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < columns.length; i++)
                    SizedBox(
                      width: _cellSize + _cellGap,
                      child:
                          (i == 0 ||
                              columns[i].first.month !=
                                  columns[i - 1].first.month)
                          ? Text(
                              _monthAbbr[columns[i].first.month - 1],
                              style: MuType.caption.copyWith(fontSize: 9),
                            )
                          : const SizedBox.shrink(),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final week in columns)
                    Padding(
                      padding: const EdgeInsets.only(right: _cellGap),
                      child: Column(
                        children: [
                          for (final day in week)
                            Padding(
                              padding: const EdgeInsets.only(bottom: _cellGap),
                              child: Container(
                                width: _cellSize,
                                height: _cellSize,
                                decoration: BoxDecoration(
                                  color: day.isAfter(todayOnly)
                                      ? Colors.transparent
                                      : MuColors.heatScale[bucketFor(
                                          totals[day] ?? 0,
                                        )],
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: MuSpace.m),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Less', style: MuType.caption),
            const SizedBox(width: 6),
            for (final color in MuColors.heatScale)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Container(
                  width: _cellSize,
                  height: _cellSize,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            const SizedBox(width: 6),
            Text('More', style: MuType.caption),
          ],
        ),
      ],
    );
  }
}

/// Karma-distribution donut built from [UserProfile.karmaDistribution] —
/// arcs drawn with a [CustomPainter] (no charting package in pubspec.yaml),
/// colored via [MuColors.distColors], with a legend list below.
class _KarmaDonut extends StatelessWidget {
  const _KarmaDonut({required this.entries});

  final List<KarmaDistributionEntry> entries;

  @override
  Widget build(BuildContext context) {
    final total = entries.fold<num>(0, (a, b) => a + b.karma);

    if (entries.isEmpty || total <= 0) {
      return Text(
        'No karma earned yet.',
        style: MuType.body.copyWith(color: MuColors.inkSecondary),
      );
    }

    final sorted = [...entries]..sort((a, b) => b.karma.compareTo(a.karma));

    return Column(
      children: [
        Center(
          child: SizedBox(
            height: 160,
            width: 160,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(160, 160),
                  painter: _DonutPainter(entries: sorted, total: total),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${total.round()}',
                      style: MuType.stat.copyWith(fontSize: 26),
                    ),
                    Text('karma', style: MuType.caption),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: MuSpace.l),
        for (var i = 0; i < sorted.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: MuColors.distColors[i % MuColors.distColors.length],
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: MuSpace.s),
                Expanded(
                  child: Text(
                    sorted[i].taskType,
                    style: MuType.bodyMed,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${sorted[i].karma.round()}',
                  style: MuType.statSmall.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _DonutPainter extends CustomPainter {
  _DonutPainter({required this.entries, required this.total});

  final List<KarmaDistributionEntry> entries;
  final num total;

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width * 0.22;
    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );
    var startAngle = -math.pi / 2;
    for (var i = 0; i < entries.length; i++) {
      final sweep = (entries[i].karma / total) * 2 * math.pi;
      final paint = Paint()
        ..color = MuColors.distColors[i % MuColors.distColors.length]
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;
      // A tiny gap between segments (unless it's the only/full segment).
      final gap = entries.length > 1 ? 0.02 : 0.0;
      canvas.drawArc(rect, startAngle, math.max(sweep - gap, 0), false, paint);
      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) =>
      oldDelegate.entries != entries || oldDelegate.total != total;
}

/// Gear/karma-rules/share/help quick-links (DESIGN_SPEC.md §2 "12" → "Tab:
/// Basic Details" → "QUICK ACTIONS"). Only "Share my proof profile" has a
/// real destination in this app today ([ShareProfileDialog], already wired
/// from the header) — the rest are stubbed with the mock's own toast copy,
/// matching its own scope there rather than fabricating destinations that
/// don't exist yet.
class _QuickActionsList extends ConsumerWidget {
  const _QuickActionsList({required this.profile});

  final UserProfile profile;

  Future<void> _confirmSignOut(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      await ref.read(authControllerProvider.notifier).signOut();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MuCard(
      padding: const EdgeInsets.symmetric(vertical: MuSpace.xs),
      child: Column(
        children: [
          _QuickActionRow(
            icon: LucideIcons.settings,
            label: 'Account settings',
            onTap: () => MuToast.show(
              context,
              message: 'Account settings — coming next.',
            ),
          ),
          _QuickActionRow(
            icon: LucideIcons.zap,
            label: 'Karma rules & appeals',
            onTap: () => MuToast.show(
              context,
              message: 'Karma rules & appeals — coming next.',
            ),
          ),
          _QuickActionRow(
            icon: LucideIcons.share2,
            label: 'Share my proof profile',
            onTap: () => showDialog<void>(
              context: context,
              builder: (_) => ShareProfileDialog(profile: profile),
            ),
          ),
          _QuickActionRow(
            icon: LucideIcons.helpCircle,
            label: 'Help & community guidelines',
            onTap: () => MuToast.show(
              context,
              message: 'Help & community guidelines — coming next.',
            ),
          ),
          _QuickActionRow(
            icon: LucideIcons.logOut,
            label: 'Sign out',
            iconColor: MuColors.error,
            onTap: () => _confirmSignOut(context, ref),
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _QuickActionRow extends StatelessWidget {
  const _QuickActionRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.isLast = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final color = iconColor ?? MuColors.primary;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: MuSpace.l,
          vertical: MuSpace.m,
        ),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : const Border(bottom: BorderSide(color: MuColors.hairline)),
        ),
        child: Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(MuRadius.inner),
              ),
              alignment: Alignment.center,
              child: Icon(icon, size: 18, color: color),
            ),
            const SizedBox(width: MuSpace.m),
            Expanded(child: Text(label, style: MuType.bodyMed)),
            const Icon(
              LucideIcons.chevronRight,
              size: 18,
              color: MuColors.inkFaint,
            ),
          ],
        ),
      ),
    );
  }
}
