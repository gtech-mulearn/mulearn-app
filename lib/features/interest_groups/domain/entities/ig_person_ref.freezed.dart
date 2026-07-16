// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ig_person_ref.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IgPersonRef {

 String get muid; String get fullName; String? get profilePicUrl;
/// Create a copy of IgPersonRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IgPersonRefCopyWith<IgPersonRef> get copyWith => _$IgPersonRefCopyWithImpl<IgPersonRef>(this as IgPersonRef, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IgPersonRef&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.profilePicUrl, profilePicUrl) || other.profilePicUrl == profilePicUrl));
}


@override
int get hashCode => Object.hash(runtimeType,muid,fullName,profilePicUrl);

@override
String toString() {
  return 'IgPersonRef(muid: $muid, fullName: $fullName, profilePicUrl: $profilePicUrl)';
}


}

/// @nodoc
abstract mixin class $IgPersonRefCopyWith<$Res>  {
  factory $IgPersonRefCopyWith(IgPersonRef value, $Res Function(IgPersonRef) _then) = _$IgPersonRefCopyWithImpl;
@useResult
$Res call({
 String muid, String fullName, String? profilePicUrl
});




}
/// @nodoc
class _$IgPersonRefCopyWithImpl<$Res>
    implements $IgPersonRefCopyWith<$Res> {
  _$IgPersonRefCopyWithImpl(this._self, this._then);

  final IgPersonRef _self;
  final $Res Function(IgPersonRef) _then;

/// Create a copy of IgPersonRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? muid = null,Object? fullName = null,Object? profilePicUrl = freezed,}) {
  return _then(_self.copyWith(
muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,profilePicUrl: freezed == profilePicUrl ? _self.profilePicUrl : profilePicUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IgPersonRef].
extension IgPersonRefPatterns on IgPersonRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IgPersonRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IgPersonRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IgPersonRef value)  $default,){
final _that = this;
switch (_that) {
case _IgPersonRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IgPersonRef value)?  $default,){
final _that = this;
switch (_that) {
case _IgPersonRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String muid,  String fullName,  String? profilePicUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IgPersonRef() when $default != null:
return $default(_that.muid,_that.fullName,_that.profilePicUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String muid,  String fullName,  String? profilePicUrl)  $default,) {final _that = this;
switch (_that) {
case _IgPersonRef():
return $default(_that.muid,_that.fullName,_that.profilePicUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String muid,  String fullName,  String? profilePicUrl)?  $default,) {final _that = this;
switch (_that) {
case _IgPersonRef() when $default != null:
return $default(_that.muid,_that.fullName,_that.profilePicUrl);case _:
  return null;

}
}

}

/// @nodoc


class _IgPersonRef implements IgPersonRef {
  const _IgPersonRef({required this.muid, required this.fullName, this.profilePicUrl});
  

@override final  String muid;
@override final  String fullName;
@override final  String? profilePicUrl;

/// Create a copy of IgPersonRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IgPersonRefCopyWith<_IgPersonRef> get copyWith => __$IgPersonRefCopyWithImpl<_IgPersonRef>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IgPersonRef&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.profilePicUrl, profilePicUrl) || other.profilePicUrl == profilePicUrl));
}


@override
int get hashCode => Object.hash(runtimeType,muid,fullName,profilePicUrl);

@override
String toString() {
  return 'IgPersonRef(muid: $muid, fullName: $fullName, profilePicUrl: $profilePicUrl)';
}


}

/// @nodoc
abstract mixin class _$IgPersonRefCopyWith<$Res> implements $IgPersonRefCopyWith<$Res> {
  factory _$IgPersonRefCopyWith(_IgPersonRef value, $Res Function(_IgPersonRef) _then) = __$IgPersonRefCopyWithImpl;
@override @useResult
$Res call({
 String muid, String fullName, String? profilePicUrl
});




}
/// @nodoc
class __$IgPersonRefCopyWithImpl<$Res>
    implements _$IgPersonRefCopyWith<$Res> {
  __$IgPersonRefCopyWithImpl(this._self, this._then);

  final _IgPersonRef _self;
  final $Res Function(_IgPersonRef) _then;

/// Create a copy of IgPersonRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? muid = null,Object? fullName = null,Object? profilePicUrl = freezed,}) {
  return _then(_IgPersonRef(
muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,profilePicUrl: freezed == profilePicUrl ? _self.profilePicUrl : profilePicUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
