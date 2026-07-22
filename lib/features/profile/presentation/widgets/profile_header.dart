import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_icon_button.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/core/widgets/profile_avatar.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/presentation/providers/cover_photo_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_image_controller.dart';

/// Full-bleed cover photo with the avatar, identity, and edit/share actions
/// overlaid at the bottom — mirrors the reference dashboard's profile header
/// (rules.md §8).
class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({
    required this.profile,
    required this.onEdit,
    required this.onShare,
    super.key,
  });

  final UserProfile profile;
  final VoidCallback onEdit;
  final VoidCallback onShare;

  Future<void> _pickAndUploadCover(BuildContext context, WidgetRef ref) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    final bytes = await picked.readAsBytes();
    if (bytes.lengthInBytes > coverPicMaxBytes) {
      if (context.mounted) {
        MuToast.show(
          context,
          message: 'Cover image must be under 5 MB.',
          type: MuToastType.error,
        );
      }
      return;
    }
    await ref
        .read(coverPhotoControllerProvider.notifier)
        .upload(bytes, picked.name);
  }

  Future<void> _deleteCover(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove cover photo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      await ref.read(coverPhotoControllerProvider.notifier).delete();
    }
  }

  Future<void> _pickAndUploadProfilePic(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    final bytes = await picked.readAsBytes();
    await ref
        .read(profileImageControllerProvider.notifier)
        .upload(bytes, picked.name);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coverPending = ref.watch(coverPhotoControllerProvider).isLoading;
    final level = (profile.level != null && profile.level!.length > 3)
        ? profile.level!.substring(3, 4)
        : '1';
    final memberSince =
        profile.joined.length >= 4 ? profile.joined.substring(0, 4) : null;

    return ClipRRect(
      borderRadius: BorderRadius.circular(MuRadius.card),
      child: SizedBox(
        height: 220,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (profile.coverPicUrl != null && profile.coverPicUrl!.isNotEmpty)
              CachedNetworkImage(
                imageUrl: profile.coverPicUrl!,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) =>
                    const DecoratedBox(decoration: BoxDecoration(gradient: MuColors.heroGradient)),
              )
            else
              const DecoratedBox(
                decoration: BoxDecoration(gradient: MuColors.heroGradient),
              ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0),
                    Colors.black.withValues(alpha: 0.65),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 12,
              top: 12,
              child: coverPending
                  ? const SizedBox(
                      height: 32,
                      width: 32,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : PopupMenuButton<String>(
                      icon: const Icon(LucideIcons.pencil, color: Colors.white, size: 18),
                      onSelected: (value) {
                        switch (value) {
                          case 'change':
                            _pickAndUploadCover(context, ref);
                          case 'remove':
                            _deleteCover(context, ref);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'change',
                          child: Text('Change cover'),
                        ),
                        if (profile.coverPicUrl != null &&
                            profile.coverPicUrl!.isNotEmpty)
                          const PopupMenuItem(
                            value: 'remove',
                            child: Text('Remove cover'),
                          ),
                      ],
                    ),
            ),
            Positioned(
              left: MuSpace.l,
              right: MuSpace.l,
              bottom: MuSpace.l,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () => _pickAndUploadProfilePic(context, ref),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: ProfileAvatar(
                            url: profile.profilePicUrl,
                            name: profile.fullName,
                            size: 72,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                            color: MuColors.lime,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            level,
                            style: MuType.statSmall.copyWith(color: MuColors.limeInk, fontSize: 11),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: MuSpace.m),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          profile.fullName,
                          style: MuType.title.copyWith(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          profile.muid,
                          style: MuType.caption.copyWith(color: Colors.white70),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: [
                            _Badge(
                              label: profile.isPublic ? 'Public' : 'Private',
                              color: profile.isPublic ? MuColors.limeBright : MuColors.coral,
                            ),
                            if (memberSince != null)
                              Text(
                                'Member since $memberSince',
                                style: MuType.caption.copyWith(color: Colors.white70),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MuIconButton(icon: LucideIcons.share2, glass: true, onPressed: onShare),
                      const SizedBox(height: 4),
                      MuIconButton(icon: LucideIcons.pencil, glass: true, onPressed: onEdit),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(MuRadius.chip),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 6,
            width: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          Text(label, style: MuType.chip.copyWith(color: Colors.white, fontSize: 10)),
        ],
      ),
    );
  }
}
