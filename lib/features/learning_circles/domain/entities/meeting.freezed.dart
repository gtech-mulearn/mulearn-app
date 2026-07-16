// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meeting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Meeting {

 String get id; String get title; String get description; String get mode; String get meetPlace; String get meetTime; String get circleId; String get igName; bool get isStarted; bool get isEnded; int get attendeesCount; String get createdBy; String? get org; String? get meetLink; bool get isRecurring; bool get isJoined; bool get isRsvp;
/// Create a copy of Meeting
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingCopyWith<Meeting> get copyWith => _$MeetingCopyWithImpl<Meeting>(this as Meeting, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Meeting&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.meetPlace, meetPlace) || other.meetPlace == meetPlace)&&(identical(other.meetTime, meetTime) || other.meetTime == meetTime)&&(identical(other.circleId, circleId) || other.circleId == circleId)&&(identical(other.igName, igName) || other.igName == igName)&&(identical(other.isStarted, isStarted) || other.isStarted == isStarted)&&(identical(other.isEnded, isEnded) || other.isEnded == isEnded)&&(identical(other.attendeesCount, attendeesCount) || other.attendeesCount == attendeesCount)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.org, org) || other.org == org)&&(identical(other.meetLink, meetLink) || other.meetLink == meetLink)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.isJoined, isJoined) || other.isJoined == isJoined)&&(identical(other.isRsvp, isRsvp) || other.isRsvp == isRsvp));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,mode,meetPlace,meetTime,circleId,igName,isStarted,isEnded,attendeesCount,createdBy,org,meetLink,isRecurring,isJoined,isRsvp);

@override
String toString() {
  return 'Meeting(id: $id, title: $title, description: $description, mode: $mode, meetPlace: $meetPlace, meetTime: $meetTime, circleId: $circleId, igName: $igName, isStarted: $isStarted, isEnded: $isEnded, attendeesCount: $attendeesCount, createdBy: $createdBy, org: $org, meetLink: $meetLink, isRecurring: $isRecurring, isJoined: $isJoined, isRsvp: $isRsvp)';
}


}

/// @nodoc
abstract mixin class $MeetingCopyWith<$Res>  {
  factory $MeetingCopyWith(Meeting value, $Res Function(Meeting) _then) = _$MeetingCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String mode, String meetPlace, String meetTime, String circleId, String igName, bool isStarted, bool isEnded, int attendeesCount, String createdBy, String? org, String? meetLink, bool isRecurring, bool isJoined, bool isRsvp
});




}
/// @nodoc
class _$MeetingCopyWithImpl<$Res>
    implements $MeetingCopyWith<$Res> {
  _$MeetingCopyWithImpl(this._self, this._then);

  final Meeting _self;
  final $Res Function(Meeting) _then;

/// Create a copy of Meeting
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? mode = null,Object? meetPlace = null,Object? meetTime = null,Object? circleId = null,Object? igName = null,Object? isStarted = null,Object? isEnded = null,Object? attendeesCount = null,Object? createdBy = null,Object? org = freezed,Object? meetLink = freezed,Object? isRecurring = null,Object? isJoined = null,Object? isRsvp = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,meetPlace: null == meetPlace ? _self.meetPlace : meetPlace // ignore: cast_nullable_to_non_nullable
as String,meetTime: null == meetTime ? _self.meetTime : meetTime // ignore: cast_nullable_to_non_nullable
as String,circleId: null == circleId ? _self.circleId : circleId // ignore: cast_nullable_to_non_nullable
as String,igName: null == igName ? _self.igName : igName // ignore: cast_nullable_to_non_nullable
as String,isStarted: null == isStarted ? _self.isStarted : isStarted // ignore: cast_nullable_to_non_nullable
as bool,isEnded: null == isEnded ? _self.isEnded : isEnded // ignore: cast_nullable_to_non_nullable
as bool,attendeesCount: null == attendeesCount ? _self.attendeesCount : attendeesCount // ignore: cast_nullable_to_non_nullable
as int,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,org: freezed == org ? _self.org : org // ignore: cast_nullable_to_non_nullable
as String?,meetLink: freezed == meetLink ? _self.meetLink : meetLink // ignore: cast_nullable_to_non_nullable
as String?,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,isJoined: null == isJoined ? _self.isJoined : isJoined // ignore: cast_nullable_to_non_nullable
as bool,isRsvp: null == isRsvp ? _self.isRsvp : isRsvp // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Meeting].
extension MeetingPatterns on Meeting {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Meeting value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Meeting() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Meeting value)  $default,){
final _that = this;
switch (_that) {
case _Meeting():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Meeting value)?  $default,){
final _that = this;
switch (_that) {
case _Meeting() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String mode,  String meetPlace,  String meetTime,  String circleId,  String igName,  bool isStarted,  bool isEnded,  int attendeesCount,  String createdBy,  String? org,  String? meetLink,  bool isRecurring,  bool isJoined,  bool isRsvp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Meeting() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.mode,_that.meetPlace,_that.meetTime,_that.circleId,_that.igName,_that.isStarted,_that.isEnded,_that.attendeesCount,_that.createdBy,_that.org,_that.meetLink,_that.isRecurring,_that.isJoined,_that.isRsvp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String mode,  String meetPlace,  String meetTime,  String circleId,  String igName,  bool isStarted,  bool isEnded,  int attendeesCount,  String createdBy,  String? org,  String? meetLink,  bool isRecurring,  bool isJoined,  bool isRsvp)  $default,) {final _that = this;
switch (_that) {
case _Meeting():
return $default(_that.id,_that.title,_that.description,_that.mode,_that.meetPlace,_that.meetTime,_that.circleId,_that.igName,_that.isStarted,_that.isEnded,_that.attendeesCount,_that.createdBy,_that.org,_that.meetLink,_that.isRecurring,_that.isJoined,_that.isRsvp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  String mode,  String meetPlace,  String meetTime,  String circleId,  String igName,  bool isStarted,  bool isEnded,  int attendeesCount,  String createdBy,  String? org,  String? meetLink,  bool isRecurring,  bool isJoined,  bool isRsvp)?  $default,) {final _that = this;
switch (_that) {
case _Meeting() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.mode,_that.meetPlace,_that.meetTime,_that.circleId,_that.igName,_that.isStarted,_that.isEnded,_that.attendeesCount,_that.createdBy,_that.org,_that.meetLink,_that.isRecurring,_that.isJoined,_that.isRsvp);case _:
  return null;

}
}

}

/// @nodoc


class _Meeting implements Meeting {
  const _Meeting({required this.id, required this.title, required this.description, required this.mode, required this.meetPlace, required this.meetTime, required this.circleId, required this.igName, required this.isStarted, required this.isEnded, required this.attendeesCount, required this.createdBy, this.org, this.meetLink, this.isRecurring = false, this.isJoined = false, this.isRsvp = false});
  

@override final  String id;
@override final  String title;
@override final  String description;
@override final  String mode;
@override final  String meetPlace;
@override final  String meetTime;
@override final  String circleId;
@override final  String igName;
@override final  bool isStarted;
@override final  bool isEnded;
@override final  int attendeesCount;
@override final  String createdBy;
@override final  String? org;
@override final  String? meetLink;
@override@JsonKey() final  bool isRecurring;
@override@JsonKey() final  bool isJoined;
@override@JsonKey() final  bool isRsvp;

/// Create a copy of Meeting
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingCopyWith<_Meeting> get copyWith => __$MeetingCopyWithImpl<_Meeting>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Meeting&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.meetPlace, meetPlace) || other.meetPlace == meetPlace)&&(identical(other.meetTime, meetTime) || other.meetTime == meetTime)&&(identical(other.circleId, circleId) || other.circleId == circleId)&&(identical(other.igName, igName) || other.igName == igName)&&(identical(other.isStarted, isStarted) || other.isStarted == isStarted)&&(identical(other.isEnded, isEnded) || other.isEnded == isEnded)&&(identical(other.attendeesCount, attendeesCount) || other.attendeesCount == attendeesCount)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.org, org) || other.org == org)&&(identical(other.meetLink, meetLink) || other.meetLink == meetLink)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.isJoined, isJoined) || other.isJoined == isJoined)&&(identical(other.isRsvp, isRsvp) || other.isRsvp == isRsvp));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,mode,meetPlace,meetTime,circleId,igName,isStarted,isEnded,attendeesCount,createdBy,org,meetLink,isRecurring,isJoined,isRsvp);

@override
String toString() {
  return 'Meeting(id: $id, title: $title, description: $description, mode: $mode, meetPlace: $meetPlace, meetTime: $meetTime, circleId: $circleId, igName: $igName, isStarted: $isStarted, isEnded: $isEnded, attendeesCount: $attendeesCount, createdBy: $createdBy, org: $org, meetLink: $meetLink, isRecurring: $isRecurring, isJoined: $isJoined, isRsvp: $isRsvp)';
}


}

/// @nodoc
abstract mixin class _$MeetingCopyWith<$Res> implements $MeetingCopyWith<$Res> {
  factory _$MeetingCopyWith(_Meeting value, $Res Function(_Meeting) _then) = __$MeetingCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String mode, String meetPlace, String meetTime, String circleId, String igName, bool isStarted, bool isEnded, int attendeesCount, String createdBy, String? org, String? meetLink, bool isRecurring, bool isJoined, bool isRsvp
});




}
/// @nodoc
class __$MeetingCopyWithImpl<$Res>
    implements _$MeetingCopyWith<$Res> {
  __$MeetingCopyWithImpl(this._self, this._then);

  final _Meeting _self;
  final $Res Function(_Meeting) _then;

/// Create a copy of Meeting
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? mode = null,Object? meetPlace = null,Object? meetTime = null,Object? circleId = null,Object? igName = null,Object? isStarted = null,Object? isEnded = null,Object? attendeesCount = null,Object? createdBy = null,Object? org = freezed,Object? meetLink = freezed,Object? isRecurring = null,Object? isJoined = null,Object? isRsvp = null,}) {
  return _then(_Meeting(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,meetPlace: null == meetPlace ? _self.meetPlace : meetPlace // ignore: cast_nullable_to_non_nullable
as String,meetTime: null == meetTime ? _self.meetTime : meetTime // ignore: cast_nullable_to_non_nullable
as String,circleId: null == circleId ? _self.circleId : circleId // ignore: cast_nullable_to_non_nullable
as String,igName: null == igName ? _self.igName : igName // ignore: cast_nullable_to_non_nullable
as String,isStarted: null == isStarted ? _self.isStarted : isStarted // ignore: cast_nullable_to_non_nullable
as bool,isEnded: null == isEnded ? _self.isEnded : isEnded // ignore: cast_nullable_to_non_nullable
as bool,attendeesCount: null == attendeesCount ? _self.attendeesCount : attendeesCount // ignore: cast_nullable_to_non_nullable
as int,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,org: freezed == org ? _self.org : org // ignore: cast_nullable_to_non_nullable
as String?,meetLink: freezed == meetLink ? _self.meetLink : meetLink // ignore: cast_nullable_to_non_nullable
as String?,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,isJoined: null == isJoined ? _self.isJoined : isJoined // ignore: cast_nullable_to_non_nullable
as bool,isRsvp: null == isRsvp ? _self.isRsvp : isRsvp // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
