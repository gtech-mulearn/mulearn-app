// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'role_verification_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RoleVerificationDto {

 String get role; bool get isVerified;
/// Create a copy of RoleVerificationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoleVerificationDtoCopyWith<RoleVerificationDto> get copyWith => _$RoleVerificationDtoCopyWithImpl<RoleVerificationDto>(this as RoleVerificationDto, _$identity);

  /// Serializes this RoleVerificationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoleVerificationDto&&(identical(other.role, role) || other.role == role)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,isVerified);

@override
String toString() {
  return 'RoleVerificationDto(role: $role, isVerified: $isVerified)';
}


}

/// @nodoc
abstract mixin class $RoleVerificationDtoCopyWith<$Res>  {
  factory $RoleVerificationDtoCopyWith(RoleVerificationDto value, $Res Function(RoleVerificationDto) _then) = _$RoleVerificationDtoCopyWithImpl;
@useResult
$Res call({
 String role, bool isVerified
});




}
/// @nodoc
class _$RoleVerificationDtoCopyWithImpl<$Res>
    implements $RoleVerificationDtoCopyWith<$Res> {
  _$RoleVerificationDtoCopyWithImpl(this._self, this._then);

  final RoleVerificationDto _self;
  final $Res Function(RoleVerificationDto) _then;

/// Create a copy of RoleVerificationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? role = null,Object? isVerified = null,}) {
  return _then(_self.copyWith(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RoleVerificationDto].
extension RoleVerificationDtoPatterns on RoleVerificationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoleVerificationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoleVerificationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoleVerificationDto value)  $default,){
final _that = this;
switch (_that) {
case _RoleVerificationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoleVerificationDto value)?  $default,){
final _that = this;
switch (_that) {
case _RoleVerificationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String role,  bool isVerified)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoleVerificationDto() when $default != null:
return $default(_that.role,_that.isVerified);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String role,  bool isVerified)  $default,) {final _that = this;
switch (_that) {
case _RoleVerificationDto():
return $default(_that.role,_that.isVerified);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String role,  bool isVerified)?  $default,) {final _that = this;
switch (_that) {
case _RoleVerificationDto() when $default != null:
return $default(_that.role,_that.isVerified);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoleVerificationDto extends RoleVerificationDto {
  const _RoleVerificationDto({required this.role, required this.isVerified}): super._();
  factory _RoleVerificationDto.fromJson(Map<String, dynamic> json) => _$RoleVerificationDtoFromJson(json);

@override final  String role;
@override final  bool isVerified;

/// Create a copy of RoleVerificationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoleVerificationDtoCopyWith<_RoleVerificationDto> get copyWith => __$RoleVerificationDtoCopyWithImpl<_RoleVerificationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoleVerificationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoleVerificationDto&&(identical(other.role, role) || other.role == role)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,isVerified);

@override
String toString() {
  return 'RoleVerificationDto(role: $role, isVerified: $isVerified)';
}


}

/// @nodoc
abstract mixin class _$RoleVerificationDtoCopyWith<$Res> implements $RoleVerificationDtoCopyWith<$Res> {
  factory _$RoleVerificationDtoCopyWith(_RoleVerificationDto value, $Res Function(_RoleVerificationDto) _then) = __$RoleVerificationDtoCopyWithImpl;
@override @useResult
$Res call({
 String role, bool isVerified
});




}
/// @nodoc
class __$RoleVerificationDtoCopyWithImpl<$Res>
    implements _$RoleVerificationDtoCopyWith<$Res> {
  __$RoleVerificationDtoCopyWithImpl(this._self, this._then);

  final _RoleVerificationDto _self;
  final $Res Function(_RoleVerificationDto) _then;

/// Create a copy of RoleVerificationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? role = null,Object? isVerified = null,}) {
  return _then(_RoleVerificationDto(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
