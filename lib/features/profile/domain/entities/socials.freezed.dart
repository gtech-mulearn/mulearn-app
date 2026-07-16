// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'socials.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Socials {

 String? get github; String? get facebook; String? get instagram; String? get linkedin; String? get dribble; String? get behance; String? get stackoverflow; String? get medium; String? get hackerrank;
/// Create a copy of Socials
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialsCopyWith<Socials> get copyWith => _$SocialsCopyWithImpl<Socials>(this as Socials, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Socials&&(identical(other.github, github) || other.github == github)&&(identical(other.facebook, facebook) || other.facebook == facebook)&&(identical(other.instagram, instagram) || other.instagram == instagram)&&(identical(other.linkedin, linkedin) || other.linkedin == linkedin)&&(identical(other.dribble, dribble) || other.dribble == dribble)&&(identical(other.behance, behance) || other.behance == behance)&&(identical(other.stackoverflow, stackoverflow) || other.stackoverflow == stackoverflow)&&(identical(other.medium, medium) || other.medium == medium)&&(identical(other.hackerrank, hackerrank) || other.hackerrank == hackerrank));
}


@override
int get hashCode => Object.hash(runtimeType,github,facebook,instagram,linkedin,dribble,behance,stackoverflow,medium,hackerrank);

@override
String toString() {
  return 'Socials(github: $github, facebook: $facebook, instagram: $instagram, linkedin: $linkedin, dribble: $dribble, behance: $behance, stackoverflow: $stackoverflow, medium: $medium, hackerrank: $hackerrank)';
}


}

/// @nodoc
abstract mixin class $SocialsCopyWith<$Res>  {
  factory $SocialsCopyWith(Socials value, $Res Function(Socials) _then) = _$SocialsCopyWithImpl;
@useResult
$Res call({
 String? github, String? facebook, String? instagram, String? linkedin, String? dribble, String? behance, String? stackoverflow, String? medium, String? hackerrank
});




}
/// @nodoc
class _$SocialsCopyWithImpl<$Res>
    implements $SocialsCopyWith<$Res> {
  _$SocialsCopyWithImpl(this._self, this._then);

  final Socials _self;
  final $Res Function(Socials) _then;

/// Create a copy of Socials
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? github = freezed,Object? facebook = freezed,Object? instagram = freezed,Object? linkedin = freezed,Object? dribble = freezed,Object? behance = freezed,Object? stackoverflow = freezed,Object? medium = freezed,Object? hackerrank = freezed,}) {
  return _then(_self.copyWith(
github: freezed == github ? _self.github : github // ignore: cast_nullable_to_non_nullable
as String?,facebook: freezed == facebook ? _self.facebook : facebook // ignore: cast_nullable_to_non_nullable
as String?,instagram: freezed == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String?,linkedin: freezed == linkedin ? _self.linkedin : linkedin // ignore: cast_nullable_to_non_nullable
as String?,dribble: freezed == dribble ? _self.dribble : dribble // ignore: cast_nullable_to_non_nullable
as String?,behance: freezed == behance ? _self.behance : behance // ignore: cast_nullable_to_non_nullable
as String?,stackoverflow: freezed == stackoverflow ? _self.stackoverflow : stackoverflow // ignore: cast_nullable_to_non_nullable
as String?,medium: freezed == medium ? _self.medium : medium // ignore: cast_nullable_to_non_nullable
as String?,hackerrank: freezed == hackerrank ? _self.hackerrank : hackerrank // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Socials].
extension SocialsPatterns on Socials {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Socials value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Socials() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Socials value)  $default,){
final _that = this;
switch (_that) {
case _Socials():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Socials value)?  $default,){
final _that = this;
switch (_that) {
case _Socials() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? github,  String? facebook,  String? instagram,  String? linkedin,  String? dribble,  String? behance,  String? stackoverflow,  String? medium,  String? hackerrank)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Socials() when $default != null:
return $default(_that.github,_that.facebook,_that.instagram,_that.linkedin,_that.dribble,_that.behance,_that.stackoverflow,_that.medium,_that.hackerrank);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? github,  String? facebook,  String? instagram,  String? linkedin,  String? dribble,  String? behance,  String? stackoverflow,  String? medium,  String? hackerrank)  $default,) {final _that = this;
switch (_that) {
case _Socials():
return $default(_that.github,_that.facebook,_that.instagram,_that.linkedin,_that.dribble,_that.behance,_that.stackoverflow,_that.medium,_that.hackerrank);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? github,  String? facebook,  String? instagram,  String? linkedin,  String? dribble,  String? behance,  String? stackoverflow,  String? medium,  String? hackerrank)?  $default,) {final _that = this;
switch (_that) {
case _Socials() when $default != null:
return $default(_that.github,_that.facebook,_that.instagram,_that.linkedin,_that.dribble,_that.behance,_that.stackoverflow,_that.medium,_that.hackerrank);case _:
  return null;

}
}

}

/// @nodoc


class _Socials implements Socials {
  const _Socials({this.github, this.facebook, this.instagram, this.linkedin, this.dribble, this.behance, this.stackoverflow, this.medium, this.hackerrank});
  

@override final  String? github;
@override final  String? facebook;
@override final  String? instagram;
@override final  String? linkedin;
@override final  String? dribble;
@override final  String? behance;
@override final  String? stackoverflow;
@override final  String? medium;
@override final  String? hackerrank;

/// Create a copy of Socials
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialsCopyWith<_Socials> get copyWith => __$SocialsCopyWithImpl<_Socials>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Socials&&(identical(other.github, github) || other.github == github)&&(identical(other.facebook, facebook) || other.facebook == facebook)&&(identical(other.instagram, instagram) || other.instagram == instagram)&&(identical(other.linkedin, linkedin) || other.linkedin == linkedin)&&(identical(other.dribble, dribble) || other.dribble == dribble)&&(identical(other.behance, behance) || other.behance == behance)&&(identical(other.stackoverflow, stackoverflow) || other.stackoverflow == stackoverflow)&&(identical(other.medium, medium) || other.medium == medium)&&(identical(other.hackerrank, hackerrank) || other.hackerrank == hackerrank));
}


@override
int get hashCode => Object.hash(runtimeType,github,facebook,instagram,linkedin,dribble,behance,stackoverflow,medium,hackerrank);

@override
String toString() {
  return 'Socials(github: $github, facebook: $facebook, instagram: $instagram, linkedin: $linkedin, dribble: $dribble, behance: $behance, stackoverflow: $stackoverflow, medium: $medium, hackerrank: $hackerrank)';
}


}

/// @nodoc
abstract mixin class _$SocialsCopyWith<$Res> implements $SocialsCopyWith<$Res> {
  factory _$SocialsCopyWith(_Socials value, $Res Function(_Socials) _then) = __$SocialsCopyWithImpl;
@override @useResult
$Res call({
 String? github, String? facebook, String? instagram, String? linkedin, String? dribble, String? behance, String? stackoverflow, String? medium, String? hackerrank
});




}
/// @nodoc
class __$SocialsCopyWithImpl<$Res>
    implements _$SocialsCopyWith<$Res> {
  __$SocialsCopyWithImpl(this._self, this._then);

  final _Socials _self;
  final $Res Function(_Socials) _then;

/// Create a copy of Socials
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? github = freezed,Object? facebook = freezed,Object? instagram = freezed,Object? linkedin = freezed,Object? dribble = freezed,Object? behance = freezed,Object? stackoverflow = freezed,Object? medium = freezed,Object? hackerrank = freezed,}) {
  return _then(_Socials(
github: freezed == github ? _self.github : github // ignore: cast_nullable_to_non_nullable
as String?,facebook: freezed == facebook ? _self.facebook : facebook // ignore: cast_nullable_to_non_nullable
as String?,instagram: freezed == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String?,linkedin: freezed == linkedin ? _self.linkedin : linkedin // ignore: cast_nullable_to_non_nullable
as String?,dribble: freezed == dribble ? _self.dribble : dribble // ignore: cast_nullable_to_non_nullable
as String?,behance: freezed == behance ? _self.behance : behance // ignore: cast_nullable_to_non_nullable
as String?,stackoverflow: freezed == stackoverflow ? _self.stackoverflow : stackoverflow // ignore: cast_nullable_to_non_nullable
as String?,medium: freezed == medium ? _self.medium : medium // ignore: cast_nullable_to_non_nullable
as String?,hackerrank: freezed == hackerrank ? _self.hackerrank : hackerrank // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
