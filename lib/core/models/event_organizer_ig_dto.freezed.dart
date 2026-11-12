// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_organizer_ig_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventOrganizerIgDto {

 String get id; String get name; String? get iconImage;
/// Create a copy of EventOrganizerIgDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventOrganizerIgDtoCopyWith<EventOrganizerIgDto> get copyWith => _$EventOrganizerIgDtoCopyWithImpl<EventOrganizerIgDto>(this as EventOrganizerIgDto, _$identity);

  /// Serializes this EventOrganizerIgDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventOrganizerIgDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconImage, iconImage) || other.iconImage == iconImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,iconImage);

@override
String toString() {
  return 'EventOrganizerIgDto(id: $id, name: $name, iconImage: $iconImage)';
}


}

/// @nodoc
abstract mixin class $EventOrganizerIgDtoCopyWith<$Res>  {
  factory $EventOrganizerIgDtoCopyWith(EventOrganizerIgDto value, $Res Function(EventOrganizerIgDto) _then) = _$EventOrganizerIgDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? iconImage
});




}
/// @nodoc
class _$EventOrganizerIgDtoCopyWithImpl<$Res>
    implements $EventOrganizerIgDtoCopyWith<$Res> {
  _$EventOrganizerIgDtoCopyWithImpl(this._self, this._then);

  final EventOrganizerIgDto _self;
  final $Res Function(EventOrganizerIgDto) _then;

/// Create a copy of EventOrganizerIgDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? iconImage = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconImage: freezed == iconImage ? _self.iconImage : iconImage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EventOrganizerIgDto].
extension EventOrganizerIgDtoPatterns on EventOrganizerIgDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventOrganizerIgDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventOrganizerIgDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventOrganizerIgDto value)  $default,){
final _that = this;
switch (_that) {
case _EventOrganizerIgDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventOrganizerIgDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventOrganizerIgDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? iconImage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventOrganizerIgDto() when $default != null:
return $default(_that.id,_that.name,_that.iconImage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? iconImage)  $default,) {final _that = this;
switch (_that) {
case _EventOrganizerIgDto():
return $default(_that.id,_that.name,_that.iconImage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? iconImage)?  $default,) {final _that = this;
switch (_that) {
case _EventOrganizerIgDto() when $default != null:
return $default(_that.id,_that.name,_that.iconImage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventOrganizerIgDto extends EventOrganizerIgDto {
  const _EventOrganizerIgDto({required this.id, required this.name, this.iconImage}): super._();
  factory _EventOrganizerIgDto.fromJson(Map<String, dynamic> json) => _$EventOrganizerIgDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? iconImage;

/// Create a copy of EventOrganizerIgDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventOrganizerIgDtoCopyWith<_EventOrganizerIgDto> get copyWith => __$EventOrganizerIgDtoCopyWithImpl<_EventOrganizerIgDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventOrganizerIgDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventOrganizerIgDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconImage, iconImage) || other.iconImage == iconImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,iconImage);

@override
String toString() {
  return 'EventOrganizerIgDto(id: $id, name: $name, iconImage: $iconImage)';
}


}

/// @nodoc
abstract mixin class _$EventOrganizerIgDtoCopyWith<$Res> implements $EventOrganizerIgDtoCopyWith<$Res> {
  factory _$EventOrganizerIgDtoCopyWith(_EventOrganizerIgDto value, $Res Function(_EventOrganizerIgDto) _then) = __$EventOrganizerIgDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? iconImage
});




}
/// @nodoc
class __$EventOrganizerIgDtoCopyWithImpl<$Res>
    implements _$EventOrganizerIgDtoCopyWith<$Res> {
  __$EventOrganizerIgDtoCopyWithImpl(this._self, this._then);

  final _EventOrganizerIgDto _self;
  final $Res Function(_EventOrganizerIgDto) _then;

/// Create a copy of EventOrganizerIgDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? iconImage = freezed,}) {
  return _then(_EventOrganizerIgDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconImage: freezed == iconImage ? _self.iconImage : iconImage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
