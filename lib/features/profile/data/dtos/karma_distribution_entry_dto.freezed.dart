// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'karma_distribution_entry_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KarmaDistributionEntryDto {

 String get taskType; num get karma;
/// Create a copy of KarmaDistributionEntryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KarmaDistributionEntryDtoCopyWith<KarmaDistributionEntryDto> get copyWith => _$KarmaDistributionEntryDtoCopyWithImpl<KarmaDistributionEntryDto>(this as KarmaDistributionEntryDto, _$identity);

  /// Serializes this KarmaDistributionEntryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KarmaDistributionEntryDto&&(identical(other.taskType, taskType) || other.taskType == taskType)&&(identical(other.karma, karma) || other.karma == karma));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,taskType,karma);

@override
String toString() {
  return 'KarmaDistributionEntryDto(taskType: $taskType, karma: $karma)';
}


}

/// @nodoc
abstract mixin class $KarmaDistributionEntryDtoCopyWith<$Res>  {
  factory $KarmaDistributionEntryDtoCopyWith(KarmaDistributionEntryDto value, $Res Function(KarmaDistributionEntryDto) _then) = _$KarmaDistributionEntryDtoCopyWithImpl;
@useResult
$Res call({
 String taskType, num karma
});




}
/// @nodoc
class _$KarmaDistributionEntryDtoCopyWithImpl<$Res>
    implements $KarmaDistributionEntryDtoCopyWith<$Res> {
  _$KarmaDistributionEntryDtoCopyWithImpl(this._self, this._then);

  final KarmaDistributionEntryDto _self;
  final $Res Function(KarmaDistributionEntryDto) _then;

/// Create a copy of KarmaDistributionEntryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? taskType = null,Object? karma = null,}) {
  return _then(_self.copyWith(
taskType: null == taskType ? _self.taskType : taskType // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [KarmaDistributionEntryDto].
extension KarmaDistributionEntryDtoPatterns on KarmaDistributionEntryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KarmaDistributionEntryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KarmaDistributionEntryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KarmaDistributionEntryDto value)  $default,){
final _that = this;
switch (_that) {
case _KarmaDistributionEntryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KarmaDistributionEntryDto value)?  $default,){
final _that = this;
switch (_that) {
case _KarmaDistributionEntryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String taskType,  num karma)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KarmaDistributionEntryDto() when $default != null:
return $default(_that.taskType,_that.karma);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String taskType,  num karma)  $default,) {final _that = this;
switch (_that) {
case _KarmaDistributionEntryDto():
return $default(_that.taskType,_that.karma);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String taskType,  num karma)?  $default,) {final _that = this;
switch (_that) {
case _KarmaDistributionEntryDto() when $default != null:
return $default(_that.taskType,_that.karma);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KarmaDistributionEntryDto extends KarmaDistributionEntryDto {
  const _KarmaDistributionEntryDto({required this.taskType, required this.karma}): super._();
  factory _KarmaDistributionEntryDto.fromJson(Map<String, dynamic> json) => _$KarmaDistributionEntryDtoFromJson(json);

@override final  String taskType;
@override final  num karma;

/// Create a copy of KarmaDistributionEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KarmaDistributionEntryDtoCopyWith<_KarmaDistributionEntryDto> get copyWith => __$KarmaDistributionEntryDtoCopyWithImpl<_KarmaDistributionEntryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KarmaDistributionEntryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KarmaDistributionEntryDto&&(identical(other.taskType, taskType) || other.taskType == taskType)&&(identical(other.karma, karma) || other.karma == karma));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,taskType,karma);

@override
String toString() {
  return 'KarmaDistributionEntryDto(taskType: $taskType, karma: $karma)';
}


}

/// @nodoc
abstract mixin class _$KarmaDistributionEntryDtoCopyWith<$Res> implements $KarmaDistributionEntryDtoCopyWith<$Res> {
  factory _$KarmaDistributionEntryDtoCopyWith(_KarmaDistributionEntryDto value, $Res Function(_KarmaDistributionEntryDto) _then) = __$KarmaDistributionEntryDtoCopyWithImpl;
@override @useResult
$Res call({
 String taskType, num karma
});




}
/// @nodoc
class __$KarmaDistributionEntryDtoCopyWithImpl<$Res>
    implements _$KarmaDistributionEntryDtoCopyWith<$Res> {
  __$KarmaDistributionEntryDtoCopyWithImpl(this._self, this._then);

  final _KarmaDistributionEntryDto _self;
  final $Res Function(_KarmaDistributionEntryDto) _then;

/// Create a copy of KarmaDistributionEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? taskType = null,Object? karma = null,}) {
  return _then(_KarmaDistributionEntryDto(
taskType: null == taskType ? _self.taskType : taskType // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on
