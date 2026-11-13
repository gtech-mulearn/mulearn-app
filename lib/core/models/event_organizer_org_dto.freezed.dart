// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_organizer_org_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventOrganizerOrgDto {

 String get id; String get title; String get orgType;
/// Create a copy of EventOrganizerOrgDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventOrganizerOrgDtoCopyWith<EventOrganizerOrgDto> get copyWith => _$EventOrganizerOrgDtoCopyWithImpl<EventOrganizerOrgDto>(this as EventOrganizerOrgDto, _$identity);

  /// Serializes this EventOrganizerOrgDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventOrganizerOrgDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.orgType, orgType) || other.orgType == orgType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,orgType);

@override
String toString() {
  return 'EventOrganizerOrgDto(id: $id, title: $title, orgType: $orgType)';
}


}

/// @nodoc
abstract mixin class $EventOrganizerOrgDtoCopyWith<$Res>  {
  factory $EventOrganizerOrgDtoCopyWith(EventOrganizerOrgDto value, $Res Function(EventOrganizerOrgDto) _then) = _$EventOrganizerOrgDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String orgType
});




}
/// @nodoc
class _$EventOrganizerOrgDtoCopyWithImpl<$Res>
    implements $EventOrganizerOrgDtoCopyWith<$Res> {
  _$EventOrganizerOrgDtoCopyWithImpl(this._self, this._then);

  final EventOrganizerOrgDto _self;
  final $Res Function(EventOrganizerOrgDto) _then;

/// Create a copy of EventOrganizerOrgDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? orgType = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,orgType: null == orgType ? _self.orgType : orgType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EventOrganizerOrgDto].
extension EventOrganizerOrgDtoPatterns on EventOrganizerOrgDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventOrganizerOrgDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventOrganizerOrgDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventOrganizerOrgDto value)  $default,){
final _that = this;
switch (_that) {
case _EventOrganizerOrgDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventOrganizerOrgDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventOrganizerOrgDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String orgType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventOrganizerOrgDto() when $default != null:
return $default(_that.id,_that.title,_that.orgType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String orgType)  $default,) {final _that = this;
switch (_that) {
case _EventOrganizerOrgDto():
return $default(_that.id,_that.title,_that.orgType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String orgType)?  $default,) {final _that = this;
switch (_that) {
case _EventOrganizerOrgDto() when $default != null:
return $default(_that.id,_that.title,_that.orgType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventOrganizerOrgDto extends EventOrganizerOrgDto {
  const _EventOrganizerOrgDto({required this.id, required this.title, required this.orgType}): super._();
  factory _EventOrganizerOrgDto.fromJson(Map<String, dynamic> json) => _$EventOrganizerOrgDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  String orgType;

/// Create a copy of EventOrganizerOrgDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventOrganizerOrgDtoCopyWith<_EventOrganizerOrgDto> get copyWith => __$EventOrganizerOrgDtoCopyWithImpl<_EventOrganizerOrgDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventOrganizerOrgDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventOrganizerOrgDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.orgType, orgType) || other.orgType == orgType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,orgType);

@override
String toString() {
  return 'EventOrganizerOrgDto(id: $id, title: $title, orgType: $orgType)';
}


}

/// @nodoc
abstract mixin class _$EventOrganizerOrgDtoCopyWith<$Res> implements $EventOrganizerOrgDtoCopyWith<$Res> {
  factory _$EventOrganizerOrgDtoCopyWith(_EventOrganizerOrgDto value, $Res Function(_EventOrganizerOrgDto) _then) = __$EventOrganizerOrgDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String orgType
});




}
/// @nodoc
class __$EventOrganizerOrgDtoCopyWithImpl<$Res>
    implements _$EventOrganizerOrgDtoCopyWith<$Res> {
  __$EventOrganizerOrgDtoCopyWithImpl(this._self, this._then);

  final _EventOrganizerOrgDto _self;
  final $Res Function(_EventOrganizerOrgDto) _then;

/// Create a copy of EventOrganizerOrgDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? orgType = null,}) {
  return _then(_EventOrganizerOrgDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,orgType: null == orgType ? _self.orgType : orgType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
