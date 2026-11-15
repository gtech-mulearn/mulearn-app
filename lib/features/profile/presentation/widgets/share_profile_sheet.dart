import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';

/// Share your profile: the public switch, then (when public) a QR to scan
/// and the link with Copy as the main action. The QR comes from
/// quickchart.io, same as the reference dashboard.
class ShareProfileSheet extends ConsumerWidget {
  const ShareProfileSheet({required this.profile, super.key});

  final UserProfile profile;

  /// Opens the sheet over [context].
  static Future<void> show(BuildContext context, UserProfile profile) =>
      showMuSheet<void>(context, builder: (_) => ShareProfileSheet(profile: profile));

  // The production dashboard is app.mulearn.org (mulearn-dashboard.vercel.app
  // is a preview alias). Confirmed live: `/profile/{muid}`, not `/u/{muid}`.
  static const _profileUrlBase = 'https://app.mulearn.org/profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    // Watch the live value so the switch and QR follow a toggle.
    final isPublic = ref.watch(profileControllerProvider).value?.isPublic ?? profile.isPublic;
    final profileUrl = '$_profileUrlBase/${profile.muid}';
    final qrUrl =
        'https://quickchart.io/qr'
        '?text=${Uri.encodeComponent(profileUrl)}'
        '&margin=1'
        '&centerImageUrl=${Uri.encodeComponent('https://avatars.githubusercontent.com/u/98015594?s=88&v=4')}';

    Future<void> toggle({required bool value}) async {
      try {
        await ref.read(profileControllerProvider.notifier).togglePublic(isPublic: value);
      } on Object catch (e) {
        if (context.mounted) {
          MuToast.show(context, message: ApiException.messageFor(e), type: MuToastType.error);
        }
      }
    }

    Future<void> copy() async {
      await Clipboard.setData(ClipboardData(text: profileUrl));
      if (context.mounted) {
        MuToast.show(context, message: 'Link copied', type: MuToastType.success);
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(MuSpacing.space5, 0, MuSpacing.space5, MuSpacing.space5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(header: true, child: Text('Share profile', style: mu.text.title2)),
          const SizedBox(height: MuSpacing.space3),
          MuSwitchTile(
            label: 'Public profile',
            subtitle: isPublic ? 'Anyone with the link can see it.' : 'Only you can see it. Turn on to share.',
            value: isPublic,
            onChanged: (value) => toggle(value: value),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: !isPublic
                ? const SizedBox(width: double.infinity)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: MuSpacing.space4),
                      Center(
                        child: Semantics(
                          image: true,
                          label: 'QR code for your profile link',
                          child: Container(
                            padding: const EdgeInsets.all(MuSpacing.space3),
                            decoration: BoxDecoration(
                              // QR codes scan best dark-on-white, in either theme.
                              color: c.onCobalt,
                              borderRadius: BorderRadius.circular(MuRadii.card),
                              border: Border.all(color: c.line),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: qrUrl,
                              width: 196,
                              height: 196,
                              placeholder: (_, _) => const SizedBox.square(dimension: 196),
                              errorWidget: (_, _, _) => SizedBox.square(
                                dimension: 196,
                                child: Center(
                                  child: Text(
                                    "Couldn't load the QR",
                                    style: mu.text.caption.copyWith(color: c.inkPrint),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: MuSpacing.space4),
                      Container(
                        padding: const EdgeInsetsDirectional.only(start: 16, end: 4),
                        constraints: const BoxConstraints(minHeight: MuSizes.fieldH),
                        decoration: BoxDecoration(
                          color: c.surfaceSunk,
                          borderRadius: BorderRadius.circular(MuRadii.control),
                        ),
                        child: Row(
                          children: [
                            Icon(LucideIcons.link, size: MuSizes.iconSm, color: c.ink3),
                            const SizedBox(width: MuSpacing.space2),
                            Expanded(
                              child: Text(
                                profileUrl.replaceFirst('https://', ''),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: mu.text.codeSm.copyWith(color: c.ink2),
                              ),
                            ),
                            MuIconButton(icon: LucideIcons.copy, tooltip: 'Copy link', onPressed: copy),
                          ],
                        ),
                      ),
                      const SizedBox(height: MuSpacing.space4),
                      MuButton(label: 'Copy link', icon: LucideIcons.copy, block: true, onPressed: copy),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
