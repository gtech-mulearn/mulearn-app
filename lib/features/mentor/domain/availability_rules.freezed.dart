// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'availability_rules.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SlotInput {

 int get weekday; int get startMinutes; int get endMinutes; String get timezone; String? get igId; bool get isActive;
/// Create a copy of SlotInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlotInputCopyWith<SlotInput> get copyWith => _$SlotInputCopyWithImpl<SlotInput>(this as SlotInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlotInput&&(identical(other.weekday, weekday) || other.weekday == weekday)&&(identical(other.startMinutes, startMinutes) || other.startMinutes == startMinutes)&&(identical(other.endMinutes, endMinutes) || other.endMinutes == endMinutes)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.igId, igId) || other.igId == igId)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,weekday,startMinutes,endMinutes,timezone,igId,isActive);

@override
String toString() {
  return 'SlotInput(weekday: $weekday, startMinutes: $startMinutes, endMinutes: $endMinutes, timezone: $timezone, igId: $igId, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $SlotInputCopyWith<$Res>  {
  factory $SlotInputCopyWith(SlotInput value, $Res Function(SlotInput) _then) = _$SlotInputCopyWithImpl;
@useResult
$Res call({
 int weekday, int startMinutes, int endMinutes, String timezone, String? igId, bool isActive
});




}
/// @nodoc
class _$SlotInputCopyWithImpl<$Res>
    implements $SlotInputCopyWith<$Res> {
  _$SlotInputCopyWithImpl(this._self, this._then);

  final SlotInput _self;
  final $Res Function(SlotInput) _then;

/// Create a copy of SlotInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weekday = null,Object? startMinutes = null,Object? endMinutes = null,Object? timezone = null,Object? igId = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int,startMinutes: null == startMinutes ? _self.startMinutes : startMinutes // ignore: cast_nullable_to_non_nullable
as int,endMinutes: null == endMinutes ? _self.endMinutes : endMinutes // ignore: cast_nullable_to_non_nullable
as int,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,igId: freezed == igId ? _self.igId : igId // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SlotInput].
extension SlotInputPatterns on SlotInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SlotInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SlotInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SlotInput value)  $default,){
final _that = this;
switch (_that) {
case _SlotInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SlotInput value)?  $default,){
final _that = this;
switch (_that) {
case _SlotInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int weekday,  int startMinutes,  int endMinutes,  String timezone,  String? igId,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SlotInput() when $default != null:
return $default(_that.weekday,_that.startMinutes,_that.endMinutes,_that.timezone,_that.igId,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int weekday,  int startMinutes,  int endMinutes,  String timezone,  String? igId,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _SlotInput():
return $default(_that.weekday,_that.startMinutes,_that.endMinutes,_that.timezone,_that.igId,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int weekday,  int startMinutes,  int endMinutes,  String timezone,  String? igId,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _SlotInput() when $default != null:
return $default(_that.weekday,_that.startMinutes,_that.endMinutes,_that.timezone,_that.igId,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc


class _SlotInput extends SlotInput {
  const _SlotInput({required this.weekday, required this.startMinutes, required this.endMinutes, required this.timezone, this.igId, this.isActive = true}): super._();
  

@override final  int weekday;
@override final  int startMinutes;
@override final  int endMinutes;
@override final  String timezone;
@override final  String? igId;
@override@JsonKey() final  bool isActive;

/// Create a copy of SlotInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SlotInputCopyWith<_SlotInput> get copyWith => __$SlotInputCopyWithImpl<_SlotInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SlotInput&&(identical(other.weekday, weekday) || other.weekday == weekday)&&(identical(other.startMinutes, startMinutes) || other.startMinutes == startMinutes)&&(identical(other.endMinutes, endMinutes) || other.endMinutes == endMinutes)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.igId, igId) || other.igId == igId)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,weekday,startMinutes,endMinutes,timezone,igId,isActive);

@override
String toString() {
  return 'SlotInput(weekday: $weekday, startMinutes: $startMinutes, endMinutes: $endMinutes, timezone: $timezone, igId: $igId, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$SlotInputCopyWith<$Res> implements $SlotInputCopyWith<$Res> {
  factory _$SlotInputCopyWith(_SlotInput value, $Res Function(_SlotInput) _then) = __$SlotInputCopyWithImpl;
@override @useResult
$Res call({
 int weekday, int startMinutes, int endMinutes, String timezone, String? igId, bool isActive
});




}
/// @nodoc
class __$SlotInputCopyWithImpl<$Res>
    implements _$SlotInputCopyWith<$Res> {
  __$SlotInputCopyWithImpl(this._self, this._then);

  final _SlotInput _self;
  final $Res Function(_SlotInput) _then;

/// Create a copy of SlotInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weekday = null,Object? startMinutes = null,Object? endMinutes = null,Object? timezone = null,Object? igId = freezed,Object? isActive = null,}) {
  return _then(_SlotInput(
weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int,startMinutes: null == startMinutes ? _self.startMinutes : startMinutes // ignore: cast_nullable_to_non_nullable
as int,endMinutes: null == endMinutes ? _self.endMinutes : endMinutes // ignore: cast_nullable_to_non_nullable
as int,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,igId: freezed == igId ? _self.igId : igId // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
