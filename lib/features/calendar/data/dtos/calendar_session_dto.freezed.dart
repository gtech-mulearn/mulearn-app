// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_session_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalendarSessionDto {

 String get id; String get title; String get startsAt; String get endsAt; String get status; String? get mode; String? get meetingLink; String? get venue; String? get mentorName; int? get menteeCount;
/// Create a copy of CalendarSessionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarSessionDtoCopyWith<CalendarSessionDto> get copyWith => _$CalendarSessionDtoCopyWithImpl<CalendarSessionDto>(this as CalendarSessionDto, _$identity);

  /// Serializes this CalendarSessionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarSessionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.meetingLink, meetingLink) || other.meetingLink == meetingLink)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.mentorName, mentorName) || other.mentorName == mentorName)&&(identical(other.menteeCount, menteeCount) || other.menteeCount == menteeCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,startsAt,endsAt,status,mode,meetingLink,venue,mentorName,menteeCount);

@override
String toString() {
  return 'CalendarSessionDto(id: $id, title: $title, startsAt: $startsAt, endsAt: $endsAt, status: $status, mode: $mode, meetingLink: $meetingLink, venue: $venue, mentorName: $mentorName, menteeCount: $menteeCount)';
}


}

/// @nodoc
abstract mixin class $CalendarSessionDtoCopyWith<$Res>  {
  factory $CalendarSessionDtoCopyWith(CalendarSessionDto value, $Res Function(CalendarSessionDto) _then) = _$CalendarSessionDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String startsAt, String endsAt, String status, String? mode, String? meetingLink, String? venue, String? mentorName, int? menteeCount
});




}
/// @nodoc
class _$CalendarSessionDtoCopyWithImpl<$Res>
    implements $CalendarSessionDtoCopyWith<$Res> {
  _$CalendarSessionDtoCopyWithImpl(this._self, this._then);

  final CalendarSessionDto _self;
  final $Res Function(CalendarSessionDto) _then;

/// Create a copy of CalendarSessionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startsAt = null,Object? endsAt = null,Object? status = null,Object? mode = freezed,Object? meetingLink = freezed,Object? venue = freezed,Object? mentorName = freezed,Object? menteeCount = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String?,meetingLink: freezed == meetingLink ? _self.meetingLink : meetingLink // ignore: cast_nullable_to_non_nullable
as String?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,mentorName: freezed == mentorName ? _self.mentorName : mentorName // ignore: cast_nullable_to_non_nullable
as String?,menteeCount: freezed == menteeCount ? _self.menteeCount : menteeCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarSessionDto].
extension CalendarSessionDtoPatterns on CalendarSessionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarSessionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarSessionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarSessionDto value)  $default,){
final _that = this;
switch (_that) {
case _CalendarSessionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarSessionDto value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarSessionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String startsAt,  String endsAt,  String status,  String? mode,  String? meetingLink,  String? venue,  String? mentorName,  int? menteeCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarSessionDto() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.status,_that.mode,_that.meetingLink,_that.venue,_that.mentorName,_that.menteeCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String startsAt,  String endsAt,  String status,  String? mode,  String? meetingLink,  String? venue,  String? mentorName,  int? menteeCount)  $default,) {final _that = this;
switch (_that) {
case _CalendarSessionDto():
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.status,_that.mode,_that.meetingLink,_that.venue,_that.mentorName,_that.menteeCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String startsAt,  String endsAt,  String status,  String? mode,  String? meetingLink,  String? venue,  String? mentorName,  int? menteeCount)?  $default,) {final _that = this;
switch (_that) {
case _CalendarSessionDto() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.endsAt,_that.status,_that.mode,_that.meetingLink,_that.venue,_that.mentorName,_that.menteeCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalendarSessionDto extends CalendarSessionDto {
  const _CalendarSessionDto({required this.id, required this.title, required this.startsAt, required this.endsAt, this.status = '', this.mode, this.meetingLink, this.venue, this.mentorName, this.menteeCount}): super._();
  factory _CalendarSessionDto.fromJson(Map<String, dynamic> json) => _$CalendarSessionDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  String startsAt;
@override final  String endsAt;
@override@JsonKey() final  String status;
@override final  String? mode;
@override final  String? meetingLink;
@override final  String? venue;
@override final  String? mentorName;
@override final  int? menteeCount;

/// Create a copy of CalendarSessionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarSessionDtoCopyWith<_CalendarSessionDto> get copyWith => __$CalendarSessionDtoCopyWithImpl<_CalendarSessionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalendarSessionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarSessionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.meetingLink, meetingLink) || other.meetingLink == meetingLink)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.mentorName, mentorName) || other.mentorName == mentorName)&&(identical(other.menteeCount, menteeCount) || other.menteeCount == menteeCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,startsAt,endsAt,status,mode,meetingLink,venue,mentorName,menteeCount);

@override
String toString() {
  return 'CalendarSessionDto(id: $id, title: $title, startsAt: $startsAt, endsAt: $endsAt, status: $status, mode: $mode, meetingLink: $meetingLink, venue: $venue, mentorName: $mentorName, menteeCount: $menteeCount)';
}


}

/// @nodoc
abstract mixin class _$CalendarSessionDtoCopyWith<$Res> implements $CalendarSessionDtoCopyWith<$Res> {
  factory _$CalendarSessionDtoCopyWith(_CalendarSessionDto value, $Res Function(_CalendarSessionDto) _then) = __$CalendarSessionDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String startsAt, String endsAt, String status, String? mode, String? meetingLink, String? venue, String? mentorName, int? menteeCount
});




}
/// @nodoc
class __$CalendarSessionDtoCopyWithImpl<$Res>
    implements _$CalendarSessionDtoCopyWith<$Res> {
  __$CalendarSessionDtoCopyWithImpl(this._self, this._then);

  final _CalendarSessionDto _self;
  final $Res Function(_CalendarSessionDto) _then;

/// Create a copy of CalendarSessionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startsAt = null,Object? endsAt = null,Object? status = null,Object? mode = freezed,Object? meetingLink = freezed,Object? venue = freezed,Object? mentorName = freezed,Object? menteeCount = freezed,}) {
  return _then(_CalendarSessionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String?,meetingLink: freezed == meetingLink ? _self.meetingLink : meetingLink // ignore: cast_nullable_to_non_nullable
as String?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,mentorName: freezed == mentorName ? _self.mentorName : mentorName // ignore: cast_nullable_to_non_nullable
as String?,menteeCount: freezed == menteeCount ? _self.menteeCount : menteeCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
