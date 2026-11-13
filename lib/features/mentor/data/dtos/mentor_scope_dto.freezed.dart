// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mentor_scope_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MentorScopeDto {

 String? get scopeType; String get scopeId; String get scopeName; Map<String, dynamic> get metrics;
/// Create a copy of MentorScopeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MentorScopeDtoCopyWith<MentorScopeDto> get copyWith => _$MentorScopeDtoCopyWithImpl<MentorScopeDto>(this as MentorScopeDto, _$identity);

  /// Serializes this MentorScopeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MentorScopeDto&&(identical(other.scopeType, scopeType) || other.scopeType == scopeType)&&(identical(other.scopeId, scopeId) || other.scopeId == scopeId)&&(identical(other.scopeName, scopeName) || other.scopeName == scopeName)&&const DeepCollectionEquality().equals(other.metrics, metrics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scopeType,scopeId,scopeName,const DeepCollectionEquality().hash(metrics));

@override
String toString() {
  return 'MentorScopeDto(scopeType: $scopeType, scopeId: $scopeId, scopeName: $scopeName, metrics: $metrics)';
}


}

/// @nodoc
abstract mixin class $MentorScopeDtoCopyWith<$Res>  {
  factory $MentorScopeDtoCopyWith(MentorScopeDto value, $Res Function(MentorScopeDto) _then) = _$MentorScopeDtoCopyWithImpl;
@useResult
$Res call({
 String? scopeType, String scopeId, String scopeName, Map<String, dynamic> metrics
});




}
/// @nodoc
class _$MentorScopeDtoCopyWithImpl<$Res>
    implements $MentorScopeDtoCopyWith<$Res> {
  _$MentorScopeDtoCopyWithImpl(this._self, this._then);

  final MentorScopeDto _self;
  final $Res Function(MentorScopeDto) _then;

/// Create a copy of MentorScopeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scopeType = freezed,Object? scopeId = null,Object? scopeName = null,Object? metrics = null,}) {
  return _then(_self.copyWith(
scopeType: freezed == scopeType ? _self.scopeType : scopeType // ignore: cast_nullable_to_non_nullable
as String?,scopeId: null == scopeId ? _self.scopeId : scopeId // ignore: cast_nullable_to_non_nullable
as String,scopeName: null == scopeName ? _self.scopeName : scopeName // ignore: cast_nullable_to_non_nullable
as String,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [MentorScopeDto].
extension MentorScopeDtoPatterns on MentorScopeDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MentorScopeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MentorScopeDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MentorScopeDto value)  $default,){
final _that = this;
switch (_that) {
case _MentorScopeDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MentorScopeDto value)?  $default,){
final _that = this;
switch (_that) {
case _MentorScopeDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? scopeType,  String scopeId,  String scopeName,  Map<String, dynamic> metrics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MentorScopeDto() when $default != null:
return $default(_that.scopeType,_that.scopeId,_that.scopeName,_that.metrics);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? scopeType,  String scopeId,  String scopeName,  Map<String, dynamic> metrics)  $default,) {final _that = this;
switch (_that) {
case _MentorScopeDto():
return $default(_that.scopeType,_that.scopeId,_that.scopeName,_that.metrics);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? scopeType,  String scopeId,  String scopeName,  Map<String, dynamic> metrics)?  $default,) {final _that = this;
switch (_that) {
case _MentorScopeDto() when $default != null:
return $default(_that.scopeType,_that.scopeId,_that.scopeName,_that.metrics);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MentorScopeDto extends MentorScopeDto {
  const _MentorScopeDto({this.scopeType, this.scopeId = '', this.scopeName = '', final  Map<String, dynamic> metrics = const <String, dynamic>{}}): _metrics = metrics,super._();
  factory _MentorScopeDto.fromJson(Map<String, dynamic> json) => _$MentorScopeDtoFromJson(json);

@override final  String? scopeType;
@override@JsonKey() final  String scopeId;
@override@JsonKey() final  String scopeName;
 final  Map<String, dynamic> _metrics;
@override@JsonKey() Map<String, dynamic> get metrics {
  if (_metrics is EqualUnmodifiableMapView) return _metrics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metrics);
}


/// Create a copy of MentorScopeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MentorScopeDtoCopyWith<_MentorScopeDto> get copyWith => __$MentorScopeDtoCopyWithImpl<_MentorScopeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MentorScopeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MentorScopeDto&&(identical(other.scopeType, scopeType) || other.scopeType == scopeType)&&(identical(other.scopeId, scopeId) || other.scopeId == scopeId)&&(identical(other.scopeName, scopeName) || other.scopeName == scopeName)&&const DeepCollectionEquality().equals(other._metrics, _metrics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scopeType,scopeId,scopeName,const DeepCollectionEquality().hash(_metrics));

@override
String toString() {
  return 'MentorScopeDto(scopeType: $scopeType, scopeId: $scopeId, scopeName: $scopeName, metrics: $metrics)';
}


}

/// @nodoc
abstract mixin class _$MentorScopeDtoCopyWith<$Res> implements $MentorScopeDtoCopyWith<$Res> {
  factory _$MentorScopeDtoCopyWith(_MentorScopeDto value, $Res Function(_MentorScopeDto) _then) = __$MentorScopeDtoCopyWithImpl;
@override @useResult
$Res call({
 String? scopeType, String scopeId, String scopeName, Map<String, dynamic> metrics
});




}
/// @nodoc
class __$MentorScopeDtoCopyWithImpl<$Res>
    implements _$MentorScopeDtoCopyWith<$Res> {
  __$MentorScopeDtoCopyWithImpl(this._self, this._then);

  final _MentorScopeDto _self;
  final $Res Function(_MentorScopeDto) _then;

/// Create a copy of MentorScopeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scopeType = freezed,Object? scopeId = null,Object? scopeName = null,Object? metrics = null,}) {
  return _then(_MentorScopeDto(
scopeType: freezed == scopeType ? _self.scopeType : scopeType // ignore: cast_nullable_to_non_nullable
as String?,scopeId: null == scopeId ? _self.scopeId : scopeId // ignore: cast_nullable_to_non_nullable
as String,scopeName: null == scopeName ? _self.scopeName : scopeName // ignore: cast_nullable_to_non_nullable
as String,metrics: null == metrics ? _self._metrics : metrics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
