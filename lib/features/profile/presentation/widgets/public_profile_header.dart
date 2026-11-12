import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/profile_avatar.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';

/// Level number → the product's stable level names (DESIGN_SPEC.md §2
/// "06 — Level journey" `LEVELS`) — static display copy, not per-user data.
const _levelNames = [
  'Initiate', 'Explorer', 'Builder', 'Specialist', //
  'Practitioner', 'Mentor', 'Master',
];

/// Read-only version of [ProfileHeader] — same layout minus every edit
/// affordance (no cover menu, no profile-pic upload, no edit/share
/// buttons), including the same "cover photo shown as a card backdrop when
/// set, plain canvas otherwise" behavior.
class PublicProfileHeader extends StatelessWidget {
  const PublicProfileHeader({required this.profile, super.key});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final hasCover =
        profile.coverPicUrl != null && profile.coverPicUrl!.isNotEmpty;
    final content = _Content(profile: profile, onDark: hasCover);

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
          // Gradient, not a flat overlay — a uniform dark wash made even a
          // successfully-loaded cover photo look almost identical to "no
          // cover." Only darken toward the bottom, where the name/handle
          // need the contrast.
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

class _Content extends StatelessWidget {
  const _Content({required this.profile, required this.onDark});

  final UserProfile profile;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final titleColor = onDark ? Colors.white : MuColors.ink;
    final subColor = onDark ? Colors.white70 : MuColors.inkSecondary;
    final levelN = (profile.level != null && profile.level!.length > 3)
        ? int.tryParse(profile.level!.substring(3)) ?? 1
        : 1;
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
            Container(
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
          ],
        ),
        if (profile.joined.length >= 4) ...[
          const SizedBox(height: MuSpace.s),
          Text(
            'Member since ${profile.joined.substring(0, 4)}',
            style: MuType.caption.copyWith(
              color: onDark ? Colors.white70 : MuColors.inkTertiary,
            ),
          ),
        ],
      ],
    );
  }
}
