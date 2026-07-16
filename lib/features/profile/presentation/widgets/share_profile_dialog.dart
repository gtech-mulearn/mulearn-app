import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';

/// QR code + public/private toggle for sharing the profile — mirrors the
/// reference dashboard's share-profile modal (QR image sourced from
/// quickchart.io, same as the reference).
class ShareProfileDialog extends ConsumerWidget {
  const ShareProfileDialog({required this.profile, super.key});

  final UserProfile profile;

  static const _profileUrlBase = 'https://mulearn-dashboard.vercel.app/u';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileUrl = '$_profileUrlBase/${profile.muid}';
    final qrUrl = 'https://quickchart.io/qr'
        '?text=${Uri.encodeComponent(profileUrl)}'
        '&centerImageUrl=${Uri.encodeComponent('https://avatars.githubusercontent.com/u/98015594?s=88&v=4')}';

    return AlertDialog(
      title: const Text('Share profile'),
      content: SizedBox(
        width: 320,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Public profile'),
              subtitle: Text(
                profile.isPublic
                    ? 'Anyone with the link can view your profile.'
                    : 'Only you can view your profile.',
              ),
              value: profile.isPublic,
              onChanged: (value) => ref
                  .read(profileControllerProvider.notifier)
                  .togglePublic(isPublic: value),
            ),
            const SizedBox(height: 12),
            if (profile.isPublic) ...[
              CachedNetworkImage(imageUrl: qrUrl, height: 200, width: 200),
              const SizedBox(height: 12),
              SelectableText(profileUrl, textAlign: TextAlign.center),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
