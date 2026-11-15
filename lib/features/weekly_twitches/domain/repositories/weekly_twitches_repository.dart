import 'package:mulearn_app/features/weekly_twitches/domain/entities/twitch.dart';

/// The weekly shows, read-only. Throws `ApiException` on failure.
abstract interface class WeeklyTwitchesRepository {
  /// A page of [show]'s episodes with any of [statuses] (all when empty),
  /// newest date first.
  Future<TwitchPage> episodes(
    TwitchShow show, {
    Set<TwitchStatus> statuses,
    int pageIndex,
    int perPage,
  });

  /// One episode.
  Future<TwitchEpisode> episode(TwitchShow show, String id);
}
