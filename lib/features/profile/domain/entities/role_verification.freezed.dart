// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'role_verification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RoleVerification {

 String get role; bool get isVerified;
/// Create a copy of RoleVerification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoleVerificationCopyWith<RoleVerification> get copyWith => _$RoleVerificationCopyWithImpl<RoleVerification>(this as RoleVerification, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoleVerification&&(identical(other.role, role) || other.role == role)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified));
}


@override
int get hashCode => Object.hash(runtimeType,role,isVerified);

@override
String toString() {
  return 'RoleVerification(role: $role, isVerified: $isVerified)';
}


}

/// @nodoc
abstract mixin class $RoleVerificationCopyWith<$Res>  {
  factory $RoleVerificationCopyWith(RoleVerification value, $Res Function(RoleVerification) _then) = _$RoleVerificationCopyWithImpl;
@useResult
$Res call({
 String role, bool isVerified
});




}
/// @nodoc
class _$RoleVerificationCopyWithImpl<$Res>
    implements $RoleVerificationCopyWith<$Res> {
  _$RoleVerificationCopyWithImpl(this._self, this._then);

  final RoleVerification _self;
  final $Res Function(RoleVerification) _then;

/// Create a copy of RoleVerification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? role = null,Object? isVerified = null,}) {
  return _then(_self.copyWith(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RoleVerification].
extension RoleVerificationPatterns on RoleVerification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoleVerification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoleVerification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoleVerification value)  $default,){
final _that = this;
switch (_that) {
case _RoleVerification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoleVerification value)?  $default,){
final _that = this;
switch (_that) {
case _RoleVerification() when $default != null:
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
case _RoleVerification() when $default != null:
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
case _RoleVerification():
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
case _RoleVerification() when $default != null:
return $default(_that.role,_that.isVerified);case _:
  return null;

}
}

}

/// @nodoc


class _RoleVerification implements RoleVerification {
  const _RoleVerification({required this.role, required this.isVerified});
  

@override final  String role;
@override final  bool isVerified;

/// Create a copy of RoleVerification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoleVerificationCopyWith<_RoleVerification> get copyWith => __$RoleVerificationCopyWithImpl<_RoleVerification>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoleVerification&&(identical(other.role, role) || other.role == role)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified));
}


@override
int get hashCode => Object.hash(runtimeType,role,isVerified);

@override
String toString() {
  return 'RoleVerification(role: $role, isVerified: $isVerified)';
}


}

/// @nodoc
abstract mixin class _$RoleVerificationCopyWith<$Res> implements $RoleVerificationCopyWith<$Res> {
  factory _$RoleVerificationCopyWith(_RoleVerification value, $Res Function(_RoleVerification) _then) = __$RoleVerificationCopyWithImpl;
@override @useResult
$Res call({
 String role, bool isVerified
});




}
/// @nodoc
class __$RoleVerificationCopyWithImpl<$Res>
    implements _$RoleVerificationCopyWith<$Res> {
  __$RoleVerificationCopyWithImpl(this._self, this._then);

  final _RoleVerification _self;
  final $Res Function(_RoleVerification) _then;

/// Create a copy of RoleVerification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? role = null,Object? isVerified = null,}) {
  return _then(_RoleVerification(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
