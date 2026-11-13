// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_participant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionParticipant {

 String get linkId; String get userId; String get fullName; String get muid; String get role; AttendanceStatus get attendance; String? get progressNote; String? get feedback; int? get contributedMinutes;
/// Create a copy of SessionParticipant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionParticipantCopyWith<SessionParticipant> get copyWith => _$SessionParticipantCopyWithImpl<SessionParticipant>(this as SessionParticipant, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionParticipant&&(identical(other.linkId, linkId) || other.linkId == linkId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.role, role) || other.role == role)&&(identical(other.attendance, attendance) || other.attendance == attendance)&&(identical(other.progressNote, progressNote) || other.progressNote == progressNote)&&(identical(other.feedback, feedback) || other.feedback == feedback)&&(identical(other.contributedMinutes, contributedMinutes) || other.contributedMinutes == contributedMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,linkId,userId,fullName,muid,role,attendance,progressNote,feedback,contributedMinutes);

@override
String toString() {
  return 'SessionParticipant(linkId: $linkId, userId: $userId, fullName: $fullName, muid: $muid, role: $role, attendance: $attendance, progressNote: $progressNote, feedback: $feedback, contributedMinutes: $contributedMinutes)';
}


}

/// @nodoc
abstract mixin class $SessionParticipantCopyWith<$Res>  {
  factory $SessionParticipantCopyWith(SessionParticipant value, $Res Function(SessionParticipant) _then) = _$SessionParticipantCopyWithImpl;
@useResult
$Res call({
 String linkId, String userId, String fullName, String muid, String role, AttendanceStatus attendance, String? progressNote, String? feedback, int? contributedMinutes
});




}
/// @nodoc
class _$SessionParticipantCopyWithImpl<$Res>
    implements $SessionParticipantCopyWith<$Res> {
  _$SessionParticipantCopyWithImpl(this._self, this._then);

  final SessionParticipant _self;
  final $Res Function(SessionParticipant) _then;

/// Create a copy of SessionParticipant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? linkId = null,Object? userId = null,Object? fullName = null,Object? muid = null,Object? role = null,Object? attendance = null,Object? progressNote = freezed,Object? feedback = freezed,Object? contributedMinutes = freezed,}) {
  return _then(_self.copyWith(
linkId: null == linkId ? _self.linkId : linkId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,attendance: null == attendance ? _self.attendance : attendance // ignore: cast_nullable_to_non_nullable
as AttendanceStatus,progressNote: freezed == progressNote ? _self.progressNote : progressNote // ignore: cast_nullable_to_non_nullable
as String?,feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as String?,contributedMinutes: freezed == contributedMinutes ? _self.contributedMinutes : contributedMinutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionParticipant].
extension SessionParticipantPatterns on SessionParticipant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionParticipant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionParticipant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionParticipant value)  $default,){
final _that = this;
switch (_that) {
case _SessionParticipant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionParticipant value)?  $default,){
final _that = this;
switch (_that) {
case _SessionParticipant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String linkId,  String userId,  String fullName,  String muid,  String role,  AttendanceStatus attendance,  String? progressNote,  String? feedback,  int? contributedMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionParticipant() when $default != null:
return $default(_that.linkId,_that.userId,_that.fullName,_that.muid,_that.role,_that.attendance,_that.progressNote,_that.feedback,_that.contributedMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String linkId,  String userId,  String fullName,  String muid,  String role,  AttendanceStatus attendance,  String? progressNote,  String? feedback,  int? contributedMinutes)  $default,) {final _that = this;
switch (_that) {
case _SessionParticipant():
return $default(_that.linkId,_that.userId,_that.fullName,_that.muid,_that.role,_that.attendance,_that.progressNote,_that.feedback,_that.contributedMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String linkId,  String userId,  String fullName,  String muid,  String role,  AttendanceStatus attendance,  String? progressNote,  String? feedback,  int? contributedMinutes)?  $default,) {final _that = this;
switch (_that) {
case _SessionParticipant() when $default != null:
return $default(_that.linkId,_that.userId,_that.fullName,_that.muid,_that.role,_that.attendance,_that.progressNote,_that.feedback,_that.contributedMinutes);case _:
  return null;

}
}

}

/// @nodoc


class _SessionParticipant implements SessionParticipant {
  const _SessionParticipant({required this.linkId, required this.userId, required this.fullName, required this.muid, required this.role, required this.attendance, this.progressNote, this.feedback, this.contributedMinutes});
  

@override final  String linkId;
@override final  String userId;
@override final  String fullName;
@override final  String muid;
@override final  String role;
@override final  AttendanceStatus attendance;
@override final  String? progressNote;
@override final  String? feedback;
@override final  int? contributedMinutes;

/// Create a copy of SessionParticipant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionParticipantCopyWith<_SessionParticipant> get copyWith => __$SessionParticipantCopyWithImpl<_SessionParticipant>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionParticipant&&(identical(other.linkId, linkId) || other.linkId == linkId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.role, role) || other.role == role)&&(identical(other.attendance, attendance) || other.attendance == attendance)&&(identical(other.progressNote, progressNote) || other.progressNote == progressNote)&&(identical(other.feedback, feedback) || other.feedback == feedback)&&(identical(other.contributedMinutes, contributedMinutes) || other.contributedMinutes == contributedMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,linkId,userId,fullName,muid,role,attendance,progressNote,feedback,contributedMinutes);

@override
String toString() {
  return 'SessionParticipant(linkId: $linkId, userId: $userId, fullName: $fullName, muid: $muid, role: $role, attendance: $attendance, progressNote: $progressNote, feedback: $feedback, contributedMinutes: $contributedMinutes)';
}


}

/// @nodoc
abstract mixin class _$SessionParticipantCopyWith<$Res> implements $SessionParticipantCopyWith<$Res> {
  factory _$SessionParticipantCopyWith(_SessionParticipant value, $Res Function(_SessionParticipant) _then) = __$SessionParticipantCopyWithImpl;
@override @useResult
$Res call({
 String linkId, String userId, String fullName, String muid, String role, AttendanceStatus attendance, String? progressNote, String? feedback, int? contributedMinutes
});




}
/// @nodoc
class __$SessionParticipantCopyWithImpl<$Res>
    implements _$SessionParticipantCopyWith<$Res> {
  __$SessionParticipantCopyWithImpl(this._self, this._then);

  final _SessionParticipant _self;
  final $Res Function(_SessionParticipant) _then;

/// Create a copy of SessionParticipant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? linkId = null,Object? userId = null,Object? fullName = null,Object? muid = null,Object? role = null,Object? attendance = null,Object? progressNote = freezed,Object? feedback = freezed,Object? contributedMinutes = freezed,}) {
  return _then(_SessionParticipant(
linkId: null == linkId ? _self.linkId : linkId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,attendance: null == attendance ? _self.attendance : attendance // ignore: cast_nullable_to_non_nullable
as AttendanceStatus,progressNote: freezed == progressNote ? _self.progressNote : progressNote // ignore: cast_nullable_to_non_nullable
as String?,feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as String?,contributedMinutes: freezed == contributedMinutes ? _self.contributedMinutes : contributedMinutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
