// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'circle_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CircleFilter {

 String? get status; String? get igId; String get search;
/// Create a copy of CircleFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CircleFilterCopyWith<CircleFilter> get copyWith => _$CircleFilterCopyWithImpl<CircleFilter>(this as CircleFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CircleFilter&&(identical(other.status, status) || other.status == status)&&(identical(other.igId, igId) || other.igId == igId)&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,status,igId,search);

@override
String toString() {
  return 'CircleFilter(status: $status, igId: $igId, search: $search)';
}


}

/// @nodoc
abstract mixin class $CircleFilterCopyWith<$Res>  {
  factory $CircleFilterCopyWith(CircleFilter value, $Res Function(CircleFilter) _then) = _$CircleFilterCopyWithImpl;
@useResult
$Res call({
 String? status, String? igId, String search
});




}
/// @nodoc
class _$CircleFilterCopyWithImpl<$Res>
    implements $CircleFilterCopyWith<$Res> {
  _$CircleFilterCopyWithImpl(this._self, this._then);

  final CircleFilter _self;
  final $Res Function(CircleFilter) _then;

/// Create a copy of CircleFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? igId = freezed,Object? search = null,}) {
  return _then(_self.copyWith(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,igId: freezed == igId ? _self.igId : igId // ignore: cast_nullable_to_non_nullable
as String?,search: null == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CircleFilter].
extension CircleFilterPatterns on CircleFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CircleFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CircleFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CircleFilter value)  $default,){
final _that = this;
switch (_that) {
case _CircleFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CircleFilter value)?  $default,){
final _that = this;
switch (_that) {
case _CircleFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? status,  String? igId,  String search)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CircleFilter() when $default != null:
return $default(_that.status,_that.igId,_that.search);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? status,  String? igId,  String search)  $default,) {final _that = this;
switch (_that) {
case _CircleFilter():
return $default(_that.status,_that.igId,_that.search);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? status,  String? igId,  String search)?  $default,) {final _that = this;
switch (_that) {
case _CircleFilter() when $default != null:
return $default(_that.status,_that.igId,_that.search);case _:
  return null;

}
}

}

/// @nodoc


class _CircleFilter extends CircleFilter {
  const _CircleFilter({this.status, this.igId, this.search = ''}): super._();
  

@override final  String? status;
@override final  String? igId;
@override@JsonKey() final  String search;

/// Create a copy of CircleFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CircleFilterCopyWith<_CircleFilter> get copyWith => __$CircleFilterCopyWithImpl<_CircleFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CircleFilter&&(identical(other.status, status) || other.status == status)&&(identical(other.igId, igId) || other.igId == igId)&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,status,igId,search);

@override
String toString() {
  return 'CircleFilter(status: $status, igId: $igId, search: $search)';
}


}

/// @nodoc
abstract mixin class _$CircleFilterCopyWith<$Res> implements $CircleFilterCopyWith<$Res> {
  factory _$CircleFilterCopyWith(_CircleFilter value, $Res Function(_CircleFilter) _then) = __$CircleFilterCopyWithImpl;
@override @useResult
$Res call({
 String? status, String? igId, String search
});




}
/// @nodoc
class __$CircleFilterCopyWithImpl<$Res>
    implements _$CircleFilterCopyWith<$Res> {
  __$CircleFilterCopyWithImpl(this._self, this._then);

  final _CircleFilter _self;
  final $Res Function(_CircleFilter) _then;

/// Create a copy of CircleFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? igId = freezed,Object? search = null,}) {
  return _then(_CircleFilter(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,igId: freezed == igId ? _self.igId : igId // ignore: cast_nullable_to_non_nullable
as String?,search: null == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
