// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_organizer_ig.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventOrganizerIg {

 String get id; String get name; String? get iconImage;
/// Create a copy of EventOrganizerIg
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventOrganizerIgCopyWith<EventOrganizerIg> get copyWith => _$EventOrganizerIgCopyWithImpl<EventOrganizerIg>(this as EventOrganizerIg, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventOrganizerIg&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconImage, iconImage) || other.iconImage == iconImage));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,iconImage);

@override
String toString() {
  return 'EventOrganizerIg(id: $id, name: $name, iconImage: $iconImage)';
}


}

/// @nodoc
abstract mixin class $EventOrganizerIgCopyWith<$Res>  {
  factory $EventOrganizerIgCopyWith(EventOrganizerIg value, $Res Function(EventOrganizerIg) _then) = _$EventOrganizerIgCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? iconImage
});




}
/// @nodoc
class _$EventOrganizerIgCopyWithImpl<$Res>
    implements $EventOrganizerIgCopyWith<$Res> {
  _$EventOrganizerIgCopyWithImpl(this._self, this._then);

  final EventOrganizerIg _self;
  final $Res Function(EventOrganizerIg) _then;

/// Create a copy of EventOrganizerIg
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


/// Adds pattern-matching-related methods to [EventOrganizerIg].
extension EventOrganizerIgPatterns on EventOrganizerIg {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventOrganizerIg value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventOrganizerIg() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventOrganizerIg value)  $default,){
final _that = this;
switch (_that) {
case _EventOrganizerIg():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventOrganizerIg value)?  $default,){
final _that = this;
switch (_that) {
case _EventOrganizerIg() when $default != null:
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
case _EventOrganizerIg() when $default != null:
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
case _EventOrganizerIg():
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
case _EventOrganizerIg() when $default != null:
return $default(_that.id,_that.name,_that.iconImage);case _:
  return null;

}
}

}

/// @nodoc


class _EventOrganizerIg implements EventOrganizerIg {
  const _EventOrganizerIg({required this.id, required this.name, this.iconImage});
  

@override final  String id;
@override final  String name;
@override final  String? iconImage;

/// Create a copy of EventOrganizerIg
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventOrganizerIgCopyWith<_EventOrganizerIg> get copyWith => __$EventOrganizerIgCopyWithImpl<_EventOrganizerIg>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventOrganizerIg&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconImage, iconImage) || other.iconImage == iconImage));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,iconImage);

@override
String toString() {
  return 'EventOrganizerIg(id: $id, name: $name, iconImage: $iconImage)';
}


}

/// @nodoc
abstract mixin class _$EventOrganizerIgCopyWith<$Res> implements $EventOrganizerIgCopyWith<$Res> {
  factory _$EventOrganizerIgCopyWith(_EventOrganizerIg value, $Res Function(_EventOrganizerIg) _then) = __$EventOrganizerIgCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? iconImage
});




}
/// @nodoc
class __$EventOrganizerIgCopyWithImpl<$Res>
    implements _$EventOrganizerIgCopyWith<$Res> {
  __$EventOrganizerIgCopyWithImpl(this._self, this._then);

  final _EventOrganizerIg _self;
  final $Res Function(_EventOrganizerIg) _then;

/// Create a copy of EventOrganizerIg
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? iconImage = freezed,}) {
  return _then(_EventOrganizerIg(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconImage: freezed == iconImage ? _self.iconImage : iconImage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
