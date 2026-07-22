import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/core/widgets/mu_icon_button.dart';
import 'package:mulearn_app/features/profile/domain/entities/socials.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/presentation/providers/public_profile_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/socials_controller.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/edit_interest_groups_dialog.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/edit_socials_dialog.dart';

/// Roles, verification badges, social links, and interest groups —
/// mirrors the reference dashboard's Basic Details tab. Pass [publicMuid]
/// to view another user's details read-only instead of the signed-in
/// user's own (hides the edit affordances on interest groups/socials).
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

    return ListView(
      padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.screenH, MuSpace.screenH, MuSpace.navClearance),
      children: [
        _SectionCard(
          title: 'Roles',
          child: Wrap(
            spacing: MuSpace.s,
            runSpacing: MuSpace.s,
            children: [
              for (final role in profile.roles)
                MuTagChip(
                  label: role,
                  style: profile.roleVerification
                          .where((r) => r.role == role)
                          .firstOrNull
                          ?.isVerified ??
                      false
                      ? MuTagStyle.success
                      : MuTagStyle.neutral,
                ),
              if (profile.roles.isEmpty)
                Text('—', style: MuType.body.copyWith(color: MuColors.inkSecondary)),
            ],
          ),
        ),
        _SectionCard(
          title: 'Interest groups',
          onEdit: !isOwnProfile
              ? null
              : () => showDialog<void>(
                    context: context,
                    builder: (_) => EditInterestGroupsDialog(
                      initialSelectedIds: profile.interestGroups
                          .map((g) => g.id)
                          .whereType<String>()
                          .toSet(),
                    ),
                  ),
          child: Wrap(
            spacing: MuSpace.s,
            runSpacing: MuSpace.s,
            children: [
              for (final group in profile.interestGroups) MuTagChip(label: group.name),
              if (profile.interestGroups.isEmpty)
                Text('—', style: MuType.body.copyWith(color: MuColors.inkSecondary)),
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
      return Text('—', style: MuType.body.copyWith(color: MuColors.inkSecondary));
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
  const _SectionCard({required this.title, required this.child, this.onEdit});

  final String title;
  final Widget child;
  final VoidCallback? onEdit;

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
                Expanded(child: Text(title, style: MuType.title.copyWith(fontSize: 16))),
                if (onEdit != null)
                  MuIconButton(icon: LucideIcons.pencil, onPressed: onEdit),
              ],
            ),
            const SizedBox(height: MuSpace.s),
            child,
          ],
        ),
      ),
    );
  }
}
