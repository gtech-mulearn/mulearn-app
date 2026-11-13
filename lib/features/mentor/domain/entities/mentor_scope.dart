import 'package:freezed_annotation/freezed_annotation.dart';

part 'mentor_scope.freezed.dart';

/// What a mentor is granted to mentor (`MentorScopeGrant.ScopeType`,
/// `db/user.py:194`); [global] is the plain `MENTOR` scope.
enum MentorScopeType {
  igMentor('IG_MENTOR'),
  campusMentor('CAMPUS_MENTOR'),
  companyMentor('COMPANY_MENTOR'),
  global('MENTOR'),
  unknown('');

  const MentorScopeType(this.wire);
  final String wire;

  static MentorScopeType fromWire(String? value) =>
      values.firstWhere((e) => e != unknown && e.wire == value?.toUpperCase(), orElse: () => unknown);
}

/// One scope from `GET mentor/overview/` with its numbers.
@freezed
abstract class MentorScope with _$MentorScope {
  const factory MentorScope({
    required MentorScopeType type,
    required String id,
    required String name,
    required MentorScopeMetrics metrics,
  }) = _MentorScope;
}

@freezed
abstract class MentorScopeMetrics with _$MentorScopeMetrics {
  const factory MentorScopeMetrics({
    @Default(0) int totalIgLearners,
    @Default(0) int activeIgLearners,
    @Default(0) int upcomingSessions,
    @Default(0) int completedSessions,
    @Default(0) int pendingTasks,
    @Default(0) int igLearningCircles,
    @Default(0) int openOpportunities,
    @Default(0) int igTasks,
  }) = _MentorScopeMetrics;
}
