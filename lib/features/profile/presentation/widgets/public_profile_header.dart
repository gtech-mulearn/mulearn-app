import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
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
                errorWidget: (_, __, ___) => const DecoratedBox(
                  decoration: BoxDecoration(gradient: MuColors.heroGradient),
                ),
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
              left: MuSpace.l,
              right: MuSpace.l,
              bottom: MuSpace.l,
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
                        if (memberSince != null)
                          Text(
                            'Member since $memberSince',
                            style: MuType.caption.copyWith(color: Colors.white70),
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
