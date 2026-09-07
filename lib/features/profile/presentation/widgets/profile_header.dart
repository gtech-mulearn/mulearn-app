import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_icon_button.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/core/widgets/profile_avatar.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/domain/level_number.dart';
import 'package:mulearn_app/features/profile/presentation/providers/cover_photo_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_image_controller.dart';

/// Level number → the product's stable level names (DESIGN_SPEC.md §2
/// "06 — Level journey" `LEVELS`) — static display copy, not per-user data,
/// mirroring the same precedent already used in this app's onboarding tour.
const _levelNames = [
  'Initiate', 'Explorer', 'Builder', 'Specialist', //
  'Practitioner', 'Mentor', 'Master',
];

/// Profile identity header. With no cover photo set, this is the plain
/// avatar/name/handle directly on the canvas (DESIGN_SPEC.md §2 "12 —
/// Profile & karma"), confirmed against the rendered mock — no card, no
/// dark background. Cover photo is a real feature the mock doesn't model
/// at all; when one IS set, it's still shown (dropping it silently would
/// be a real regression, not a redesign), just as a rounded card behind
/// the same content with a dark scrim for legibility, rather than the old
/// dominant full-bleed banner.
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
    // A failed upload/delete previously vanished silently (spinner just
    // stopped) — surface it so "nothing visibly changed" always means
    // either a real success or a visible error, never an ambiguous no-op.
    ref.listen(coverPhotoControllerProvider, (_, next) {
      if (next.hasError && !next.isLoading) {
        MuToast.show(
          context,
          message: ApiException.messageFor(next.error!),
          type: MuToastType.error,
        );
      }
    });
    final coverPending = ref.watch(coverPhotoControllerProvider).isLoading;
    final hasCover =
        profile.coverPicUrl != null && profile.coverPicUrl!.isNotEmpty;

    final content = _HeaderContent(
      profile: profile,
      onDark: hasCover,
      coverPending: coverPending,
      onPickAvatar: () => _pickAndUploadProfilePic(context, ref),
      onCoverMenuSelected: (value) {
        switch (value) {
          case 'change':
            _pickAndUploadCover(context, ref);
          case 'remove':
            _deleteCover(context, ref);
        }
      },
      hasCover: hasCover,
      onShare: onShare,
      onEdit: onEdit,
    );

    if (!hasCover) return content;

    return ClipRRect(
      borderRadius: BorderRadius.circular(MuRadius.hero),
      child: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: profile.coverPicUrl!,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) => const ColoredBox(color: MuColors.ink),
            ),
          ),
          // A flat overlay was darkening the whole photo uniformly, making
          // even a successfully-loaded cover image look almost identical to
          // "no cover" (both render as a near-solid dark card). A gradient
          // keeps the photo visible and only darkens toward the bottom,
          // where the name/handle/badges actually need the contrast.
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x1A000000), Color(0x99000000)],
                ),
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(MuSpace.l), child: content),
        ],
      ),
    );
  }
}

class _HeaderContent extends StatelessWidget {
  const _HeaderContent({
    required this.profile,
    required this.onDark,
    required this.coverPending,
    required this.hasCover,
    required this.onPickAvatar,
    required this.onCoverMenuSelected,
    required this.onShare,
    required this.onEdit,
  });

  final UserProfile profile;
  final bool onDark;
  final bool coverPending;
  final bool hasCover;
  final VoidCallback onPickAvatar;
  final ValueChanged<String> onCoverMenuSelected;
  final VoidCallback onShare;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final titleColor = onDark ? Colors.white : MuColors.ink;
    final subColor = onDark ? Colors.white70 : MuColors.inkSecondary;
    final iconColor = onDark ? Colors.white : MuColors.primary;
    final levelN = parseLevelNumber(profile.level);
    final levelName =
        (levelN >= 1 && levelN <= _levelNames.length)
            ? _levelNames[levelN - 1]
            : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onPickAvatar,
              child: Container(
                decoration: onDark
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      )
                    : null,
                child: ProfileAvatar(
                  url: profile.profilePicUrl,
                  name: profile.fullName,
                  size: 72,
                ),
              ),
            ),
            const SizedBox(width: MuSpace.l),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      profile.fullName,
                      style: MuType.headline
                          .copyWith(fontSize: 24, color: titleColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      levelName != null
                          ? '@${profile.muid} · Level $levelN $levelName'
                          : '@${profile.muid} · Level $levelN',
                      style: MuType.body.copyWith(color: subColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: MuSpace.s),
            if (coverPending)
              SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: iconColor,
                ),
              )
            else
              PopupMenuButton<String>(
                icon: Icon(LucideIcons.image, size: 18, color: iconColor),
                tooltip: 'Cover photo',
                onSelected: onCoverMenuSelected,
                itemBuilder: (context) => [
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
              ),
            MuIconButton(icon: LucideIcons.share2, glass: onDark, onPressed: onShare),
            const SizedBox(width: MuSpace.xs),
            MuIconButton(icon: LucideIcons.pencil, glass: onDark, onPressed: onEdit),
          ],
        ),
        const SizedBox(height: MuSpace.s),
        Row(
          children: [
            _Badge(
              label: profile.isPublic ? 'Public' : 'Private',
              color: profile.isPublic ? MuColors.success : MuColors.error,
              onDark: onDark,
            ),
            if (profile.joined.length >= 4) ...[
              const SizedBox(width: 8),
              Text(
                'Member since ${profile.joined.substring(0, 4)}',
                style: MuType.caption.copyWith(
                  color: onDark ? Colors.white70 : MuColors.inkTertiary,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color, required this.onDark});

  final String label;
  final Color color;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: onDark ? Colors.white.withValues(alpha: 0.16) : color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(99),
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
            style: MuType.chip.copyWith(
              color: onDark ? Colors.white : color,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
