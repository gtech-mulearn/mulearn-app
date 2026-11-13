import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_scope.dart';

part 'persona.freezed.dart';

/// Who the mentor is acting as (`persona/status/`): a learner, or a mentor
/// in one scope. The backend gates nothing on it; the app uses it as the
/// default scope for new sessions.
@freezed
abstract class Persona with _$Persona {
  const factory Persona({
    required bool isMentor,
    MentorScopeType? scopeType,
    String? scopeId,
    String? scopeName,
  }) = _Persona;
}
