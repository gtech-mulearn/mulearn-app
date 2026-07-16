// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vc_subject_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VcSubjectInfo {

 VcCredentialType get type; String get did; String get name; String? get email;
/// Create a copy of VcSubjectInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VcSubjectInfoCopyWith<VcSubjectInfo> get copyWith => _$VcSubjectInfoCopyWithImpl<VcSubjectInfo>(this as VcSubjectInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VcSubjectInfo&&(identical(other.type, type) || other.type == type)&&(identical(other.did, did) || other.did == did)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,type,did,name,email);

@override
String toString() {
  return 'VcSubjectInfo(type: $type, did: $did, name: $name, email: $email)';
}


}

/// @nodoc
abstract mixin class $VcSubjectInfoCopyWith<$Res>  {
  factory $VcSubjectInfoCopyWith(VcSubjectInfo value, $Res Function(VcSubjectInfo) _then) = _$VcSubjectInfoCopyWithImpl;
@useResult
$Res call({
 VcCredentialType type, String did, String name, String? email
});




}
/// @nodoc
class _$VcSubjectInfoCopyWithImpl<$Res>
    implements $VcSubjectInfoCopyWith<$Res> {
  _$VcSubjectInfoCopyWithImpl(this._self, this._then);

  final VcSubjectInfo _self;
  final $Res Function(VcSubjectInfo) _then;

/// Create a copy of VcSubjectInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? did = null,Object? name = null,Object? email = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as VcCredentialType,did: null == did ? _self.did : did // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VcSubjectInfo].
extension VcSubjectInfoPatterns on VcSubjectInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VcSubjectInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VcSubjectInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VcSubjectInfo value)  $default,){
final _that = this;
switch (_that) {
case _VcSubjectInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VcSubjectInfo value)?  $default,){
final _that = this;
switch (_that) {
case _VcSubjectInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( VcCredentialType type,  String did,  String name,  String? email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VcSubjectInfo() when $default != null:
return $default(_that.type,_that.did,_that.name,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( VcCredentialType type,  String did,  String name,  String? email)  $default,) {final _that = this;
switch (_that) {
case _VcSubjectInfo():
return $default(_that.type,_that.did,_that.name,_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( VcCredentialType type,  String did,  String name,  String? email)?  $default,) {final _that = this;
switch (_that) {
case _VcSubjectInfo() when $default != null:
return $default(_that.type,_that.did,_that.name,_that.email);case _:
  return null;

}
}

}

/// @nodoc


class _VcSubjectInfo implements VcSubjectInfo {
  const _VcSubjectInfo({required this.type, required this.did, required this.name, this.email});
  

@override final  VcCredentialType type;
@override final  String did;
@override final  String name;
@override final  String? email;

/// Create a copy of VcSubjectInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VcSubjectInfoCopyWith<_VcSubjectInfo> get copyWith => __$VcSubjectInfoCopyWithImpl<_VcSubjectInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VcSubjectInfo&&(identical(other.type, type) || other.type == type)&&(identical(other.did, did) || other.did == did)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,type,did,name,email);

@override
String toString() {
  return 'VcSubjectInfo(type: $type, did: $did, name: $name, email: $email)';
}


}

/// @nodoc
abstract mixin class _$VcSubjectInfoCopyWith<$Res> implements $VcSubjectInfoCopyWith<$Res> {
  factory _$VcSubjectInfoCopyWith(_VcSubjectInfo value, $Res Function(_VcSubjectInfo) _then) = __$VcSubjectInfoCopyWithImpl;
@override @useResult
$Res call({
 VcCredentialType type, String did, String name, String? email
});




}
/// @nodoc
class __$VcSubjectInfoCopyWithImpl<$Res>
    implements _$VcSubjectInfoCopyWith<$Res> {
  __$VcSubjectInfoCopyWithImpl(this._self, this._then);

  final _VcSubjectInfo _self;
  final $Res Function(_VcSubjectInfo) _then;

/// Create a copy of VcSubjectInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? did = null,Object? name = null,Object? email = freezed,}) {
  return _then(_VcSubjectInfo(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as VcCredentialType,did: null == did ? _self.did : did // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
