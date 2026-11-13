// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StudentRequestDto {

 String get id; String get startsAt; String get endsAt; String get title; String? get description; String? get mode; String get entityName; String? get meetingLink; String? get venue; String get requestedByName; String get requestedByMuid;
/// Create a copy of StudentRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentRequestDtoCopyWith<StudentRequestDto> get copyWith => _$StudentRequestDtoCopyWithImpl<StudentRequestDto>(this as StudentRequestDto, _$identity);

  /// Serializes this StudentRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentRequestDto&&(identical(other.id, id) || other.id == id)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.entityName, entityName) || other.entityName == entityName)&&(identical(other.meetingLink, meetingLink) || other.meetingLink == meetingLink)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.requestedByName, requestedByName) || other.requestedByName == requestedByName)&&(identical(other.requestedByMuid, requestedByMuid) || other.requestedByMuid == requestedByMuid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startsAt,endsAt,title,description,mode,entityName,meetingLink,venue,requestedByName,requestedByMuid);

@override
String toString() {
  return 'StudentRequestDto(id: $id, startsAt: $startsAt, endsAt: $endsAt, title: $title, description: $description, mode: $mode, entityName: $entityName, meetingLink: $meetingLink, venue: $venue, requestedByName: $requestedByName, requestedByMuid: $requestedByMuid)';
}


}

/// @nodoc
abstract mixin class $StudentRequestDtoCopyWith<$Res>  {
  factory $StudentRequestDtoCopyWith(StudentRequestDto value, $Res Function(StudentRequestDto) _then) = _$StudentRequestDtoCopyWithImpl;
@useResult
$Res call({
 String id, String startsAt, String endsAt, String title, String? description, String? mode, String entityName, String? meetingLink, String? venue, String requestedByName, String requestedByMuid
});




}
/// @nodoc
class _$StudentRequestDtoCopyWithImpl<$Res>
    implements $StudentRequestDtoCopyWith<$Res> {
  _$StudentRequestDtoCopyWithImpl(this._self, this._then);

  final StudentRequestDto _self;
  final $Res Function(StudentRequestDto) _then;

/// Create a copy of StudentRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? startsAt = null,Object? endsAt = null,Object? title = null,Object? description = freezed,Object? mode = freezed,Object? entityName = null,Object? meetingLink = freezed,Object? venue = freezed,Object? requestedByName = null,Object? requestedByMuid = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String?,entityName: null == entityName ? _self.entityName : entityName // ignore: cast_nullable_to_non_nullable
as String,meetingLink: freezed == meetingLink ? _self.meetingLink : meetingLink // ignore: cast_nullable_to_non_nullable
as String?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,requestedByName: null == requestedByName ? _self.requestedByName : requestedByName // ignore: cast_nullable_to_non_nullable
as String,requestedByMuid: null == requestedByMuid ? _self.requestedByMuid : requestedByMuid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StudentRequestDto].
extension StudentRequestDtoPatterns on StudentRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudentRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudentRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudentRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _StudentRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudentRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _StudentRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String startsAt,  String endsAt,  String title,  String? description,  String? mode,  String entityName,  String? meetingLink,  String? venue,  String requestedByName,  String requestedByMuid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudentRequestDto() when $default != null:
return $default(_that.id,_that.startsAt,_that.endsAt,_that.title,_that.description,_that.mode,_that.entityName,_that.meetingLink,_that.venue,_that.requestedByName,_that.requestedByMuid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String startsAt,  String endsAt,  String title,  String? description,  String? mode,  String entityName,  String? meetingLink,  String? venue,  String requestedByName,  String requestedByMuid)  $default,) {final _that = this;
switch (_that) {
case _StudentRequestDto():
return $default(_that.id,_that.startsAt,_that.endsAt,_that.title,_that.description,_that.mode,_that.entityName,_that.meetingLink,_that.venue,_that.requestedByName,_that.requestedByMuid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String startsAt,  String endsAt,  String title,  String? description,  String? mode,  String entityName,  String? meetingLink,  String? venue,  String requestedByName,  String requestedByMuid)?  $default,) {final _that = this;
switch (_that) {
case _StudentRequestDto() when $default != null:
return $default(_that.id,_that.startsAt,_that.endsAt,_that.title,_that.description,_that.mode,_that.entityName,_that.meetingLink,_that.venue,_that.requestedByName,_that.requestedByMuid);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StudentRequestDto extends StudentRequestDto {
  const _StudentRequestDto({required this.id, required this.startsAt, required this.endsAt, this.title = '', this.description, this.mode, this.entityName = '', this.meetingLink, this.venue, this.requestedByName = '', this.requestedByMuid = ''}): super._();
  factory _StudentRequestDto.fromJson(Map<String, dynamic> json) => _$StudentRequestDtoFromJson(json);

@override final  String id;
@override final  String startsAt;
@override final  String endsAt;
@override@JsonKey() final  String title;
@override final  String? description;
@override final  String? mode;
@override@JsonKey() final  String entityName;
@override final  String? meetingLink;
@override final  String? venue;
@override@JsonKey() final  String requestedByName;
@override@JsonKey() final  String requestedByMuid;

/// Create a copy of StudentRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudentRequestDtoCopyWith<_StudentRequestDto> get copyWith => __$StudentRequestDtoCopyWithImpl<_StudentRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudentRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudentRequestDto&&(identical(other.id, id) || other.id == id)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.entityName, entityName) || other.entityName == entityName)&&(identical(other.meetingLink, meetingLink) || other.meetingLink == meetingLink)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.requestedByName, requestedByName) || other.requestedByName == requestedByName)&&(identical(other.requestedByMuid, requestedByMuid) || other.requestedByMuid == requestedByMuid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startsAt,endsAt,title,description,mode,entityName,meetingLink,venue,requestedByName,requestedByMuid);

@override
String toString() {
  return 'StudentRequestDto(id: $id, startsAt: $startsAt, endsAt: $endsAt, title: $title, description: $description, mode: $mode, entityName: $entityName, meetingLink: $meetingLink, venue: $venue, requestedByName: $requestedByName, requestedByMuid: $requestedByMuid)';
}


}

/// @nodoc
abstract mixin class _$StudentRequestDtoCopyWith<$Res> implements $StudentRequestDtoCopyWith<$Res> {
  factory _$StudentRequestDtoCopyWith(_StudentRequestDto value, $Res Function(_StudentRequestDto) _then) = __$StudentRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String startsAt, String endsAt, String title, String? description, String? mode, String entityName, String? meetingLink, String? venue, String requestedByName, String requestedByMuid
});




}
/// @nodoc
class __$StudentRequestDtoCopyWithImpl<$Res>
    implements _$StudentRequestDtoCopyWith<$Res> {
  __$StudentRequestDtoCopyWithImpl(this._self, this._then);

  final _StudentRequestDto _self;
  final $Res Function(_StudentRequestDto) _then;

/// Create a copy of StudentRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startsAt = null,Object? endsAt = null,Object? title = null,Object? description = freezed,Object? mode = freezed,Object? entityName = null,Object? meetingLink = freezed,Object? venue = freezed,Object? requestedByName = null,Object? requestedByMuid = null,}) {
  return _then(_StudentRequestDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String?,entityName: null == entityName ? _self.entityName : entityName // ignore: cast_nullable_to_non_nullable
as String,meetingLink: freezed == meetingLink ? _self.meetingLink : meetingLink // ignore: cast_nullable_to_non_nullable
as String?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,requestedByName: null == requestedByName ? _self.requestedByName : requestedByName // ignore: cast_nullable_to_non_nullable
as String,requestedByMuid: null == requestedByMuid ? _self.requestedByMuid : requestedByMuid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
