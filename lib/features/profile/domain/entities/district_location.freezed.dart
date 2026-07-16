// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'district_location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DistrictLocation {

 String get id; String get name; StateLocation get state;
/// Create a copy of DistrictLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DistrictLocationCopyWith<DistrictLocation> get copyWith => _$DistrictLocationCopyWithImpl<DistrictLocation>(this as DistrictLocation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DistrictLocation&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,state);

@override
String toString() {
  return 'DistrictLocation(id: $id, name: $name, state: $state)';
}


}

/// @nodoc
abstract mixin class $DistrictLocationCopyWith<$Res>  {
  factory $DistrictLocationCopyWith(DistrictLocation value, $Res Function(DistrictLocation) _then) = _$DistrictLocationCopyWithImpl;
@useResult
$Res call({
 String id, String name, StateLocation state
});


$StateLocationCopyWith<$Res> get state;

}
/// @nodoc
class _$DistrictLocationCopyWithImpl<$Res>
    implements $DistrictLocationCopyWith<$Res> {
  _$DistrictLocationCopyWithImpl(this._self, this._then);

  final DistrictLocation _self;
  final $Res Function(DistrictLocation) _then;

/// Create a copy of DistrictLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? state = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as StateLocation,
  ));
}
/// Create a copy of DistrictLocation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateLocationCopyWith<$Res> get state {
  
  return $StateLocationCopyWith<$Res>(_self.state, (value) {
    return _then(_self.copyWith(state: value));
  });
}
}


/// Adds pattern-matching-related methods to [DistrictLocation].
extension DistrictLocationPatterns on DistrictLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DistrictLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DistrictLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DistrictLocation value)  $default,){
final _that = this;
switch (_that) {
case _DistrictLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DistrictLocation value)?  $default,){
final _that = this;
switch (_that) {
case _DistrictLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  StateLocation state)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DistrictLocation() when $default != null:
return $default(_that.id,_that.name,_that.state);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  StateLocation state)  $default,) {final _that = this;
switch (_that) {
case _DistrictLocation():
return $default(_that.id,_that.name,_that.state);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  StateLocation state)?  $default,) {final _that = this;
switch (_that) {
case _DistrictLocation() when $default != null:
return $default(_that.id,_that.name,_that.state);case _:
  return null;

}
}

}

/// @nodoc


class _DistrictLocation implements DistrictLocation {
  const _DistrictLocation({required this.id, required this.name, required this.state});
  

@override final  String id;
@override final  String name;
@override final  StateLocation state;

/// Create a copy of DistrictLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DistrictLocationCopyWith<_DistrictLocation> get copyWith => __$DistrictLocationCopyWithImpl<_DistrictLocation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DistrictLocation&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,state);

@override
String toString() {
  return 'DistrictLocation(id: $id, name: $name, state: $state)';
}


}

/// @nodoc
abstract mixin class _$DistrictLocationCopyWith<$Res> implements $DistrictLocationCopyWith<$Res> {
  factory _$DistrictLocationCopyWith(_DistrictLocation value, $Res Function(_DistrictLocation) _then) = __$DistrictLocationCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, StateLocation state
});


@override $StateLocationCopyWith<$Res> get state;

}
/// @nodoc
class __$DistrictLocationCopyWithImpl<$Res>
    implements _$DistrictLocationCopyWith<$Res> {
  __$DistrictLocationCopyWithImpl(this._self, this._then);

  final _DistrictLocation _self;
  final $Res Function(_DistrictLocation) _then;

/// Create a copy of DistrictLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? state = null,}) {
  return _then(_DistrictLocation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as StateLocation,
  ));
}

/// Create a copy of DistrictLocation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateLocationCopyWith<$Res> get state {
  
  return $StateLocationCopyWith<$Res>(_self.state, (value) {
    return _then(_self.copyWith(state: value));
  });
}
}

// dart format on
