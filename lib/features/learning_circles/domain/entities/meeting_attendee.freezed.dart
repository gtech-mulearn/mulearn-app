// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meeting_attendee.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MeetingAttendee {

 String get userId; String get fullName; bool get isJoined; bool get isReportSubmitted; String? get profilePicUrl; bool? get isSameOrg;
/// Create a copy of MeetingAttendee
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingAttendeeCopyWith<MeetingAttendee> get copyWith => _$MeetingAttendeeCopyWithImpl<MeetingAttendee>(this as MeetingAttendee, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeetingAttendee&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.isJoined, isJoined) || other.isJoined == isJoined)&&(identical(other.isReportSubmitted, isReportSubmitted) || other.isReportSubmitted == isReportSubmitted)&&(identical(other.profilePicUrl, profilePicUrl) || other.profilePicUrl == profilePicUrl)&&(identical(other.isSameOrg, isSameOrg) || other.isSameOrg == isSameOrg));
}


@override
int get hashCode => Object.hash(runtimeType,userId,fullName,isJoined,isReportSubmitted,profilePicUrl,isSameOrg);

@override
String toString() {
  return 'MeetingAttendee(userId: $userId, fullName: $fullName, isJoined: $isJoined, isReportSubmitted: $isReportSubmitted, profilePicUrl: $profilePicUrl, isSameOrg: $isSameOrg)';
}


}

/// @nodoc
abstract mixin class $MeetingAttendeeCopyWith<$Res>  {
  factory $MeetingAttendeeCopyWith(MeetingAttendee value, $Res Function(MeetingAttendee) _then) = _$MeetingAttendeeCopyWithImpl;
@useResult
$Res call({
 String userId, String fullName, bool isJoined, bool isReportSubmitted, String? profilePicUrl, bool? isSameOrg
});




}
/// @nodoc
class _$MeetingAttendeeCopyWithImpl<$Res>
    implements $MeetingAttendeeCopyWith<$Res> {
  _$MeetingAttendeeCopyWithImpl(this._self, this._then);

  final MeetingAttendee _self;
  final $Res Function(MeetingAttendee) _then;

/// Create a copy of MeetingAttendee
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? fullName = null,Object? isJoined = null,Object? isReportSubmitted = null,Object? profilePicUrl = freezed,Object? isSameOrg = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,isJoined: null == isJoined ? _self.isJoined : isJoined // ignore: cast_nullable_to_non_nullable
as bool,isReportSubmitted: null == isReportSubmitted ? _self.isReportSubmitted : isReportSubmitted // ignore: cast_nullable_to_non_nullable
as bool,profilePicUrl: freezed == profilePicUrl ? _self.profilePicUrl : profilePicUrl // ignore: cast_nullable_to_non_nullable
as String?,isSameOrg: freezed == isSameOrg ? _self.isSameOrg : isSameOrg // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [MeetingAttendee].
extension MeetingAttendeePatterns on MeetingAttendee {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeetingAttendee value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeetingAttendee() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeetingAttendee value)  $default,){
final _that = this;
switch (_that) {
case _MeetingAttendee():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeetingAttendee value)?  $default,){
final _that = this;
switch (_that) {
case _MeetingAttendee() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String fullName,  bool isJoined,  bool isReportSubmitted,  String? profilePicUrl,  bool? isSameOrg)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeetingAttendee() when $default != null:
return $default(_that.userId,_that.fullName,_that.isJoined,_that.isReportSubmitted,_that.profilePicUrl,_that.isSameOrg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String fullName,  bool isJoined,  bool isReportSubmitted,  String? profilePicUrl,  bool? isSameOrg)  $default,) {final _that = this;
switch (_that) {
case _MeetingAttendee():
return $default(_that.userId,_that.fullName,_that.isJoined,_that.isReportSubmitted,_that.profilePicUrl,_that.isSameOrg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String fullName,  bool isJoined,  bool isReportSubmitted,  String? profilePicUrl,  bool? isSameOrg)?  $default,) {final _that = this;
switch (_that) {
case _MeetingAttendee() when $default != null:
return $default(_that.userId,_that.fullName,_that.isJoined,_that.isReportSubmitted,_that.profilePicUrl,_that.isSameOrg);case _:
  return null;

}
}

}

/// @nodoc


class _MeetingAttendee implements MeetingAttendee {
  const _MeetingAttendee({required this.userId, required this.fullName, required this.isJoined, required this.isReportSubmitted, this.profilePicUrl, this.isSameOrg});
  

@override final  String userId;
@override final  String fullName;
@override final  bool isJoined;
@override final  bool isReportSubmitted;
@override final  String? profilePicUrl;
@override final  bool? isSameOrg;

/// Create a copy of MeetingAttendee
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingAttendeeCopyWith<_MeetingAttendee> get copyWith => __$MeetingAttendeeCopyWithImpl<_MeetingAttendee>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeetingAttendee&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.isJoined, isJoined) || other.isJoined == isJoined)&&(identical(other.isReportSubmitted, isReportSubmitted) || other.isReportSubmitted == isReportSubmitted)&&(identical(other.profilePicUrl, profilePicUrl) || other.profilePicUrl == profilePicUrl)&&(identical(other.isSameOrg, isSameOrg) || other.isSameOrg == isSameOrg));
}


@override
int get hashCode => Object.hash(runtimeType,userId,fullName,isJoined,isReportSubmitted,profilePicUrl,isSameOrg);

@override
String toString() {
  return 'MeetingAttendee(userId: $userId, fullName: $fullName, isJoined: $isJoined, isReportSubmitted: $isReportSubmitted, profilePicUrl: $profilePicUrl, isSameOrg: $isSameOrg)';
}


}

/// @nodoc
abstract mixin class _$MeetingAttendeeCopyWith<$Res> implements $MeetingAttendeeCopyWith<$Res> {
  factory _$MeetingAttendeeCopyWith(_MeetingAttendee value, $Res Function(_MeetingAttendee) _then) = __$MeetingAttendeeCopyWithImpl;
@override @useResult
$Res call({
 String userId, String fullName, bool isJoined, bool isReportSubmitted, String? profilePicUrl, bool? isSameOrg
});




}
/// @nodoc
class __$MeetingAttendeeCopyWithImpl<$Res>
    implements _$MeetingAttendeeCopyWith<$Res> {
  __$MeetingAttendeeCopyWithImpl(this._self, this._then);

  final _MeetingAttendee _self;
  final $Res Function(_MeetingAttendee) _then;

/// Create a copy of MeetingAttendee
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? fullName = null,Object? isJoined = null,Object? isReportSubmitted = null,Object? profilePicUrl = freezed,Object? isSameOrg = freezed,}) {
  return _then(_MeetingAttendee(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,isJoined: null == isJoined ? _self.isJoined : isJoined // ignore: cast_nullable_to_non_nullable
as bool,isReportSubmitted: null == isReportSubmitted ? _self.isReportSubmitted : isReportSubmitted // ignore: cast_nullable_to_non_nullable
as bool,profilePicUrl: freezed == profilePicUrl ? _self.profilePicUrl : profilePicUrl // ignore: cast_nullable_to_non_nullable
as String?,isSameOrg: freezed == isSameOrg ? _self.isSameOrg : isSameOrg // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
