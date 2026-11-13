import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_scope.dart';

part 'mentor_scope_dto.freezed.dart';
part 'mentor_scope_dto.g.dart';

/// One `scopes[]` item of `GET mentor/overview/` (`MentorOverviewAPI`).
@freezed
abstract class MentorScopeDto with _$MentorScopeDto {
  const factory MentorScopeDto({
    String? scopeType,
    @Default('') String scopeId,
    @Default('') String scopeName,
    @Default(<String, dynamic>{}) Map<String, dynamic> metrics,
  }) = _MentorScopeDto;

  const MentorScopeDto._();

  factory MentorScopeDto.fromJson(Map<String, dynamic> json) => _$MentorScopeDtoFromJson(json);

  MentorScope toDomain() {
    int n(String key) => (metrics[key] as num?)?.toInt() ?? 0;
    return MentorScope(
      type: MentorScopeType.fromWire(scopeType),
      id: scopeId,
      name: scopeName,
      metrics: MentorScopeMetrics(
        totalIgLearners: n('total_ig_learners'),
        activeIgLearners: n('active_ig_learners'),
        upcomingSessions: n('upcoming_sessions'),
        completedSessions: n('completed_sessions'),
        pendingTasks: n('pending_tasks'),
        igLearningCircles: n('ig_learning_circles'),
        openOpportunities: n('open_opportunities'),
        igTasks: n('ig_tasks'),
      ),
    );
  }
}
