// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mentor_session_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MentorSessionDto {

 String get id; String get startsAt; String get endsAt; String get entityId; String get entityName; String? get sessionType; String get title; String? get description; String? get mode; String? get status; int? get maxParticipants; String? get meetingLink; String? get venue; bool get isRecurring;
/// Create a copy of MentorSessionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MentorSessionDtoCopyWith<MentorSessionDto> get copyWith => _$MentorSessionDtoCopyWithImpl<MentorSessionDto>(this as MentorSessionDto, _$identity);

  /// Serializes this MentorSessionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MentorSessionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.entityName, entityName) || other.entityName == entityName)&&(identical(other.sessionType, sessionType) || other.sessionType == sessionType)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.status, status) || other.status == status)&&(identical(other.maxParticipants, maxParticipants) || other.maxParticipants == maxParticipants)&&(identical(other.meetingLink, meetingLink) || other.meetingLink == meetingLink)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startsAt,endsAt,entityId,entityName,sessionType,title,description,mode,status,maxParticipants,meetingLink,venue,isRecurring);

@override
String toString() {
  return 'MentorSessionDto(id: $id, startsAt: $startsAt, endsAt: $endsAt, entityId: $entityId, entityName: $entityName, sessionType: $sessionType, title: $title, description: $description, mode: $mode, status: $status, maxParticipants: $maxParticipants, meetingLink: $meetingLink, venue: $venue, isRecurring: $isRecurring)';
}


}

/// @nodoc
abstract mixin class $MentorSessionDtoCopyWith<$Res>  {
  factory $MentorSessionDtoCopyWith(MentorSessionDto value, $Res Function(MentorSessionDto) _then) = _$MentorSessionDtoCopyWithImpl;
@useResult
$Res call({
 String id, String startsAt, String endsAt, String entityId, String entityName, String? sessionType, String title, String? description, String? mode, String? status, int? maxParticipants, String? meetingLink, String? venue, bool isRecurring
});




}
/// @nodoc
class _$MentorSessionDtoCopyWithImpl<$Res>
    implements $MentorSessionDtoCopyWith<$Res> {
  _$MentorSessionDtoCopyWithImpl(this._self, this._then);

  final MentorSessionDto _self;
  final $Res Function(MentorSessionDto) _then;

/// Create a copy of MentorSessionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? startsAt = null,Object? endsAt = null,Object? entityId = null,Object? entityName = null,Object? sessionType = freezed,Object? title = null,Object? description = freezed,Object? mode = freezed,Object? status = freezed,Object? maxParticipants = freezed,Object? meetingLink = freezed,Object? venue = freezed,Object? isRecurring = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,entityName: null == entityName ? _self.entityName : entityName // ignore: cast_nullable_to_non_nullable
as String,sessionType: freezed == sessionType ? _self.sessionType : sessionType // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,maxParticipants: freezed == maxParticipants ? _self.maxParticipants : maxParticipants // ignore: cast_nullable_to_non_nullable
as int?,meetingLink: freezed == meetingLink ? _self.meetingLink : meetingLink // ignore: cast_nullable_to_non_nullable
as String?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MentorSessionDto].
extension MentorSessionDtoPatterns on MentorSessionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MentorSessionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MentorSessionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MentorSessionDto value)  $default,){
final _that = this;
switch (_that) {
case _MentorSessionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MentorSessionDto value)?  $default,){
final _that = this;
switch (_that) {
case _MentorSessionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String startsAt,  String endsAt,  String entityId,  String entityName,  String? sessionType,  String title,  String? description,  String? mode,  String? status,  int? maxParticipants,  String? meetingLink,  String? venue,  bool isRecurring)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MentorSessionDto() when $default != null:
return $default(_that.id,_that.startsAt,_that.endsAt,_that.entityId,_that.entityName,_that.sessionType,_that.title,_that.description,_that.mode,_that.status,_that.maxParticipants,_that.meetingLink,_that.venue,_that.isRecurring);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String startsAt,  String endsAt,  String entityId,  String entityName,  String? sessionType,  String title,  String? description,  String? mode,  String? status,  int? maxParticipants,  String? meetingLink,  String? venue,  bool isRecurring)  $default,) {final _that = this;
switch (_that) {
case _MentorSessionDto():
return $default(_that.id,_that.startsAt,_that.endsAt,_that.entityId,_that.entityName,_that.sessionType,_that.title,_that.description,_that.mode,_that.status,_that.maxParticipants,_that.meetingLink,_that.venue,_that.isRecurring);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String startsAt,  String endsAt,  String entityId,  String entityName,  String? sessionType,  String title,  String? description,  String? mode,  String? status,  int? maxParticipants,  String? meetingLink,  String? venue,  bool isRecurring)?  $default,) {final _that = this;
switch (_that) {
case _MentorSessionDto() when $default != null:
return $default(_that.id,_that.startsAt,_that.endsAt,_that.entityId,_that.entityName,_that.sessionType,_that.title,_that.description,_that.mode,_that.status,_that.maxParticipants,_that.meetingLink,_that.venue,_that.isRecurring);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MentorSessionDto extends MentorSessionDto {
  const _MentorSessionDto({required this.id, required this.startsAt, required this.endsAt, this.entityId = '', this.entityName = '', this.sessionType, this.title = '', this.description, this.mode, this.status, this.maxParticipants, this.meetingLink, this.venue, this.isRecurring = false}): super._();
  factory _MentorSessionDto.fromJson(Map<String, dynamic> json) => _$MentorSessionDtoFromJson(json);

@override final  String id;
@override final  String startsAt;
@override final  String endsAt;
@override@JsonKey() final  String entityId;
@override@JsonKey() final  String entityName;
@override final  String? sessionType;
@override@JsonKey() final  String title;
@override final  String? description;
@override final  String? mode;
@override final  String? status;
@override final  int? maxParticipants;
@override final  String? meetingLink;
@override final  String? venue;
@override@JsonKey() final  bool isRecurring;

/// Create a copy of MentorSessionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MentorSessionDtoCopyWith<_MentorSessionDto> get copyWith => __$MentorSessionDtoCopyWithImpl<_MentorSessionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MentorSessionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MentorSessionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.entityName, entityName) || other.entityName == entityName)&&(identical(other.sessionType, sessionType) || other.sessionType == sessionType)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.status, status) || other.status == status)&&(identical(other.maxParticipants, maxParticipants) || other.maxParticipants == maxParticipants)&&(identical(other.meetingLink, meetingLink) || other.meetingLink == meetingLink)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startsAt,endsAt,entityId,entityName,sessionType,title,description,mode,status,maxParticipants,meetingLink,venue,isRecurring);

@override
String toString() {
  return 'MentorSessionDto(id: $id, startsAt: $startsAt, endsAt: $endsAt, entityId: $entityId, entityName: $entityName, sessionType: $sessionType, title: $title, description: $description, mode: $mode, status: $status, maxParticipants: $maxParticipants, meetingLink: $meetingLink, venue: $venue, isRecurring: $isRecurring)';
}


}

/// @nodoc
abstract mixin class _$MentorSessionDtoCopyWith<$Res> implements $MentorSessionDtoCopyWith<$Res> {
  factory _$MentorSessionDtoCopyWith(_MentorSessionDto value, $Res Function(_MentorSessionDto) _then) = __$MentorSessionDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String startsAt, String endsAt, String entityId, String entityName, String? sessionType, String title, String? description, String? mode, String? status, int? maxParticipants, String? meetingLink, String? venue, bool isRecurring
});




}
/// @nodoc
class __$MentorSessionDtoCopyWithImpl<$Res>
    implements _$MentorSessionDtoCopyWith<$Res> {
  __$MentorSessionDtoCopyWithImpl(this._self, this._then);

  final _MentorSessionDto _self;
  final $Res Function(_MentorSessionDto) _then;

/// Create a copy of MentorSessionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startsAt = null,Object? endsAt = null,Object? entityId = null,Object? entityName = null,Object? sessionType = freezed,Object? title = null,Object? description = freezed,Object? mode = freezed,Object? status = freezed,Object? maxParticipants = freezed,Object? meetingLink = freezed,Object? venue = freezed,Object? isRecurring = null,}) {
  return _then(_MentorSessionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,entityName: null == entityName ? _self.entityName : entityName // ignore: cast_nullable_to_non_nullable
as String,sessionType: freezed == sessionType ? _self.sessionType : sessionType // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,maxParticipants: freezed == maxParticipants ? _self.maxParticipants : maxParticipants // ignore: cast_nullable_to_non_nullable
as int?,meetingLink: freezed == meetingLink ? _self.meetingLink : meetingLink // ignore: cast_nullable_to_non_nullable
as String?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
