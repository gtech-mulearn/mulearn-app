import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/features/profile/domain/entities/karma_distribution_entry.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_log_entry.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/presentation/providers/badges_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/public_profile_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/user_log_controller.dart';

/// The profile's Karma section: a year of activity, where the karma comes
/// from, the tasks completed, and the ledger. Pass [publicMuid] for someone
/// else's profile.
class ProfileKarmaTab extends ConsumerWidget {
  const ProfileKarmaTab({required this.profile, this.publicMuid, super.key});

  final UserProfile profile;
  final String? publicMuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logState = publicMuid == null ? ref.watch(userLogProvider) : ref.watch(publicUserLogProvider(publicMuid!));
    final badges = ref.watch(badgesProvider(publicMuid ?? profile.muid)).value?.completedTasks ?? const <String>[];

    // A plain column: it lives inside the profile's single scroll.
    return Padding(
      padding: const EdgeInsets.fromLTRB(MuSpacing.space5, MuSpacing.space2, MuSpacing.space5, MuSpacing.navClearance),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Card(
            title: 'Activity',
            child: logState.when(
              loading: () => const SizedBox(height: 120, child: Center(child: CircularProgressIndicator())),
              error: (e, _) => Text(ApiException.messageFor(e), style: context.mu.text.body),
              data: (entries) => _Heatmap(entries: entries),
            ),
          ),
          if (profile.karmaDistribution.any((e) => e.karma > 0))
            _Card(
              title: 'Where it comes from',
              child: _Distribution(entries: profile.karmaDistribution),
            ),
          if (badges.isNotEmpty)
            _Card(
              title: 'Tasks completed',
              trailing: '${badges.length}',
              child: _Badges(names: badges),
            ),
          _Card(
            title: 'Karma history',
            child: logState.when(
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
              data: (entries) => entries.isEmpty
                  ? Text('No karma yet. Finish a task to earn some.', style: context.mu.text.body)
                  : _Ledger(entries: entries),
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.title, required this.child, this.trailing});

  final String title;
  final String? trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    return Padding(
      padding: const EdgeInsets.only(bottom: MuSpacing.space4),
      child: Container(
        padding: const EdgeInsets.all(MuSpacing.space5),
        decoration: BoxDecoration(color: mu.colors.surface, borderRadius: BorderRadius.circular(MuRadii.card)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Semantics(header: true, child: Text(title, style: mu.text.title3)),
                ),
                if (trailing != null) Text(trailing!, style: mu.text.caption),
              ],
            ),
            const SizedBox(height: MuSpacing.space3),
            child,
          ],
        ),
      ),
    );
  }
}

/// Recent karma as a day grid (one column per week, Monday on top), shaded
/// by the day's karma relative to the busiest day. As many whole weeks as
/// fit the card's width, ending this week, so the grid fills the card edge
/// to edge with no horizontal scroll.
class _Heatmap extends StatelessWidget {
  const _Heatmap({required this.entries});

  final List<UserLogEntry> entries;

  static const _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  static const _gap = 3.0;
  static const _targetCell = 12.0;
  static const _labelH = 14.0;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final scale = [
      c.surfaceSunk,
      for (final t in const [0.3, 0.55, 0.8, 1.0]) Color.lerp(c.surfaceSunk, c.cobalt, t)!,
    ];

    final totals = <DateTime, num>{};
    for (final e in entries) {
      final d = DateTime.tryParse(e.createdDate)?.toLocal();
      if (d == null) continue;
      final day = DateTime(d.year, d.month, d.day);
      totals.update(day, (v) => v + e.karma, ifAbsent: () => e.karma);
    }
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final thisMonday = today.subtract(Duration(days: today.weekday - 1));

    return LayoutBuilder(
      builder: (context, box) {
        final width = box.maxWidth;
        final weeks = ((width + _gap) / (_targetCell + _gap)).floor().clamp(4, 53);
        final cell = (width - (weeks - 1) * _gap) / weeks;
        final first = thisMonday.subtract(Duration(days: (weeks - 1) * 7));
        final columns = [
          for (var w = 0; w < weeks; w++) [for (var d = 0; d < 7; d++) first.add(Duration(days: w * 7 + d))],
        ];
        final inRange = totals.entries.where((e) => !e.key.isBefore(first) && !e.key.isAfter(today));
        final busiest = inRange.fold<num>(0, (a, e) => e.value > a ? e.value : a);
        final total = inRange.fold<num>(0, (a, e) => a + e.value);
        int bucket(num v) => (v <= 0 || busiest <= 0) ? 0 : ((v / busiest) * 4).ceil().clamp(1, 4);
        final monthsShown = (weeks * 7 / 30.4).round();

        // Month labels sit over the first week that starts in that month;
        // a label is skipped when it would collide with the previous one.
        final labels = <Widget>[];
        var lastEnd = -100.0;
        for (var i = 0; i < columns.length; i++) {
          final m = columns[i].first.month;
          if (i > 0 && columns[i - 1].first.month == m) continue;
          final x = i * (cell + _gap);
          if (x < lastEnd + 4 || x > width - 22) continue;
          labels.add(
            Positioned(
              left: x,
              top: 0,
              child: Text(_months[m - 1], style: mu.text.caption.copyWith(fontSize: 10)),
            ),
          );
          lastEnd = x + 24;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: muGrouped(total.round()),
                    style: mu.text.numeral.copyWith(fontSize: 22, color: c.voltText),
                  ),
                  TextSpan(
                    text: '  karma in the last $monthsShown months',
                    style: mu.text.label.copyWith(color: c.ink2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: MuSpacing.space3),
            ExcludeSemantics(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: _labelH,
                    width: width,
                    child: Stack(clipBehavior: Clip.none, children: labels),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var w = 0; w < columns.length; w++)
                        Padding(
                          padding: EdgeInsets.only(right: w == columns.length - 1 ? 0 : _gap),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (var d = 0; d < 7; d++)
                                Padding(
                                  padding: EdgeInsets.only(bottom: d == 6 ? 0 : _gap),
                                  child: Container(
                                    width: cell,
                                    height: cell,
                                    decoration: BoxDecoration(
                                      color: columns[w][d].isAfter(today)
                                          ? Colors.transparent
                                          : scale[bucket(totals[columns[w][d]] ?? 0)],
                                      borderRadius: BorderRadius.circular(cell / 4),
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
            const SizedBox(height: MuSpacing.space3),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Less', style: mu.text.caption),
                const SizedBox(width: 6),
                for (final color in scale)
                  Container(
                    width: 11,
                    height: 11,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
                  ),
                const SizedBox(width: 6),
                Text('More', style: mu.text.caption),
              ],
            ),
          ],
        );
      },
    );
  }
}

/// Karma by task type as bars scaled to the largest.
class _Distribution extends StatelessWidget {
  const _Distribution({required this.entries});

  final List<KarmaDistributionEntry> entries;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final rows = entries.where((e) => e.karma > 0).toList()..sort((a, b) => b.karma.compareTo(a.karma));
    final max = rows.first.karma;
    return Column(
      children: [
        for (final e in rows)
          Padding(
            padding: const EdgeInsets.only(bottom: MuSpacing.space3),
            child: Semantics(
              label: '${e.taskType}, ${muGrouped(e.karma.round())} karma',
              excludeSemantics: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(e.taskType, style: mu.text.label, maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                      Text(muGrouped(e.karma.round()), style: mu.text.code.copyWith(fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(MuRadii.round),
                    child: SizedBox(
                      height: 8,
                      child: Stack(
                        children: [
                          Positioned.fill(child: ColoredBox(color: c.surfaceSunk)),
                          FractionallySizedBox(
                            // Grow from the start edge (the default centres the bar).
                            alignment: AlignmentDirectional.centerStart,
                            widthFactor: (e.karma / max).clamp(0.02, 1.0),
                            child: ColoredBox(color: c.cobalt),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

/// Completed tasks as success pills; the first dozen, then a count.
class _Badges extends StatelessWidget {
  const _Badges({required this.names});

  final List<String> names;

  @override
  Widget build(BuildContext context) {
    const shown = 12;
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final n in names.take(shown)) MuPill(n, tone: MuPillTone.success, icon: LucideIcons.check),
        if (names.length > shown) MuPill('+${names.length - shown} more'),
      ],
    );
  }
}

/// Every karma change, newest first, as people say the time.
class _Ledger extends StatelessWidget {
  const _Ledger({required this.entries});

  final List<UserLogEntry> entries;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final now = DateTime.now();
    final sorted = [...entries]..sort((a, b) => b.createdDate.compareTo(a.createdDate));
    return Column(
      children: [
        for (var i = 0; i < sorted.length; i++) ...[
          if (i > 0) Divider(color: c.line, height: 1),
          Builder(
            builder: (context) {
              final e = sorted[i];
              final negative = e.karma < 0;
              final when = DateTime.tryParse(e.createdDate)?.toLocal();
              final amount = '${negative ? '−' : '+'}${muGrouped(e.karma.abs().round())}';
              return Semantics(
                label: '${e.taskName}, $amount karma${when == null ? '' : ', ${formatAgo(when, now)}'}',
                excludeSemantics: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: MuSpacing.space3),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(color: negative ? c.dangerTint : c.volt, shape: BoxShape.circle),
                        child: Icon(LucideIcons.zap, size: MuSizes.iconSm, color: negative ? c.danger : c.onVolt),
                      ),
                      const SizedBox(width: MuSpacing.space3),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e.taskName, style: mu.text.bodyStrong, maxLines: 2, overflow: TextOverflow.ellipsis),
                            if (when != null) Text(formatAgo(when, now), style: mu.text.caption),
                          ],
                        ),
                      ),
                      const SizedBox(width: MuSpacing.space2),
                      Text(
                        amount,
                        style: mu.text.code.copyWith(
                          fontWeight: FontWeight.w700,
                          color: negative ? c.danger : c.voltText,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ],
    );
  }
}
