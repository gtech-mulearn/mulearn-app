// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_log_entry_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserLogEntryDto {

 String get taskName; num get karma; String get createdDate;
/// Create a copy of UserLogEntryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserLogEntryDtoCopyWith<UserLogEntryDto> get copyWith => _$UserLogEntryDtoCopyWithImpl<UserLogEntryDto>(this as UserLogEntryDto, _$identity);

  /// Serializes this UserLogEntryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserLogEntryDto&&(identical(other.taskName, taskName) || other.taskName == taskName)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,taskName,karma,createdDate);

@override
String toString() {
  return 'UserLogEntryDto(taskName: $taskName, karma: $karma, createdDate: $createdDate)';
}


}

/// @nodoc
abstract mixin class $UserLogEntryDtoCopyWith<$Res>  {
  factory $UserLogEntryDtoCopyWith(UserLogEntryDto value, $Res Function(UserLogEntryDto) _then) = _$UserLogEntryDtoCopyWithImpl;
@useResult
$Res call({
 String taskName, num karma, String createdDate
});




}
/// @nodoc
class _$UserLogEntryDtoCopyWithImpl<$Res>
    implements $UserLogEntryDtoCopyWith<$Res> {
  _$UserLogEntryDtoCopyWithImpl(this._self, this._then);

  final UserLogEntryDto _self;
  final $Res Function(UserLogEntryDto) _then;

/// Create a copy of UserLogEntryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? taskName = null,Object? karma = null,Object? createdDate = null,}) {
  return _then(_self.copyWith(
taskName: null == taskName ? _self.taskName : taskName // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserLogEntryDto].
extension UserLogEntryDtoPatterns on UserLogEntryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserLogEntryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserLogEntryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserLogEntryDto value)  $default,){
final _that = this;
switch (_that) {
case _UserLogEntryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserLogEntryDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserLogEntryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String taskName,  num karma,  String createdDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserLogEntryDto() when $default != null:
return $default(_that.taskName,_that.karma,_that.createdDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String taskName,  num karma,  String createdDate)  $default,) {final _that = this;
switch (_that) {
case _UserLogEntryDto():
return $default(_that.taskName,_that.karma,_that.createdDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String taskName,  num karma,  String createdDate)?  $default,) {final _that = this;
switch (_that) {
case _UserLogEntryDto() when $default != null:
return $default(_that.taskName,_that.karma,_that.createdDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserLogEntryDto extends UserLogEntryDto {
  const _UserLogEntryDto({required this.taskName, required this.karma, required this.createdDate}): super._();
  factory _UserLogEntryDto.fromJson(Map<String, dynamic> json) => _$UserLogEntryDtoFromJson(json);

@override final  String taskName;
@override final  num karma;
@override final  String createdDate;

/// Create a copy of UserLogEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserLogEntryDtoCopyWith<_UserLogEntryDto> get copyWith => __$UserLogEntryDtoCopyWithImpl<_UserLogEntryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserLogEntryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserLogEntryDto&&(identical(other.taskName, taskName) || other.taskName == taskName)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,taskName,karma,createdDate);

@override
String toString() {
  return 'UserLogEntryDto(taskName: $taskName, karma: $karma, createdDate: $createdDate)';
}


}

/// @nodoc
abstract mixin class _$UserLogEntryDtoCopyWith<$Res> implements $UserLogEntryDtoCopyWith<$Res> {
  factory _$UserLogEntryDtoCopyWith(_UserLogEntryDto value, $Res Function(_UserLogEntryDto) _then) = __$UserLogEntryDtoCopyWithImpl;
@override @useResult
$Res call({
 String taskName, num karma, String createdDate
});




}
/// @nodoc
class __$UserLogEntryDtoCopyWithImpl<$Res>
    implements _$UserLogEntryDtoCopyWith<$Res> {
  __$UserLogEntryDtoCopyWithImpl(this._self, this._then);

  final _UserLogEntryDto _self;
  final $Res Function(_UserLogEntryDto) _then;

/// Create a copy of UserLogEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? taskName = null,Object? karma = null,Object? createdDate = null,}) {
  return _then(_UserLogEntryDto(
taskName: null == taskName ? _self.taskName : taskName // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
