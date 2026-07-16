// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'learning_circle_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LearningCirclePage {

 List<LearningCircle> get circles; bool get hasNext;
/// Create a copy of LearningCirclePage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LearningCirclePageCopyWith<LearningCirclePage> get copyWith => _$LearningCirclePageCopyWithImpl<LearningCirclePage>(this as LearningCirclePage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LearningCirclePage&&const DeepCollectionEquality().equals(other.circles, circles)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(circles),hasNext);

@override
String toString() {
  return 'LearningCirclePage(circles: $circles, hasNext: $hasNext)';
}


}

/// @nodoc
abstract mixin class $LearningCirclePageCopyWith<$Res>  {
  factory $LearningCirclePageCopyWith(LearningCirclePage value, $Res Function(LearningCirclePage) _then) = _$LearningCirclePageCopyWithImpl;
@useResult
$Res call({
 List<LearningCircle> circles, bool hasNext
});




}
/// @nodoc
class _$LearningCirclePageCopyWithImpl<$Res>
    implements $LearningCirclePageCopyWith<$Res> {
  _$LearningCirclePageCopyWithImpl(this._self, this._then);

  final LearningCirclePage _self;
  final $Res Function(LearningCirclePage) _then;

/// Create a copy of LearningCirclePage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? circles = null,Object? hasNext = null,}) {
  return _then(_self.copyWith(
circles: null == circles ? _self.circles : circles // ignore: cast_nullable_to_non_nullable
as List<LearningCircle>,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LearningCirclePage].
extension LearningCirclePagePatterns on LearningCirclePage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LearningCirclePage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LearningCirclePage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LearningCirclePage value)  $default,){
final _that = this;
switch (_that) {
case _LearningCirclePage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LearningCirclePage value)?  $default,){
final _that = this;
switch (_that) {
case _LearningCirclePage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LearningCircle> circles,  bool hasNext)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LearningCirclePage() when $default != null:
return $default(_that.circles,_that.hasNext);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LearningCircle> circles,  bool hasNext)  $default,) {final _that = this;
switch (_that) {
case _LearningCirclePage():
return $default(_that.circles,_that.hasNext);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LearningCircle> circles,  bool hasNext)?  $default,) {final _that = this;
switch (_that) {
case _LearningCirclePage() when $default != null:
return $default(_that.circles,_that.hasNext);case _:
  return null;

}
}

}

/// @nodoc


class _LearningCirclePage implements LearningCirclePage {
  const _LearningCirclePage({required final  List<LearningCircle> circles, required this.hasNext}): _circles = circles;
  

 final  List<LearningCircle> _circles;
@override List<LearningCircle> get circles {
  if (_circles is EqualUnmodifiableListView) return _circles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_circles);
}

@override final  bool hasNext;

/// Create a copy of LearningCirclePage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LearningCirclePageCopyWith<_LearningCirclePage> get copyWith => __$LearningCirclePageCopyWithImpl<_LearningCirclePage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LearningCirclePage&&const DeepCollectionEquality().equals(other._circles, _circles)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_circles),hasNext);

@override
String toString() {
  return 'LearningCirclePage(circles: $circles, hasNext: $hasNext)';
}


}

/// @nodoc
abstract mixin class _$LearningCirclePageCopyWith<$Res> implements $LearningCirclePageCopyWith<$Res> {
  factory _$LearningCirclePageCopyWith(_LearningCirclePage value, $Res Function(_LearningCirclePage) _then) = __$LearningCirclePageCopyWithImpl;
@override @useResult
$Res call({
 List<LearningCircle> circles, bool hasNext
});




}
/// @nodoc
class __$LearningCirclePageCopyWithImpl<$Res>
    implements _$LearningCirclePageCopyWith<$Res> {
  __$LearningCirclePageCopyWithImpl(this._self, this._then);

  final _LearningCirclePage _self;
  final $Res Function(_LearningCirclePage) _then;

/// Create a copy of LearningCirclePage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? circles = null,Object? hasNext = null,}) {
  return _then(_LearningCirclePage(
circles: null == circles ? _self._circles : circles // ignore: cast_nullable_to_non_nullable
as List<LearningCircle>,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
