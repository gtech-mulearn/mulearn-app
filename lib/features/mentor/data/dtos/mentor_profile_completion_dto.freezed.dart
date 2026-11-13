// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mentor_profile_completion_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MentorProfileCompletionDto {

 int get percentage; Map<String, dynamic> get checklist;
/// Create a copy of MentorProfileCompletionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MentorProfileCompletionDtoCopyWith<MentorProfileCompletionDto> get copyWith => _$MentorProfileCompletionDtoCopyWithImpl<MentorProfileCompletionDto>(this as MentorProfileCompletionDto, _$identity);

  /// Serializes this MentorProfileCompletionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MentorProfileCompletionDto&&(identical(other.percentage, percentage) || other.percentage == percentage)&&const DeepCollectionEquality().equals(other.checklist, checklist));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,percentage,const DeepCollectionEquality().hash(checklist));

@override
String toString() {
  return 'MentorProfileCompletionDto(percentage: $percentage, checklist: $checklist)';
}


}

/// @nodoc
abstract mixin class $MentorProfileCompletionDtoCopyWith<$Res>  {
  factory $MentorProfileCompletionDtoCopyWith(MentorProfileCompletionDto value, $Res Function(MentorProfileCompletionDto) _then) = _$MentorProfileCompletionDtoCopyWithImpl;
@useResult
$Res call({
 int percentage, Map<String, dynamic> checklist
});




}
/// @nodoc
class _$MentorProfileCompletionDtoCopyWithImpl<$Res>
    implements $MentorProfileCompletionDtoCopyWith<$Res> {
  _$MentorProfileCompletionDtoCopyWithImpl(this._self, this._then);

  final MentorProfileCompletionDto _self;
  final $Res Function(MentorProfileCompletionDto) _then;

/// Create a copy of MentorProfileCompletionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? percentage = null,Object? checklist = null,}) {
  return _then(_self.copyWith(
percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as int,checklist: null == checklist ? _self.checklist : checklist // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [MentorProfileCompletionDto].
extension MentorProfileCompletionDtoPatterns on MentorProfileCompletionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MentorProfileCompletionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MentorProfileCompletionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MentorProfileCompletionDto value)  $default,){
final _that = this;
switch (_that) {
case _MentorProfileCompletionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MentorProfileCompletionDto value)?  $default,){
final _that = this;
switch (_that) {
case _MentorProfileCompletionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int percentage,  Map<String, dynamic> checklist)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MentorProfileCompletionDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int percentage,  Map<String, dynamic> checklist)  $default,) {final _that = this;
switch (_that) {
case _MentorProfileCompletionDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int percentage,  Map<String, dynamic> checklist)?  $default,) {final _that = this;
switch (_that) {
case _MentorProfileCompletionDto() when $default != null:
return $default(_that.percentage,_that.checklist);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MentorProfileCompletionDto extends MentorProfileCompletionDto {
  const _MentorProfileCompletionDto({this.percentage = 0, final  Map<String, dynamic> checklist = const <String, dynamic>{}}): _checklist = checklist,super._();
  factory _MentorProfileCompletionDto.fromJson(Map<String, dynamic> json) => _$MentorProfileCompletionDtoFromJson(json);

@override@JsonKey() final  int percentage;
 final  Map<String, dynamic> _checklist;
@override@JsonKey() Map<String, dynamic> get checklist {
  if (_checklist is EqualUnmodifiableMapView) return _checklist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_checklist);
}


/// Create a copy of MentorProfileCompletionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MentorProfileCompletionDtoCopyWith<_MentorProfileCompletionDto> get copyWith => __$MentorProfileCompletionDtoCopyWithImpl<_MentorProfileCompletionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MentorProfileCompletionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MentorProfileCompletionDto&&(identical(other.percentage, percentage) || other.percentage == percentage)&&const DeepCollectionEquality().equals(other._checklist, _checklist));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,percentage,const DeepCollectionEquality().hash(_checklist));

@override
String toString() {
  return 'MentorProfileCompletionDto(percentage: $percentage, checklist: $checklist)';
}


}

/// @nodoc
abstract mixin class _$MentorProfileCompletionDtoCopyWith<$Res> implements $MentorProfileCompletionDtoCopyWith<$Res> {
  factory _$MentorProfileCompletionDtoCopyWith(_MentorProfileCompletionDto value, $Res Function(_MentorProfileCompletionDto) _then) = __$MentorProfileCompletionDtoCopyWithImpl;
@override @useResult
$Res call({
 int percentage, Map<String, dynamic> checklist
});




}
/// @nodoc
class __$MentorProfileCompletionDtoCopyWithImpl<$Res>
    implements _$MentorProfileCompletionDtoCopyWith<$Res> {
  __$MentorProfileCompletionDtoCopyWithImpl(this._self, this._then);

  final _MentorProfileCompletionDto _self;
  final $Res Function(_MentorProfileCompletionDto) _then;

/// Create a copy of MentorProfileCompletionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? percentage = null,Object? checklist = null,}) {
  return _then(_MentorProfileCompletionDto(
percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as int,checklist: null == checklist ? _self._checklist : checklist // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
