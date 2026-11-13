// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'availability_slot_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AvailabilitySlotDto {

 String get id; int get weekday; String get startTime; String get endTime; String get timezone; bool get isActive; String? get igId; String? get igName;
/// Create a copy of AvailabilitySlotDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvailabilitySlotDtoCopyWith<AvailabilitySlotDto> get copyWith => _$AvailabilitySlotDtoCopyWithImpl<AvailabilitySlotDto>(this as AvailabilitySlotDto, _$identity);

  /// Serializes this AvailabilitySlotDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvailabilitySlotDto&&(identical(other.id, id) || other.id == id)&&(identical(other.weekday, weekday) || other.weekday == weekday)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.igId, igId) || other.igId == igId)&&(identical(other.igName, igName) || other.igName == igName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,weekday,startTime,endTime,timezone,isActive,igId,igName);

@override
String toString() {
  return 'AvailabilitySlotDto(id: $id, weekday: $weekday, startTime: $startTime, endTime: $endTime, timezone: $timezone, isActive: $isActive, igId: $igId, igName: $igName)';
}


}

/// @nodoc
abstract mixin class $AvailabilitySlotDtoCopyWith<$Res>  {
  factory $AvailabilitySlotDtoCopyWith(AvailabilitySlotDto value, $Res Function(AvailabilitySlotDto) _then) = _$AvailabilitySlotDtoCopyWithImpl;
@useResult
$Res call({
 String id, int weekday, String startTime, String endTime, String timezone, bool isActive, String? igId, String? igName
});




}
/// @nodoc
class _$AvailabilitySlotDtoCopyWithImpl<$Res>
    implements $AvailabilitySlotDtoCopyWith<$Res> {
  _$AvailabilitySlotDtoCopyWithImpl(this._self, this._then);

  final AvailabilitySlotDto _self;
  final $Res Function(AvailabilitySlotDto) _then;

/// Create a copy of AvailabilitySlotDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? weekday = null,Object? startTime = null,Object? endTime = null,Object? timezone = null,Object? isActive = null,Object? igId = freezed,Object? igName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,igId: freezed == igId ? _self.igId : igId // ignore: cast_nullable_to_non_nullable
as String?,igName: freezed == igName ? _self.igName : igName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AvailabilitySlotDto].
extension AvailabilitySlotDtoPatterns on AvailabilitySlotDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AvailabilitySlotDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AvailabilitySlotDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AvailabilitySlotDto value)  $default,){
final _that = this;
switch (_that) {
case _AvailabilitySlotDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AvailabilitySlotDto value)?  $default,){
final _that = this;
switch (_that) {
case _AvailabilitySlotDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int weekday,  String startTime,  String endTime,  String timezone,  bool isActive,  String? igId,  String? igName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AvailabilitySlotDto() when $default != null:
return $default(_that.id,_that.weekday,_that.startTime,_that.endTime,_that.timezone,_that.isActive,_that.igId,_that.igName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int weekday,  String startTime,  String endTime,  String timezone,  bool isActive,  String? igId,  String? igName)  $default,) {final _that = this;
switch (_that) {
case _AvailabilitySlotDto():
return $default(_that.id,_that.weekday,_that.startTime,_that.endTime,_that.timezone,_that.isActive,_that.igId,_that.igName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int weekday,  String startTime,  String endTime,  String timezone,  bool isActive,  String? igId,  String? igName)?  $default,) {final _that = this;
switch (_that) {
case _AvailabilitySlotDto() when $default != null:
return $default(_that.id,_that.weekday,_that.startTime,_that.endTime,_that.timezone,_that.isActive,_that.igId,_that.igName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AvailabilitySlotDto extends AvailabilitySlotDto {
  const _AvailabilitySlotDto({required this.id, required this.weekday, required this.startTime, required this.endTime, this.timezone = defaultTimezone, this.isActive = true, this.igId, this.igName}): super._();
  factory _AvailabilitySlotDto.fromJson(Map<String, dynamic> json) => _$AvailabilitySlotDtoFromJson(json);

@override final  String id;
@override final  int weekday;
@override final  String startTime;
@override final  String endTime;
@override@JsonKey() final  String timezone;
@override@JsonKey() final  bool isActive;
@override final  String? igId;
@override final  String? igName;

/// Create a copy of AvailabilitySlotDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AvailabilitySlotDtoCopyWith<_AvailabilitySlotDto> get copyWith => __$AvailabilitySlotDtoCopyWithImpl<_AvailabilitySlotDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AvailabilitySlotDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AvailabilitySlotDto&&(identical(other.id, id) || other.id == id)&&(identical(other.weekday, weekday) || other.weekday == weekday)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.igId, igId) || other.igId == igId)&&(identical(other.igName, igName) || other.igName == igName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,weekday,startTime,endTime,timezone,isActive,igId,igName);

@override
String toString() {
  return 'AvailabilitySlotDto(id: $id, weekday: $weekday, startTime: $startTime, endTime: $endTime, timezone: $timezone, isActive: $isActive, igId: $igId, igName: $igName)';
}


}

/// @nodoc
abstract mixin class _$AvailabilitySlotDtoCopyWith<$Res> implements $AvailabilitySlotDtoCopyWith<$Res> {
  factory _$AvailabilitySlotDtoCopyWith(_AvailabilitySlotDto value, $Res Function(_AvailabilitySlotDto) _then) = __$AvailabilitySlotDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, int weekday, String startTime, String endTime, String timezone, bool isActive, String? igId, String? igName
});




}
/// @nodoc
class __$AvailabilitySlotDtoCopyWithImpl<$Res>
    implements _$AvailabilitySlotDtoCopyWith<$Res> {
  __$AvailabilitySlotDtoCopyWithImpl(this._self, this._then);

  final _AvailabilitySlotDto _self;
  final $Res Function(_AvailabilitySlotDto) _then;

/// Create a copy of AvailabilitySlotDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? weekday = null,Object? startTime = null,Object? endTime = null,Object? timezone = null,Object? isActive = null,Object? igId = freezed,Object? igName = freezed,}) {
  return _then(_AvailabilitySlotDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,igId: freezed == igId ? _self.igId : igId // ignore: cast_nullable_to_non_nullable
as String?,igName: freezed == igName ? _self.igName : igName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
