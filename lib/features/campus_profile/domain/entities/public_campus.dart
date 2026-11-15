import 'package:freezed_annotation/freezed_annotation.dart';

part 'public_campus.freezed.dart';

/// Someone named on a campus page: its Campus Lead or an execom member.
@freezed
abstract class CampusPerson with _$CampusPerson {
  const factory CampusPerson({
    required String muid,
    required String fullName,
    String? profilePic,
    String? role,
  }) = _CampusPerson;
}

/// A row of the campus's top-10 leaderboard.
@freezed
abstract class CampusLeader with _$CampusLeader {
  const factory CampusLeader({
    required int rank,
    required String muid,
    required String fullName,
    required int karma,
    String? profilePic,
  }) = _CampusLeader;
}

/// An interest group chapter active at the campus.
@freezed
abstract class CampusChapter with _$CampusChapter {
  const factory CampusChapter({
    required String name,
    required String code,
    required int members,
    String? leadName,
  }) = _CampusChapter;
}

/// Karma and members for one IG category (coder, maker…, unclustered).
@freezed
abstract class CampusCluster with _$CampusCluster {
  const factory CampusCluster({
    required String cluster,
    required int karma,
    required int members,
  }) = _CampusCluster;
}

/// A campus's own social link.
@freezed
abstract class CampusLink with _$CampusLink {
  const factory CampusLink({required String platform, required String url}) =
      _CampusLink;
}

/// A college's public page (CampusDetailsPublicAPI, `campus/<org_id>/`):
/// any signed-in member can open it.
@freezed
abstract class PublicCampus with _$PublicCampus {
  const factory PublicCampus({
    required String id,
    required String name,
    required String code,
    required String zone,
    required int totalKarma,
    required int members,
    required int activeMembers,
    int? rank,
    CampusPerson? lead,
    @Default(<CampusPerson>[]) List<CampusPerson> execom,
    @Default(<CampusLeader>[]) List<CampusLeader> topLearners,
    @Default(<CampusChapter>[]) List<CampusChapter> chapters,
    @Default(<CampusCluster>[]) List<CampusCluster> clusters,
    @Default(<CampusLink>[]) List<CampusLink> links,
  }) = _PublicCampus;
}

/// Karma earned on one day.
typedef CampusKarmaDay = ({DateTime day, int karma});
