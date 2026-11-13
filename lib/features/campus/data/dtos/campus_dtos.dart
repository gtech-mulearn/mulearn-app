import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_student.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_summary.dart';

part 'campus_dtos.freezed.dart';
part 'campus_dtos.g.dart';

int _int(Object? v) => (v as num?)?.toInt() ?? 0;
String _str(Object? v) => v is String ? v : '';
DateTime? _time(Object? v) => v is String && v.isNotEmpty ? DateTime.tryParse(v)?.toUtc() : null;

/// `campus/home-summary/` (`CampusDashboardSummaryAPIView`). Rows that
/// don't parse are skipped rather than failing the whole overview.
CampusSummary parseCampusSummary(Map<String, dynamic> json) {
  final campus = json['campus'] as Map<String, dynamic>? ?? const {};
  final funnel = json['member_funnel'] as Map<String, dynamic>? ?? const {};
  List<Map<String, dynamic>> rows(Object? v) => [
        if (v is List)
          for (final r in v)
            if (r is Map<String, dynamic>) r,
      ];
  return CampusSummary(
    orgId: _str(campus['org_id']),
    collegeName: _str(campus['college_name']),
    campusCode: _str(campus['campus_code']),
    zone: _str(campus['campus_zone']),
    stats: [
      for (final s in rows(json['stat_cards']))
        StatCard(
          key: _str(s['key']),
          label: _str(s['label']),
          value: s['value'] as num?,
          delta: s['delta'] as num?,
          deltaType: s['delta_type'] as String?,
          period: s['period'] as String?,
        ),
    ],
    funnel: [
      for (final f in rows(funnel['stages']))
        FunnelStage(
          key: _str(f['key']),
          label: _str(f['label']),
          count: _int(f['count']),
          percentage: (f['percentage'] as num?)?.toDouble() ?? 0,
        ),
    ],
    funnelMax: _int(funnel['max']),
    circleHealth: [
      for (final c in rows(json['circle_health']))
        if (c['circle_id'] is String)
          CircleHealth(
            circleId: c['circle_id'] as String,
            circleName: _str(c['circle_name']),
            igName: _str(c['ig_name']),
            memberCount: _int(c['member_count']),
            sessionsPerMonth: (c['sessions_per_month'] as num?) ?? 0,
            status: _str(c['status']).toLowerCase(),
            lastSessionAt: _time(c['last_session_at']),
          ),
    ],
    recentActivity: [
      for (final a in rows(json['recent_activity']))
        if (_time(a['created_at']) != null)
          CampusActivity(
            id: _str(a['id']),
            type: _str(a['type']),
            title: _str(a['title']),
            createdAt: _time(a['created_at'])!,
            actorName: (a['actor'] as Map<String, dynamic>?)?['full_name'] as String?,
            actorMuid: (a['actor'] as Map<String, dynamic>?)?['muid'] as String?,
          ),
    ],
  );
}

/// `campus/weekly-karma/`: date keys only (the college name is skipped),
/// oldest first.
List<KarmaDay> parseWeeklyKarma(Map<String, dynamic> json) {
  final days = <KarmaDay>[];
  for (final e in json.entries) {
    final date = DateTime.tryParse(e.key);
    if (date == null || e.value is! num) continue;
    days.add((day: DateTime(date.year, date.month, date.day), karma: (e.value as num).toInt()));
  }
  days.sort((a, b) => a.day.compareTo(b.day));
  return days;
}

/// One row of `campus/student-details/` (`CampusStudentDetailsSerializer`).
@freezed
abstract class CampusStudentDto with _$CampusStudentDto {
  const factory CampusStudentDto({
    @Default('') String fullName,
    @Default('') String muid,
    @Default(0) int karma,
    int? rank,
    @Default('') String level,
    String? joinDate,
    String? lastKarmaGained,
    String? graduationYear,
    String? department,
    @Default(false) bool isAlumni,
    @Default(0) int igCount,
    @Default(0) int lcCount,
  }) = _CampusStudentDto;

  const CampusStudentDto._();

  factory CampusStudentDto.fromJson(Map<String, dynamic> json) => _$CampusStudentDtoFromJson(json);

  CampusStudent toDomain() => CampusStudent(
        fullName: fullName,
        muid: muid,
        karma: karma,
        rank: rank,
        level: level,
        isAlumni: isAlumni,
        igCount: igCount,
        lcCount: lcCount,
        joinedAt: _time(joinDate),
        lastKarmaAt: _time(lastKarmaGained),
        graduationYear: (graduationYear ?? '').isEmpty ? null : graduationYear,
        department: (department ?? '').isEmpty ? null : department,
      );
}
