import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/router/tab_navigation.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/core/widgets/role_pending_banner.dart';
import 'package:mulearn_app/core/widgets/workspace_links.dart';
import 'package:mulearn_app/features/profile/domain/entities/socials.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/presentation/providers/editable_profile_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/interest_groups_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/public_profile_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/socials_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/user_levels_controller.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/edit_socials_dialog.dart';

/// The night sheet over the profile hero (artifact: ProfilePoster → Sheet):
/// the stat trio, top interests, campus, roles, workspaces and socials —
/// everything that says who this person is, in one place.
class ProfileSheet extends ConsumerWidget {
  const ProfileSheet({required this.profile, this.isOwn = true, this.onKarma, super.key});

  /// The sheet's ground: `night` over the light page; in dark mode the
  /// page's own dark, so the whole profile reads as one dark surface.
  static Color colorOf(BuildContext context) => context.mu.isDark ? context.mu.colors.chalk : context.mu.colors.night;

  final UserProfile profile;
  final bool isOwn;

  /// Shows the Karma section (the stat tile's action).
  final VoidCallback? onKarma;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final levels = isOwn ? ref.watch(userLevelsProvider) : ref.watch(publicUserLevelsProvider(profile.muid));
    final tasksDone = levels.value?.fold<int>(0, (sum, l) => sum + l.tasks.where((t) => t.completed).length);
    final department = isOwn ? ref.watch(editableProfileControllerProvider).value?.department?.title : null;
    final groups = ref.watch(interestGroupsListProvider).value;
    final categories = <String, String?>{
      if (groups != null)
        for (final ig in groups) ig.name.toLowerCase(): ig.category,
    };
    final socials = isOwn ? ref.watch(socialsControllerProvider) : ref.watch(publicSocialsProvider(profile.muid));

    return Container(
      width: double.infinity,
      // The rounded top is drawn by ProfileView, up into the hero.
      padding: const EdgeInsets.fromLTRB(MuSpacing.space5, 0, MuSpacing.space5, MuSpacing.space6),
      color: ProfileSheet.colorOf(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isOwn) const PendingRoleBanners(),
          Row(
            children: [
              Expanded(
                child: _Stat(value: muGrouped(profile.karma), label: 'Karma', karma: true, onTap: onKarma),
              ),
              const SizedBox(width: MuSpacing.space2),
              Expanded(
                child: _Stat(
                  value: tasksDone == null ? '—' : '$tasksDone',
                  label: 'Tasks done',
                  onTap: isOwn ? () => context.openTab(RoutePaths.journey) : null,
                ),
              ),
              const SizedBox(width: MuSpacing.space2),
              Expanded(
                child: _Stat(
                  value: profile.rank == null ? '—' : '#${profile.rank}',
                  label: 'Rank',
                  onTap: () => context.openTab(RoutePaths.leaderboard),
                ),
              ),
            ],
          ),
          const SizedBox(height: MuSpacing.space6),
          _Heading(
            isOwn ? 'Your interests' : 'Interests',
            action: isOwn ? 'Edit' : null,
            onAction: () => context.push(RoutePaths.interestGroups),
          ),
          const SizedBox(height: MuSpacing.space3),
          if (profile.interestGroups.isEmpty)
            Text(
              isOwn ? 'Join up to three Interest Groups to get their tasks.' : 'No Interest Groups yet.',
              style: mu.text.body.copyWith(color: c.onNight2),
            )
          else
            Wrap(
              spacing: MuSpacing.space2,
              runSpacing: MuSpacing.space2,
              children: [
                for (final ig in profile.interestGroups)
                  MuIgChip(name: ig.name, category: IgCategory.parse(categories[ig.name.toLowerCase()])),
              ],
            ),
          const SizedBox(height: MuSpacing.space6),
          _Campus(
            code: profile.collegeCode,
            department: department,
            joinedYear: profile.joined.length >= 4 ? profile.joined.substring(0, 4) : null,
          ),
          if (profile.roles.isNotEmpty) ...[
            const SizedBox(height: MuSpacing.space6),
            const _Heading('Roles'),
            const SizedBox(height: MuSpacing.space3),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final role in profile.roles)
                  if (profile.roleVerification.where((r) => r.role == role).firstOrNull?.isVerified ?? false)
                    MuPill(role, tone: MuPillTone.success, icon: LucideIcons.badgeCheck)
                  else if (profile.roleVerification.any((r) => r.role == role))
                    MuPill('$role · pending', tone: MuPillTone.warning, icon: LucideIcons.clock)
                  else
                    MuPill(role, tone: MuPillTone.paper),
              ],
            ),
          ],
          if (isOwn) const WorkspaceLinks(),
          const SizedBox(height: MuSpacing.space6),
          _Heading(
            'Socials',
            action: isOwn && socials.value != null ? 'Edit' : null,
            onAction: () => showDialog<void>(
              context: context,
              builder: (_) => EditSocialsDialog(initial: socials.value!),
            ),
          ),
          const SizedBox(height: MuSpacing.space3),
          socials.when(
            loading: () => const SizedBox(height: 32),
            error: (_, _) => Text("Couldn't load socials", style: mu.text.body.copyWith(color: c.onNight2)),
            data: (s) => _SocialChips(socials: s, isOwn: isOwn),
          ),
        ],
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.title, {this.action, this.onAction});

  final String title;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return Row(
      children: [
        Expanded(
          child: Semantics(
            header: true,
            child: Text(title.toUpperCase(), style: mu.text.eyebrow.copyWith(color: c.onNight2)),
          ),
        ),
        if (action != null)
          Semantics(
            container: true,
            button: true,
            label: '$action ${title.toLowerCase()}',
            excludeSemantics: true,
            child: MuPressable(
              onTap: onAction,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 32, minWidth: MuSizes.touchMin),
                child: Center(
                  child: Text(action!, style: mu.text.label.copyWith(color: c.volt)),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label, this.karma = false, this.onTap});

  final String value;
  final String label;
  final bool karma;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final tile = Container(
      padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space2, vertical: 14),
      decoration: BoxDecoration(color: c.surface, borderRadius: BorderRadius.circular(MuRadii.control)),
      child: Column(
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(value, style: mu.text.numeral.copyWith(fontSize: 26, color: karma ? c.voltText : c.ink)),
          ),
          const SizedBox(height: 4),
          Text(label, style: mu.text.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
    return Semantics(
      container: true,
      button: onTap != null,
      label: '$label $value',
      excludeSemantics: true,
      child: onTap == null ? tile : MuPressable(onTap: onTap, pressedScale: 0.96, child: tile),
    );
  }
}

/// The campus as a stamped seal (artifact: CampusCrest).
class _Campus extends StatelessWidget {
  const _Campus({required this.code, required this.department, required this.joinedYear});

  final String? code;
  final String? department;
  final String? joinedYear;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final hasCode = (code ?? '').isNotEmpty;
    final lines = [?department, if (joinedYear != null) 'Member since $joinedYear'];
    // Artifact CampusCrest: a surface card, the campus seal in `night` with a
    // dashed inner ring, then the campus and what the person studies there.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space4, vertical: 14),
      decoration: BoxDecoration(color: c.surface, borderRadius: BorderRadius.circular(MuRadii.card)),
      child: Row(
        children: [
          SizedBox.square(
            dimension: 56,
            child: CustomPaint(
              painter: _SealPainter(fill: c.night, ring: c.onNight.withValues(alpha: 0.35)),
              child: Center(
                child: hasCode
                    ? Padding(
                        padding: const EdgeInsets.all(8),
                        child: FittedBox(
                          child: Text(
                            code!,
                            style: mu.text.title3.copyWith(color: c.onNight, fontSize: 15, letterSpacing: 0.3),
                          ),
                        ),
                      )
                    : Icon(LucideIcons.school, size: MuSizes.iconMd, color: c.onNight),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(hasCode ? code! : 'No campus yet', style: mu.text.title3.copyWith(color: c.ink)),
                if (lines.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(lines.join(' · '), style: mu.text.caption.copyWith(color: c.ink3)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The campus seal: a 16-radius `night` square with a dashed ring inset 4.
class _SealPainter extends CustomPainter {
  _SealPainter({required this.fill, required this.ring});

  final Color fill;
  final Color ring;

  @override
  void paint(Canvas canvas, Size size) {
    final outer = RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(16));
    canvas.drawRRect(outer, Paint()..color = fill);
    final inner = RRect.fromRectAndRadius(
      const Offset(4, 4) & Size(size.width - 8, size.height - 8),
      const Radius.circular(12),
    );
    final paint = Paint()
      ..color = ring
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    for (final metric in (Path()..addRRect(inner)).computeMetrics()) {
      for (var d = 0.0; d < metric.length; d += 7) {
        canvas.drawPath(metric.extractPath(d, d + 4), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_SealPainter old) => old.fill != fill || old.ring != ring;
}

/// Socials as chips that open the person's page.
class _SocialChips extends ConsumerWidget {
  const _SocialChips({required this.socials, required this.isOwn});

  final Socials socials;
  final bool isOwn;

  static Uri? _url(String base, String? handle) {
    final h = handle?.trim() ?? '';
    if (h.isEmpty) return null;
    if (h.startsWith('http://') || h.startsWith('https://')) return Uri.tryParse(h);
    return Uri.tryParse('$base$h');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final links = <(String, IconData, Uri?)>[
      ('GitHub', LucideIcons.github, _url('https://github.com/', socials.github)),
      ('LinkedIn', LucideIcons.linkedin, _url('https://www.linkedin.com/in/', socials.linkedin)),
      ('Instagram', LucideIcons.instagram, _url('https://www.instagram.com/', socials.instagram)),
      ('Facebook', LucideIcons.facebook, _url('https://www.facebook.com/', socials.facebook)),
      ('Dribbble', LucideIcons.dribbble, _url('https://dribbble.com/', socials.dribble)),
      ('Behance', LucideIcons.palette, _url('https://www.behance.net/', socials.behance)),
      ('Stack Overflow', LucideIcons.layers, _url('https://stackoverflow.com/users/', socials.stackoverflow)),
      ('Medium', LucideIcons.bookOpen, _url('https://medium.com/@', socials.medium)),
      ('HackerRank', LucideIcons.code2, _url('https://www.hackerrank.com/', socials.hackerrank)),
    ].where((l) => l.$3 != null).toList();

    if (links.isEmpty) {
      return Text(
        isOwn ? 'Add your GitHub or LinkedIn so peers can find your work.' : 'No socials added.',
        style: mu.text.body.copyWith(color: c.onNight2),
      );
    }
    return Wrap(
      spacing: MuSpacing.space2,
      runSpacing: MuSpacing.space2,
      children: [
        for (final (label, icon, uri) in links)
          Semantics(
            container: true,
            button: true,
            label: 'Open $label',
            excludeSemantics: true,
            child: MuPressable(
              onTap: () => unawaited(ref.read(openExternalProvider)(uri!)),
              child: Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: c.onNight.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(MuRadii.round),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: MuSizes.iconSm, color: c.onNight),
                    const SizedBox(width: 6),
                    Text(label, style: mu.text.label.copyWith(color: c.onNight)),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
