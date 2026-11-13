// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_participant_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SessionParticipantDto {

 String get id; String get userId; String get userFullName; String get muId; String get participantRole; String? get attendanceStatus; String? get progressNote; String? get feedback; int? get contributedMinutes;
/// Create a copy of SessionParticipantDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionParticipantDtoCopyWith<SessionParticipantDto> get copyWith => _$SessionParticipantDtoCopyWithImpl<SessionParticipantDto>(this as SessionParticipantDto, _$identity);

  /// Serializes this SessionParticipantDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionParticipantDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userFullName, userFullName) || other.userFullName == userFullName)&&(identical(other.muId, muId) || other.muId == muId)&&(identical(other.participantRole, participantRole) || other.participantRole == participantRole)&&(identical(other.attendanceStatus, attendanceStatus) || other.attendanceStatus == attendanceStatus)&&(identical(other.progressNote, progressNote) || other.progressNote == progressNote)&&(identical(other.feedback, feedback) || other.feedback == feedback)&&(identical(other.contributedMinutes, contributedMinutes) || other.contributedMinutes == contributedMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,userFullName,muId,participantRole,attendanceStatus,progressNote,feedback,contributedMinutes);

@override
String toString() {
  return 'SessionParticipantDto(id: $id, userId: $userId, userFullName: $userFullName, muId: $muId, participantRole: $participantRole, attendanceStatus: $attendanceStatus, progressNote: $progressNote, feedback: $feedback, contributedMinutes: $contributedMinutes)';
}


}

/// @nodoc
abstract mixin class $SessionParticipantDtoCopyWith<$Res>  {
  factory $SessionParticipantDtoCopyWith(SessionParticipantDto value, $Res Function(SessionParticipantDto) _then) = _$SessionParticipantDtoCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String userFullName, String muId, String participantRole, String? attendanceStatus, String? progressNote, String? feedback, int? contributedMinutes
});




}
/// @nodoc
class _$SessionParticipantDtoCopyWithImpl<$Res>
    implements $SessionParticipantDtoCopyWith<$Res> {
  _$SessionParticipantDtoCopyWithImpl(this._self, this._then);

  final SessionParticipantDto _self;
  final $Res Function(SessionParticipantDto) _then;

/// Create a copy of SessionParticipantDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? userFullName = null,Object? muId = null,Object? participantRole = null,Object? attendanceStatus = freezed,Object? progressNote = freezed,Object? feedback = freezed,Object? contributedMinutes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userFullName: null == userFullName ? _self.userFullName : userFullName // ignore: cast_nullable_to_non_nullable
as String,muId: null == muId ? _self.muId : muId // ignore: cast_nullable_to_non_nullable
as String,participantRole: null == participantRole ? _self.participantRole : participantRole // ignore: cast_nullable_to_non_nullable
as String,attendanceStatus: freezed == attendanceStatus ? _self.attendanceStatus : attendanceStatus // ignore: cast_nullable_to_non_nullable
as String?,progressNote: freezed == progressNote ? _self.progressNote : progressNote // ignore: cast_nullable_to_non_nullable
as String?,feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as String?,contributedMinutes: freezed == contributedMinutes ? _self.contributedMinutes : contributedMinutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionParticipantDto].
extension SessionParticipantDtoPatterns on SessionParticipantDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionParticipantDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionParticipantDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionParticipantDto value)  $default,){
final _that = this;
switch (_that) {
case _SessionParticipantDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionParticipantDto value)?  $default,){
final _that = this;
switch (_that) {
case _SessionParticipantDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String userFullName,  String muId,  String participantRole,  String? attendanceStatus,  String? progressNote,  String? feedback,  int? contributedMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionParticipantDto() when $default != null:
return $default(_that.id,_that.userId,_that.userFullName,_that.muId,_that.participantRole,_that.attendanceStatus,_that.progressNote,_that.feedback,_that.contributedMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String userFullName,  String muId,  String participantRole,  String? attendanceStatus,  String? progressNote,  String? feedback,  int? contributedMinutes)  $default,) {final _that = this;
switch (_that) {
case _SessionParticipantDto():
return $default(_that.id,_that.userId,_that.userFullName,_that.muId,_that.participantRole,_that.attendanceStatus,_that.progressNote,_that.feedback,_that.contributedMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String userFullName,  String muId,  String participantRole,  String? attendanceStatus,  String? progressNote,  String? feedback,  int? contributedMinutes)?  $default,) {final _that = this;
switch (_that) {
case _SessionParticipantDto() when $default != null:
return $default(_that.id,_that.userId,_that.userFullName,_that.muId,_that.participantRole,_that.attendanceStatus,_that.progressNote,_that.feedback,_that.contributedMinutes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionParticipantDto extends SessionParticipantDto {
  const _SessionParticipantDto({required this.id, this.userId = '', this.userFullName = '', this.muId = '', this.participantRole = '', this.attendanceStatus, this.progressNote, this.feedback, this.contributedMinutes}): super._();
  factory _SessionParticipantDto.fromJson(Map<String, dynamic> json) => _$SessionParticipantDtoFromJson(json);

@override final  String id;
@override@JsonKey() final  String userId;
@override@JsonKey() final  String userFullName;
@override@JsonKey() final  String muId;
@override@JsonKey() final  String participantRole;
@override final  String? attendanceStatus;
@override final  String? progressNote;
@override final  String? feedback;
@override final  int? contributedMinutes;

/// Create a copy of SessionParticipantDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionParticipantDtoCopyWith<_SessionParticipantDto> get copyWith => __$SessionParticipantDtoCopyWithImpl<_SessionParticipantDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionParticipantDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionParticipantDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userFullName, userFullName) || other.userFullName == userFullName)&&(identical(other.muId, muId) || other.muId == muId)&&(identical(other.participantRole, participantRole) || other.participantRole == participantRole)&&(identical(other.attendanceStatus, attendanceStatus) || other.attendanceStatus == attendanceStatus)&&(identical(other.progressNote, progressNote) || other.progressNote == progressNote)&&(identical(other.feedback, feedback) || other.feedback == feedback)&&(identical(other.contributedMinutes, contributedMinutes) || other.contributedMinutes == contributedMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,userFullName,muId,participantRole,attendanceStatus,progressNote,feedback,contributedMinutes);

@override
String toString() {
  return 'SessionParticipantDto(id: $id, userId: $userId, userFullName: $userFullName, muId: $muId, participantRole: $participantRole, attendanceStatus: $attendanceStatus, progressNote: $progressNote, feedback: $feedback, contributedMinutes: $contributedMinutes)';
}


}

/// @nodoc
abstract mixin class _$SessionParticipantDtoCopyWith<$Res> implements $SessionParticipantDtoCopyWith<$Res> {
  factory _$SessionParticipantDtoCopyWith(_SessionParticipantDto value, $Res Function(_SessionParticipantDto) _then) = __$SessionParticipantDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String userFullName, String muId, String participantRole, String? attendanceStatus, String? progressNote, String? feedback, int? contributedMinutes
});




}
/// @nodoc
class __$SessionParticipantDtoCopyWithImpl<$Res>
    implements _$SessionParticipantDtoCopyWith<$Res> {
  __$SessionParticipantDtoCopyWithImpl(this._self, this._then);

  final _SessionParticipantDto _self;
  final $Res Function(_SessionParticipantDto) _then;

/// Create a copy of SessionParticipantDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? userFullName = null,Object? muId = null,Object? participantRole = null,Object? attendanceStatus = freezed,Object? progressNote = freezed,Object? feedback = freezed,Object? contributedMinutes = freezed,}) {
  return _then(_SessionParticipantDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userFullName: null == userFullName ? _self.userFullName : userFullName // ignore: cast_nullable_to_non_nullable
as String,muId: null == muId ? _self.muId : muId // ignore: cast_nullable_to_non_nullable
as String,participantRole: null == participantRole ? _self.participantRole : participantRole // ignore: cast_nullable_to_non_nullable
as String,attendanceStatus: freezed == attendanceStatus ? _self.attendanceStatus : attendanceStatus // ignore: cast_nullable_to_non_nullable
as String?,progressNote: freezed == progressNote ? _self.progressNote : progressNote // ignore: cast_nullable_to_non_nullable
as String?,feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as String?,contributedMinutes: freezed == contributedMinutes ? _self.contributedMinutes : contributedMinutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
