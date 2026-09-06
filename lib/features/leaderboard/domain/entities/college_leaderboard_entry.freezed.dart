// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'college_leaderboard_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CollegeLeaderboardEntry {

 int get totalStudents; num get totalKarma; String? get code; String? get title;
/// Create a copy of CollegeLeaderboardEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollegeLeaderboardEntryCopyWith<CollegeLeaderboardEntry> get copyWith => _$CollegeLeaderboardEntryCopyWithImpl<CollegeLeaderboardEntry>(this as CollegeLeaderboardEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollegeLeaderboardEntry&&(identical(other.totalStudents, totalStudents) || other.totalStudents == totalStudents)&&(identical(other.totalKarma, totalKarma) || other.totalKarma == totalKarma)&&(identical(other.code, code) || other.code == code)&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode => Object.hash(runtimeType,totalStudents,totalKarma,code,title);

@override
String toString() {
  return 'CollegeLeaderboardEntry(totalStudents: $totalStudents, totalKarma: $totalKarma, code: $code, title: $title)';
}


}

/// @nodoc
abstract mixin class $CollegeLeaderboardEntryCopyWith<$Res>  {
  factory $CollegeLeaderboardEntryCopyWith(CollegeLeaderboardEntry value, $Res Function(CollegeLeaderboardEntry) _then) = _$CollegeLeaderboardEntryCopyWithImpl;
@useResult
$Res call({
 int totalStudents, num totalKarma, String? code, String? title
});




}
/// @nodoc
class _$CollegeLeaderboardEntryCopyWithImpl<$Res>
    implements $CollegeLeaderboardEntryCopyWith<$Res> {
  _$CollegeLeaderboardEntryCopyWithImpl(this._self, this._then);

  final CollegeLeaderboardEntry _self;
  final $Res Function(CollegeLeaderboardEntry) _then;

/// Create a copy of CollegeLeaderboardEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalStudents = null,Object? totalKarma = null,Object? code = freezed,Object? title = freezed,}) {
  return _then(_self.copyWith(
totalStudents: null == totalStudents ? _self.totalStudents : totalStudents // ignore: cast_nullable_to_non_nullable
as int,totalKarma: null == totalKarma ? _self.totalKarma : totalKarma // ignore: cast_nullable_to_non_nullable
as num,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CollegeLeaderboardEntry].
extension CollegeLeaderboardEntryPatterns on CollegeLeaderboardEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollegeLeaderboardEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollegeLeaderboardEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollegeLeaderboardEntry value)  $default,){
final _that = this;
switch (_that) {
case _CollegeLeaderboardEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollegeLeaderboardEntry value)?  $default,){
final _that = this;
switch (_that) {
case _CollegeLeaderboardEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalStudents,  num totalKarma,  String? code,  String? title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollegeLeaderboardEntry() when $default != null:
return $default(_that.totalStudents,_that.totalKarma,_that.code,_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalStudents,  num totalKarma,  String? code,  String? title)  $default,) {final _that = this;
switch (_that) {
case _CollegeLeaderboardEntry():
return $default(_that.totalStudents,_that.totalKarma,_that.code,_that.title);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalStudents,  num totalKarma,  String? code,  String? title)?  $default,) {final _that = this;
switch (_that) {
case _CollegeLeaderboardEntry() when $default != null:
return $default(_that.totalStudents,_that.totalKarma,_that.code,_that.title);case _:
  return null;

}
}

}

/// @nodoc


class _CollegeLeaderboardEntry implements CollegeLeaderboardEntry {
  const _CollegeLeaderboardEntry({required this.totalStudents, required this.totalKarma, this.code, this.title});
  

@override final  int totalStudents;
@override final  num totalKarma;
@override final  String? code;
@override final  String? title;

/// Create a copy of CollegeLeaderboardEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollegeLeaderboardEntryCopyWith<_CollegeLeaderboardEntry> get copyWith => __$CollegeLeaderboardEntryCopyWithImpl<_CollegeLeaderboardEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollegeLeaderboardEntry&&(identical(other.totalStudents, totalStudents) || other.totalStudents == totalStudents)&&(identical(other.totalKarma, totalKarma) || other.totalKarma == totalKarma)&&(identical(other.code, code) || other.code == code)&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode => Object.hash(runtimeType,totalStudents,totalKarma,code,title);

@override
String toString() {
  return 'CollegeLeaderboardEntry(totalStudents: $totalStudents, totalKarma: $totalKarma, code: $code, title: $title)';
}


}

/// @nodoc
abstract mixin class _$CollegeLeaderboardEntryCopyWith<$Res> implements $CollegeLeaderboardEntryCopyWith<$Res> {
  factory _$CollegeLeaderboardEntryCopyWith(_CollegeLeaderboardEntry value, $Res Function(_CollegeLeaderboardEntry) _then) = __$CollegeLeaderboardEntryCopyWithImpl;
@override @useResult
$Res call({
 int totalStudents, num totalKarma, String? code, String? title
});




}
/// @nodoc
class __$CollegeLeaderboardEntryCopyWithImpl<$Res>
    implements _$CollegeLeaderboardEntryCopyWith<$Res> {
  __$CollegeLeaderboardEntryCopyWithImpl(this._self, this._then);

  final _CollegeLeaderboardEntry _self;
  final $Res Function(_CollegeLeaderboardEntry) _then;

/// Create a copy of CollegeLeaderboardEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalStudents = null,Object? totalKarma = null,Object? code = freezed,Object? title = freezed,}) {
  return _then(_CollegeLeaderboardEntry(
totalStudents: null == totalStudents ? _self.totalStudents : totalStudents // ignore: cast_nullable_to_non_nullable
as int,totalKarma: null == totalKarma ? _self.totalKarma : totalKarma // ignore: cast_nullable_to_non_nullable
as num,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
