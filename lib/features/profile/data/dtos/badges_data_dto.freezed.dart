// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'badges_data_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BadgesDataDto {

 String get fullName; List<String> get completedTasks;
/// Create a copy of BadgesDataDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BadgesDataDtoCopyWith<BadgesDataDto> get copyWith => _$BadgesDataDtoCopyWithImpl<BadgesDataDto>(this as BadgesDataDto, _$identity);

  /// Serializes this BadgesDataDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BadgesDataDto&&(identical(other.fullName, fullName) || other.fullName == fullName)&&const DeepCollectionEquality().equals(other.completedTasks, completedTasks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,const DeepCollectionEquality().hash(completedTasks));

@override
String toString() {
  return 'BadgesDataDto(fullName: $fullName, completedTasks: $completedTasks)';
}


}

/// @nodoc
abstract mixin class $BadgesDataDtoCopyWith<$Res>  {
  factory $BadgesDataDtoCopyWith(BadgesDataDto value, $Res Function(BadgesDataDto) _then) = _$BadgesDataDtoCopyWithImpl;
@useResult
$Res call({
 String fullName, List<String> completedTasks
});




}
/// @nodoc
class _$BadgesDataDtoCopyWithImpl<$Res>
    implements $BadgesDataDtoCopyWith<$Res> {
  _$BadgesDataDtoCopyWithImpl(this._self, this._then);

  final BadgesDataDto _self;
  final $Res Function(BadgesDataDto) _then;

/// Create a copy of BadgesDataDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? completedTasks = null,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,completedTasks: null == completedTasks ? _self.completedTasks : completedTasks // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [BadgesDataDto].
extension BadgesDataDtoPatterns on BadgesDataDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BadgesDataDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BadgesDataDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BadgesDataDto value)  $default,){
final _that = this;
switch (_that) {
case _BadgesDataDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BadgesDataDto value)?  $default,){
final _that = this;
switch (_that) {
case _BadgesDataDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fullName,  List<String> completedTasks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BadgesDataDto() when $default != null:
return $default(_that.fullName,_that.completedTasks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fullName,  List<String> completedTasks)  $default,) {final _that = this;
switch (_that) {
case _BadgesDataDto():
return $default(_that.fullName,_that.completedTasks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fullName,  List<String> completedTasks)?  $default,) {final _that = this;
switch (_that) {
case _BadgesDataDto() when $default != null:
return $default(_that.fullName,_that.completedTasks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BadgesDataDto extends BadgesDataDto {
  const _BadgesDataDto({required this.fullName, final  List<String> completedTasks = const []}): _completedTasks = completedTasks,super._();
  factory _BadgesDataDto.fromJson(Map<String, dynamic> json) => _$BadgesDataDtoFromJson(json);

@override final  String fullName;
 final  List<String> _completedTasks;
@override@JsonKey() List<String> get completedTasks {
  if (_completedTasks is EqualUnmodifiableListView) return _completedTasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_completedTasks);
}


/// Create a copy of BadgesDataDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BadgesDataDtoCopyWith<_BadgesDataDto> get copyWith => __$BadgesDataDtoCopyWithImpl<_BadgesDataDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BadgesDataDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BadgesDataDto&&(identical(other.fullName, fullName) || other.fullName == fullName)&&const DeepCollectionEquality().equals(other._completedTasks, _completedTasks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,const DeepCollectionEquality().hash(_completedTasks));

@override
String toString() {
  return 'BadgesDataDto(fullName: $fullName, completedTasks: $completedTasks)';
}


}

/// @nodoc
abstract mixin class _$BadgesDataDtoCopyWith<$Res> implements $BadgesDataDtoCopyWith<$Res> {
  factory _$BadgesDataDtoCopyWith(_BadgesDataDto value, $Res Function(_BadgesDataDto) _then) = __$BadgesDataDtoCopyWithImpl;
@override @useResult
$Res call({
 String fullName, List<String> completedTasks
});




}
/// @nodoc
class __$BadgesDataDtoCopyWithImpl<$Res>
    implements _$BadgesDataDtoCopyWith<$Res> {
  __$BadgesDataDtoCopyWithImpl(this._self, this._then);

  final _BadgesDataDto _self;
  final $Res Function(_BadgesDataDto) _then;

/// Create a copy of BadgesDataDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? completedTasks = null,}) {
  return _then(_BadgesDataDto(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,completedTasks: null == completedTasks ? _self._completedTasks : completedTasks // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
