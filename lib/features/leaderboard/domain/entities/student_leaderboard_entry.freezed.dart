// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_leaderboard_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudentLeaderboardEntry {

 String get fullName; num get totalKarma; String get institution; String? get profilePic;
/// Create a copy of StudentLeaderboardEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentLeaderboardEntryCopyWith<StudentLeaderboardEntry> get copyWith => _$StudentLeaderboardEntryCopyWithImpl<StudentLeaderboardEntry>(this as StudentLeaderboardEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentLeaderboardEntry&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.totalKarma, totalKarma) || other.totalKarma == totalKarma)&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,totalKarma,institution,profilePic);

@override
String toString() {
  return 'StudentLeaderboardEntry(fullName: $fullName, totalKarma: $totalKarma, institution: $institution, profilePic: $profilePic)';
}


}

/// @nodoc
abstract mixin class $StudentLeaderboardEntryCopyWith<$Res>  {
  factory $StudentLeaderboardEntryCopyWith(StudentLeaderboardEntry value, $Res Function(StudentLeaderboardEntry) _then) = _$StudentLeaderboardEntryCopyWithImpl;
@useResult
$Res call({
 String fullName, num totalKarma, String institution, String? profilePic
});




}
/// @nodoc
class _$StudentLeaderboardEntryCopyWithImpl<$Res>
    implements $StudentLeaderboardEntryCopyWith<$Res> {
  _$StudentLeaderboardEntryCopyWithImpl(this._self, this._then);

  final StudentLeaderboardEntry _self;
  final $Res Function(StudentLeaderboardEntry) _then;

/// Create a copy of StudentLeaderboardEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? totalKarma = null,Object? institution = null,Object? profilePic = freezed,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,totalKarma: null == totalKarma ? _self.totalKarma : totalKarma // ignore: cast_nullable_to_non_nullable
as num,institution: null == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as String,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StudentLeaderboardEntry].
extension StudentLeaderboardEntryPatterns on StudentLeaderboardEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudentLeaderboardEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudentLeaderboardEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudentLeaderboardEntry value)  $default,){
final _that = this;
switch (_that) {
case _StudentLeaderboardEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudentLeaderboardEntry value)?  $default,){
final _that = this;
switch (_that) {
case _StudentLeaderboardEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fullName,  num totalKarma,  String institution,  String? profilePic)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudentLeaderboardEntry() when $default != null:
return $default(_that.fullName,_that.totalKarma,_that.institution,_that.profilePic);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fullName,  num totalKarma,  String institution,  String? profilePic)  $default,) {final _that = this;
switch (_that) {
case _StudentLeaderboardEntry():
return $default(_that.fullName,_that.totalKarma,_that.institution,_that.profilePic);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fullName,  num totalKarma,  String institution,  String? profilePic)?  $default,) {final _that = this;
switch (_that) {
case _StudentLeaderboardEntry() when $default != null:
return $default(_that.fullName,_that.totalKarma,_that.institution,_that.profilePic);case _:
  return null;

}
}

}

/// @nodoc


class _StudentLeaderboardEntry implements StudentLeaderboardEntry {
  const _StudentLeaderboardEntry({required this.fullName, required this.totalKarma, required this.institution, this.profilePic});
  

@override final  String fullName;
@override final  num totalKarma;
@override final  String institution;
@override final  String? profilePic;

/// Create a copy of StudentLeaderboardEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudentLeaderboardEntryCopyWith<_StudentLeaderboardEntry> get copyWith => __$StudentLeaderboardEntryCopyWithImpl<_StudentLeaderboardEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudentLeaderboardEntry&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.totalKarma, totalKarma) || other.totalKarma == totalKarma)&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,totalKarma,institution,profilePic);

@override
String toString() {
  return 'StudentLeaderboardEntry(fullName: $fullName, totalKarma: $totalKarma, institution: $institution, profilePic: $profilePic)';
}


}

/// @nodoc
abstract mixin class _$StudentLeaderboardEntryCopyWith<$Res> implements $StudentLeaderboardEntryCopyWith<$Res> {
  factory _$StudentLeaderboardEntryCopyWith(_StudentLeaderboardEntry value, $Res Function(_StudentLeaderboardEntry) _then) = __$StudentLeaderboardEntryCopyWithImpl;
@override @useResult
$Res call({
 String fullName, num totalKarma, String institution, String? profilePic
});




}
/// @nodoc
class __$StudentLeaderboardEntryCopyWithImpl<$Res>
    implements _$StudentLeaderboardEntryCopyWith<$Res> {
  __$StudentLeaderboardEntryCopyWithImpl(this._self, this._then);

  final _StudentLeaderboardEntry _self;
  final $Res Function(_StudentLeaderboardEntry) _then;

/// Create a copy of StudentLeaderboardEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? totalKarma = null,Object? institution = null,Object? profilePic = freezed,}) {
  return _then(_StudentLeaderboardEntry(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,totalKarma: null == totalKarma ? _self.totalKarma : totalKarma // ignore: cast_nullable_to_non_nullable
as num,institution: null == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as String,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
