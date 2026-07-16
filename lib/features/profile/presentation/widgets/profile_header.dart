import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mulearn_app/core/theme/mulearn_gradients.dart';
import 'package:mulearn_app/core/widgets/profile_avatar.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/presentation/providers/cover_photo_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_image_controller.dart';

/// Full-bleed cover photo with the avatar, identity, and edit/share actions
/// overlaid at the bottom — mirrors the reference dashboard's profile header.
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cover image must be under 5 MB.')),
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
    final theme = Theme.of(context);
    final coverPending = ref.watch(coverPhotoControllerProvider).isLoading;
    final level = (profile.level != null && profile.level!.length > 3)
        ? profile.level!.substring(3, 4)
        : '1';
    final memberSince =
        profile.joined.length >= 4 ? profile.joined.substring(0, 4) : null;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
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
                    const DecoratedBox(decoration: BoxDecoration(gradient: MulearnGradients.trusty)),
              )
            else
              const DecoratedBox(
                decoration: BoxDecoration(gradient: MulearnGradients.trusty),
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
                      icon: const Icon(Icons.edit, color: Colors.white),
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
              left: 16,
              right: 16,
              bottom: 16,
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
                            color: MulearnGradients.trusty.colors.last,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            level,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          profile.fullName,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          profile.muid,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.white70),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: [
                            _Badge(
                              label: profile.isPublic ? 'Public' : 'Private',
                              color: profile.isPublic
                                  ? Colors.greenAccent
                                  : Colors.orangeAccent,
                            ),
                            if (memberSince != null)
                              Text(
                                'Member since $memberSince',
                                style: theme.textTheme.labelSmall
                                    ?.copyWith(color: Colors.white70),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton.filledTonal(
                        onPressed: onShare,
                        icon: const Icon(Icons.share, size: 18),
                        visualDensity: VisualDensity.compact,
                      ),
                      const SizedBox(height: 4),
                      IconButton.filled(
                        onPressed: onEdit,
                        icon: const Icon(Icons.edit_outlined, size: 18),
                        visualDensity: VisualDensity.compact,
                      ),
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
        borderRadius: BorderRadius.circular(20),
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
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
