// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'join_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JoinRequest {

 String get linkId; String get userId; String get fullName; String get muid; String? get profilePicUrl; String? get requestedAt;
/// Create a copy of JoinRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JoinRequestCopyWith<JoinRequest> get copyWith => _$JoinRequestCopyWithImpl<JoinRequest>(this as JoinRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinRequest&&(identical(other.linkId, linkId) || other.linkId == linkId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.profilePicUrl, profilePicUrl) || other.profilePicUrl == profilePicUrl)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt));
}


@override
int get hashCode => Object.hash(runtimeType,linkId,userId,fullName,muid,profilePicUrl,requestedAt);

@override
String toString() {
  return 'JoinRequest(linkId: $linkId, userId: $userId, fullName: $fullName, muid: $muid, profilePicUrl: $profilePicUrl, requestedAt: $requestedAt)';
}


}

/// @nodoc
abstract mixin class $JoinRequestCopyWith<$Res>  {
  factory $JoinRequestCopyWith(JoinRequest value, $Res Function(JoinRequest) _then) = _$JoinRequestCopyWithImpl;
@useResult
$Res call({
 String linkId, String userId, String fullName, String muid, String? profilePicUrl, String? requestedAt
});




}
/// @nodoc
class _$JoinRequestCopyWithImpl<$Res>
    implements $JoinRequestCopyWith<$Res> {
  _$JoinRequestCopyWithImpl(this._self, this._then);

  final JoinRequest _self;
  final $Res Function(JoinRequest) _then;

/// Create a copy of JoinRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? linkId = null,Object? userId = null,Object? fullName = null,Object? muid = null,Object? profilePicUrl = freezed,Object? requestedAt = freezed,}) {
  return _then(_self.copyWith(
linkId: null == linkId ? _self.linkId : linkId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,profilePicUrl: freezed == profilePicUrl ? _self.profilePicUrl : profilePicUrl // ignore: cast_nullable_to_non_nullable
as String?,requestedAt: freezed == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [JoinRequest].
extension JoinRequestPatterns on JoinRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JoinRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JoinRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JoinRequest value)  $default,){
final _that = this;
switch (_that) {
case _JoinRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JoinRequest value)?  $default,){
final _that = this;
switch (_that) {
case _JoinRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String linkId,  String userId,  String fullName,  String muid,  String? profilePicUrl,  String? requestedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JoinRequest() when $default != null:
return $default(_that.linkId,_that.userId,_that.fullName,_that.muid,_that.profilePicUrl,_that.requestedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String linkId,  String userId,  String fullName,  String muid,  String? profilePicUrl,  String? requestedAt)  $default,) {final _that = this;
switch (_that) {
case _JoinRequest():
return $default(_that.linkId,_that.userId,_that.fullName,_that.muid,_that.profilePicUrl,_that.requestedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String linkId,  String userId,  String fullName,  String muid,  String? profilePicUrl,  String? requestedAt)?  $default,) {final _that = this;
switch (_that) {
case _JoinRequest() when $default != null:
return $default(_that.linkId,_that.userId,_that.fullName,_that.muid,_that.profilePicUrl,_that.requestedAt);case _:
  return null;

}
}

}

/// @nodoc


class _JoinRequest implements JoinRequest {
  const _JoinRequest({required this.linkId, required this.userId, required this.fullName, required this.muid, this.profilePicUrl, this.requestedAt});
  

@override final  String linkId;
@override final  String userId;
@override final  String fullName;
@override final  String muid;
@override final  String? profilePicUrl;
@override final  String? requestedAt;

/// Create a copy of JoinRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JoinRequestCopyWith<_JoinRequest> get copyWith => __$JoinRequestCopyWithImpl<_JoinRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JoinRequest&&(identical(other.linkId, linkId) || other.linkId == linkId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.profilePicUrl, profilePicUrl) || other.profilePicUrl == profilePicUrl)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt));
}


@override
int get hashCode => Object.hash(runtimeType,linkId,userId,fullName,muid,profilePicUrl,requestedAt);

@override
String toString() {
  return 'JoinRequest(linkId: $linkId, userId: $userId, fullName: $fullName, muid: $muid, profilePicUrl: $profilePicUrl, requestedAt: $requestedAt)';
}


}

/// @nodoc
abstract mixin class _$JoinRequestCopyWith<$Res> implements $JoinRequestCopyWith<$Res> {
  factory _$JoinRequestCopyWith(_JoinRequest value, $Res Function(_JoinRequest) _then) = __$JoinRequestCopyWithImpl;
@override @useResult
$Res call({
 String linkId, String userId, String fullName, String muid, String? profilePicUrl, String? requestedAt
});




}
/// @nodoc
class __$JoinRequestCopyWithImpl<$Res>
    implements _$JoinRequestCopyWith<$Res> {
  __$JoinRequestCopyWithImpl(this._self, this._then);

  final _JoinRequest _self;
  final $Res Function(_JoinRequest) _then;

/// Create a copy of JoinRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? linkId = null,Object? userId = null,Object? fullName = null,Object? muid = null,Object? profilePicUrl = freezed,Object? requestedAt = freezed,}) {
  return _then(_JoinRequest(
linkId: null == linkId ? _self.linkId : linkId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,profilePicUrl: freezed == profilePicUrl ? _self.profilePicUrl : profilePicUrl // ignore: cast_nullable_to_non_nullable
as String?,requestedAt: freezed == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
