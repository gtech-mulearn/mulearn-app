// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'circle_user_ref.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CircleUserRef {

 String get fullName; String? get id; String? get muid; String? get profilePicUrl;
/// Create a copy of CircleUserRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CircleUserRefCopyWith<CircleUserRef> get copyWith => _$CircleUserRefCopyWithImpl<CircleUserRef>(this as CircleUserRef, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CircleUserRef&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.id, id) || other.id == id)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.profilePicUrl, profilePicUrl) || other.profilePicUrl == profilePicUrl));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,id,muid,profilePicUrl);

@override
String toString() {
  return 'CircleUserRef(fullName: $fullName, id: $id, muid: $muid, profilePicUrl: $profilePicUrl)';
}


}

/// @nodoc
abstract mixin class $CircleUserRefCopyWith<$Res>  {
  factory $CircleUserRefCopyWith(CircleUserRef value, $Res Function(CircleUserRef) _then) = _$CircleUserRefCopyWithImpl;
@useResult
$Res call({
 String fullName, String? id, String? muid, String? profilePicUrl
});




}
/// @nodoc
class _$CircleUserRefCopyWithImpl<$Res>
    implements $CircleUserRefCopyWith<$Res> {
  _$CircleUserRefCopyWithImpl(this._self, this._then);

  final CircleUserRef _self;
  final $Res Function(CircleUserRef) _then;

/// Create a copy of CircleUserRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? id = freezed,Object? muid = freezed,Object? profilePicUrl = freezed,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,muid: freezed == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String?,profilePicUrl: freezed == profilePicUrl ? _self.profilePicUrl : profilePicUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CircleUserRef].
extension CircleUserRefPatterns on CircleUserRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CircleUserRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CircleUserRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CircleUserRef value)  $default,){
final _that = this;
switch (_that) {
case _CircleUserRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CircleUserRef value)?  $default,){
final _that = this;
switch (_that) {
case _CircleUserRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fullName,  String? id,  String? muid,  String? profilePicUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CircleUserRef() when $default != null:
return $default(_that.fullName,_that.id,_that.muid,_that.profilePicUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fullName,  String? id,  String? muid,  String? profilePicUrl)  $default,) {final _that = this;
switch (_that) {
case _CircleUserRef():
return $default(_that.fullName,_that.id,_that.muid,_that.profilePicUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fullName,  String? id,  String? muid,  String? profilePicUrl)?  $default,) {final _that = this;
switch (_that) {
case _CircleUserRef() when $default != null:
return $default(_that.fullName,_that.id,_that.muid,_that.profilePicUrl);case _:
  return null;

}
}

}

/// @nodoc


class _CircleUserRef implements CircleUserRef {
  const _CircleUserRef({required this.fullName, this.id, this.muid, this.profilePicUrl});
  

@override final  String fullName;
@override final  String? id;
@override final  String? muid;
@override final  String? profilePicUrl;

/// Create a copy of CircleUserRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CircleUserRefCopyWith<_CircleUserRef> get copyWith => __$CircleUserRefCopyWithImpl<_CircleUserRef>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CircleUserRef&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.id, id) || other.id == id)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.profilePicUrl, profilePicUrl) || other.profilePicUrl == profilePicUrl));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,id,muid,profilePicUrl);

@override
String toString() {
  return 'CircleUserRef(fullName: $fullName, id: $id, muid: $muid, profilePicUrl: $profilePicUrl)';
}


}

/// @nodoc
abstract mixin class _$CircleUserRefCopyWith<$Res> implements $CircleUserRefCopyWith<$Res> {
  factory _$CircleUserRefCopyWith(_CircleUserRef value, $Res Function(_CircleUserRef) _then) = __$CircleUserRefCopyWithImpl;
@override @useResult
$Res call({
 String fullName, String? id, String? muid, String? profilePicUrl
});




}
/// @nodoc
class __$CircleUserRefCopyWithImpl<$Res>
    implements _$CircleUserRefCopyWith<$Res> {
  __$CircleUserRefCopyWithImpl(this._self, this._then);

  final _CircleUserRef _self;
  final $Res Function(_CircleUserRef) _then;

/// Create a copy of CircleUserRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? id = freezed,Object? muid = freezed,Object? profilePicUrl = freezed,}) {
  return _then(_CircleUserRef(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,muid: freezed == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String?,profilePicUrl: freezed == profilePicUrl ? _self.profilePicUrl : profilePicUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
