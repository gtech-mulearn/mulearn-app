// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state_location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StateLocation {

 String get id; String get name; CountryLocation get country;
/// Create a copy of StateLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StateLocationCopyWith<StateLocation> get copyWith => _$StateLocationCopyWithImpl<StateLocation>(this as StateLocation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StateLocation&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.country, country) || other.country == country));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,country);

@override
String toString() {
  return 'StateLocation(id: $id, name: $name, country: $country)';
}


}

/// @nodoc
abstract mixin class $StateLocationCopyWith<$Res>  {
  factory $StateLocationCopyWith(StateLocation value, $Res Function(StateLocation) _then) = _$StateLocationCopyWithImpl;
@useResult
$Res call({
 String id, String name, CountryLocation country
});


$CountryLocationCopyWith<$Res> get country;

}
/// @nodoc
class _$StateLocationCopyWithImpl<$Res>
    implements $StateLocationCopyWith<$Res> {
  _$StateLocationCopyWithImpl(this._self, this._then);

  final StateLocation _self;
  final $Res Function(StateLocation) _then;

/// Create a copy of StateLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? country = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as CountryLocation,
  ));
}
/// Create a copy of StateLocation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CountryLocationCopyWith<$Res> get country {
  
  return $CountryLocationCopyWith<$Res>(_self.country, (value) {
    return _then(_self.copyWith(country: value));
  });
}
}


/// Adds pattern-matching-related methods to [StateLocation].
extension StateLocationPatterns on StateLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StateLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StateLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StateLocation value)  $default,){
final _that = this;
switch (_that) {
case _StateLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StateLocation value)?  $default,){
final _that = this;
switch (_that) {
case _StateLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  CountryLocation country)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StateLocation() when $default != null:
return $default(_that.id,_that.name,_that.country);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  CountryLocation country)  $default,) {final _that = this;
switch (_that) {
case _StateLocation():
return $default(_that.id,_that.name,_that.country);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  CountryLocation country)?  $default,) {final _that = this;
switch (_that) {
case _StateLocation() when $default != null:
return $default(_that.id,_that.name,_that.country);case _:
  return null;

}
}

}

/// @nodoc


class _StateLocation implements StateLocation {
  const _StateLocation({required this.id, required this.name, required this.country});
  

@override final  String id;
@override final  String name;
@override final  CountryLocation country;

/// Create a copy of StateLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StateLocationCopyWith<_StateLocation> get copyWith => __$StateLocationCopyWithImpl<_StateLocation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateLocation&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.country, country) || other.country == country));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,country);

@override
String toString() {
  return 'StateLocation(id: $id, name: $name, country: $country)';
}


}

/// @nodoc
abstract mixin class _$StateLocationCopyWith<$Res> implements $StateLocationCopyWith<$Res> {
  factory _$StateLocationCopyWith(_StateLocation value, $Res Function(_StateLocation) _then) = __$StateLocationCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, CountryLocation country
});


@override $CountryLocationCopyWith<$Res> get country;

}
/// @nodoc
class __$StateLocationCopyWithImpl<$Res>
    implements _$StateLocationCopyWith<$Res> {
  __$StateLocationCopyWithImpl(this._self, this._then);

  final _StateLocation _self;
  final $Res Function(_StateLocation) _then;

/// Create a copy of StateLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? country = null,}) {
  return _then(_StateLocation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as CountryLocation,
  ));
}

/// Create a copy of StateLocation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CountryLocationCopyWith<$Res> get country {
  
  return $CountryLocationCopyWith<$Res>(_self.country, (value) {
    return _then(_self.copyWith(country: value));
  });
}
}

// dart format on
