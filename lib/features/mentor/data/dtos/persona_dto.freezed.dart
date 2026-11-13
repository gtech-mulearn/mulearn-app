// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'persona_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PersonaDto {

 String get activePersona; String? get activeScopeType; String? get activeScopeId; String? get activeScopeName;
/// Create a copy of PersonaDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonaDtoCopyWith<PersonaDto> get copyWith => _$PersonaDtoCopyWithImpl<PersonaDto>(this as PersonaDto, _$identity);

  /// Serializes this PersonaDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonaDto&&(identical(other.activePersona, activePersona) || other.activePersona == activePersona)&&(identical(other.activeScopeType, activeScopeType) || other.activeScopeType == activeScopeType)&&(identical(other.activeScopeId, activeScopeId) || other.activeScopeId == activeScopeId)&&(identical(other.activeScopeName, activeScopeName) || other.activeScopeName == activeScopeName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,activePersona,activeScopeType,activeScopeId,activeScopeName);

@override
String toString() {
  return 'PersonaDto(activePersona: $activePersona, activeScopeType: $activeScopeType, activeScopeId: $activeScopeId, activeScopeName: $activeScopeName)';
}


}

/// @nodoc
abstract mixin class $PersonaDtoCopyWith<$Res>  {
  factory $PersonaDtoCopyWith(PersonaDto value, $Res Function(PersonaDto) _then) = _$PersonaDtoCopyWithImpl;
@useResult
$Res call({
 String activePersona, String? activeScopeType, String? activeScopeId, String? activeScopeName
});




}
/// @nodoc
class _$PersonaDtoCopyWithImpl<$Res>
    implements $PersonaDtoCopyWith<$Res> {
  _$PersonaDtoCopyWithImpl(this._self, this._then);

  final PersonaDto _self;
  final $Res Function(PersonaDto) _then;

/// Create a copy of PersonaDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activePersona = null,Object? activeScopeType = freezed,Object? activeScopeId = freezed,Object? activeScopeName = freezed,}) {
  return _then(_self.copyWith(
activePersona: null == activePersona ? _self.activePersona : activePersona // ignore: cast_nullable_to_non_nullable
as String,activeScopeType: freezed == activeScopeType ? _self.activeScopeType : activeScopeType // ignore: cast_nullable_to_non_nullable
as String?,activeScopeId: freezed == activeScopeId ? _self.activeScopeId : activeScopeId // ignore: cast_nullable_to_non_nullable
as String?,activeScopeName: freezed == activeScopeName ? _self.activeScopeName : activeScopeName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PersonaDto].
extension PersonaDtoPatterns on PersonaDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonaDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonaDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonaDto value)  $default,){
final _that = this;
switch (_that) {
case _PersonaDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonaDto value)?  $default,){
final _that = this;
switch (_that) {
case _PersonaDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String activePersona,  String? activeScopeType,  String? activeScopeId,  String? activeScopeName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonaDto() when $default != null:
return $default(_that.activePersona,_that.activeScopeType,_that.activeScopeId,_that.activeScopeName);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String activePersona,  String? activeScopeType,  String? activeScopeId,  String? activeScopeName)  $default,) {final _that = this;
switch (_that) {
case _PersonaDto():
return $default(_that.activePersona,_that.activeScopeType,_that.activeScopeId,_that.activeScopeName);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String activePersona,  String? activeScopeType,  String? activeScopeId,  String? activeScopeName)?  $default,) {final _that = this;
switch (_that) {
case _PersonaDto() when $default != null:
return $default(_that.activePersona,_that.activeScopeType,_that.activeScopeId,_that.activeScopeName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersonaDto extends PersonaDto {
  const _PersonaDto({this.activePersona = 'learner', this.activeScopeType, this.activeScopeId, this.activeScopeName}): super._();
  factory _PersonaDto.fromJson(Map<String, dynamic> json) => _$PersonaDtoFromJson(json);

@override@JsonKey() final  String activePersona;
@override final  String? activeScopeType;
@override final  String? activeScopeId;
@override final  String? activeScopeName;

/// Create a copy of PersonaDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonaDtoCopyWith<_PersonaDto> get copyWith => __$PersonaDtoCopyWithImpl<_PersonaDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonaDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonaDto&&(identical(other.activePersona, activePersona) || other.activePersona == activePersona)&&(identical(other.activeScopeType, activeScopeType) || other.activeScopeType == activeScopeType)&&(identical(other.activeScopeId, activeScopeId) || other.activeScopeId == activeScopeId)&&(identical(other.activeScopeName, activeScopeName) || other.activeScopeName == activeScopeName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,activePersona,activeScopeType,activeScopeId,activeScopeName);

@override
String toString() {
  return 'PersonaDto(activePersona: $activePersona, activeScopeType: $activeScopeType, activeScopeId: $activeScopeId, activeScopeName: $activeScopeName)';
}


}

/// @nodoc
abstract mixin class _$PersonaDtoCopyWith<$Res> implements $PersonaDtoCopyWith<$Res> {
  factory _$PersonaDtoCopyWith(_PersonaDto value, $Res Function(_PersonaDto) _then) = __$PersonaDtoCopyWithImpl;
@override @useResult
$Res call({
 String activePersona, String? activeScopeType, String? activeScopeId, String? activeScopeName
});




}
/// @nodoc
class __$PersonaDtoCopyWithImpl<$Res>
    implements _$PersonaDtoCopyWith<$Res> {
  __$PersonaDtoCopyWithImpl(this._self, this._then);

  final _PersonaDto _self;
  final $Res Function(_PersonaDto) _then;

/// Create a copy of PersonaDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activePersona = null,Object? activeScopeType = freezed,Object? activeScopeId = freezed,Object? activeScopeName = freezed,}) {
  return _then(_PersonaDto(
activePersona: null == activePersona ? _self.activePersona : activePersona // ignore: cast_nullable_to_non_nullable
as String,activeScopeType: freezed == activeScopeType ? _self.activeScopeType : activeScopeType // ignore: cast_nullable_to_non_nullable
as String?,activeScopeId: freezed == activeScopeId ? _self.activeScopeId : activeScopeId // ignore: cast_nullable_to_non_nullable
as String?,activeScopeName: freezed == activeScopeName ? _self.activeScopeName : activeScopeName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
