import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/widgets/mu_image_cropper.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/presentation/providers/cover_photo_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_image_controller.dart';

/// Level number → the product's stable level names (DESIGN_SPEC.md §2
/// "06 — Level journey" `LEVELS`) — static display copy, not per-user data.
const _levelNames = [
  'Initiate', 'Explorer', 'Builder', 'Specialist', //
  'Practitioner', 'Mentor', 'Master',
];

/// The profile hero (artifact: ProfilePoster → Hero): full-bleed cobalt (or
/// the member's cover photo), the name huge and heavy, level and campus, the
/// level and muid as pills, and the photo in a capsule window at the
/// bottom-right. The night sheet below overlaps it.
///
/// Own profile ([isOwn]): tap the photo to change it, cover/edit/share/
/// settings as glass tools, tap the muid to copy it. Someone else's: a back
/// button and the muid copy only.
class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({required this.profile, this.isOwn = true, this.onEdit, this.onShare, super.key});

  final UserProfile profile;
  final bool isOwn;
  final VoidCallback? onEdit;
  final VoidCallback? onShare;

  /// How far the sheet below overlaps the hero.
  static const double sheetOverlap = 28;

  Future<void> _pickAndUploadCover(BuildContext context, WidgetRef ref) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    final raw = await picked.readAsBytes();
    if (!context.mounted) return;
    // Frame it first: the cover is a 3:1 banner, as on the dashboard.
    final bytes = await showMuImageCropper(context, bytes: raw, aspect: 3, title: 'Adjust cover', maxWidth: 1800);
    if (bytes == null) return;
    if (bytes.lengthInBytes > coverPicMaxBytes) {
      if (context.mounted) {
        MuToast.show(context, message: 'Cover image must be under 5 MB.', type: MuToastType.error);
      }
      return;
    }
    await ref.read(coverPhotoControllerProvider.notifier).upload(bytes, 'cover.jpg');
  }

  Future<void> _deleteCover(BuildContext context, WidgetRef ref) async {
    final confirmed = await showMuConfirm(
      context,
      title: 'Remove cover photo?',
      body: 'Your profile goes back to the plain blue poster.',
      confirmLabel: 'Remove',
      destructive: true,
    );
    if (confirmed) await ref.read(coverPhotoControllerProvider.notifier).delete();
  }

  Future<void> _pickAndUploadProfilePic(BuildContext context, WidgetRef ref) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    final raw = await picked.readAsBytes();
    if (!context.mounted) return;
    // Frame it first: a square, like the dashboard's avatar crop.
    final bytes = await showMuImageCropper(
      context,
      bytes: raw,
      aspect: 1,
      round: true,
      title: 'Adjust photo',
      maxWidth: 800,
    );
    if (bytes == null) return;
    await ref.read(profileImageControllerProvider.notifier).upload(bytes, 'profile.jpg');
  }

  Future<void> _copyMuid(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: profile.muid));
    if (context.mounted) MuToast.show(context, message: 'Copied ${profile.muid}', type: MuToastType.success);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isOwn) {
      // A failed upload/delete must never vanish silently.
      ref.listen(coverPhotoControllerProvider, (_, next) {
        if (next.hasError && !next.isLoading) {
          MuToast.show(context, message: ApiException.messageFor(next.error!), type: MuToastType.error);
        }
      });
    }
    final mu = context.mu;
    final c = mu.colors;
    final coverPending = isOwn && ref.watch(coverPhotoControllerProvider).isLoading;
    final hasCover = profile.coverPicUrl != null && profile.coverPicUrl!.isNotEmpty;

    final levelN = (profile.level != null && profile.level!.length > 3)
        ? int.tryParse(profile.level!.substring(3)) ?? 1
        : 1;
    final levelName = (levelN >= 1 && levelN <= _levelNames.length) ? _levelNames[levelN - 1] : null;
    final name = profile.fullName.trim().isEmpty ? profile.muid : profile.fullName.trim();
    // Never truncate the name: step down 48 → 40 → 32 to fit two lines.
    final nameSize = name.length > 22 ? 32.0 : (name.length > 14 ? 40.0 : 48.0);
    // Artifact ProfilePoster: "Web Development · CET" (top interest, campus);
    // the level has its own pill below. With no interest yet, the level's
    // name stands in.
    final role = [
      if (profile.interestGroups.isNotEmpty) profile.interestGroups.first.name else ?levelName,
      if ((profile.collegeCode ?? '').isNotEmpty) profile.collegeCode!,
    ].join(' · ');
    final top = MediaQuery.paddingOf(context).top;
    // A 3:1 banner below the status bar, plus the status bar it sits under.
    final bannerH = top + MediaQuery.sizeOf(context).width / 3;
    // Tools row: status inset + 4 + 48. With a cover, the name starts where
    // the banner ends (less its fade), so it never sits on the photo.
    final toolsBottom = top + MuSpacing.space1 + MuSizes.touchMin;
    final nameGap = hasCover ? math.max(MuSpacing.space4, bannerH - toolsBottom - 12) : MuSpacing.space4;

    Widget glass(IconData icon, String tooltip, VoidCallback onTap) =>
        MuIconButton(icon: icon, tooltip: tooltip, variant: MuIconButtonVariant.glass, onPressed: onTap);

    final photo = Container(
      width: 132,
      height: 168,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: c.volt,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(66)),
      ),
      child: (profile.profilePicUrl ?? '').isEmpty
          ? _Initials(name: name)
          : CachedNetworkImage(
              imageUrl: profile.profilePicUrl!,
              fit: BoxFit.cover,
              errorWidget: (_, _, _) => _Initials(name: name),
            ),
    );

    return ColoredBox(
      color: c.cobalt,
      child: Stack(
        children: [
          // The cover is cropped 3:1 (dashboard PROFILE_COVER_ASPECT), so it
          // shows as a banner across the top, exactly as framed, and fades
          // into the cobalt poster under the name.
          if (hasCover)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: bannerH,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: profile.coverPicUrl!,
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter,
                    errorWidget: (_, _, _) => const SizedBox.shrink(),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0, 0.25, 0.7, 1],
                        colors: [c.night.withValues(alpha: 0.4), c.night.withValues(alpha: 0), c.cobalt.withValues(alpha: 0), c.cobalt],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          PositionedDirectional(
            end: MuSpacing.space2,
            bottom: sheetOverlap,
            child: isOwn
                ? Semantics(
                    button: true,
                    label: 'Change profile photo',
                    excludeSemantics: true,
                    child: MuPressable(onTap: () => _pickAndUploadProfilePic(context, ref), child: photo),
                  )
                : ExcludeSemantics(child: photo),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(MuSpacing.space3, top + MuSpacing.space1, MuSpacing.space3, sheetOverlap + 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (!isOwn) glass(LucideIcons.arrowLeft, 'Back', () => Navigator.of(context).maybePop()),
                    const Spacer(),
                    if (isOwn) ...[
                      if (coverPending)
                        Padding(
                          padding: const EdgeInsets.all(MuSpacing.space3),
                          child: SizedBox.square(
                            dimension: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, color: c.onCobalt),
                          ),
                        )
                      else
                        PopupMenuButton<String>(
                          tooltip: 'Cover photo',
                          padding: EdgeInsets.zero,
                          onSelected: (value) => switch (value) {
                            'change' => _pickAndUploadCover(context, ref),
                            _ => _deleteCover(context, ref),
                          },
                          itemBuilder: (_) => [
                            const PopupMenuItem(value: 'change', child: Text('Change cover')),
                            if (hasCover) const PopupMenuItem(value: 'remove', child: Text('Remove cover')),
                          ],
                          // Same glass circle as the tools beside it.
                          child: SizedBox.square(
                            dimension: MuSizes.touchMin,
                            child: Center(
                              child: Container(
                                width: MuSizes.iconBtn,
                                height: MuSizes.iconBtn,
                                decoration: BoxDecoration(
                                  color: c.onCobalt.withValues(alpha: 0.18),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(LucideIcons.image, color: c.onCobalt, size: MuSizes.iconMd),
                              ),
                            ),
                          ),
                        ),
                      if (onEdit != null) glass(LucideIcons.pencil, 'Edit profile', onEdit!),
                      if (onShare != null) glass(LucideIcons.share2, 'Share profile', onShare!),
                      glass(LucideIcons.settings, 'Settings', () => context.push(RoutePaths.settings)),
                    ],
                  ],
                ),
                SizedBox(height: nameGap),
                // Clear of the photo window.
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: MuSpacing.space2, end: 132),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Semantics(
                        header: true,
                        child: Text(
                          name.toUpperCase(),
                          maxLines: 2,
                          style: mu.text.poster.copyWith(fontSize: nameSize, color: c.onCobalt),
                        ),
                      ),
                      const SizedBox(height: MuSpacing.space2),
                      if (role.isNotEmpty)
                        Text(
                          role,
                          style: mu.text.body.copyWith(fontSize: 14, color: c.onCobalt.withValues(alpha: 0.9)),
                        ),
                      const SizedBox(height: MuSpacing.space3),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          MuPill('Level $levelN', tone: MuPillTone.volt),
                          Semantics(
                            button: true,
                            label: 'Copy ${profile.muid}',
                            excludeSemantics: true,
                            child: MuPressable(
                              onTap: () => _copyMuid(context),
                              child: MuPill(profile.muid, tone: MuPillTone.paper, mono: true),
                            ),
                          ),
                          // Visibility as a compact glyph so the tags stay on
                          // one line, as on the poster.
                          if (isOwn)
                            Semantics(
                              label: profile.isPublic ? 'Public profile' : 'Private profile',
                              excludeSemantics: true,
                              child: MuPill(
                                '',
                                tone: MuPillTone.paper,
                                icon: profile.isPublic ? LucideIcons.globe : LucideIcons.lock,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Initials extends StatelessWidget {
  const _Initials({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) => Center(
    child: Text(
      MuAvatar.initialsOf(name),
      style: context.mu.text.poster.copyWith(fontSize: 52, color: context.mu.colors.onVolt),
    ),
  );
}
