import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_catalog_item.freezed.dart';

/// Which section of `GET /api/v1/dashboard/task/list/`'s response this task
/// came from — confirmed live: `start_journey` (beginner-friendly tasks open
/// to everyone), `become_expert` (interest-group-gated tasks), `events`
/// (tasks tied to a specific event). Doubles as the Tasks screen's filter.
enum TaskCategory { startJourney, becomeExpert, events }

/// One task in the real, dedicated task catalog (`GET
/// /api/v1/dashboard/task/list/`) — confirmed live, replacing the earlier
/// approach of flattening `get-user-levels` (which had no steps/category
/// data and only covered the signed-in user's own unlocked levels). Pure-Dart
/// domain entity (rules.md §2).
///
/// The mock's difficulty tags, steps list, "N doing this" counts, and a
/// ready-made Discord deep link have no backend support and are
/// intentionally omitted rather than fabricated — this endpoint gives a
/// channel name + hashtag + a raw Discord channel ID (no guild id, so no
/// valid `discord.com/channels/{guild}/{channel}` link can be built from it
/// alone).
@freezed
abstract class TaskCatalogItem with _$TaskCatalogItem {
  const factory TaskCatalogItem({
    required String id,
    required String title,
    required num karma,
    required bool completed,
    required TaskCategory category,
    String? description,
    String? hashtag,
    String? channel,
    String? discordId,

    /// Work-type tag, e.g. "General Enablement", "Volunteering", "IGLU",
    /// "Contribution", "Participation", "Event".
    String? type,

    /// Raw level gate as the backend sends it, e.g. `"lvl1"` — kept
    /// unparsed since nothing currently needs it as an int.
    String? level,
    String? interestGroupName,
  }) = _TaskCatalogItem;
}
