/// What a guest can see of the community before signing in: real counts
/// and real featured events and groups, from the public endpoints. Every
/// count is nullable: a count that didn't load is left out, never guessed.
class PublicStats {
  const PublicStats({this.members, this.campuses, this.companies, this.mentors, this.interestGroups, this.circles});

  final int? members;
  final int? campuses;
  final int? companies;
  final int? mentors;
  final int? interestGroups;
  final int? circles;
}

/// A featured event as a guest sees it.
class GuestEvent {
  const GuestEvent({
    required this.id,
    required this.title,
    required this.start,
    required this.end,
    required this.place,
    required this.interested,
    this.coverImage,
    this.type,
  });

  final String id;
  final String title;
  final DateTime? start;
  final DateTime? end;

  /// "Online" or the venue's city.
  final String place;
  final int interested;
  final String? coverImage;

  /// The backend's event type ("hackathon").
  final String? type;
}

/// An Interest Group as a guest sees it.
class GuestInterestGroup {
  const GuestInterestGroup({required this.id, required this.name});

  final String id;
  final String name;
}
