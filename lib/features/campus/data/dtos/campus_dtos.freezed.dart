// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campus_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CampusCircleDto {

 String get id; String get name; String? get igName; int get memberCount; int get meetingCount; String? get lastMeetingTime;
/// Create a copy of CampusCircleDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampusCircleDtoCopyWith<CampusCircleDto> get copyWith => _$CampusCircleDtoCopyWithImpl<CampusCircleDto>(this as CampusCircleDto, _$identity);

  /// Serializes this CampusCircleDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampusCircleDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.igName, igName) || other.igName == igName)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.meetingCount, meetingCount) || other.meetingCount == meetingCount)&&(identical(other.lastMeetingTime, lastMeetingTime) || other.lastMeetingTime == lastMeetingTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,igName,memberCount,meetingCount,lastMeetingTime);

@override
String toString() {
  return 'CampusCircleDto(id: $id, name: $name, igName: $igName, memberCount: $memberCount, meetingCount: $meetingCount, lastMeetingTime: $lastMeetingTime)';
}


}

/// @nodoc
abstract mixin class $CampusCircleDtoCopyWith<$Res>  {
  factory $CampusCircleDtoCopyWith(CampusCircleDto value, $Res Function(CampusCircleDto) _then) = _$CampusCircleDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? igName, int memberCount, int meetingCount, String? lastMeetingTime
});




}
/// @nodoc
class _$CampusCircleDtoCopyWithImpl<$Res>
    implements $CampusCircleDtoCopyWith<$Res> {
  _$CampusCircleDtoCopyWithImpl(this._self, this._then);

  final CampusCircleDto _self;
  final $Res Function(CampusCircleDto) _then;

/// Create a copy of CampusCircleDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? igName = freezed,Object? memberCount = null,Object? meetingCount = null,Object? lastMeetingTime = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,igName: freezed == igName ? _self.igName : igName // ignore: cast_nullable_to_non_nullable
as String?,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,meetingCount: null == meetingCount ? _self.meetingCount : meetingCount // ignore: cast_nullable_to_non_nullable
as int,lastMeetingTime: freezed == lastMeetingTime ? _self.lastMeetingTime : lastMeetingTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CampusCircleDto].
extension CampusCircleDtoPatterns on CampusCircleDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampusCircleDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampusCircleDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampusCircleDto value)  $default,){
final _that = this;
switch (_that) {
case _CampusCircleDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampusCircleDto value)?  $default,){
final _that = this;
switch (_that) {
case _CampusCircleDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? igName,  int memberCount,  int meetingCount,  String? lastMeetingTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampusCircleDto() when $default != null:
return $default(_that.id,_that.name,_that.igName,_that.memberCount,_that.meetingCount,_that.lastMeetingTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? igName,  int memberCount,  int meetingCount,  String? lastMeetingTime)  $default,) {final _that = this;
switch (_that) {
case _CampusCircleDto():
return $default(_that.id,_that.name,_that.igName,_that.memberCount,_that.meetingCount,_that.lastMeetingTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? igName,  int memberCount,  int meetingCount,  String? lastMeetingTime)?  $default,) {final _that = this;
switch (_that) {
case _CampusCircleDto() when $default != null:
return $default(_that.id,_that.name,_that.igName,_that.memberCount,_that.meetingCount,_that.lastMeetingTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CampusCircleDto extends CampusCircleDto {
  const _CampusCircleDto({required this.id, this.name = '', this.igName, this.memberCount = 0, this.meetingCount = 0, this.lastMeetingTime}): super._();
  factory _CampusCircleDto.fromJson(Map<String, dynamic> json) => _$CampusCircleDtoFromJson(json);

@override final  String id;
@override@JsonKey() final  String name;
@override final  String? igName;
@override@JsonKey() final  int memberCount;
@override@JsonKey() final  int meetingCount;
@override final  String? lastMeetingTime;

/// Create a copy of CampusCircleDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampusCircleDtoCopyWith<_CampusCircleDto> get copyWith => __$CampusCircleDtoCopyWithImpl<_CampusCircleDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CampusCircleDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampusCircleDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.igName, igName) || other.igName == igName)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.meetingCount, meetingCount) || other.meetingCount == meetingCount)&&(identical(other.lastMeetingTime, lastMeetingTime) || other.lastMeetingTime == lastMeetingTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,igName,memberCount,meetingCount,lastMeetingTime);

@override
String toString() {
  return 'CampusCircleDto(id: $id, name: $name, igName: $igName, memberCount: $memberCount, meetingCount: $meetingCount, lastMeetingTime: $lastMeetingTime)';
}


}

/// @nodoc
abstract mixin class _$CampusCircleDtoCopyWith<$Res> implements $CampusCircleDtoCopyWith<$Res> {
  factory _$CampusCircleDtoCopyWith(_CampusCircleDto value, $Res Function(_CampusCircleDto) _then) = __$CampusCircleDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? igName, int memberCount, int meetingCount, String? lastMeetingTime
});




}
/// @nodoc
class __$CampusCircleDtoCopyWithImpl<$Res>
    implements _$CampusCircleDtoCopyWith<$Res> {
  __$CampusCircleDtoCopyWithImpl(this._self, this._then);

  final _CampusCircleDto _self;
  final $Res Function(_CampusCircleDto) _then;

/// Create a copy of CampusCircleDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? igName = freezed,Object? memberCount = null,Object? meetingCount = null,Object? lastMeetingTime = freezed,}) {
  return _then(_CampusCircleDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,igName: freezed == igName ? _self.igName : igName // ignore: cast_nullable_to_non_nullable
as String?,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,meetingCount: null == meetingCount ? _self.meetingCount : meetingCount // ignore: cast_nullable_to_non_nullable
as int,lastMeetingTime: freezed == lastMeetingTime ? _self.lastMeetingTime : lastMeetingTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CampusIgDto {

 String get id; String get name; String get code; int get campusMemberCount; String? get iconImage;
/// Create a copy of CampusIgDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampusIgDtoCopyWith<CampusIgDto> get copyWith => _$CampusIgDtoCopyWithImpl<CampusIgDto>(this as CampusIgDto, _$identity);

  /// Serializes this CampusIgDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampusIgDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.campusMemberCount, campusMemberCount) || other.campusMemberCount == campusMemberCount)&&(identical(other.iconImage, iconImage) || other.iconImage == iconImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code,campusMemberCount,iconImage);

@override
String toString() {
  return 'CampusIgDto(id: $id, name: $name, code: $code, campusMemberCount: $campusMemberCount, iconImage: $iconImage)';
}


}

/// @nodoc
abstract mixin class $CampusIgDtoCopyWith<$Res>  {
  factory $CampusIgDtoCopyWith(CampusIgDto value, $Res Function(CampusIgDto) _then) = _$CampusIgDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String code, int campusMemberCount, String? iconImage
});




}
/// @nodoc
class _$CampusIgDtoCopyWithImpl<$Res>
    implements $CampusIgDtoCopyWith<$Res> {
  _$CampusIgDtoCopyWithImpl(this._self, this._then);

  final CampusIgDto _self;
  final $Res Function(CampusIgDto) _then;

/// Create a copy of CampusIgDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? code = null,Object? campusMemberCount = null,Object? iconImage = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,campusMemberCount: null == campusMemberCount ? _self.campusMemberCount : campusMemberCount // ignore: cast_nullable_to_non_nullable
as int,iconImage: freezed == iconImage ? _self.iconImage : iconImage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CampusIgDto].
extension CampusIgDtoPatterns on CampusIgDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampusIgDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampusIgDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampusIgDto value)  $default,){
final _that = this;
switch (_that) {
case _CampusIgDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampusIgDto value)?  $default,){
final _that = this;
switch (_that) {
case _CampusIgDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String code,  int campusMemberCount,  String? iconImage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampusIgDto() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.campusMemberCount,_that.iconImage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String code,  int campusMemberCount,  String? iconImage)  $default,) {final _that = this;
switch (_that) {
case _CampusIgDto():
return $default(_that.id,_that.name,_that.code,_that.campusMemberCount,_that.iconImage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String code,  int campusMemberCount,  String? iconImage)?  $default,) {final _that = this;
switch (_that) {
case _CampusIgDto() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.campusMemberCount,_that.iconImage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CampusIgDto extends CampusIgDto {
  const _CampusIgDto({required this.id, this.name = '', this.code = '', this.campusMemberCount = 0, this.iconImage}): super._();
  factory _CampusIgDto.fromJson(Map<String, dynamic> json) => _$CampusIgDtoFromJson(json);

@override final  String id;
@override@JsonKey() final  String name;
@override@JsonKey() final  String code;
@override@JsonKey() final  int campusMemberCount;
@override final  String? iconImage;

/// Create a copy of CampusIgDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampusIgDtoCopyWith<_CampusIgDto> get copyWith => __$CampusIgDtoCopyWithImpl<_CampusIgDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CampusIgDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampusIgDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.campusMemberCount, campusMemberCount) || other.campusMemberCount == campusMemberCount)&&(identical(other.iconImage, iconImage) || other.iconImage == iconImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code,campusMemberCount,iconImage);

@override
String toString() {
  return 'CampusIgDto(id: $id, name: $name, code: $code, campusMemberCount: $campusMemberCount, iconImage: $iconImage)';
}


}

/// @nodoc
abstract mixin class _$CampusIgDtoCopyWith<$Res> implements $CampusIgDtoCopyWith<$Res> {
  factory _$CampusIgDtoCopyWith(_CampusIgDto value, $Res Function(_CampusIgDto) _then) = __$CampusIgDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String code, int campusMemberCount, String? iconImage
});




}
/// @nodoc
class __$CampusIgDtoCopyWithImpl<$Res>
    implements _$CampusIgDtoCopyWith<$Res> {
  __$CampusIgDtoCopyWithImpl(this._self, this._then);

  final _CampusIgDto _self;
  final $Res Function(_CampusIgDto) _then;

/// Create a copy of CampusIgDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? code = null,Object? campusMemberCount = null,Object? iconImage = freezed,}) {
  return _then(_CampusIgDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,campusMemberCount: null == campusMemberCount ? _self.campusMemberCount : campusMemberCount // ignore: cast_nullable_to_non_nullable
as int,iconImage: freezed == iconImage ? _self.iconImage : iconImage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$StudentActivityDto {

 String get id; String get createdAt; String get taskName; String? get igName; int get karma; String get status;
/// Create a copy of StudentActivityDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentActivityDtoCopyWith<StudentActivityDto> get copyWith => _$StudentActivityDtoCopyWithImpl<StudentActivityDto>(this as StudentActivityDto, _$identity);

  /// Serializes this StudentActivityDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentActivityDto&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.taskName, taskName) || other.taskName == taskName)&&(identical(other.igName, igName) || other.igName == igName)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,taskName,igName,karma,status);

@override
String toString() {
  return 'StudentActivityDto(id: $id, createdAt: $createdAt, taskName: $taskName, igName: $igName, karma: $karma, status: $status)';
}


}

/// @nodoc
abstract mixin class $StudentActivityDtoCopyWith<$Res>  {
  factory $StudentActivityDtoCopyWith(StudentActivityDto value, $Res Function(StudentActivityDto) _then) = _$StudentActivityDtoCopyWithImpl;
@useResult
$Res call({
 String id, String createdAt, String taskName, String? igName, int karma, String status
});




}
/// @nodoc
class _$StudentActivityDtoCopyWithImpl<$Res>
    implements $StudentActivityDtoCopyWith<$Res> {
  _$StudentActivityDtoCopyWithImpl(this._self, this._then);

  final StudentActivityDto _self;
  final $Res Function(StudentActivityDto) _then;

/// Create a copy of StudentActivityDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? createdAt = null,Object? taskName = null,Object? igName = freezed,Object? karma = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,taskName: null == taskName ? _self.taskName : taskName // ignore: cast_nullable_to_non_nullable
as String,igName: freezed == igName ? _self.igName : igName // ignore: cast_nullable_to_non_nullable
as String?,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StudentActivityDto].
extension StudentActivityDtoPatterns on StudentActivityDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudentActivityDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudentActivityDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudentActivityDto value)  $default,){
final _that = this;
switch (_that) {
case _StudentActivityDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudentActivityDto value)?  $default,){
final _that = this;
switch (_that) {
case _StudentActivityDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String createdAt,  String taskName,  String? igName,  int karma,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudentActivityDto() when $default != null:
return $default(_that.id,_that.createdAt,_that.taskName,_that.igName,_that.karma,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String createdAt,  String taskName,  String? igName,  int karma,  String status)  $default,) {final _that = this;
switch (_that) {
case _StudentActivityDto():
return $default(_that.id,_that.createdAt,_that.taskName,_that.igName,_that.karma,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String createdAt,  String taskName,  String? igName,  int karma,  String status)?  $default,) {final _that = this;
switch (_that) {
case _StudentActivityDto() when $default != null:
return $default(_that.id,_that.createdAt,_that.taskName,_that.igName,_that.karma,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StudentActivityDto extends StudentActivityDto {
  const _StudentActivityDto({required this.id, required this.createdAt, this.taskName = '', this.igName, this.karma = 0, this.status = 'Pending'}): super._();
  factory _StudentActivityDto.fromJson(Map<String, dynamic> json) => _$StudentActivityDtoFromJson(json);

@override final  String id;
@override final  String createdAt;
@override@JsonKey() final  String taskName;
@override final  String? igName;
@override@JsonKey() final  int karma;
@override@JsonKey() final  String status;

/// Create a copy of StudentActivityDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudentActivityDtoCopyWith<_StudentActivityDto> get copyWith => __$StudentActivityDtoCopyWithImpl<_StudentActivityDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudentActivityDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudentActivityDto&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.taskName, taskName) || other.taskName == taskName)&&(identical(other.igName, igName) || other.igName == igName)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,taskName,igName,karma,status);

@override
String toString() {
  return 'StudentActivityDto(id: $id, createdAt: $createdAt, taskName: $taskName, igName: $igName, karma: $karma, status: $status)';
}


}

/// @nodoc
abstract mixin class _$StudentActivityDtoCopyWith<$Res> implements $StudentActivityDtoCopyWith<$Res> {
  factory _$StudentActivityDtoCopyWith(_StudentActivityDto value, $Res Function(_StudentActivityDto) _then) = __$StudentActivityDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String createdAt, String taskName, String? igName, int karma, String status
});




}
/// @nodoc
class __$StudentActivityDtoCopyWithImpl<$Res>
    implements _$StudentActivityDtoCopyWith<$Res> {
  __$StudentActivityDtoCopyWithImpl(this._self, this._then);

  final _StudentActivityDto _self;
  final $Res Function(_StudentActivityDto) _then;

/// Create a copy of StudentActivityDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdAt = null,Object? taskName = null,Object? igName = freezed,Object? karma = null,Object? status = null,}) {
  return _then(_StudentActivityDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,taskName: null == taskName ? _self.taskName : taskName // ignore: cast_nullable_to_non_nullable
as String,igName: freezed == igName ? _self.igName : igName // ignore: cast_nullable_to_non_nullable
as String?,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CampusStudentDto {

 String get fullName; String get muid; int get karma; int? get rank; String get level; String? get joinDate; String? get lastKarmaGained; String? get graduationYear; String? get department; bool get isAlumni; int get igCount; int get lcCount;
/// Create a copy of CampusStudentDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampusStudentDtoCopyWith<CampusStudentDto> get copyWith => _$CampusStudentDtoCopyWithImpl<CampusStudentDto>(this as CampusStudentDto, _$identity);

  /// Serializes this CampusStudentDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampusStudentDto&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.level, level) || other.level == level)&&(identical(other.joinDate, joinDate) || other.joinDate == joinDate)&&(identical(other.lastKarmaGained, lastKarmaGained) || other.lastKarmaGained == lastKarmaGained)&&(identical(other.graduationYear, graduationYear) || other.graduationYear == graduationYear)&&(identical(other.department, department) || other.department == department)&&(identical(other.isAlumni, isAlumni) || other.isAlumni == isAlumni)&&(identical(other.igCount, igCount) || other.igCount == igCount)&&(identical(other.lcCount, lcCount) || other.lcCount == lcCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,muid,karma,rank,level,joinDate,lastKarmaGained,graduationYear,department,isAlumni,igCount,lcCount);

@override
String toString() {
  return 'CampusStudentDto(fullName: $fullName, muid: $muid, karma: $karma, rank: $rank, level: $level, joinDate: $joinDate, lastKarmaGained: $lastKarmaGained, graduationYear: $graduationYear, department: $department, isAlumni: $isAlumni, igCount: $igCount, lcCount: $lcCount)';
}


}

/// @nodoc
abstract mixin class $CampusStudentDtoCopyWith<$Res>  {
  factory $CampusStudentDtoCopyWith(CampusStudentDto value, $Res Function(CampusStudentDto) _then) = _$CampusStudentDtoCopyWithImpl;
@useResult
$Res call({
 String fullName, String muid, int karma, int? rank, String level, String? joinDate, String? lastKarmaGained, String? graduationYear, String? department, bool isAlumni, int igCount, int lcCount
});




}
/// @nodoc
class _$CampusStudentDtoCopyWithImpl<$Res>
    implements $CampusStudentDtoCopyWith<$Res> {
  _$CampusStudentDtoCopyWithImpl(this._self, this._then);

  final CampusStudentDto _self;
  final $Res Function(CampusStudentDto) _then;

/// Create a copy of CampusStudentDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? muid = null,Object? karma = null,Object? rank = freezed,Object? level = null,Object? joinDate = freezed,Object? lastKarmaGained = freezed,Object? graduationYear = freezed,Object? department = freezed,Object? isAlumni = null,Object? igCount = null,Object? lcCount = null,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as int,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int?,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,joinDate: freezed == joinDate ? _self.joinDate : joinDate // ignore: cast_nullable_to_non_nullable
as String?,lastKarmaGained: freezed == lastKarmaGained ? _self.lastKarmaGained : lastKarmaGained // ignore: cast_nullable_to_non_nullable
as String?,graduationYear: freezed == graduationYear ? _self.graduationYear : graduationYear // ignore: cast_nullable_to_non_nullable
as String?,department: freezed == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String?,isAlumni: null == isAlumni ? _self.isAlumni : isAlumni // ignore: cast_nullable_to_non_nullable
as bool,igCount: null == igCount ? _self.igCount : igCount // ignore: cast_nullable_to_non_nullable
as int,lcCount: null == lcCount ? _self.lcCount : lcCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CampusStudentDto].
extension CampusStudentDtoPatterns on CampusStudentDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampusStudentDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampusStudentDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampusStudentDto value)  $default,){
final _that = this;
switch (_that) {
case _CampusStudentDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampusStudentDto value)?  $default,){
final _that = this;
switch (_that) {
case _CampusStudentDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fullName,  String muid,  int karma,  int? rank,  String level,  String? joinDate,  String? lastKarmaGained,  String? graduationYear,  String? department,  bool isAlumni,  int igCount,  int lcCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampusStudentDto() when $default != null:
return $default(_that.fullName,_that.muid,_that.karma,_that.rank,_that.level,_that.joinDate,_that.lastKarmaGained,_that.graduationYear,_that.department,_that.isAlumni,_that.igCount,_that.lcCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fullName,  String muid,  int karma,  int? rank,  String level,  String? joinDate,  String? lastKarmaGained,  String? graduationYear,  String? department,  bool isAlumni,  int igCount,  int lcCount)  $default,) {final _that = this;
switch (_that) {
case _CampusStudentDto():
return $default(_that.fullName,_that.muid,_that.karma,_that.rank,_that.level,_that.joinDate,_that.lastKarmaGained,_that.graduationYear,_that.department,_that.isAlumni,_that.igCount,_that.lcCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fullName,  String muid,  int karma,  int? rank,  String level,  String? joinDate,  String? lastKarmaGained,  String? graduationYear,  String? department,  bool isAlumni,  int igCount,  int lcCount)?  $default,) {final _that = this;
switch (_that) {
case _CampusStudentDto() when $default != null:
return $default(_that.fullName,_that.muid,_that.karma,_that.rank,_that.level,_that.joinDate,_that.lastKarmaGained,_that.graduationYear,_that.department,_that.isAlumni,_that.igCount,_that.lcCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CampusStudentDto extends CampusStudentDto {
  const _CampusStudentDto({this.fullName = '', this.muid = '', this.karma = 0, this.rank, this.level = '', this.joinDate, this.lastKarmaGained, this.graduationYear, this.department, this.isAlumni = false, this.igCount = 0, this.lcCount = 0}): super._();
  factory _CampusStudentDto.fromJson(Map<String, dynamic> json) => _$CampusStudentDtoFromJson(json);

@override@JsonKey() final  String fullName;
@override@JsonKey() final  String muid;
@override@JsonKey() final  int karma;
@override final  int? rank;
@override@JsonKey() final  String level;
@override final  String? joinDate;
@override final  String? lastKarmaGained;
@override final  String? graduationYear;
@override final  String? department;
@override@JsonKey() final  bool isAlumni;
@override@JsonKey() final  int igCount;
@override@JsonKey() final  int lcCount;

/// Create a copy of CampusStudentDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampusStudentDtoCopyWith<_CampusStudentDto> get copyWith => __$CampusStudentDtoCopyWithImpl<_CampusStudentDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CampusStudentDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampusStudentDto&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.level, level) || other.level == level)&&(identical(other.joinDate, joinDate) || other.joinDate == joinDate)&&(identical(other.lastKarmaGained, lastKarmaGained) || other.lastKarmaGained == lastKarmaGained)&&(identical(other.graduationYear, graduationYear) || other.graduationYear == graduationYear)&&(identical(other.department, department) || other.department == department)&&(identical(other.isAlumni, isAlumni) || other.isAlumni == isAlumni)&&(identical(other.igCount, igCount) || other.igCount == igCount)&&(identical(other.lcCount, lcCount) || other.lcCount == lcCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,muid,karma,rank,level,joinDate,lastKarmaGained,graduationYear,department,isAlumni,igCount,lcCount);

@override
String toString() {
  return 'CampusStudentDto(fullName: $fullName, muid: $muid, karma: $karma, rank: $rank, level: $level, joinDate: $joinDate, lastKarmaGained: $lastKarmaGained, graduationYear: $graduationYear, department: $department, isAlumni: $isAlumni, igCount: $igCount, lcCount: $lcCount)';
}


}

/// @nodoc
abstract mixin class _$CampusStudentDtoCopyWith<$Res> implements $CampusStudentDtoCopyWith<$Res> {
  factory _$CampusStudentDtoCopyWith(_CampusStudentDto value, $Res Function(_CampusStudentDto) _then) = __$CampusStudentDtoCopyWithImpl;
@override @useResult
$Res call({
 String fullName, String muid, int karma, int? rank, String level, String? joinDate, String? lastKarmaGained, String? graduationYear, String? department, bool isAlumni, int igCount, int lcCount
});




}
/// @nodoc
class __$CampusStudentDtoCopyWithImpl<$Res>
    implements _$CampusStudentDtoCopyWith<$Res> {
  __$CampusStudentDtoCopyWithImpl(this._self, this._then);

  final _CampusStudentDto _self;
  final $Res Function(_CampusStudentDto) _then;

/// Create a copy of CampusStudentDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? muid = null,Object? karma = null,Object? rank = freezed,Object? level = null,Object? joinDate = freezed,Object? lastKarmaGained = freezed,Object? graduationYear = freezed,Object? department = freezed,Object? isAlumni = null,Object? igCount = null,Object? lcCount = null,}) {
  return _then(_CampusStudentDto(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as int,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int?,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,joinDate: freezed == joinDate ? _self.joinDate : joinDate // ignore: cast_nullable_to_non_nullable
as String?,lastKarmaGained: freezed == lastKarmaGained ? _self.lastKarmaGained : lastKarmaGained // ignore: cast_nullable_to_non_nullable
as String?,graduationYear: freezed == graduationYear ? _self.graduationYear : graduationYear // ignore: cast_nullable_to_non_nullable
as String?,department: freezed == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String?,isAlumni: null == isAlumni ? _self.isAlumni : isAlumni // ignore: cast_nullable_to_non_nullable
as bool,igCount: null == igCount ? _self.igCount : igCount // ignore: cast_nullable_to_non_nullable
as int,lcCount: null == lcCount ? _self.lcCount : lcCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
