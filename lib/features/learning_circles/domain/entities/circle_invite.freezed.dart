// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'circle_invite.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CircleInvite {

 String get linkId; String get fullName; String get muid; String get status; String? get userId; String? get profilePicUrl; String? get invitedAt; String? get circleId; String? get circleTitle; bool get isLeadInvite;
/// Create a copy of CircleInvite
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CircleInviteCopyWith<CircleInvite> get copyWith => _$CircleInviteCopyWithImpl<CircleInvite>(this as CircleInvite, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CircleInvite&&(identical(other.linkId, linkId) || other.linkId == linkId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.status, status) || other.status == status)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.profilePicUrl, profilePicUrl) || other.profilePicUrl == profilePicUrl)&&(identical(other.invitedAt, invitedAt) || other.invitedAt == invitedAt)&&(identical(other.circleId, circleId) || other.circleId == circleId)&&(identical(other.circleTitle, circleTitle) || other.circleTitle == circleTitle)&&(identical(other.isLeadInvite, isLeadInvite) || other.isLeadInvite == isLeadInvite));
}


@override
int get hashCode => Object.hash(runtimeType,linkId,fullName,muid,status,userId,profilePicUrl,invitedAt,circleId,circleTitle,isLeadInvite);

@override
String toString() {
  return 'CircleInvite(linkId: $linkId, fullName: $fullName, muid: $muid, status: $status, userId: $userId, profilePicUrl: $profilePicUrl, invitedAt: $invitedAt, circleId: $circleId, circleTitle: $circleTitle, isLeadInvite: $isLeadInvite)';
}


}

/// @nodoc
abstract mixin class $CircleInviteCopyWith<$Res>  {
  factory $CircleInviteCopyWith(CircleInvite value, $Res Function(CircleInvite) _then) = _$CircleInviteCopyWithImpl;
@useResult
$Res call({
 String linkId, String fullName, String muid, String status, String? userId, String? profilePicUrl, String? invitedAt, String? circleId, String? circleTitle, bool isLeadInvite
});




}
/// @nodoc
class _$CircleInviteCopyWithImpl<$Res>
    implements $CircleInviteCopyWith<$Res> {
  _$CircleInviteCopyWithImpl(this._self, this._then);

  final CircleInvite _self;
  final $Res Function(CircleInvite) _then;

/// Create a copy of CircleInvite
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? linkId = null,Object? fullName = null,Object? muid = null,Object? status = null,Object? userId = freezed,Object? profilePicUrl = freezed,Object? invitedAt = freezed,Object? circleId = freezed,Object? circleTitle = freezed,Object? isLeadInvite = null,}) {
  return _then(_self.copyWith(
linkId: null == linkId ? _self.linkId : linkId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,profilePicUrl: freezed == profilePicUrl ? _self.profilePicUrl : profilePicUrl // ignore: cast_nullable_to_non_nullable
as String?,invitedAt: freezed == invitedAt ? _self.invitedAt : invitedAt // ignore: cast_nullable_to_non_nullable
as String?,circleId: freezed == circleId ? _self.circleId : circleId // ignore: cast_nullable_to_non_nullable
as String?,circleTitle: freezed == circleTitle ? _self.circleTitle : circleTitle // ignore: cast_nullable_to_non_nullable
as String?,isLeadInvite: null == isLeadInvite ? _self.isLeadInvite : isLeadInvite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CircleInvite].
extension CircleInvitePatterns on CircleInvite {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CircleInvite value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CircleInvite() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CircleInvite value)  $default,){
final _that = this;
switch (_that) {
case _CircleInvite():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CircleInvite value)?  $default,){
final _that = this;
switch (_that) {
case _CircleInvite() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String linkId,  String fullName,  String muid,  String status,  String? userId,  String? profilePicUrl,  String? invitedAt,  String? circleId,  String? circleTitle,  bool isLeadInvite)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CircleInvite() when $default != null:
return $default(_that.linkId,_that.fullName,_that.muid,_that.status,_that.userId,_that.profilePicUrl,_that.invitedAt,_that.circleId,_that.circleTitle,_that.isLeadInvite);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String linkId,  String fullName,  String muid,  String status,  String? userId,  String? profilePicUrl,  String? invitedAt,  String? circleId,  String? circleTitle,  bool isLeadInvite)  $default,) {final _that = this;
switch (_that) {
case _CircleInvite():
return $default(_that.linkId,_that.fullName,_that.muid,_that.status,_that.userId,_that.profilePicUrl,_that.invitedAt,_that.circleId,_that.circleTitle,_that.isLeadInvite);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String linkId,  String fullName,  String muid,  String status,  String? userId,  String? profilePicUrl,  String? invitedAt,  String? circleId,  String? circleTitle,  bool isLeadInvite)?  $default,) {final _that = this;
switch (_that) {
case _CircleInvite() when $default != null:
return $default(_that.linkId,_that.fullName,_that.muid,_that.status,_that.userId,_that.profilePicUrl,_that.invitedAt,_that.circleId,_that.circleTitle,_that.isLeadInvite);case _:
  return null;

}
}

}

/// @nodoc


class _CircleInvite implements CircleInvite {
  const _CircleInvite({required this.linkId, required this.fullName, required this.muid, required this.status, this.userId, this.profilePicUrl, this.invitedAt, this.circleId, this.circleTitle, this.isLeadInvite = false});
  

@override final  String linkId;
@override final  String fullName;
@override final  String muid;
@override final  String status;
@override final  String? userId;
@override final  String? profilePicUrl;
@override final  String? invitedAt;
@override final  String? circleId;
@override final  String? circleTitle;
@override@JsonKey() final  bool isLeadInvite;

/// Create a copy of CircleInvite
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CircleInviteCopyWith<_CircleInvite> get copyWith => __$CircleInviteCopyWithImpl<_CircleInvite>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CircleInvite&&(identical(other.linkId, linkId) || other.linkId == linkId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.status, status) || other.status == status)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.profilePicUrl, profilePicUrl) || other.profilePicUrl == profilePicUrl)&&(identical(other.invitedAt, invitedAt) || other.invitedAt == invitedAt)&&(identical(other.circleId, circleId) || other.circleId == circleId)&&(identical(other.circleTitle, circleTitle) || other.circleTitle == circleTitle)&&(identical(other.isLeadInvite, isLeadInvite) || other.isLeadInvite == isLeadInvite));
}


@override
int get hashCode => Object.hash(runtimeType,linkId,fullName,muid,status,userId,profilePicUrl,invitedAt,circleId,circleTitle,isLeadInvite);

@override
String toString() {
  return 'CircleInvite(linkId: $linkId, fullName: $fullName, muid: $muid, status: $status, userId: $userId, profilePicUrl: $profilePicUrl, invitedAt: $invitedAt, circleId: $circleId, circleTitle: $circleTitle, isLeadInvite: $isLeadInvite)';
}


}

/// @nodoc
abstract mixin class _$CircleInviteCopyWith<$Res> implements $CircleInviteCopyWith<$Res> {
  factory _$CircleInviteCopyWith(_CircleInvite value, $Res Function(_CircleInvite) _then) = __$CircleInviteCopyWithImpl;
@override @useResult
$Res call({
 String linkId, String fullName, String muid, String status, String? userId, String? profilePicUrl, String? invitedAt, String? circleId, String? circleTitle, bool isLeadInvite
});




}
/// @nodoc
class __$CircleInviteCopyWithImpl<$Res>
    implements _$CircleInviteCopyWith<$Res> {
  __$CircleInviteCopyWithImpl(this._self, this._then);

  final _CircleInvite _self;
  final $Res Function(_CircleInvite) _then;

/// Create a copy of CircleInvite
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? linkId = null,Object? fullName = null,Object? muid = null,Object? status = null,Object? userId = freezed,Object? profilePicUrl = freezed,Object? invitedAt = freezed,Object? circleId = freezed,Object? circleTitle = freezed,Object? isLeadInvite = null,}) {
  return _then(_CircleInvite(
linkId: null == linkId ? _self.linkId : linkId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,profilePicUrl: freezed == profilePicUrl ? _self.profilePicUrl : profilePicUrl // ignore: cast_nullable_to_non_nullable
as String?,invitedAt: freezed == invitedAt ? _self.invitedAt : invitedAt // ignore: cast_nullable_to_non_nullable
as String?,circleId: freezed == circleId ? _self.circleId : circleId // ignore: cast_nullable_to_non_nullable
as String?,circleTitle: freezed == circleTitle ? _self.circleTitle : circleTitle // ignore: cast_nullable_to_non_nullable
as String?,isLeadInvite: null == isLeadInvite ? _self.isLeadInvite : isLeadInvite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
