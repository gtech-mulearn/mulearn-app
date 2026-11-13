import 'package:freezed_annotation/freezed_annotation.dart';

part 'campus_summary.freezed.dart';

/// `GET campus/home-summary/` for the caller's campus.
@freezed
abstract class CampusSummary with _$CampusSummary {
  const factory CampusSummary({
    required String orgId,
    required String collegeName,
    required String campusCode,
    required String zone,
    required List<StatCard> stats,
    required List<FunnelStage> funnel,
    required int funnelMax,
    required List<CircleHealth> circleHealth,
    required List<CampusActivity> recentActivity,
  }) = _CampusSummary;
}

/// A headline number; [value] is null when the backend has none (e.g. no
/// rank yet). [deltaType] is `increase`, `decrease` or `neutral`.
@freezed
abstract class StatCard with _$StatCard {
  const factory StatCard({
    required String key,
    required String label,
    num? value,
    num? delta,
    String? deltaType,
    String? period,
  }) = _StatCard;
}

@freezed
abstract class FunnelStage with _$FunnelStage {
  const factory FunnelStage({
    required String key,
    required String label,
    required int count,
    required double percentage,
  }) = _FunnelStage;
}

/// A campus circle's pulse; [status] is `active`, `slow` or `inactive`.
@freezed
abstract class CircleHealth with _$CircleHealth {
  const factory CircleHealth({
    required String circleId,
    required String circleName,
    required String igName,
    required int memberCount,
    required num sessionsPerMonth,
    required String status,
    DateTime? lastSessionAt,
  }) = _CircleHealth;
}

@freezed
abstract class CampusActivity with _$CampusActivity {
  const factory CampusActivity({
    required String id,
    required String type,
    required String title,
    required DateTime createdAt,
    String? actorName,
    String? actorMuid,
  }) = _CampusActivity;
}

/// One day of `campus/weekly-karma/`.
typedef KarmaDay = ({DateTime day, int karma});
