// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_entry_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalendarEntryDto {

 String get id; String get title; String get start; String get end; String get status; String? get venueType; String? get organiserName; String? get categoryName; bool get isFeatured;
/// Create a copy of CalendarEntryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarEntryDtoCopyWith<CalendarEntryDto> get copyWith => _$CalendarEntryDtoCopyWithImpl<CalendarEntryDto>(this as CalendarEntryDto, _$identity);

  /// Serializes this CalendarEntryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarEntryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.status, status) || other.status == status)&&(identical(other.venueType, venueType) || other.venueType == venueType)&&(identical(other.organiserName, organiserName) || other.organiserName == organiserName)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,start,end,status,venueType,organiserName,categoryName,isFeatured);

@override
String toString() {
  return 'CalendarEntryDto(id: $id, title: $title, start: $start, end: $end, status: $status, venueType: $venueType, organiserName: $organiserName, categoryName: $categoryName, isFeatured: $isFeatured)';
}


}

/// @nodoc
abstract mixin class $CalendarEntryDtoCopyWith<$Res>  {
  factory $CalendarEntryDtoCopyWith(CalendarEntryDto value, $Res Function(CalendarEntryDto) _then) = _$CalendarEntryDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String start, String end, String status, String? venueType, String? organiserName, String? categoryName, bool isFeatured
});




}
/// @nodoc
class _$CalendarEntryDtoCopyWithImpl<$Res>
    implements $CalendarEntryDtoCopyWith<$Res> {
  _$CalendarEntryDtoCopyWithImpl(this._self, this._then);

  final CalendarEntryDto _self;
  final $Res Function(CalendarEntryDto) _then;

/// Create a copy of CalendarEntryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? start = null,Object? end = null,Object? status = null,Object? venueType = freezed,Object? organiserName = freezed,Object? categoryName = freezed,Object? isFeatured = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as String,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,venueType: freezed == venueType ? _self.venueType : venueType // ignore: cast_nullable_to_non_nullable
as String?,organiserName: freezed == organiserName ? _self.organiserName : organiserName // ignore: cast_nullable_to_non_nullable
as String?,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarEntryDto].
extension CalendarEntryDtoPatterns on CalendarEntryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarEntryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarEntryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarEntryDto value)  $default,){
final _that = this;
switch (_that) {
case _CalendarEntryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarEntryDto value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarEntryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String start,  String end,  String status,  String? venueType,  String? organiserName,  String? categoryName,  bool isFeatured)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarEntryDto() when $default != null:
return $default(_that.id,_that.title,_that.start,_that.end,_that.status,_that.venueType,_that.organiserName,_that.categoryName,_that.isFeatured);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String start,  String end,  String status,  String? venueType,  String? organiserName,  String? categoryName,  bool isFeatured)  $default,) {final _that = this;
switch (_that) {
case _CalendarEntryDto():
return $default(_that.id,_that.title,_that.start,_that.end,_that.status,_that.venueType,_that.organiserName,_that.categoryName,_that.isFeatured);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String start,  String end,  String status,  String? venueType,  String? organiserName,  String? categoryName,  bool isFeatured)?  $default,) {final _that = this;
switch (_that) {
case _CalendarEntryDto() when $default != null:
return $default(_that.id,_that.title,_that.start,_that.end,_that.status,_that.venueType,_that.organiserName,_that.categoryName,_that.isFeatured);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalendarEntryDto extends CalendarEntryDto {
  const _CalendarEntryDto({required this.id, required this.title, required this.start, required this.end, this.status = '', this.venueType, this.organiserName, this.categoryName, this.isFeatured = false}): super._();
  factory _CalendarEntryDto.fromJson(Map<String, dynamic> json) => _$CalendarEntryDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  String start;
@override final  String end;
@override@JsonKey() final  String status;
@override final  String? venueType;
@override final  String? organiserName;
@override final  String? categoryName;
@override@JsonKey() final  bool isFeatured;

/// Create a copy of CalendarEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarEntryDtoCopyWith<_CalendarEntryDto> get copyWith => __$CalendarEntryDtoCopyWithImpl<_CalendarEntryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalendarEntryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarEntryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.status, status) || other.status == status)&&(identical(other.venueType, venueType) || other.venueType == venueType)&&(identical(other.organiserName, organiserName) || other.organiserName == organiserName)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,start,end,status,venueType,organiserName,categoryName,isFeatured);

@override
String toString() {
  return 'CalendarEntryDto(id: $id, title: $title, start: $start, end: $end, status: $status, venueType: $venueType, organiserName: $organiserName, categoryName: $categoryName, isFeatured: $isFeatured)';
}


}

/// @nodoc
abstract mixin class _$CalendarEntryDtoCopyWith<$Res> implements $CalendarEntryDtoCopyWith<$Res> {
  factory _$CalendarEntryDtoCopyWith(_CalendarEntryDto value, $Res Function(_CalendarEntryDto) _then) = __$CalendarEntryDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String start, String end, String status, String? venueType, String? organiserName, String? categoryName, bool isFeatured
});




}
/// @nodoc
class __$CalendarEntryDtoCopyWithImpl<$Res>
    implements _$CalendarEntryDtoCopyWith<$Res> {
  __$CalendarEntryDtoCopyWithImpl(this._self, this._then);

  final _CalendarEntryDto _self;
  final $Res Function(_CalendarEntryDto) _then;

/// Create a copy of CalendarEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? start = null,Object? end = null,Object? status = null,Object? venueType = freezed,Object? organiserName = freezed,Object? categoryName = freezed,Object? isFeatured = null,}) {
  return _then(_CalendarEntryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as String,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,venueType: freezed == venueType ? _self.venueType : venueType // ignore: cast_nullable_to_non_nullable
as String?,organiserName: freezed == organiserName ? _self.organiserName : organiserName // ignore: cast_nullable_to_non_nullable
as String?,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
