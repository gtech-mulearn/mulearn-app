import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/presentation/providers/cover_photo_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_image_controller.dart';

/// Level number → the product's stable level names (DESIGN_SPEC.md §2
/// "06 — Level journey" `LEVELS`) — static display copy, not per-user data,
/// mirroring the same precedent already used in this app's onboarding tour.
const _levelNames = [
  'Initiate', 'Explorer', 'Builder', 'Specialist', //
  'Practitioner', 'Mentor', 'Master',
];

/// The own-profile header as a poster (artifact: ProfilePoster): the name
/// huge and heavy on cobalt, or on the member's cover photo when they've set
/// one; their photo in a capsule window (tap to change it); level, muid,
/// visibility and join year as pills; cover, share and edit as glass tools.
class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({required this.profile, required this.onEdit, required this.onShare, super.key});

  final UserProfile profile;
  final VoidCallback onEdit;
  final VoidCallback onShare;

  Future<void> _pickAndUploadCover(BuildContext context, WidgetRef ref) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    final bytes = await picked.readAsBytes();
    if (bytes.lengthInBytes > coverPicMaxBytes) {
      if (context.mounted) {
        MuToast.show(context, message: 'Cover image must be under 5 MB.', type: MuToastType.error);
      }
      return;
    }
    await ref.read(coverPhotoControllerProvider.notifier).upload(bytes, picked.name);
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
    final bytes = await picked.readAsBytes();
    await ref.read(profileImageControllerProvider.notifier).upload(bytes, picked.name);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // A failed upload/delete previously vanished silently (spinner just
    // stopped) — surface it so "nothing visibly changed" always means
    // either a real success or a visible error, never an ambiguous no-op.
    ref.listen(coverPhotoControllerProvider, (_, next) {
      if (next.hasError && !next.isLoading) {
        MuToast.show(context, message: ApiException.messageFor(next.error!), type: MuToastType.error);
      }
    });
    final mu = context.mu;
    final c = mu.colors;
    final coverPending = ref.watch(coverPhotoControllerProvider).isLoading;
    final hasCover = profile.coverPicUrl != null && profile.coverPicUrl!.isNotEmpty;

    final levelN = (profile.level != null && profile.level!.length > 3)
        ? int.tryParse(profile.level!.substring(3)) ?? 1
        : 1;
    final levelName = (levelN >= 1 && levelN <= _levelNames.length) ? _levelNames[levelN - 1] : null;
    final name = profile.fullName.trim().isEmpty ? profile.muid : profile.fullName.trim();
    final nameSize = name.length > 26 ? 30.0 : (name.length > 16 ? 36.0 : 44.0);

    final poster = Stack(
      children: [
        if (hasCover) ...[
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: profile.coverPicUrl!,
              fit: BoxFit.cover,
              errorWidget: (_, _, _) => ColoredBox(color: c.cobalt),
            ),
          ),
          // Darken toward the bottom only, where the name needs contrast.
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [c.night.withValues(alpha: 0.1), c.night.withValues(alpha: 0.7)],
                ),
              ),
            ),
          ),
        ],
        // The photo window: a capsule cut flat at the bottom.
        PositionedDirectional(
          end: -6,
          bottom: 0,
          child: Semantics(
            button: true,
            label: 'Change profile photo',
            excludeSemantics: true,
            child: MuPressable(
              onTap: () => _pickAndUploadProfilePic(context, ref),
              child: Container(
                width: 124,
                height: 156,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: c.volt,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(62)),
                ),
                child: (profile.profilePicUrl ?? '').isEmpty
                    ? Center(
                        child: Text(
                          MuAvatar.initialsOf(name),
                          style: mu.text.poster.copyWith(fontSize: 52, color: c.onVolt),
                        ),
                      )
                    : CachedNetworkImage(
                        imageUrl: profile.profilePicUrl!,
                        fit: BoxFit.cover,
                        errorWidget: (_, _, _) => Center(
                          child: Text(
                            MuAvatar.initialsOf(name),
                            style: mu.text.poster.copyWith(fontSize: 52, color: c.onVolt),
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(MuSpacing.space5, MuSpacing.space3, MuSpacing.space3, MuSpacing.space6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                      // Same glass circle as Share and Edit beside it.
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
                      onSelected: (value) {
                        switch (value) {
                          case 'change':
                            _pickAndUploadCover(context, ref);
                          case 'remove':
                            _deleteCover(context, ref);
                        }
                      },
                      itemBuilder: (_) => [
                        const PopupMenuItem(value: 'change', child: Text('Change cover')),
                        if (hasCover) const PopupMenuItem(value: 'remove', child: Text('Remove cover')),
                      ],
                    ),
                  MuIconButton(
                    tooltip: 'Share profile',
                    icon: LucideIcons.share2,
                    variant: MuIconButtonVariant.glass,
                    onPressed: onShare,
                  ),
                  MuIconButton(
                    tooltip: 'Edit profile',
                    icon: LucideIcons.pencil,
                    variant: MuIconButtonVariant.glass,
                    onPressed: onEdit,
                  ),
                ],
              ),
              const SizedBox(height: MuSpacing.space2),
              // Keep the name and pills clear of the photo window.
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 112),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Semantics(
                      header: true,
                      child: Text(
                        name.toUpperCase(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: mu.text.poster.copyWith(fontSize: nameSize, color: c.onCobalt),
                      ),
                    ),
                    const SizedBox(height: MuSpacing.space2),
                    Text(
                      levelName == null ? 'Level $levelN' : 'Level $levelN · $levelName',
                      style: mu.text.body.copyWith(color: c.onCobalt.withValues(alpha: 0.9)),
                    ),
                    const SizedBox(height: MuSpacing.space3),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        MuPill('Level $levelN', tone: MuPillTone.volt),
                        MuPill(profile.muid, tone: MuPillTone.paper, mono: true),
                        MuPill(
                          profile.isPublic ? 'Public' : 'Private',
                          tone: MuPillTone.paper,
                          icon: profile.isPublic ? LucideIcons.globe : LucideIcons.lock,
                        ),
                        if (profile.joined.length >= 4)
                          MuPill('Since ${profile.joined.substring(0, 4)}', tone: MuPillTone.paper),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return Container(
      clipBehavior: Clip.antiAlias,
      constraints: const BoxConstraints(minHeight: 236),
      decoration: BoxDecoration(color: c.cobalt, borderRadius: BorderRadius.circular(MuRadii.panel)),
      child: poster,
    );
  }
}
