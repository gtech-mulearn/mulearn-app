// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor_scope_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MentorScopeDto _$MentorScopeDtoFromJson(Map<String, dynamic> json) =>
    _MentorScopeDto(
      scopeType: json['scope_type'] as String?,
      scopeId: json['scope_id'] as String? ?? '',
      scopeName: json['scope_name'] as String? ?? '',
      metrics:
          json['metrics'] as Map<String, dynamic>? ?? const <String, dynamic>{},
    );

Map<String, dynamic> _$MentorScopeDtoToJson(_MentorScopeDto instance) =>
    <String, dynamic>{
      'scope_type': instance.scopeType,
      'scope_id': instance.scopeId,
      'scope_name': instance.scopeName,
      'metrics': instance.metrics,
    };
