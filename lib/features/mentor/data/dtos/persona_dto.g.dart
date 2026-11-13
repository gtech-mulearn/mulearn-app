// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persona_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PersonaDto _$PersonaDtoFromJson(Map<String, dynamic> json) => _PersonaDto(
  activePersona: json['active_persona'] as String? ?? 'learner',
  activeScopeType: json['active_scope_type'] as String?,
  activeScopeId: json['active_scope_id'] as String?,
  activeScopeName: json['active_scope_name'] as String?,
);

Map<String, dynamic> _$PersonaDtoToJson(_PersonaDto instance) =>
    <String, dynamic>{
      'active_persona': instance.activePersona,
      'active_scope_type': instance.activeScopeType,
      'active_scope_id': instance.activeScopeId,
      'active_scope_name': instance.activeScopeName,
    };
