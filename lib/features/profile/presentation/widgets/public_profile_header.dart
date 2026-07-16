import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mulearn_gradients.dart';
import 'package:mulearn_app/core/widgets/profile_avatar.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';

/// Read-only cover/avatar/identity header for viewing another user's
/// profile — the same visual language as [ProfileHeader] minus every edit
/// affordance (no cover menu, no profile-pic upload, no edit/share buttons).
class PublicProfileHeader extends StatelessWidget {
  const PublicProfileHeader({required this.profile, super.key});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                errorWidget: (_, __, ___) => const DecoratedBox(
                  decoration: BoxDecoration(gradient: MulearnGradients.trusty),
                ),
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
              left: 16,
              right: 16,
              bottom: 16,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      Container(
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
                        if (memberSince != null)
                          Text(
                            'Member since $memberSince',
                            style: theme.textTheme.labelSmall
                                ?.copyWith(color: Colors.white70),
                          ),
                      ],
                    ),
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
