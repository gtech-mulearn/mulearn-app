import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_scope.dart';
import 'package:mulearn_app/features/mentor/domain/entities/persona.dart';

part 'persona_dto.freezed.dart';
part 'persona_dto.g.dart';

/// `GET mentor/persona/status/` (`PersonaStatusAPI`).
@freezed
abstract class PersonaDto with _$PersonaDto {
  const factory PersonaDto({
    @Default('learner') String activePersona,
    String? activeScopeType,
    String? activeScopeId,
    String? activeScopeName,
  }) = _PersonaDto;

  const PersonaDto._();

  factory PersonaDto.fromJson(Map<String, dynamic> json) => _$PersonaDtoFromJson(json);

  Persona toDomain() => activePersona.toLowerCase() == 'mentor'
      ? Persona(
          isMentor: true,
          scopeType: activeScopeType == null ? null : MentorScopeType.fromWire(activeScopeType),
          scopeId: activeScopeId,
          scopeName: activeScopeName,
        )
      : const Persona(isMentor: false);
}
