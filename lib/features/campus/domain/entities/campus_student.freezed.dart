// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campus_student.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CampusStudent {

 String get fullName; String get muid; int get karma; String get level; bool get isAlumni; int get igCount; int get lcCount; int? get rank; DateTime? get joinedAt; DateTime? get lastKarmaAt; String? get graduationYear; String? get department;
/// Create a copy of CampusStudent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampusStudentCopyWith<CampusStudent> get copyWith => _$CampusStudentCopyWithImpl<CampusStudent>(this as CampusStudent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampusStudent&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.level, level) || other.level == level)&&(identical(other.isAlumni, isAlumni) || other.isAlumni == isAlumni)&&(identical(other.igCount, igCount) || other.igCount == igCount)&&(identical(other.lcCount, lcCount) || other.lcCount == lcCount)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.lastKarmaAt, lastKarmaAt) || other.lastKarmaAt == lastKarmaAt)&&(identical(other.graduationYear, graduationYear) || other.graduationYear == graduationYear)&&(identical(other.department, department) || other.department == department));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,muid,karma,level,isAlumni,igCount,lcCount,rank,joinedAt,lastKarmaAt,graduationYear,department);

@override
String toString() {
  return 'CampusStudent(fullName: $fullName, muid: $muid, karma: $karma, level: $level, isAlumni: $isAlumni, igCount: $igCount, lcCount: $lcCount, rank: $rank, joinedAt: $joinedAt, lastKarmaAt: $lastKarmaAt, graduationYear: $graduationYear, department: $department)';
}


}

/// @nodoc
abstract mixin class $CampusStudentCopyWith<$Res>  {
  factory $CampusStudentCopyWith(CampusStudent value, $Res Function(CampusStudent) _then) = _$CampusStudentCopyWithImpl;
@useResult
$Res call({
 String fullName, String muid, int karma, String level, bool isAlumni, int igCount, int lcCount, int? rank, DateTime? joinedAt, DateTime? lastKarmaAt, String? graduationYear, String? department
});




}
/// @nodoc
class _$CampusStudentCopyWithImpl<$Res>
    implements $CampusStudentCopyWith<$Res> {
  _$CampusStudentCopyWithImpl(this._self, this._then);

  final CampusStudent _self;
  final $Res Function(CampusStudent) _then;

/// Create a copy of CampusStudent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? muid = null,Object? karma = null,Object? level = null,Object? isAlumni = null,Object? igCount = null,Object? lcCount = null,Object? rank = freezed,Object? joinedAt = freezed,Object? lastKarmaAt = freezed,Object? graduationYear = freezed,Object? department = freezed,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,isAlumni: null == isAlumni ? _self.isAlumni : isAlumni // ignore: cast_nullable_to_non_nullable
as bool,igCount: null == igCount ? _self.igCount : igCount // ignore: cast_nullable_to_non_nullable
as int,lcCount: null == lcCount ? _self.lcCount : lcCount // ignore: cast_nullable_to_non_nullable
as int,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int?,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastKarmaAt: freezed == lastKarmaAt ? _self.lastKarmaAt : lastKarmaAt // ignore: cast_nullable_to_non_nullable
as DateTime?,graduationYear: freezed == graduationYear ? _self.graduationYear : graduationYear // ignore: cast_nullable_to_non_nullable
as String?,department: freezed == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CampusStudent].
extension CampusStudentPatterns on CampusStudent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampusStudent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampusStudent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampusStudent value)  $default,){
final _that = this;
switch (_that) {
case _CampusStudent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampusStudent value)?  $default,){
final _that = this;
switch (_that) {
case _CampusStudent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fullName,  String muid,  int karma,  String level,  bool isAlumni,  int igCount,  int lcCount,  int? rank,  DateTime? joinedAt,  DateTime? lastKarmaAt,  String? graduationYear,  String? department)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampusStudent() when $default != null:
return $default(_that.fullName,_that.muid,_that.karma,_that.level,_that.isAlumni,_that.igCount,_that.lcCount,_that.rank,_that.joinedAt,_that.lastKarmaAt,_that.graduationYear,_that.department);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fullName,  String muid,  int karma,  String level,  bool isAlumni,  int igCount,  int lcCount,  int? rank,  DateTime? joinedAt,  DateTime? lastKarmaAt,  String? graduationYear,  String? department)  $default,) {final _that = this;
switch (_that) {
case _CampusStudent():
return $default(_that.fullName,_that.muid,_that.karma,_that.level,_that.isAlumni,_that.igCount,_that.lcCount,_that.rank,_that.joinedAt,_that.lastKarmaAt,_that.graduationYear,_that.department);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fullName,  String muid,  int karma,  String level,  bool isAlumni,  int igCount,  int lcCount,  int? rank,  DateTime? joinedAt,  DateTime? lastKarmaAt,  String? graduationYear,  String? department)?  $default,) {final _that = this;
switch (_that) {
case _CampusStudent() when $default != null:
return $default(_that.fullName,_that.muid,_that.karma,_that.level,_that.isAlumni,_that.igCount,_that.lcCount,_that.rank,_that.joinedAt,_that.lastKarmaAt,_that.graduationYear,_that.department);case _:
  return null;

}
}

}

/// @nodoc


class _CampusStudent implements CampusStudent {
  const _CampusStudent({required this.fullName, required this.muid, required this.karma, required this.level, required this.isAlumni, required this.igCount, required this.lcCount, this.rank, this.joinedAt, this.lastKarmaAt, this.graduationYear, this.department});
  

@override final  String fullName;
@override final  String muid;
@override final  int karma;
@override final  String level;
@override final  bool isAlumni;
@override final  int igCount;
@override final  int lcCount;
@override final  int? rank;
@override final  DateTime? joinedAt;
@override final  DateTime? lastKarmaAt;
@override final  String? graduationYear;
@override final  String? department;

/// Create a copy of CampusStudent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampusStudentCopyWith<_CampusStudent> get copyWith => __$CampusStudentCopyWithImpl<_CampusStudent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampusStudent&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.level, level) || other.level == level)&&(identical(other.isAlumni, isAlumni) || other.isAlumni == isAlumni)&&(identical(other.igCount, igCount) || other.igCount == igCount)&&(identical(other.lcCount, lcCount) || other.lcCount == lcCount)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.lastKarmaAt, lastKarmaAt) || other.lastKarmaAt == lastKarmaAt)&&(identical(other.graduationYear, graduationYear) || other.graduationYear == graduationYear)&&(identical(other.department, department) || other.department == department));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,muid,karma,level,isAlumni,igCount,lcCount,rank,joinedAt,lastKarmaAt,graduationYear,department);

@override
String toString() {
  return 'CampusStudent(fullName: $fullName, muid: $muid, karma: $karma, level: $level, isAlumni: $isAlumni, igCount: $igCount, lcCount: $lcCount, rank: $rank, joinedAt: $joinedAt, lastKarmaAt: $lastKarmaAt, graduationYear: $graduationYear, department: $department)';
}


}

/// @nodoc
abstract mixin class _$CampusStudentCopyWith<$Res> implements $CampusStudentCopyWith<$Res> {
  factory _$CampusStudentCopyWith(_CampusStudent value, $Res Function(_CampusStudent) _then) = __$CampusStudentCopyWithImpl;
@override @useResult
$Res call({
 String fullName, String muid, int karma, String level, bool isAlumni, int igCount, int lcCount, int? rank, DateTime? joinedAt, DateTime? lastKarmaAt, String? graduationYear, String? department
});




}
/// @nodoc
class __$CampusStudentCopyWithImpl<$Res>
    implements _$CampusStudentCopyWith<$Res> {
  __$CampusStudentCopyWithImpl(this._self, this._then);

  final _CampusStudent _self;
  final $Res Function(_CampusStudent) _then;

/// Create a copy of CampusStudent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? muid = null,Object? karma = null,Object? level = null,Object? isAlumni = null,Object? igCount = null,Object? lcCount = null,Object? rank = freezed,Object? joinedAt = freezed,Object? lastKarmaAt = freezed,Object? graduationYear = freezed,Object? department = freezed,}) {
  return _then(_CampusStudent(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,isAlumni: null == isAlumni ? _self.isAlumni : isAlumni // ignore: cast_nullable_to_non_nullable
as bool,igCount: null == igCount ? _self.igCount : igCount // ignore: cast_nullable_to_non_nullable
as int,lcCount: null == lcCount ? _self.lcCount : lcCount // ignore: cast_nullable_to_non_nullable
as int,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int?,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastKarmaAt: freezed == lastKarmaAt ? _self.lastKarmaAt : lastKarmaAt // ignore: cast_nullable_to_non_nullable
as DateTime?,graduationYear: freezed == graduationYear ? _self.graduationYear : graduationYear // ignore: cast_nullable_to_non_nullable
as String?,department: freezed == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
