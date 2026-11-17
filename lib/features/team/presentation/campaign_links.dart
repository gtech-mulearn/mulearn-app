/// The `value` that lets the person type their own app path.
const String kCampaignCustomLink = 'custom';

/// The `value` for a push that only opens the app (no route is sent).
const String kCampaignNoLink = 'none';

/// Where a push can take people, as `(value, label)`. Copied from the
/// dashboard's `LINKS` (`push-campaign-dialog.tsx`). The value is an app
/// path, [kCampaignNoLink] (send no route) or [kCampaignCustomLink].
const List<(String, String)> kCampaignLinks = [
  (kCampaignNoLink, 'Just open the app'),
  ('/tasks', 'Tasks'),
  ('/events', 'Events'),
  ('/circles', 'Learning circles'),
  ('/interest-groups', 'Interest groups'),
  ('/weekly-twitches', 'Weekly Twitches'),
  ('/opportunities', 'Jobs & internships'),
  ('/projects', 'Projects'),
  ('/problem-statements', 'Problem statements'),
  ('/leaderboard', 'Leaderboard'),
  (kCampaignCustomLink, 'Another app path…'),
];

/// What a saved route reads as: its label when it is a listed path, else
/// the path itself; "Just open the app" for none.
String campaignLinkLabel(String? route) {
  if (route == null || route.isEmpty) return 'Just open the app';
  for (final (value, label) in kCampaignLinks) {
    if (value == route) return label;
  }
  return route;
}
