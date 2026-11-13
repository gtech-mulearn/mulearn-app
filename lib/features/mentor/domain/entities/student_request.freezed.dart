// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudentSessionRequest {

 String get id; String get title; String get description; SessionMode get mode; DateTime get startsAt; DateTime get endsAt; String get scopeName; String get requesterName; String get requesterMuid; String? get meetingLink; String? get venue;
/// Create a copy of StudentSessionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentSessionRequestCopyWith<StudentSessionRequest> get copyWith => _$StudentSessionRequestCopyWithImpl<StudentSessionRequest>(this as StudentSessionRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentSessionRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.scopeName, scopeName) || other.scopeName == scopeName)&&(identical(other.requesterName, requesterName) || other.requesterName == requesterName)&&(identical(other.requesterMuid, requesterMuid) || other.requesterMuid == requesterMuid)&&(identical(other.meetingLink, meetingLink) || other.meetingLink == meetingLink)&&(identical(other.venue, venue) || other.venue == venue));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,mode,startsAt,endsAt,scopeName,requesterName,requesterMuid,meetingLink,venue);

@override
String toString() {
  return 'StudentSessionRequest(id: $id, title: $title, description: $description, mode: $mode, startsAt: $startsAt, endsAt: $endsAt, scopeName: $scopeName, requesterName: $requesterName, requesterMuid: $requesterMuid, meetingLink: $meetingLink, venue: $venue)';
}


}

/// @nodoc
abstract mixin class $StudentSessionRequestCopyWith<$Res>  {
  factory $StudentSessionRequestCopyWith(StudentSessionRequest value, $Res Function(StudentSessionRequest) _then) = _$StudentSessionRequestCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, SessionMode mode, DateTime startsAt, DateTime endsAt, String scopeName, String requesterName, String requesterMuid, String? meetingLink, String? venue
});




}
/// @nodoc
class _$StudentSessionRequestCopyWithImpl<$Res>
    implements $StudentSessionRequestCopyWith<$Res> {
  _$StudentSessionRequestCopyWithImpl(this._self, this._then);

  final StudentSessionRequest _self;
  final $Res Function(StudentSessionRequest) _then;

/// Create a copy of StudentSessionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? mode = null,Object? startsAt = null,Object? endsAt = null,Object? scopeName = null,Object? requesterName = null,Object? requesterMuid = null,Object? meetingLink = freezed,Object? venue = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as SessionMode,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,scopeName: null == scopeName ? _self.scopeName : scopeName // ignore: cast_nullable_to_non_nullable
as String,requesterName: null == requesterName ? _self.requesterName : requesterName // ignore: cast_nullable_to_non_nullable
as String,requesterMuid: null == requesterMuid ? _self.requesterMuid : requesterMuid // ignore: cast_nullable_to_non_nullable
as String,meetingLink: freezed == meetingLink ? _self.meetingLink : meetingLink // ignore: cast_nullable_to_non_nullable
as String?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StudentSessionRequest].
extension StudentSessionRequestPatterns on StudentSessionRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudentSessionRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudentSessionRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudentSessionRequest value)  $default,){
final _that = this;
switch (_that) {
case _StudentSessionRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudentSessionRequest value)?  $default,){
final _that = this;
switch (_that) {
case _StudentSessionRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  SessionMode mode,  DateTime startsAt,  DateTime endsAt,  String scopeName,  String requesterName,  String requesterMuid,  String? meetingLink,  String? venue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudentSessionRequest() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.mode,_that.startsAt,_that.endsAt,_that.scopeName,_that.requesterName,_that.requesterMuid,_that.meetingLink,_that.venue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  SessionMode mode,  DateTime startsAt,  DateTime endsAt,  String scopeName,  String requesterName,  String requesterMuid,  String? meetingLink,  String? venue)  $default,) {final _that = this;
switch (_that) {
case _StudentSessionRequest():
return $default(_that.id,_that.title,_that.description,_that.mode,_that.startsAt,_that.endsAt,_that.scopeName,_that.requesterName,_that.requesterMuid,_that.meetingLink,_that.venue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  SessionMode mode,  DateTime startsAt,  DateTime endsAt,  String scopeName,  String requesterName,  String requesterMuid,  String? meetingLink,  String? venue)?  $default,) {final _that = this;
switch (_that) {
case _StudentSessionRequest() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.mode,_that.startsAt,_that.endsAt,_that.scopeName,_that.requesterName,_that.requesterMuid,_that.meetingLink,_that.venue);case _:
  return null;

}
}

}

/// @nodoc


class _StudentSessionRequest implements StudentSessionRequest {
  const _StudentSessionRequest({required this.id, required this.title, required this.description, required this.mode, required this.startsAt, required this.endsAt, required this.scopeName, required this.requesterName, required this.requesterMuid, this.meetingLink, this.venue});
  

@override final  String id;
@override final  String title;
@override final  String description;
@override final  SessionMode mode;
@override final  DateTime startsAt;
@override final  DateTime endsAt;
@override final  String scopeName;
@override final  String requesterName;
@override final  String requesterMuid;
@override final  String? meetingLink;
@override final  String? venue;

/// Create a copy of StudentSessionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudentSessionRequestCopyWith<_StudentSessionRequest> get copyWith => __$StudentSessionRequestCopyWithImpl<_StudentSessionRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudentSessionRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.scopeName, scopeName) || other.scopeName == scopeName)&&(identical(other.requesterName, requesterName) || other.requesterName == requesterName)&&(identical(other.requesterMuid, requesterMuid) || other.requesterMuid == requesterMuid)&&(identical(other.meetingLink, meetingLink) || other.meetingLink == meetingLink)&&(identical(other.venue, venue) || other.venue == venue));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,mode,startsAt,endsAt,scopeName,requesterName,requesterMuid,meetingLink,venue);

@override
String toString() {
  return 'StudentSessionRequest(id: $id, title: $title, description: $description, mode: $mode, startsAt: $startsAt, endsAt: $endsAt, scopeName: $scopeName, requesterName: $requesterName, requesterMuid: $requesterMuid, meetingLink: $meetingLink, venue: $venue)';
}


}

/// @nodoc
abstract mixin class _$StudentSessionRequestCopyWith<$Res> implements $StudentSessionRequestCopyWith<$Res> {
  factory _$StudentSessionRequestCopyWith(_StudentSessionRequest value, $Res Function(_StudentSessionRequest) _then) = __$StudentSessionRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, SessionMode mode, DateTime startsAt, DateTime endsAt, String scopeName, String requesterName, String requesterMuid, String? meetingLink, String? venue
});




}
/// @nodoc
class __$StudentSessionRequestCopyWithImpl<$Res>
    implements _$StudentSessionRequestCopyWith<$Res> {
  __$StudentSessionRequestCopyWithImpl(this._self, this._then);

  final _StudentSessionRequest _self;
  final $Res Function(_StudentSessionRequest) _then;

/// Create a copy of StudentSessionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? mode = null,Object? startsAt = null,Object? endsAt = null,Object? scopeName = null,Object? requesterName = null,Object? requesterMuid = null,Object? meetingLink = freezed,Object? venue = freezed,}) {
  return _then(_StudentSessionRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as SessionMode,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,scopeName: null == scopeName ? _self.scopeName : scopeName // ignore: cast_nullable_to_non_nullable
as String,requesterName: null == requesterName ? _self.requesterName : requesterName // ignore: cast_nullable_to_non_nullable
as String,requesterMuid: null == requesterMuid ? _self.requesterMuid : requesterMuid // ignore: cast_nullable_to_non_nullable
as String,meetingLink: freezed == meetingLink ? _self.meetingLink : meetingLink // ignore: cast_nullable_to_non_nullable
as String?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
