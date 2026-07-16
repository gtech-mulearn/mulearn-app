import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
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
    final theme = Theme.of(context);
    final isOwnProfile = publicMuid == null;
    final socialsState = isOwnProfile
        ? ref.watch(socialsControllerProvider)
        : ref.watch(publicSocialsProvider(publicMuid!));

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _SectionCard(
          title: 'Roles',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final role in profile.roles)
                Chip(
                  label: Text(role),
                  avatar: Icon(
                    profile.roleVerification
                            .where((r) => r.role == role)
                            .firstOrNull
                            ?.isVerified ??
                        false
                        ? Icons.verified
                        : Icons.hourglass_top,
                    size: 16,
                  ),
                ),
              if (profile.roles.isEmpty)
                const Text('—', style: TextStyle(color: MulearnColors.gray600)),
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
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final group in profile.interestGroups)
                Chip(label: Text(group.name)),
              if (profile.interestGroups.isEmpty)
                const Text('—', style: TextStyle(color: MulearnColors.gray600)),
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
              Text(profile.collegeCode ?? '—', style: theme.textTheme.bodyMedium),
              if (profile.departmentName != null)
                Text(
                  profile.departmentName!,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: MulearnColors.gray600),
                ),
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

  static const _icons = {
    'GitHub': Icons.code,
    'LinkedIn': Icons.business_center,
    'Instagram': Icons.camera_alt,
    'Facebook': Icons.facebook,
    'Dribble': Icons.sports_basketball,
    'Behance': Icons.brush,
    'Stack Overflow': Icons.forum,
    'Medium': Icons.article,
    'HackerRank': Icons.terminal,
  };

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
      return const Text('—', style: TextStyle(color: MulearnColors.gray600));
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final entry in entries.entries)
          Chip(
            avatar: Icon(_icons[entry.key] ?? Icons.link, size: 16),
            label: Text(entry.key),
          ),
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
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(title, style: theme.textTheme.titleSmall),
                ),
                if (onEdit != null)
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    onPressed: onEdit,
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}
