import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';

/// QR code + public/private toggle for sharing the profile (QR image
/// sourced from quickchart.io, same as the reference dashboard) — styled to
/// this app's design system (rounded sheet, `MuColors`/`MuType`, pill
/// toggle/buttons) rather than a default `AlertDialog`.
class ShareProfileDialog extends ConsumerWidget {
  const ShareProfileDialog({required this.profile, super.key});

  final UserProfile profile;

  // The real production dashboard domain is app.mulearn.org, not
  // mulearn-dashboard.vercel.app — that vercel.app subdomain happens to
  // also serve the same deployment (a Vercel preview/staging alias), which
  // is why it returned 200 too and the mistake wasn't caught by an HTTP
  // check alone. Confirmed live: `/profile/{muid}` (not `/u/{muid}`) on
  // app.mulearn.org.
  static const _profileUrlBase = 'https://app.mulearn.org/profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileUrl = '$_profileUrlBase/${profile.muid}';
    final qrUrl = 'https://quickchart.io/qr'
        '?text=${Uri.encodeComponent(profileUrl)}'
        '&centerImageUrl=${Uri.encodeComponent('https://avatars.githubusercontent.com/u/98015594?s=88&v=4')}';

    return Dialog(
      backgroundColor: MuColors.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: MuSpace.xxl),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MuRadius.hero),
      ),
      child: Padding(
        padding: const EdgeInsets.all(MuSpace.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Share profile', style: MuType.headline),
            const SizedBox(height: MuSpace.l),
            Container(
              padding: const EdgeInsets.all(MuSpace.l),
              decoration: BoxDecoration(
                color: MuColors.canvas,
                borderRadius: BorderRadius.circular(MuRadius.card),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Public profile', style: MuType.bodyMed),
                        const SizedBox(height: 2),
                        Text(
                          profile.isPublic
                              ? 'Anyone with the link can view your profile.'
                              : 'Only you can view your profile.',
                          style: MuType.caption,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: MuSpace.m),
                  Switch(
                    value: profile.isPublic,
                    activeTrackColor: MuColors.primary,
                    onChanged: (value) => ref
                        .read(profileControllerProvider.notifier)
                        .togglePublic(isPublic: value),
                  ),
                ],
              ),
            ),
            if (profile.isPublic) ...[
              const SizedBox(height: MuSpace.xl),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(MuSpace.m),
                  decoration: BoxDecoration(
                    border: Border.all(color: MuColors.divider, width: 1.5),
                    borderRadius: BorderRadius.circular(MuRadius.qr),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: qrUrl,
                    height: 180,
                    width: 180,
                  ),
                ),
              ),
              const SizedBox(height: MuSpace.l),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: MuSpace.m,
                  vertical: MuSpace.s,
                ),
                decoration: BoxDecoration(
                  color: MuColors.canvas,
                  borderRadius: BorderRadius.circular(MuRadius.inner),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        profileUrl,
                        style: MuType.caption,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: MuSpace.s),
                    GestureDetector(
                      onTap: () async {
                        await Clipboard.setData(
                          ClipboardData(text: profileUrl),
                        );
                        if (context.mounted) {
                          MuToast.show(
                            context,
                            message: 'Link copied',
                            type: MuToastType.success,
                          );
                        }
                      },
                      child: const Icon(
                        LucideIcons.copy,
                        size: 16,
                        color: MuColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: MuSpace.xl),
            MuGhostButton(
              label: 'Close',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
