// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudentFilter {

 String get search; StudentSort get sort; bool? get alumni;
/// Create a copy of StudentFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentFilterCopyWith<StudentFilter> get copyWith => _$StudentFilterCopyWithImpl<StudentFilter>(this as StudentFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentFilter&&(identical(other.search, search) || other.search == search)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.alumni, alumni) || other.alumni == alumni));
}


@override
int get hashCode => Object.hash(runtimeType,search,sort,alumni);

@override
String toString() {
  return 'StudentFilter(search: $search, sort: $sort, alumni: $alumni)';
}


}

/// @nodoc
abstract mixin class $StudentFilterCopyWith<$Res>  {
  factory $StudentFilterCopyWith(StudentFilter value, $Res Function(StudentFilter) _then) = _$StudentFilterCopyWithImpl;
@useResult
$Res call({
 String search, StudentSort sort, bool? alumni
});




}
/// @nodoc
class _$StudentFilterCopyWithImpl<$Res>
    implements $StudentFilterCopyWith<$Res> {
  _$StudentFilterCopyWithImpl(this._self, this._then);

  final StudentFilter _self;
  final $Res Function(StudentFilter) _then;

/// Create a copy of StudentFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? search = null,Object? sort = null,Object? alumni = freezed,}) {
  return _then(_self.copyWith(
search: null == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as StudentSort,alumni: freezed == alumni ? _self.alumni : alumni // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [StudentFilter].
extension StudentFilterPatterns on StudentFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudentFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudentFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudentFilter value)  $default,){
final _that = this;
switch (_that) {
case _StudentFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudentFilter value)?  $default,){
final _that = this;
switch (_that) {
case _StudentFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String search,  StudentSort sort,  bool? alumni)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudentFilter() when $default != null:
return $default(_that.search,_that.sort,_that.alumni);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String search,  StudentSort sort,  bool? alumni)  $default,) {final _that = this;
switch (_that) {
case _StudentFilter():
return $default(_that.search,_that.sort,_that.alumni);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String search,  StudentSort sort,  bool? alumni)?  $default,) {final _that = this;
switch (_that) {
case _StudentFilter() when $default != null:
return $default(_that.search,_that.sort,_that.alumni);case _:
  return null;

}
}

}

/// @nodoc


class _StudentFilter implements StudentFilter {
  const _StudentFilter({this.search = '', this.sort = StudentSort.karma, this.alumni});
  

@override@JsonKey() final  String search;
@override@JsonKey() final  StudentSort sort;
@override final  bool? alumni;

/// Create a copy of StudentFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudentFilterCopyWith<_StudentFilter> get copyWith => __$StudentFilterCopyWithImpl<_StudentFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudentFilter&&(identical(other.search, search) || other.search == search)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.alumni, alumni) || other.alumni == alumni));
}


@override
int get hashCode => Object.hash(runtimeType,search,sort,alumni);

@override
String toString() {
  return 'StudentFilter(search: $search, sort: $sort, alumni: $alumni)';
}


}

/// @nodoc
abstract mixin class _$StudentFilterCopyWith<$Res> implements $StudentFilterCopyWith<$Res> {
  factory _$StudentFilterCopyWith(_StudentFilter value, $Res Function(_StudentFilter) _then) = __$StudentFilterCopyWithImpl;
@override @useResult
$Res call({
 String search, StudentSort sort, bool? alumni
});




}
/// @nodoc
class __$StudentFilterCopyWithImpl<$Res>
    implements _$StudentFilterCopyWith<$Res> {
  __$StudentFilterCopyWithImpl(this._self, this._then);

  final _StudentFilter _self;
  final $Res Function(_StudentFilter) _then;

/// Create a copy of StudentFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? search = null,Object? sort = null,Object? alumni = freezed,}) {
  return _then(_StudentFilter(
search: null == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as StudentSort,alumni: freezed == alumni ? _self.alumni : alumni // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
