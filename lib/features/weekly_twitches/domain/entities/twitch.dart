/// The four weekly shows (`api/dashboard/media_content/`), as the dashboard's
/// Weekly Twitches tabs list them.
enum TwitchShow {
  /// Talks by people from industry, tagged with Interest Groups.
  officeHours(
    'office-hours',
    'Office Hours',
    'Talks with people who do the work',
    'OFFICE_HOURS_ANNOUNCED',
  ),

  /// A campus-hosted episode, streamed.
  saltMangoTree(
    'salt-mango-tree',
    'Salt Mango Tree',
    'Campus stories, streamed live',
    'SALT_MANGO_TREE_ANNOUNCED',
  ),

  /// Inspiration Station Radio: a campus-hosted radio episode.
  inspirationStation(
    'inspiration-station',
    'Inspiration Station',
    'Radio episodes from campuses',
    'INSPIRATION_STATION_ANNOUNCED',
  ),

  /// A skills session run by a college, with a speaker.
  grabYourSuperpowers(
    'grab-your-superpowers',
    'Grab Your Superpowers',
    'Skill sessions run by colleges',
    'GRAB_YOUR_SUPERPOWERS_ANNOUNCED',
  );

  const TwitchShow(this.slug, this.label, this.blurb, this.notificationType);

  /// The endpoint and route segment.
  final String slug;

  /// The show's name.
  final String label;

  /// One line on what it is.
  final String blurb;

  /// The notification type that announces an episode.
  final String notificationType;

  /// The show for a route segment or notification type, if any.
  static TwitchShow? from(String? value) {
    for (final s in values) {
      if (s.slug == value || s.notificationType == value) return s;
    }
    return null;
  }
}

/// Where an episode stands, by its date (the backend's `_compute_status`).
enum TwitchStatus {
  /// After today.
  upcoming,

  /// Today.
  ongoing,

  /// Before today.
  completed;

  static TwitchStatus parse(Object? v) => switch ('$v'.toLowerCase()) {
    'ongoing' => ongoing,
    'completed' => completed,
    _ => upcoming,
  };
}

/// One episode of a show. Office Hours carry a speaker, Interest Groups and
/// a poster; Salt Mango Tree and Inspiration Station a campus and zone;
/// Grab Your Superpowers a speaker and campus.
class TwitchEpisode {
  /// An episode.
  const TwitchEpisode({
    required this.id,
    required this.show,
    required this.title,
    required this.date,
    required this.status,
    this.time,
    this.performer,
    this.designation,
    this.campus,
    this.zone,
    this.description,
    this.link,
    this.posterUrl,
    this.interestGroups = const [],
  });

  final String id;
  final TwitchShow show;

  /// `title`, or `topic` for the two campus shows.
  final String title;

  /// The day (no time zone: a wall-clock date).
  final DateTime date;

  /// `HH:mm` wall-clock start, when set.
  final ({int hour, int minute})? time;

  final TwitchStatus status;
  final String? performer;
  final String? designation;
  final String? campus;

  /// North / Central / South, as a label.
  final String? zone;
  final String? description;
  final String? link;
  final String? posterUrl;
  final List<String> interestGroups;

  /// The start as a local date-time (midnight when there's no time).
  DateTime get startsAt => DateTime(
    date.year,
    date.month,
    date.day,
    time?.hour ?? 0,
    time?.minute ?? 0,
  );

  /// The speaker, with their role when known.
  String? get speaker => performer == null
      ? null
      : designation == null
      ? performer
      : '$performer · $designation';
}

/// A page of episodes.
typedef TwitchPage = ({List<TwitchEpisode> items, bool hasNext});
