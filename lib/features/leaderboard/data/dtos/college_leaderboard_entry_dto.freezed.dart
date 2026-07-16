// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'college_leaderboard_entry_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CollegeLeaderboardEntryDto {

 String get code; String get title; int get totalStudents; num get totalKarma;
/// Create a copy of CollegeLeaderboardEntryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollegeLeaderboardEntryDtoCopyWith<CollegeLeaderboardEntryDto> get copyWith => _$CollegeLeaderboardEntryDtoCopyWithImpl<CollegeLeaderboardEntryDto>(this as CollegeLeaderboardEntryDto, _$identity);

  /// Serializes this CollegeLeaderboardEntryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollegeLeaderboardEntryDto&&(identical(other.code, code) || other.code == code)&&(identical(other.title, title) || other.title == title)&&(identical(other.totalStudents, totalStudents) || other.totalStudents == totalStudents)&&(identical(other.totalKarma, totalKarma) || other.totalKarma == totalKarma));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,title,totalStudents,totalKarma);

@override
String toString() {
  return 'CollegeLeaderboardEntryDto(code: $code, title: $title, totalStudents: $totalStudents, totalKarma: $totalKarma)';
}


}

/// @nodoc
abstract mixin class $CollegeLeaderboardEntryDtoCopyWith<$Res>  {
  factory $CollegeLeaderboardEntryDtoCopyWith(CollegeLeaderboardEntryDto value, $Res Function(CollegeLeaderboardEntryDto) _then) = _$CollegeLeaderboardEntryDtoCopyWithImpl;
@useResult
$Res call({
 String code, String title, int totalStudents, num totalKarma
});




}
/// @nodoc
class _$CollegeLeaderboardEntryDtoCopyWithImpl<$Res>
    implements $CollegeLeaderboardEntryDtoCopyWith<$Res> {
  _$CollegeLeaderboardEntryDtoCopyWithImpl(this._self, this._then);

  final CollegeLeaderboardEntryDto _self;
  final $Res Function(CollegeLeaderboardEntryDto) _then;

/// Create a copy of CollegeLeaderboardEntryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? title = null,Object? totalStudents = null,Object? totalKarma = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,totalStudents: null == totalStudents ? _self.totalStudents : totalStudents // ignore: cast_nullable_to_non_nullable
as int,totalKarma: null == totalKarma ? _self.totalKarma : totalKarma // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [CollegeLeaderboardEntryDto].
extension CollegeLeaderboardEntryDtoPatterns on CollegeLeaderboardEntryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollegeLeaderboardEntryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollegeLeaderboardEntryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollegeLeaderboardEntryDto value)  $default,){
final _that = this;
switch (_that) {
case _CollegeLeaderboardEntryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollegeLeaderboardEntryDto value)?  $default,){
final _that = this;
switch (_that) {
case _CollegeLeaderboardEntryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String title,  int totalStudents,  num totalKarma)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollegeLeaderboardEntryDto() when $default != null:
return $default(_that.code,_that.title,_that.totalStudents,_that.totalKarma);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String title,  int totalStudents,  num totalKarma)  $default,) {final _that = this;
switch (_that) {
case _CollegeLeaderboardEntryDto():
return $default(_that.code,_that.title,_that.totalStudents,_that.totalKarma);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String title,  int totalStudents,  num totalKarma)?  $default,) {final _that = this;
switch (_that) {
case _CollegeLeaderboardEntryDto() when $default != null:
return $default(_that.code,_that.title,_that.totalStudents,_that.totalKarma);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CollegeLeaderboardEntryDto extends CollegeLeaderboardEntryDto {
  const _CollegeLeaderboardEntryDto({required this.code, required this.title, required this.totalStudents, required this.totalKarma}): super._();
  factory _CollegeLeaderboardEntryDto.fromJson(Map<String, dynamic> json) => _$CollegeLeaderboardEntryDtoFromJson(json);

@override final  String code;
@override final  String title;
@override final  int totalStudents;
@override final  num totalKarma;

/// Create a copy of CollegeLeaderboardEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollegeLeaderboardEntryDtoCopyWith<_CollegeLeaderboardEntryDto> get copyWith => __$CollegeLeaderboardEntryDtoCopyWithImpl<_CollegeLeaderboardEntryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CollegeLeaderboardEntryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollegeLeaderboardEntryDto&&(identical(other.code, code) || other.code == code)&&(identical(other.title, title) || other.title == title)&&(identical(other.totalStudents, totalStudents) || other.totalStudents == totalStudents)&&(identical(other.totalKarma, totalKarma) || other.totalKarma == totalKarma));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,title,totalStudents,totalKarma);

@override
String toString() {
  return 'CollegeLeaderboardEntryDto(code: $code, title: $title, totalStudents: $totalStudents, totalKarma: $totalKarma)';
}


}

/// @nodoc
abstract mixin class _$CollegeLeaderboardEntryDtoCopyWith<$Res> implements $CollegeLeaderboardEntryDtoCopyWith<$Res> {
  factory _$CollegeLeaderboardEntryDtoCopyWith(_CollegeLeaderboardEntryDto value, $Res Function(_CollegeLeaderboardEntryDto) _then) = __$CollegeLeaderboardEntryDtoCopyWithImpl;
@override @useResult
$Res call({
 String code, String title, int totalStudents, num totalKarma
});




}
/// @nodoc
class __$CollegeLeaderboardEntryDtoCopyWithImpl<$Res>
    implements _$CollegeLeaderboardEntryDtoCopyWith<$Res> {
  __$CollegeLeaderboardEntryDtoCopyWithImpl(this._self, this._then);

  final _CollegeLeaderboardEntryDto _self;
  final $Res Function(_CollegeLeaderboardEntryDto) _then;

/// Create a copy of CollegeLeaderboardEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? title = null,Object? totalStudents = null,Object? totalKarma = null,}) {
  return _then(_CollegeLeaderboardEntryDto(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,totalStudents: null == totalStudents ? _self.totalStudents : totalStudents // ignore: cast_nullable_to_non_nullable
as int,totalKarma: null == totalKarma ? _self.totalKarma : totalKarma // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on
