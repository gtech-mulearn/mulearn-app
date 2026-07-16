// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'karma_feed_top_college.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$KarmaFeedTopCollege {

 String get name; num get karma;
/// Create a copy of KarmaFeedTopCollege
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KarmaFeedTopCollegeCopyWith<KarmaFeedTopCollege> get copyWith => _$KarmaFeedTopCollegeCopyWithImpl<KarmaFeedTopCollege>(this as KarmaFeedTopCollege, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KarmaFeedTopCollege&&(identical(other.name, name) || other.name == name)&&(identical(other.karma, karma) || other.karma == karma));
}


@override
int get hashCode => Object.hash(runtimeType,name,karma);

@override
String toString() {
  return 'KarmaFeedTopCollege(name: $name, karma: $karma)';
}


}

/// @nodoc
abstract mixin class $KarmaFeedTopCollegeCopyWith<$Res>  {
  factory $KarmaFeedTopCollegeCopyWith(KarmaFeedTopCollege value, $Res Function(KarmaFeedTopCollege) _then) = _$KarmaFeedTopCollegeCopyWithImpl;
@useResult
$Res call({
 String name, num karma
});




}
/// @nodoc
class _$KarmaFeedTopCollegeCopyWithImpl<$Res>
    implements $KarmaFeedTopCollegeCopyWith<$Res> {
  _$KarmaFeedTopCollegeCopyWithImpl(this._self, this._then);

  final KarmaFeedTopCollege _self;
  final $Res Function(KarmaFeedTopCollege) _then;

/// Create a copy of KarmaFeedTopCollege
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? karma = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [KarmaFeedTopCollege].
extension KarmaFeedTopCollegePatterns on KarmaFeedTopCollege {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KarmaFeedTopCollege value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KarmaFeedTopCollege() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KarmaFeedTopCollege value)  $default,){
final _that = this;
switch (_that) {
case _KarmaFeedTopCollege():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KarmaFeedTopCollege value)?  $default,){
final _that = this;
switch (_that) {
case _KarmaFeedTopCollege() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  num karma)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KarmaFeedTopCollege() when $default != null:
return $default(_that.name,_that.karma);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  num karma)  $default,) {final _that = this;
switch (_that) {
case _KarmaFeedTopCollege():
return $default(_that.name,_that.karma);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  num karma)?  $default,) {final _that = this;
switch (_that) {
case _KarmaFeedTopCollege() when $default != null:
return $default(_that.name,_that.karma);case _:
  return null;

}
}

}

/// @nodoc


class _KarmaFeedTopCollege implements KarmaFeedTopCollege {
  const _KarmaFeedTopCollege({required this.name, required this.karma});
  

@override final  String name;
@override final  num karma;

/// Create a copy of KarmaFeedTopCollege
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KarmaFeedTopCollegeCopyWith<_KarmaFeedTopCollege> get copyWith => __$KarmaFeedTopCollegeCopyWithImpl<_KarmaFeedTopCollege>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KarmaFeedTopCollege&&(identical(other.name, name) || other.name == name)&&(identical(other.karma, karma) || other.karma == karma));
}


@override
int get hashCode => Object.hash(runtimeType,name,karma);

@override
String toString() {
  return 'KarmaFeedTopCollege(name: $name, karma: $karma)';
}


}

/// @nodoc
abstract mixin class _$KarmaFeedTopCollegeCopyWith<$Res> implements $KarmaFeedTopCollegeCopyWith<$Res> {
  factory _$KarmaFeedTopCollegeCopyWith(_KarmaFeedTopCollege value, $Res Function(_KarmaFeedTopCollege) _then) = __$KarmaFeedTopCollegeCopyWithImpl;
@override @useResult
$Res call({
 String name, num karma
});




}
/// @nodoc
class __$KarmaFeedTopCollegeCopyWithImpl<$Res>
    implements _$KarmaFeedTopCollegeCopyWith<$Res> {
  __$KarmaFeedTopCollegeCopyWithImpl(this._self, this._then);

  final _KarmaFeedTopCollege _self;
  final $Res Function(_KarmaFeedTopCollege) _then;

/// Create a copy of KarmaFeedTopCollege
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? karma = null,}) {
  return _then(_KarmaFeedTopCollege(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on
