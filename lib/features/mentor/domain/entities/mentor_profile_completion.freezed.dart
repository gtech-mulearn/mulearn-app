// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mentor_profile_completion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MentorProfileCompletion {

 int get percentage; Map<String, bool> get checklist;
/// Create a copy of MentorProfileCompletion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MentorProfileCompletionCopyWith<MentorProfileCompletion> get copyWith => _$MentorProfileCompletionCopyWithImpl<MentorProfileCompletion>(this as MentorProfileCompletion, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MentorProfileCompletion&&(identical(other.percentage, percentage) || other.percentage == percentage)&&const DeepCollectionEquality().equals(other.checklist, checklist));
}


@override
int get hashCode => Object.hash(runtimeType,percentage,const DeepCollectionEquality().hash(checklist));

@override
String toString() {
  return 'MentorProfileCompletion(percentage: $percentage, checklist: $checklist)';
}


}

/// @nodoc
abstract mixin class $MentorProfileCompletionCopyWith<$Res>  {
  factory $MentorProfileCompletionCopyWith(MentorProfileCompletion value, $Res Function(MentorProfileCompletion) _then) = _$MentorProfileCompletionCopyWithImpl;
@useResult
$Res call({
 int percentage, Map<String, bool> checklist
});




}
/// @nodoc
class _$MentorProfileCompletionCopyWithImpl<$Res>
    implements $MentorProfileCompletionCopyWith<$Res> {
  _$MentorProfileCompletionCopyWithImpl(this._self, this._then);

  final MentorProfileCompletion _self;
  final $Res Function(MentorProfileCompletion) _then;

/// Create a copy of MentorProfileCompletion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? percentage = null,Object? checklist = null,}) {
  return _then(_self.copyWith(
percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as int,checklist: null == checklist ? _self.checklist : checklist // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,
  ));
}

}


/// Adds pattern-matching-related methods to [MentorProfileCompletion].
extension MentorProfileCompletionPatterns on MentorProfileCompletion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MentorProfileCompletion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MentorProfileCompletion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MentorProfileCompletion value)  $default,){
final _that = this;
switch (_that) {
case _MentorProfileCompletion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MentorProfileCompletion value)?  $default,){
final _that = this;
switch (_that) {
case _MentorProfileCompletion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int percentage,  Map<String, bool> checklist)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MentorProfileCompletion() when $default != null:
return $default(_that.percentage,_that.checklist);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int percentage,  Map<String, bool> checklist)  $default,) {final _that = this;
switch (_that) {
case _MentorProfileCompletion():
return $default(_that.percentage,_that.checklist);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int percentage,  Map<String, bool> checklist)?  $default,) {final _that = this;
switch (_that) {
case _MentorProfileCompletion() when $default != null:
return $default(_that.percentage,_that.checklist);case _:
  return null;

}
}

}

/// @nodoc


class _MentorProfileCompletion implements MentorProfileCompletion {
  const _MentorProfileCompletion({required this.percentage, required final  Map<String, bool> checklist}): _checklist = checklist;
  

@override final  int percentage;
 final  Map<String, bool> _checklist;
@override Map<String, bool> get checklist {
  if (_checklist is EqualUnmodifiableMapView) return _checklist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_checklist);
}


/// Create a copy of MentorProfileCompletion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MentorProfileCompletionCopyWith<_MentorProfileCompletion> get copyWith => __$MentorProfileCompletionCopyWithImpl<_MentorProfileCompletion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MentorProfileCompletion&&(identical(other.percentage, percentage) || other.percentage == percentage)&&const DeepCollectionEquality().equals(other._checklist, _checklist));
}


@override
int get hashCode => Object.hash(runtimeType,percentage,const DeepCollectionEquality().hash(_checklist));

@override
String toString() {
  return 'MentorProfileCompletion(percentage: $percentage, checklist: $checklist)';
}


}

/// @nodoc
abstract mixin class _$MentorProfileCompletionCopyWith<$Res> implements $MentorProfileCompletionCopyWith<$Res> {
  factory _$MentorProfileCompletionCopyWith(_MentorProfileCompletion value, $Res Function(_MentorProfileCompletion) _then) = __$MentorProfileCompletionCopyWithImpl;
@override @useResult
$Res call({
 int percentage, Map<String, bool> checklist
});




}
/// @nodoc
class __$MentorProfileCompletionCopyWithImpl<$Res>
    implements _$MentorProfileCompletionCopyWith<$Res> {
  __$MentorProfileCompletionCopyWithImpl(this._self, this._then);

  final _MentorProfileCompletion _self;
  final $Res Function(_MentorProfileCompletion) _then;

/// Create a copy of MentorProfileCompletion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? percentage = null,Object? checklist = null,}) {
  return _then(_MentorProfileCompletion(
percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as int,checklist: null == checklist ? _self._checklist : checklist // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,
  ));
}


}

// dart format on
