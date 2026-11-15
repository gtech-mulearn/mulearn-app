/// A campus IG chapter (`CampusIGChapter`): the campus's own chapter of a
/// μLearn interest group, with its lead, co-lead and campus members. This is
/// what the dashboard's campus workspace lists under its IG tab, not the
/// global interest groups.
class CampusChapter {
  const CampusChapter({
    required this.id,
    required this.igId,
    required this.igName,
    required this.igCode,
    required this.members,
    required this.isActive,
    this.leadName,
    this.coLeadName,
    this.description,
  });

  final String id;

  /// The interest group the chapter belongs to.
  final String igId;
  final String igName;
  final String igCode;

  /// Learners from this campus in the interest group.
  final int members;
  final bool isActive;
  final String? leadName;
  final String? coLeadName;
  final String? description;
}

/// A campus member who can lead a chapter (`execom/search/`).
typedef CampusMember = ({String muid, String name, String? photoUrl});

/// An interest group a chapter can be started for.
typedef ChapterIgOption = ({String id, String name});
