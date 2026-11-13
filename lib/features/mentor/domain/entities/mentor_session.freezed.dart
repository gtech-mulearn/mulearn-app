// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mentor_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MentorSession {

 String get id; String get entityId; String get entityName; SessionType get type; String get title; String get description; SessionMode get mode; DateTime get startsAt; DateTime get endsAt; SessionStatus get status; bool get isRecurring; int? get maxParticipants; String? get meetingLink; String? get venue;
/// Create a copy of MentorSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MentorSessionCopyWith<MentorSession> get copyWith => _$MentorSessionCopyWithImpl<MentorSession>(this as MentorSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MentorSession&&(identical(other.id, id) || other.id == id)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.entityName, entityName) || other.entityName == entityName)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.maxParticipants, maxParticipants) || other.maxParticipants == maxParticipants)&&(identical(other.meetingLink, meetingLink) || other.meetingLink == meetingLink)&&(identical(other.venue, venue) || other.venue == venue));
}


@override
int get hashCode => Object.hash(runtimeType,id,entityId,entityName,type,title,description,mode,startsAt,endsAt,status,isRecurring,maxParticipants,meetingLink,venue);

@override
String toString() {
  return 'MentorSession(id: $id, entityId: $entityId, entityName: $entityName, type: $type, title: $title, description: $description, mode: $mode, startsAt: $startsAt, endsAt: $endsAt, status: $status, isRecurring: $isRecurring, maxParticipants: $maxParticipants, meetingLink: $meetingLink, venue: $venue)';
}


}

/// @nodoc
abstract mixin class $MentorSessionCopyWith<$Res>  {
  factory $MentorSessionCopyWith(MentorSession value, $Res Function(MentorSession) _then) = _$MentorSessionCopyWithImpl;
@useResult
$Res call({
 String id, String entityId, String entityName, SessionType type, String title, String description, SessionMode mode, DateTime startsAt, DateTime endsAt, SessionStatus status, bool isRecurring, int? maxParticipants, String? meetingLink, String? venue
});




}
/// @nodoc
class _$MentorSessionCopyWithImpl<$Res>
    implements $MentorSessionCopyWith<$Res> {
  _$MentorSessionCopyWithImpl(this._self, this._then);

  final MentorSession _self;
  final $Res Function(MentorSession) _then;

/// Create a copy of MentorSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? entityId = null,Object? entityName = null,Object? type = null,Object? title = null,Object? description = null,Object? mode = null,Object? startsAt = null,Object? endsAt = null,Object? status = null,Object? isRecurring = null,Object? maxParticipants = freezed,Object? meetingLink = freezed,Object? venue = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,entityName: null == entityName ? _self.entityName : entityName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SessionType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as SessionMode,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SessionStatus,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,maxParticipants: freezed == maxParticipants ? _self.maxParticipants : maxParticipants // ignore: cast_nullable_to_non_nullable
as int?,meetingLink: freezed == meetingLink ? _self.meetingLink : meetingLink // ignore: cast_nullable_to_non_nullable
as String?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MentorSession].
extension MentorSessionPatterns on MentorSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MentorSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MentorSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MentorSession value)  $default,){
final _that = this;
switch (_that) {
case _MentorSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MentorSession value)?  $default,){
final _that = this;
switch (_that) {
case _MentorSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String entityId,  String entityName,  SessionType type,  String title,  String description,  SessionMode mode,  DateTime startsAt,  DateTime endsAt,  SessionStatus status,  bool isRecurring,  int? maxParticipants,  String? meetingLink,  String? venue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MentorSession() when $default != null:
return $default(_that.id,_that.entityId,_that.entityName,_that.type,_that.title,_that.description,_that.mode,_that.startsAt,_that.endsAt,_that.status,_that.isRecurring,_that.maxParticipants,_that.meetingLink,_that.venue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String entityId,  String entityName,  SessionType type,  String title,  String description,  SessionMode mode,  DateTime startsAt,  DateTime endsAt,  SessionStatus status,  bool isRecurring,  int? maxParticipants,  String? meetingLink,  String? venue)  $default,) {final _that = this;
switch (_that) {
case _MentorSession():
return $default(_that.id,_that.entityId,_that.entityName,_that.type,_that.title,_that.description,_that.mode,_that.startsAt,_that.endsAt,_that.status,_that.isRecurring,_that.maxParticipants,_that.meetingLink,_that.venue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String entityId,  String entityName,  SessionType type,  String title,  String description,  SessionMode mode,  DateTime startsAt,  DateTime endsAt,  SessionStatus status,  bool isRecurring,  int? maxParticipants,  String? meetingLink,  String? venue)?  $default,) {final _that = this;
switch (_that) {
case _MentorSession() when $default != null:
return $default(_that.id,_that.entityId,_that.entityName,_that.type,_that.title,_that.description,_that.mode,_that.startsAt,_that.endsAt,_that.status,_that.isRecurring,_that.maxParticipants,_that.meetingLink,_that.venue);case _:
  return null;

}
}

}

/// @nodoc


class _MentorSession implements MentorSession {
  const _MentorSession({required this.id, required this.entityId, required this.entityName, required this.type, required this.title, required this.description, required this.mode, required this.startsAt, required this.endsAt, required this.status, required this.isRecurring, this.maxParticipants, this.meetingLink, this.venue});
  

@override final  String id;
@override final  String entityId;
@override final  String entityName;
@override final  SessionType type;
@override final  String title;
@override final  String description;
@override final  SessionMode mode;
@override final  DateTime startsAt;
@override final  DateTime endsAt;
@override final  SessionStatus status;
@override final  bool isRecurring;
@override final  int? maxParticipants;
@override final  String? meetingLink;
@override final  String? venue;

/// Create a copy of MentorSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MentorSessionCopyWith<_MentorSession> get copyWith => __$MentorSessionCopyWithImpl<_MentorSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MentorSession&&(identical(other.id, id) || other.id == id)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.entityName, entityName) || other.entityName == entityName)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.maxParticipants, maxParticipants) || other.maxParticipants == maxParticipants)&&(identical(other.meetingLink, meetingLink) || other.meetingLink == meetingLink)&&(identical(other.venue, venue) || other.venue == venue));
}


@override
int get hashCode => Object.hash(runtimeType,id,entityId,entityName,type,title,description,mode,startsAt,endsAt,status,isRecurring,maxParticipants,meetingLink,venue);

@override
String toString() {
  return 'MentorSession(id: $id, entityId: $entityId, entityName: $entityName, type: $type, title: $title, description: $description, mode: $mode, startsAt: $startsAt, endsAt: $endsAt, status: $status, isRecurring: $isRecurring, maxParticipants: $maxParticipants, meetingLink: $meetingLink, venue: $venue)';
}


}

/// @nodoc
abstract mixin class _$MentorSessionCopyWith<$Res> implements $MentorSessionCopyWith<$Res> {
  factory _$MentorSessionCopyWith(_MentorSession value, $Res Function(_MentorSession) _then) = __$MentorSessionCopyWithImpl;
@override @useResult
$Res call({
 String id, String entityId, String entityName, SessionType type, String title, String description, SessionMode mode, DateTime startsAt, DateTime endsAt, SessionStatus status, bool isRecurring, int? maxParticipants, String? meetingLink, String? venue
});




}
/// @nodoc
class __$MentorSessionCopyWithImpl<$Res>
    implements _$MentorSessionCopyWith<$Res> {
  __$MentorSessionCopyWithImpl(this._self, this._then);

  final _MentorSession _self;
  final $Res Function(_MentorSession) _then;

/// Create a copy of MentorSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? entityId = null,Object? entityName = null,Object? type = null,Object? title = null,Object? description = null,Object? mode = null,Object? startsAt = null,Object? endsAt = null,Object? status = null,Object? isRecurring = null,Object? maxParticipants = freezed,Object? meetingLink = freezed,Object? venue = freezed,}) {
  return _then(_MentorSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,entityName: null == entityName ? _self.entityName : entityName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SessionType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as SessionMode,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SessionStatus,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,maxParticipants: freezed == maxParticipants ? _self.maxParticipants : maxParticipants // ignore: cast_nullable_to_non_nullable
as int?,meetingLink: freezed == meetingLink ? _self.meetingLink : meetingLink // ignore: cast_nullable_to_non_nullable
as String?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
