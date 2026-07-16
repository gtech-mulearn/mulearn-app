// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'karma_feed_top_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$KarmaFeedTopUser {

 String get fullName; String get muid; num get karma;
/// Create a copy of KarmaFeedTopUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KarmaFeedTopUserCopyWith<KarmaFeedTopUser> get copyWith => _$KarmaFeedTopUserCopyWithImpl<KarmaFeedTopUser>(this as KarmaFeedTopUser, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KarmaFeedTopUser&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.karma, karma) || other.karma == karma));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,muid,karma);

@override
String toString() {
  return 'KarmaFeedTopUser(fullName: $fullName, muid: $muid, karma: $karma)';
}


}

/// @nodoc
abstract mixin class $KarmaFeedTopUserCopyWith<$Res>  {
  factory $KarmaFeedTopUserCopyWith(KarmaFeedTopUser value, $Res Function(KarmaFeedTopUser) _then) = _$KarmaFeedTopUserCopyWithImpl;
@useResult
$Res call({
 String fullName, String muid, num karma
});




}
/// @nodoc
class _$KarmaFeedTopUserCopyWithImpl<$Res>
    implements $KarmaFeedTopUserCopyWith<$Res> {
  _$KarmaFeedTopUserCopyWithImpl(this._self, this._then);

  final KarmaFeedTopUser _self;
  final $Res Function(KarmaFeedTopUser) _then;

/// Create a copy of KarmaFeedTopUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? muid = null,Object? karma = null,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [KarmaFeedTopUser].
extension KarmaFeedTopUserPatterns on KarmaFeedTopUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KarmaFeedTopUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KarmaFeedTopUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KarmaFeedTopUser value)  $default,){
final _that = this;
switch (_that) {
case _KarmaFeedTopUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KarmaFeedTopUser value)?  $default,){
final _that = this;
switch (_that) {
case _KarmaFeedTopUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fullName,  String muid,  num karma)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KarmaFeedTopUser() when $default != null:
return $default(_that.fullName,_that.muid,_that.karma);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fullName,  String muid,  num karma)  $default,) {final _that = this;
switch (_that) {
case _KarmaFeedTopUser():
return $default(_that.fullName,_that.muid,_that.karma);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fullName,  String muid,  num karma)?  $default,) {final _that = this;
switch (_that) {
case _KarmaFeedTopUser() when $default != null:
return $default(_that.fullName,_that.muid,_that.karma);case _:
  return null;

}
}

}

/// @nodoc


class _KarmaFeedTopUser implements KarmaFeedTopUser {
  const _KarmaFeedTopUser({required this.fullName, required this.muid, required this.karma});
  

@override final  String fullName;
@override final  String muid;
@override final  num karma;

/// Create a copy of KarmaFeedTopUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KarmaFeedTopUserCopyWith<_KarmaFeedTopUser> get copyWith => __$KarmaFeedTopUserCopyWithImpl<_KarmaFeedTopUser>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KarmaFeedTopUser&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.karma, karma) || other.karma == karma));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,muid,karma);

@override
String toString() {
  return 'KarmaFeedTopUser(fullName: $fullName, muid: $muid, karma: $karma)';
}


}

/// @nodoc
abstract mixin class _$KarmaFeedTopUserCopyWith<$Res> implements $KarmaFeedTopUserCopyWith<$Res> {
  factory _$KarmaFeedTopUserCopyWith(_KarmaFeedTopUser value, $Res Function(_KarmaFeedTopUser) _then) = __$KarmaFeedTopUserCopyWithImpl;
@override @useResult
$Res call({
 String fullName, String muid, num karma
});




}
/// @nodoc
class __$KarmaFeedTopUserCopyWithImpl<$Res>
    implements _$KarmaFeedTopUserCopyWith<$Res> {
  __$KarmaFeedTopUserCopyWithImpl(this._self, this._then);

  final _KarmaFeedTopUser _self;
  final $Res Function(_KarmaFeedTopUser) _then;

/// Create a copy of KarmaFeedTopUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? muid = null,Object? karma = null,}) {
  return _then(_KarmaFeedTopUser(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on
