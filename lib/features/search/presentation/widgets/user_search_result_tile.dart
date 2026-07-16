import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
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
    return ListTile(
      onTap: onTap,
      leading: ProfileAvatar(
        url: result.profilePicUrl,
        name: result.fullName,
        size: 40,
      ),
      title: Text(result.fullName),
      subtitle: Text(
        [result.muid, if (result.organization != null) result.organization]
            .join(' · '),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('${result.karma}',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Text('karma',
              style: TextStyle(fontSize: 10, color: MulearnColors.gray600)),
        ],
      ),
    );
  }
}
