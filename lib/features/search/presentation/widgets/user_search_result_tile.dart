import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/profile_avatar.dart';
import 'package:mulearn_app/features/search/domain/entities/user_search_result.dart';

/// A single search result row — avatar, name, muid, karma, organization.
class UserSearchResultTile extends StatelessWidget {
  const UserSearchResultTile({
    required this.result,
    required this.onTap,
    super.key,
  });

  final UserSearchResult result;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: MuSpace.m),
      child: MuCard(
        onTap: onTap,
        child: Row(
          children: [
            ProfileAvatar(url: result.profilePicUrl, name: result.fullName, size: 44),
            const SizedBox(width: MuSpace.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(result.fullName, style: MuType.bodyMed, maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(
                    [result.muid, if (result.organization != null) result.organization].join(' · '),
                    style: MuType.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: MuSpace.s),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${result.karma}', style: MuType.statSmall.copyWith(fontSize: 15)),
                Text('karma', style: MuType.caption.copyWith(color: MuColors.inkTertiary)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
