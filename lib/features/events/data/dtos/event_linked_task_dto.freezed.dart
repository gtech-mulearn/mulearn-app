// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_linked_task_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventLinkedTaskDto {

 String get id; String get title; String? get hashtag; String? get description; num? get karma; bool get active; Map<String, dynamic>? get ig;
/// Create a copy of EventLinkedTaskDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventLinkedTaskDtoCopyWith<EventLinkedTaskDto> get copyWith => _$EventLinkedTaskDtoCopyWithImpl<EventLinkedTaskDto>(this as EventLinkedTaskDto, _$identity);

  /// Serializes this EventLinkedTaskDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventLinkedTaskDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.hashtag, hashtag) || other.hashtag == hashtag)&&(identical(other.description, description) || other.description == description)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.active, active) || other.active == active)&&const DeepCollectionEquality().equals(other.ig, ig));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,hashtag,description,karma,active,const DeepCollectionEquality().hash(ig));

@override
String toString() {
  return 'EventLinkedTaskDto(id: $id, title: $title, hashtag: $hashtag, description: $description, karma: $karma, active: $active, ig: $ig)';
}


}

/// @nodoc
abstract mixin class $EventLinkedTaskDtoCopyWith<$Res>  {
  factory $EventLinkedTaskDtoCopyWith(EventLinkedTaskDto value, $Res Function(EventLinkedTaskDto) _then) = _$EventLinkedTaskDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? hashtag, String? description, num? karma, bool active, Map<String, dynamic>? ig
});




}
/// @nodoc
class _$EventLinkedTaskDtoCopyWithImpl<$Res>
    implements $EventLinkedTaskDtoCopyWith<$Res> {
  _$EventLinkedTaskDtoCopyWithImpl(this._self, this._then);

  final EventLinkedTaskDto _self;
  final $Res Function(EventLinkedTaskDto) _then;

/// Create a copy of EventLinkedTaskDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? hashtag = freezed,Object? description = freezed,Object? karma = freezed,Object? active = null,Object? ig = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,hashtag: freezed == hashtag ? _self.hashtag : hashtag // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,karma: freezed == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num?,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,ig: freezed == ig ? _self.ig : ig // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [EventLinkedTaskDto].
extension EventLinkedTaskDtoPatterns on EventLinkedTaskDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventLinkedTaskDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventLinkedTaskDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventLinkedTaskDto value)  $default,){
final _that = this;
switch (_that) {
case _EventLinkedTaskDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventLinkedTaskDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventLinkedTaskDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? hashtag,  String? description,  num? karma,  bool active,  Map<String, dynamic>? ig)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventLinkedTaskDto() when $default != null:
return $default(_that.id,_that.title,_that.hashtag,_that.description,_that.karma,_that.active,_that.ig);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? hashtag,  String? description,  num? karma,  bool active,  Map<String, dynamic>? ig)  $default,) {final _that = this;
switch (_that) {
case _EventLinkedTaskDto():
return $default(_that.id,_that.title,_that.hashtag,_that.description,_that.karma,_that.active,_that.ig);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? hashtag,  String? description,  num? karma,  bool active,  Map<String, dynamic>? ig)?  $default,) {final _that = this;
switch (_that) {
case _EventLinkedTaskDto() when $default != null:
return $default(_that.id,_that.title,_that.hashtag,_that.description,_that.karma,_that.active,_that.ig);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventLinkedTaskDto extends EventLinkedTaskDto {
  const _EventLinkedTaskDto({required this.id, this.title = '', this.hashtag, this.description, this.karma, this.active = false, final  Map<String, dynamic>? ig}): _ig = ig,super._();
  factory _EventLinkedTaskDto.fromJson(Map<String, dynamic> json) => _$EventLinkedTaskDtoFromJson(json);

@override final  String id;
@override@JsonKey() final  String title;
@override final  String? hashtag;
@override final  String? description;
@override final  num? karma;
@override@JsonKey() final  bool active;
 final  Map<String, dynamic>? _ig;
@override Map<String, dynamic>? get ig {
  final value = _ig;
  if (value == null) return null;
  if (_ig is EqualUnmodifiableMapView) return _ig;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of EventLinkedTaskDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventLinkedTaskDtoCopyWith<_EventLinkedTaskDto> get copyWith => __$EventLinkedTaskDtoCopyWithImpl<_EventLinkedTaskDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventLinkedTaskDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventLinkedTaskDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.hashtag, hashtag) || other.hashtag == hashtag)&&(identical(other.description, description) || other.description == description)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.active, active) || other.active == active)&&const DeepCollectionEquality().equals(other._ig, _ig));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,hashtag,description,karma,active,const DeepCollectionEquality().hash(_ig));

@override
String toString() {
  return 'EventLinkedTaskDto(id: $id, title: $title, hashtag: $hashtag, description: $description, karma: $karma, active: $active, ig: $ig)';
}


}

/// @nodoc
abstract mixin class _$EventLinkedTaskDtoCopyWith<$Res> implements $EventLinkedTaskDtoCopyWith<$Res> {
  factory _$EventLinkedTaskDtoCopyWith(_EventLinkedTaskDto value, $Res Function(_EventLinkedTaskDto) _then) = __$EventLinkedTaskDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? hashtag, String? description, num? karma, bool active, Map<String, dynamic>? ig
});




}
/// @nodoc
class __$EventLinkedTaskDtoCopyWithImpl<$Res>
    implements _$EventLinkedTaskDtoCopyWith<$Res> {
  __$EventLinkedTaskDtoCopyWithImpl(this._self, this._then);

  final _EventLinkedTaskDto _self;
  final $Res Function(_EventLinkedTaskDto) _then;

/// Create a copy of EventLinkedTaskDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? hashtag = freezed,Object? description = freezed,Object? karma = freezed,Object? active = null,Object? ig = freezed,}) {
  return _then(_EventLinkedTaskDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,hashtag: freezed == hashtag ? _self.hashtag : hashtag // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,karma: freezed == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num?,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,ig: freezed == ig ? _self._ig : ig // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
