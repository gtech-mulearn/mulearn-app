// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_wizard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegisterWizardState {

 String? get fullName; String? get email; String? get password; RegistrationRole? get role;
/// Create a copy of RegisterWizardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterWizardStateCopyWith<RegisterWizardState> get copyWith => _$RegisterWizardStateCopyWithImpl<RegisterWizardState>(this as RegisterWizardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterWizardState&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,email,password,role);

@override
String toString() {
  return 'RegisterWizardState(fullName: $fullName, email: $email, password: $password, role: $role)';
}


}

/// @nodoc
abstract mixin class $RegisterWizardStateCopyWith<$Res>  {
  factory $RegisterWizardStateCopyWith(RegisterWizardState value, $Res Function(RegisterWizardState) _then) = _$RegisterWizardStateCopyWithImpl;
@useResult
$Res call({
 String? fullName, String? email, String? password, RegistrationRole? role
});




}
/// @nodoc
class _$RegisterWizardStateCopyWithImpl<$Res>
    implements $RegisterWizardStateCopyWith<$Res> {
  _$RegisterWizardStateCopyWithImpl(this._self, this._then);

  final RegisterWizardState _self;
  final $Res Function(RegisterWizardState) _then;

/// Create a copy of RegisterWizardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = freezed,Object? email = freezed,Object? password = freezed,Object? role = freezed,}) {
  return _then(_self.copyWith(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as RegistrationRole?,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisterWizardState].
extension RegisterWizardStatePatterns on RegisterWizardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterWizardState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterWizardState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterWizardState value)  $default,){
final _that = this;
switch (_that) {
case _RegisterWizardState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterWizardState value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterWizardState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? fullName,  String? email,  String? password,  RegistrationRole? role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterWizardState() when $default != null:
return $default(_that.fullName,_that.email,_that.password,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? fullName,  String? email,  String? password,  RegistrationRole? role)  $default,) {final _that = this;
switch (_that) {
case _RegisterWizardState():
return $default(_that.fullName,_that.email,_that.password,_that.role);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? fullName,  String? email,  String? password,  RegistrationRole? role)?  $default,) {final _that = this;
switch (_that) {
case _RegisterWizardState() when $default != null:
return $default(_that.fullName,_that.email,_that.password,_that.role);case _:
  return null;

}
}

}

/// @nodoc


class _RegisterWizardState implements RegisterWizardState {
  const _RegisterWizardState({this.fullName, this.email, this.password, this.role});
  

@override final  String? fullName;
@override final  String? email;
@override final  String? password;
@override final  RegistrationRole? role;

/// Create a copy of RegisterWizardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterWizardStateCopyWith<_RegisterWizardState> get copyWith => __$RegisterWizardStateCopyWithImpl<_RegisterWizardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterWizardState&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,email,password,role);

@override
String toString() {
  return 'RegisterWizardState(fullName: $fullName, email: $email, password: $password, role: $role)';
}


}

/// @nodoc
abstract mixin class _$RegisterWizardStateCopyWith<$Res> implements $RegisterWizardStateCopyWith<$Res> {
  factory _$RegisterWizardStateCopyWith(_RegisterWizardState value, $Res Function(_RegisterWizardState) _then) = __$RegisterWizardStateCopyWithImpl;
@override @useResult
$Res call({
 String? fullName, String? email, String? password, RegistrationRole? role
});




}
/// @nodoc
class __$RegisterWizardStateCopyWithImpl<$Res>
    implements _$RegisterWizardStateCopyWith<$Res> {
  __$RegisterWizardStateCopyWithImpl(this._self, this._then);

  final _RegisterWizardState _self;
  final $Res Function(_RegisterWizardState) _then;

/// Create a copy of RegisterWizardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = freezed,Object? email = freezed,Object? password = freezed,Object? role = freezed,}) {
  return _then(_RegisterWizardState(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as RegistrationRole?,
  ));
}


}

// dart format on
