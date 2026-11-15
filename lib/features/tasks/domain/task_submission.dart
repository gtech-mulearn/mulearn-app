import 'package:mulearn_app/features/tasks/domain/entities/task_catalog_item.dart';

/// The μLearn Discord server, as the dashboard's task panel uses it
/// (`TaskDetailPanel.tsx` `DISCORD_GUILD_ID`).
const String muDiscordGuildId = '771670169691881483';

/// The dashboard's fallback channel when a task lists none
/// (`DEFAULT_DISCORD_CHANNEL_ID`).
const String muDefaultTaskChannelId = '782353185552465951';

/// Where proof for [task] is posted: its channel in the μLearn server, or
/// the default task channel, exactly like the dashboard.
Uri taskDiscordUri(TaskCatalogItem task) {
  final channel = (task.discordId == null || task.discordId!.isEmpty) ? muDefaultTaskChannelId : task.discordId!;
  return Uri.parse('https://discord.com/channels/$muDiscordGuildId/$channel');
}

/// Search like the dashboard's μJourney: title, hashtag, type, IG, channel
/// and level, case-insensitive; "level 3" matches too.
bool taskMatches(TaskCatalogItem task, String query, {required String levelText}) {
  final q = query.trim().toLowerCase();
  if (q.isEmpty) return true;
  return [
    task.title,
    task.hashtag,
    task.type,
    task.interestGroupName,
    task.channel,
    task.level,
    levelText,
  ].any((field) => field != null && field.toLowerCase().contains(q));
}
