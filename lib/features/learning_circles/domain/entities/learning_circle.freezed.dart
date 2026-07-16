// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'learning_circle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LearningCircle {

 String get id; String get ig; String get title; int get totalMembers; String? get org;
/// Create a copy of LearningCircle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LearningCircleCopyWith<LearningCircle> get copyWith => _$LearningCircleCopyWithImpl<LearningCircle>(this as LearningCircle, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LearningCircle&&(identical(other.id, id) || other.id == id)&&(identical(other.ig, ig) || other.ig == ig)&&(identical(other.title, title) || other.title == title)&&(identical(other.totalMembers, totalMembers) || other.totalMembers == totalMembers)&&(identical(other.org, org) || other.org == org));
}


@override
int get hashCode => Object.hash(runtimeType,id,ig,title,totalMembers,org);

@override
String toString() {
  return 'LearningCircle(id: $id, ig: $ig, title: $title, totalMembers: $totalMembers, org: $org)';
}


}

/// @nodoc
abstract mixin class $LearningCircleCopyWith<$Res>  {
  factory $LearningCircleCopyWith(LearningCircle value, $Res Function(LearningCircle) _then) = _$LearningCircleCopyWithImpl;
@useResult
$Res call({
 String id, String ig, String title, int totalMembers, String? org
});




}
/// @nodoc
class _$LearningCircleCopyWithImpl<$Res>
    implements $LearningCircleCopyWith<$Res> {
  _$LearningCircleCopyWithImpl(this._self, this._then);

  final LearningCircle _self;
  final $Res Function(LearningCircle) _then;

/// Create a copy of LearningCircle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ig = null,Object? title = null,Object? totalMembers = null,Object? org = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ig: null == ig ? _self.ig : ig // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,totalMembers: null == totalMembers ? _self.totalMembers : totalMembers // ignore: cast_nullable_to_non_nullable
as int,org: freezed == org ? _self.org : org // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LearningCircle].
extension LearningCirclePatterns on LearningCircle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LearningCircle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LearningCircle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LearningCircle value)  $default,){
final _that = this;
switch (_that) {
case _LearningCircle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LearningCircle value)?  $default,){
final _that = this;
switch (_that) {
case _LearningCircle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ig,  String title,  int totalMembers,  String? org)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LearningCircle() when $default != null:
return $default(_that.id,_that.ig,_that.title,_that.totalMembers,_that.org);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ig,  String title,  int totalMembers,  String? org)  $default,) {final _that = this;
switch (_that) {
case _LearningCircle():
return $default(_that.id,_that.ig,_that.title,_that.totalMembers,_that.org);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ig,  String title,  int totalMembers,  String? org)?  $default,) {final _that = this;
switch (_that) {
case _LearningCircle() when $default != null:
return $default(_that.id,_that.ig,_that.title,_that.totalMembers,_that.org);case _:
  return null;

}
}

}

/// @nodoc


class _LearningCircle implements LearningCircle {
  const _LearningCircle({required this.id, required this.ig, required this.title, required this.totalMembers, this.org});
  

@override final  String id;
@override final  String ig;
@override final  String title;
@override final  int totalMembers;
@override final  String? org;

/// Create a copy of LearningCircle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LearningCircleCopyWith<_LearningCircle> get copyWith => __$LearningCircleCopyWithImpl<_LearningCircle>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LearningCircle&&(identical(other.id, id) || other.id == id)&&(identical(other.ig, ig) || other.ig == ig)&&(identical(other.title, title) || other.title == title)&&(identical(other.totalMembers, totalMembers) || other.totalMembers == totalMembers)&&(identical(other.org, org) || other.org == org));
}


@override
int get hashCode => Object.hash(runtimeType,id,ig,title,totalMembers,org);

@override
String toString() {
  return 'LearningCircle(id: $id, ig: $ig, title: $title, totalMembers: $totalMembers, org: $org)';
}


}

/// @nodoc
abstract mixin class _$LearningCircleCopyWith<$Res> implements $LearningCircleCopyWith<$Res> {
  factory _$LearningCircleCopyWith(_LearningCircle value, $Res Function(_LearningCircle) _then) = __$LearningCircleCopyWithImpl;
@override @useResult
$Res call({
 String id, String ig, String title, int totalMembers, String? org
});




}
/// @nodoc
class __$LearningCircleCopyWithImpl<$Res>
    implements _$LearningCircleCopyWith<$Res> {
  __$LearningCircleCopyWithImpl(this._self, this._then);

  final _LearningCircle _self;
  final $Res Function(_LearningCircle) _then;

/// Create a copy of LearningCircle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ig = null,Object? title = null,Object? totalMembers = null,Object? org = freezed,}) {
  return _then(_LearningCircle(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ig: null == ig ? _self.ig : ig // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,totalMembers: null == totalMembers ? _self.totalMembers : totalMembers // ignore: cast_nullable_to_non_nullable
as int,org: freezed == org ? _self.org : org // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
