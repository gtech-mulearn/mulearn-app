// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'enabler_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EnablerCampusDto {

 String get id; String get collegeName; String get campusCode; String? get zone; String get orgType;
/// Create a copy of EnablerCampusDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EnablerCampusDtoCopyWith<EnablerCampusDto> get copyWith => _$EnablerCampusDtoCopyWithImpl<EnablerCampusDto>(this as EnablerCampusDto, _$identity);

  /// Serializes this EnablerCampusDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EnablerCampusDto&&(identical(other.id, id) || other.id == id)&&(identical(other.collegeName, collegeName) || other.collegeName == collegeName)&&(identical(other.campusCode, campusCode) || other.campusCode == campusCode)&&(identical(other.zone, zone) || other.zone == zone)&&(identical(other.orgType, orgType) || other.orgType == orgType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,collegeName,campusCode,zone,orgType);

@override
String toString() {
  return 'EnablerCampusDto(id: $id, collegeName: $collegeName, campusCode: $campusCode, zone: $zone, orgType: $orgType)';
}


}

/// @nodoc
abstract mixin class $EnablerCampusDtoCopyWith<$Res>  {
  factory $EnablerCampusDtoCopyWith(EnablerCampusDto value, $Res Function(EnablerCampusDto) _then) = _$EnablerCampusDtoCopyWithImpl;
@useResult
$Res call({
 String id, String collegeName, String campusCode, String? zone, String orgType
});




}
/// @nodoc
class _$EnablerCampusDtoCopyWithImpl<$Res>
    implements $EnablerCampusDtoCopyWith<$Res> {
  _$EnablerCampusDtoCopyWithImpl(this._self, this._then);

  final EnablerCampusDto _self;
  final $Res Function(EnablerCampusDto) _then;

/// Create a copy of EnablerCampusDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? collegeName = null,Object? campusCode = null,Object? zone = freezed,Object? orgType = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,collegeName: null == collegeName ? _self.collegeName : collegeName // ignore: cast_nullable_to_non_nullable
as String,campusCode: null == campusCode ? _self.campusCode : campusCode // ignore: cast_nullable_to_non_nullable
as String,zone: freezed == zone ? _self.zone : zone // ignore: cast_nullable_to_non_nullable
as String?,orgType: null == orgType ? _self.orgType : orgType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EnablerCampusDto].
extension EnablerCampusDtoPatterns on EnablerCampusDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EnablerCampusDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EnablerCampusDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EnablerCampusDto value)  $default,){
final _that = this;
switch (_that) {
case _EnablerCampusDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EnablerCampusDto value)?  $default,){
final _that = this;
switch (_that) {
case _EnablerCampusDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String collegeName,  String campusCode,  String? zone,  String orgType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EnablerCampusDto() when $default != null:
return $default(_that.id,_that.collegeName,_that.campusCode,_that.zone,_that.orgType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String collegeName,  String campusCode,  String? zone,  String orgType)  $default,) {final _that = this;
switch (_that) {
case _EnablerCampusDto():
return $default(_that.id,_that.collegeName,_that.campusCode,_that.zone,_that.orgType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String collegeName,  String campusCode,  String? zone,  String orgType)?  $default,) {final _that = this;
switch (_that) {
case _EnablerCampusDto() when $default != null:
return $default(_that.id,_that.collegeName,_that.campusCode,_that.zone,_that.orgType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EnablerCampusDto extends EnablerCampusDto {
  const _EnablerCampusDto({required this.id, this.collegeName = '', this.campusCode = '', this.zone, this.orgType = ''}): super._();
  factory _EnablerCampusDto.fromJson(Map<String, dynamic> json) => _$EnablerCampusDtoFromJson(json);

@override final  String id;
@override@JsonKey() final  String collegeName;
@override@JsonKey() final  String campusCode;
@override final  String? zone;
@override@JsonKey() final  String orgType;

/// Create a copy of EnablerCampusDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EnablerCampusDtoCopyWith<_EnablerCampusDto> get copyWith => __$EnablerCampusDtoCopyWithImpl<_EnablerCampusDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EnablerCampusDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EnablerCampusDto&&(identical(other.id, id) || other.id == id)&&(identical(other.collegeName, collegeName) || other.collegeName == collegeName)&&(identical(other.campusCode, campusCode) || other.campusCode == campusCode)&&(identical(other.zone, zone) || other.zone == zone)&&(identical(other.orgType, orgType) || other.orgType == orgType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,collegeName,campusCode,zone,orgType);

@override
String toString() {
  return 'EnablerCampusDto(id: $id, collegeName: $collegeName, campusCode: $campusCode, zone: $zone, orgType: $orgType)';
}


}

/// @nodoc
abstract mixin class _$EnablerCampusDtoCopyWith<$Res> implements $EnablerCampusDtoCopyWith<$Res> {
  factory _$EnablerCampusDtoCopyWith(_EnablerCampusDto value, $Res Function(_EnablerCampusDto) _then) = __$EnablerCampusDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String collegeName, String campusCode, String? zone, String orgType
});




}
/// @nodoc
class __$EnablerCampusDtoCopyWithImpl<$Res>
    implements _$EnablerCampusDtoCopyWith<$Res> {
  __$EnablerCampusDtoCopyWithImpl(this._self, this._then);

  final _EnablerCampusDto _self;
  final $Res Function(_EnablerCampusDto) _then;

/// Create a copy of EnablerCampusDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? collegeName = null,Object? campusCode = null,Object? zone = freezed,Object? orgType = null,}) {
  return _then(_EnablerCampusDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,collegeName: null == collegeName ? _self.collegeName : collegeName // ignore: cast_nullable_to_non_nullable
as String,campusCode: null == campusCode ? _self.campusCode : campusCode // ignore: cast_nullable_to_non_nullable
as String,zone: freezed == zone ? _self.zone : zone // ignore: cast_nullable_to_non_nullable
as String?,orgType: null == orgType ? _self.orgType : orgType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CampusNoteDto {

 String get id; String get createdAt; String get note; String get priority; String get status; String? get enablerName; String? get followUpDate;
/// Create a copy of CampusNoteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampusNoteDtoCopyWith<CampusNoteDto> get copyWith => _$CampusNoteDtoCopyWithImpl<CampusNoteDto>(this as CampusNoteDto, _$identity);

  /// Serializes this CampusNoteDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampusNoteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.note, note) || other.note == note)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.enablerName, enablerName) || other.enablerName == enablerName)&&(identical(other.followUpDate, followUpDate) || other.followUpDate == followUpDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,note,priority,status,enablerName,followUpDate);

@override
String toString() {
  return 'CampusNoteDto(id: $id, createdAt: $createdAt, note: $note, priority: $priority, status: $status, enablerName: $enablerName, followUpDate: $followUpDate)';
}


}

/// @nodoc
abstract mixin class $CampusNoteDtoCopyWith<$Res>  {
  factory $CampusNoteDtoCopyWith(CampusNoteDto value, $Res Function(CampusNoteDto) _then) = _$CampusNoteDtoCopyWithImpl;
@useResult
$Res call({
 String id, String createdAt, String note, String priority, String status, String? enablerName, String? followUpDate
});




}
/// @nodoc
class _$CampusNoteDtoCopyWithImpl<$Res>
    implements $CampusNoteDtoCopyWith<$Res> {
  _$CampusNoteDtoCopyWithImpl(this._self, this._then);

  final CampusNoteDto _self;
  final $Res Function(CampusNoteDto) _then;

/// Create a copy of CampusNoteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? createdAt = null,Object? note = null,Object? priority = null,Object? status = null,Object? enablerName = freezed,Object? followUpDate = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,enablerName: freezed == enablerName ? _self.enablerName : enablerName // ignore: cast_nullable_to_non_nullable
as String?,followUpDate: freezed == followUpDate ? _self.followUpDate : followUpDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CampusNoteDto].
extension CampusNoteDtoPatterns on CampusNoteDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampusNoteDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampusNoteDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampusNoteDto value)  $default,){
final _that = this;
switch (_that) {
case _CampusNoteDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampusNoteDto value)?  $default,){
final _that = this;
switch (_that) {
case _CampusNoteDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String createdAt,  String note,  String priority,  String status,  String? enablerName,  String? followUpDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampusNoteDto() when $default != null:
return $default(_that.id,_that.createdAt,_that.note,_that.priority,_that.status,_that.enablerName,_that.followUpDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String createdAt,  String note,  String priority,  String status,  String? enablerName,  String? followUpDate)  $default,) {final _that = this;
switch (_that) {
case _CampusNoteDto():
return $default(_that.id,_that.createdAt,_that.note,_that.priority,_that.status,_that.enablerName,_that.followUpDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String createdAt,  String note,  String priority,  String status,  String? enablerName,  String? followUpDate)?  $default,) {final _that = this;
switch (_that) {
case _CampusNoteDto() when $default != null:
return $default(_that.id,_that.createdAt,_that.note,_that.priority,_that.status,_that.enablerName,_that.followUpDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CampusNoteDto extends CampusNoteDto {
  const _CampusNoteDto({required this.id, required this.createdAt, this.note = '', this.priority = 'medium', this.status = 'open', this.enablerName, this.followUpDate}): super._();
  factory _CampusNoteDto.fromJson(Map<String, dynamic> json) => _$CampusNoteDtoFromJson(json);

@override final  String id;
@override final  String createdAt;
@override@JsonKey() final  String note;
@override@JsonKey() final  String priority;
@override@JsonKey() final  String status;
@override final  String? enablerName;
@override final  String? followUpDate;

/// Create a copy of CampusNoteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampusNoteDtoCopyWith<_CampusNoteDto> get copyWith => __$CampusNoteDtoCopyWithImpl<_CampusNoteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CampusNoteDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampusNoteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.note, note) || other.note == note)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.enablerName, enablerName) || other.enablerName == enablerName)&&(identical(other.followUpDate, followUpDate) || other.followUpDate == followUpDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,createdAt,note,priority,status,enablerName,followUpDate);

@override
String toString() {
  return 'CampusNoteDto(id: $id, createdAt: $createdAt, note: $note, priority: $priority, status: $status, enablerName: $enablerName, followUpDate: $followUpDate)';
}


}

/// @nodoc
abstract mixin class _$CampusNoteDtoCopyWith<$Res> implements $CampusNoteDtoCopyWith<$Res> {
  factory _$CampusNoteDtoCopyWith(_CampusNoteDto value, $Res Function(_CampusNoteDto) _then) = __$CampusNoteDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String createdAt, String note, String priority, String status, String? enablerName, String? followUpDate
});




}
/// @nodoc
class __$CampusNoteDtoCopyWithImpl<$Res>
    implements _$CampusNoteDtoCopyWith<$Res> {
  __$CampusNoteDtoCopyWithImpl(this._self, this._then);

  final _CampusNoteDto _self;
  final $Res Function(_CampusNoteDto) _then;

/// Create a copy of CampusNoteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdAt = null,Object? note = null,Object? priority = null,Object? status = null,Object? enablerName = freezed,Object? followUpDate = freezed,}) {
  return _then(_CampusNoteDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,enablerName: freezed == enablerName ? _self.enablerName : enablerName // ignore: cast_nullable_to_non_nullable
as String?,followUpDate: freezed == followUpDate ? _self.followUpDate : followUpDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
