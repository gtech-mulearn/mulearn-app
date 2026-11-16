import 'dart:math' as math;
import 'dart:ui' as ui;

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

/// The profile hero (artifact: ProfilePoster → Hero): full-bleed cobalt (or
/// the member's cover photo), the name huge and heavy, level and campus, the
/// level and muid as pills, and the photo in a ringed circle at the
/// bottom-right. The night sheet below overlaps it.
///
/// Own profile ([isOwn]): tap the photo to change it, cover/edit/share/
/// settings as glass tools, tap the muid to copy it. Someone else's: a back
/// button and the muid copy only.
class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({
    required this.profile,
    this.isOwn = true,
    this.onEdit,
    this.onShare,
    super.key,
  });

  final UserProfile profile;
  final bool isOwn;
  final VoidCallback? onEdit;
  final VoidCallback? onShare;

  /// How far the sheet below overlaps the hero.
  static const double sheetOverlap = 28;

  static const double _photoSize = 116;

  Future<void> _pickAndUploadCover(BuildContext context, WidgetRef ref) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    final raw = await picked.readAsBytes();
    if (!context.mounted) return;
    // Frame it first: the cover is a 3:1 banner, as on the dashboard.
    final bytes = await showMuImageCropper(
      context,
      bytes: raw,
      aspect: 3,
      title: 'Adjust cover',
      maxWidth: 1800,
    );
    if (bytes == null) return;
    await ref
        .read(coverPhotoControllerProvider.notifier)
        .upload(bytes, 'cover.jpg');
    if (context.mounted) {
      _report(
        context,
        ref.read(coverPhotoControllerProvider),
        'Cover photo updated',
      );
    }
  }

  /// Every photo action ends in a toast: what went wrong (too large, not an
  /// image, the server refused), or that it worked.
  static void _report(
    BuildContext context,
    AsyncValue<void> result,
    String done,
  ) {
    MuToast.show(
      context,
      message: result.hasError ? ApiException.messageFor(result.error!) : done,
      type: result.hasError ? MuToastType.error : MuToastType.success,
    );
  }

  Future<void> _deleteCover(BuildContext context, WidgetRef ref) async {
    final confirmed = await showMuConfirm(
      context,
      title: 'Remove cover photo?',
      body: 'Your profile goes back to the plain blue poster.',
      confirmLabel: 'Remove',
      destructive: true,
    );
    if (confirmed) {
      await ref.read(coverPhotoControllerProvider.notifier).delete();
      if (context.mounted) {
        _report(
          context,
          ref.read(coverPhotoControllerProvider),
          'Cover photo removed',
        );
      }
    }
  }

  Future<void> _pickAndUploadProfilePic(
    BuildContext context,
    WidgetRef ref,
  ) async {
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
    await ref
        .read(profileImageControllerProvider.notifier)
        .upload(bytes, 'profile.jpg');
    if (context.mounted) {
      _report(
        context,
        ref.read(profileImageControllerProvider),
        'Profile photo updated',
      );
    }
  }

  Future<void> _copyMuid(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: profile.muid));
    if (context.mounted) {
      MuToast.show(
        context,
        message: 'Copied ${profile.muid}',
        type: MuToastType.success,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final coverPending =
        isOwn && ref.watch(coverPhotoControllerProvider).isLoading;
    final hasCover =
        profile.coverPicUrl != null && profile.coverPicUrl!.isNotEmpty;

    final levelN = (profile.level != null && profile.level!.length > 3)
        ? int.tryParse(profile.level!.substring(3)) ?? 1
        : 1;
    final name = profile.fullName.trim().isEmpty
        ? profile.muid
        : profile.fullName.trim();
    // Artifact ProfilePoster: "Web Development · CET" (top interest, campus);
    // the level has its own pill below.
    final role = [
      if (profile.interestGroups.isNotEmpty) profile.interestGroups.first.name,
      if ((profile.collegeCode ?? '').isNotEmpty) profile.collegeCode!,
    ].join(' · ');
    final top = MediaQuery.paddingOf(context).top;
    // A 3:1 banner below the status bar, plus the status bar it sits under.
    final bannerH = top + MediaQuery.sizeOf(context).width / 3;
    // Tools row: status inset + 4 + 48. With a cover, the name starts where
    // the banner ends (less its fade), so it never sits on the photo.
    final toolsBottom = top + MuSpacing.space1 + MuSizes.touchMin;
    final nameGap = hasCover
        ? math.max(MuSpacing.space4, bannerH - toolsBottom - 12)
        : MuSpacing.space4;

    Widget glass(IconData icon, String tooltip, VoidCallback onTap) =>
        MuIconButton(
          icon: icon,
          tooltip: tooltip,
          variant: MuIconButtonVariant.glass,
          onPressed: onTap,
        );

    final photoPending =
        isOwn && ref.watch(profileImageControllerProvider).isLoading;
    final circle = Container(
      width: _photoSize,
      height: _photoSize,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: c.volt,
        shape: BoxShape.circle,
        border: Border.all(color: c.onCobalt.withValues(alpha: 0.85), width: 3),
      ),
      child: (profile.profilePicUrl ?? '').isEmpty
          ? _Initials(name: name)
          : CachedNetworkImage(
              imageUrl: profile.profilePicUrl!,
              fit: BoxFit.cover,
              errorWidget: (_, _, _) => _Initials(name: name),
            ),
    );
    final photo = SizedBox(
      width: _photoSize,
      height: _photoSize,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          circle,
          if (photoPending)
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: c.night.withValues(alpha: 0.45),
                  shape: BoxShape.circle,
                ),
                child: const Center(child: MuDotsLoader()),
              ),
            ),
          if (isOwn)
            PositionedDirectional(
              end: 2,
              bottom: 2,
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: c.night,
                  shape: BoxShape.circle,
                  border: Border.all(color: c.onCobalt, width: 2),
                ),
                child: Icon(
                  LucideIcons.pencil,
                  size: MuSizes.iconSm,
                  color: c.onNight,
                ),
              ),
            ),
        ],
      ),
    );

    return ColoredBox(
      color: hasCover ? c.night : c.cobalt,
      child: Stack(
        children: [
          // With a cover, the whole hero is the photo: a blurred, darkened
          // full-bleed copy as the ground, and the 3:1 crop (dashboard
          // PROFILE_COVER_ASPECT) sharp across the top, fading into it. The
          // name sits on the blurred part, where it stays readable.
          if (hasCover) ...[
            Positioned.fill(
              child: ClipRect(
                child: ImageFiltered(
                  imageFilter: ui.ImageFilter.blur(
                    sigmaX: 36,
                    sigmaY: 36,
                    tileMode: TileMode.clamp,
                  ),
                  child: Transform.scale(
                    scale: 1.25,
                    child: CachedNetworkImage(
                      imageUrl: profile.coverPicUrl!,
                      fit: BoxFit.cover,
                      errorWidget: (_, _, _) => const SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: ColoredBox(color: c.night.withValues(alpha: 0.55)),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: bannerH,
              child: ShaderMask(
                // Fade the banner's lower third into the blurred ground.
                shaderCallback: (rect) => LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0, 0.65, 1],
                  colors: [c.night, c.night, c.night.withValues(alpha: 0)],
                ).createShader(rect),
                blendMode: BlendMode.dstIn,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: profile.coverPicUrl!,
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                      errorWidget: (_, _, _) => const SizedBox.shrink(),
                    ),
                    // Keeps the status bar and tools legible on bright photos.
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0, 0.45],
                          colors: [
                            c.night.withValues(alpha: 0.45),
                            c.night.withValues(alpha: 0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          PositionedDirectional(
            end: MuSpacing.space4,
            bottom: sheetOverlap + MuSpacing.space4,
            child: isOwn
                ? Semantics(
                    button: true,
                    label: 'Change profile photo',
                    excludeSemantics: true,
                    child: MuPressable(
                      onTap: photoPending
                          ? null
                          : () => _pickAndUploadProfilePic(context, ref),
                      child: photo,
                    ),
                  )
                : ExcludeSemantics(child: photo),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              MuSpacing.space3,
              top + MuSpacing.space1,
              MuSpacing.space3,
              sheetOverlap + 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (!isOwn)
                      glass(
                        LucideIcons.arrowLeft,
                        'Back',
                        () => Navigator.of(context).maybePop(),
                      ),
                    const Spacer(),
                    if (isOwn) ...[
                      if (coverPending)
                        Padding(
                          padding: const EdgeInsets.all(MuSpacing.space3),
                          child: SizedBox.square(
                            dimension: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: c.onCobalt,
                            ),
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
                            const PopupMenuItem(
                              value: 'change',
                              child: Text('Change cover'),
                            ),
                            if (hasCover)
                              const PopupMenuItem(
                                value: 'remove',
                                child: Text('Remove cover'),
                              ),
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
                                child: Icon(
                                  LucideIcons.image,
                                  color: c.onCobalt,
                                  size: MuSizes.iconMd,
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (onEdit != null)
                        glass(LucideIcons.pencil, 'Edit profile', onEdit!),
                      if (onShare != null)
                        glass(LucideIcons.share2, 'Share profile', onShare!),
                      glass(
                        LucideIcons.settings,
                        'Settings',
                        () => context.push(RoutePaths.settings),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: nameGap),
                // Clear of the photo window.
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: MuSpacing.space2,
                    end: _photoSize + MuSpacing.space4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Semantics(
                        header: true,
                        child: PosterName(
                          name,
                          style: mu.text.poster.copyWith(color: c.onCobalt),
                        ),
                      ),
                      const SizedBox(height: MuSpacing.space2),
                      if (role.isNotEmpty)
                        Text(
                          role,
                          style: mu.text.body.copyWith(
                            fontSize: 14,
                            color: c.onCobalt.withValues(alpha: 0.9),
                          ),
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
                              child: MuPill(
                                profile.muid,
                                tone: MuPillTone.paper,
                                mono: true,
                              ),
                            ),
                          ),
                          // Visibility as a compact glyph so the tags stay on
                          // one line, as on the poster.
                          if (isOwn)
                            Semantics(
                              label: profile.isPublic
                                  ? 'Public profile'
                                  : 'Private profile',
                              excludeSemantics: true,
                              child: MuPill(
                                '',
                                tone: MuPillTone.paper,
                                icon: profile.isPublic
                                    ? LucideIcons.globe
                                    : LucideIcons.lock,
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

/// The member's name, upper-cased and as big as it can be: the largest of
/// 48 / 40 / 34 / 28 / 24 at which every word fits on a line and the whole
/// name fits in two. A name too long even at 24 gets a third line, then an
/// ellipsis. Never breaks a word.
class PosterName extends StatelessWidget {
  const PosterName(this.name, {required this.style, super.key});

  final String name;
  final TextStyle style;

  static const _sizes = [48.0, 40.0, 34.0, 28.0, 24.0];

  static bool _fits(String text, TextStyle style, double width, int lines) {
    const scaler = TextScaler.noScaling;
    for (final word in text.split(RegExp(r'\s+'))) {
      final w = TextPainter(
        text: TextSpan(text: word, style: style),
        textDirection: TextDirection.ltr,
        maxLines: 1,
        textScaler: scaler,
      )..layout();
      final tooWide = w.width > width;
      w.dispose();
      if (tooWide) return false;
    }
    final all = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      maxLines: lines,
      textScaler: scaler,
    )..layout(maxWidth: width);
    final fits = !all.didExceedMaxLines;
    all.dispose();
    return fits;
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) {
      final text = name.toUpperCase();
      final scale = MediaQuery.textScalerOf(context).scale(1);
      for (final size in _sizes) {
        final sized = style.copyWith(fontSize: size * scale);
        if (_fits(text, sized, box.maxWidth, 2)) {
          return Text(text, maxLines: 2, style: style.copyWith(fontSize: size));
        }
      }
      return Text(
        text,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: style.copyWith(fontSize: _sizes.last),
      );
    },
  );
}

class _Initials extends StatelessWidget {
  const _Initials({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) => Center(
    child: Text(
      MuAvatar.initialsOf(name),
      style: context.mu.text.poster.copyWith(
        fontSize: 44,
        color: context.mu.colors.onVolt,
      ),
    ),
  );
}
