// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_progress_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MyProgressSummary {

 String get fullName; String get muid; int get karma; String? get level; String? get profilePicUrl; int? get rank; double? get percentile;
/// Create a copy of MyProgressSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyProgressSummaryCopyWith<MyProgressSummary> get copyWith => _$MyProgressSummaryCopyWithImpl<MyProgressSummary>(this as MyProgressSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyProgressSummary&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.level, level) || other.level == level)&&(identical(other.profilePicUrl, profilePicUrl) || other.profilePicUrl == profilePicUrl)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.percentile, percentile) || other.percentile == percentile));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,muid,karma,level,profilePicUrl,rank,percentile);

@override
String toString() {
  return 'MyProgressSummary(fullName: $fullName, muid: $muid, karma: $karma, level: $level, profilePicUrl: $profilePicUrl, rank: $rank, percentile: $percentile)';
}


}

/// @nodoc
abstract mixin class $MyProgressSummaryCopyWith<$Res>  {
  factory $MyProgressSummaryCopyWith(MyProgressSummary value, $Res Function(MyProgressSummary) _then) = _$MyProgressSummaryCopyWithImpl;
@useResult
$Res call({
 String fullName, String muid, int karma, String? level, String? profilePicUrl, int? rank, double? percentile
});




}
/// @nodoc
class _$MyProgressSummaryCopyWithImpl<$Res>
    implements $MyProgressSummaryCopyWith<$Res> {
  _$MyProgressSummaryCopyWithImpl(this._self, this._then);

  final MyProgressSummary _self;
  final $Res Function(MyProgressSummary) _then;

/// Create a copy of MyProgressSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? muid = null,Object? karma = null,Object? level = freezed,Object? profilePicUrl = freezed,Object? rank = freezed,Object? percentile = freezed,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as int,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String?,profilePicUrl: freezed == profilePicUrl ? _self.profilePicUrl : profilePicUrl // ignore: cast_nullable_to_non_nullable
as String?,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int?,percentile: freezed == percentile ? _self.percentile : percentile // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [MyProgressSummary].
extension MyProgressSummaryPatterns on MyProgressSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyProgressSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyProgressSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyProgressSummary value)  $default,){
final _that = this;
switch (_that) {
case _MyProgressSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyProgressSummary value)?  $default,){
final _that = this;
switch (_that) {
case _MyProgressSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fullName,  String muid,  int karma,  String? level,  String? profilePicUrl,  int? rank,  double? percentile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyProgressSummary() when $default != null:
return $default(_that.fullName,_that.muid,_that.karma,_that.level,_that.profilePicUrl,_that.rank,_that.percentile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fullName,  String muid,  int karma,  String? level,  String? profilePicUrl,  int? rank,  double? percentile)  $default,) {final _that = this;
switch (_that) {
case _MyProgressSummary():
return $default(_that.fullName,_that.muid,_that.karma,_that.level,_that.profilePicUrl,_that.rank,_that.percentile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fullName,  String muid,  int karma,  String? level,  String? profilePicUrl,  int? rank,  double? percentile)?  $default,) {final _that = this;
switch (_that) {
case _MyProgressSummary() when $default != null:
return $default(_that.fullName,_that.muid,_that.karma,_that.level,_that.profilePicUrl,_that.rank,_that.percentile);case _:
  return null;

}
}

}

/// @nodoc


class _MyProgressSummary implements MyProgressSummary {
  const _MyProgressSummary({required this.fullName, required this.muid, required this.karma, this.level, this.profilePicUrl, this.rank, this.percentile});
  

@override final  String fullName;
@override final  String muid;
@override final  int karma;
@override final  String? level;
@override final  String? profilePicUrl;
@override final  int? rank;
@override final  double? percentile;

/// Create a copy of MyProgressSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyProgressSummaryCopyWith<_MyProgressSummary> get copyWith => __$MyProgressSummaryCopyWithImpl<_MyProgressSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyProgressSummary&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.level, level) || other.level == level)&&(identical(other.profilePicUrl, profilePicUrl) || other.profilePicUrl == profilePicUrl)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.percentile, percentile) || other.percentile == percentile));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,muid,karma,level,profilePicUrl,rank,percentile);

@override
String toString() {
  return 'MyProgressSummary(fullName: $fullName, muid: $muid, karma: $karma, level: $level, profilePicUrl: $profilePicUrl, rank: $rank, percentile: $percentile)';
}


}

/// @nodoc
abstract mixin class _$MyProgressSummaryCopyWith<$Res> implements $MyProgressSummaryCopyWith<$Res> {
  factory _$MyProgressSummaryCopyWith(_MyProgressSummary value, $Res Function(_MyProgressSummary) _then) = __$MyProgressSummaryCopyWithImpl;
@override @useResult
$Res call({
 String fullName, String muid, int karma, String? level, String? profilePicUrl, int? rank, double? percentile
});




}
/// @nodoc
class __$MyProgressSummaryCopyWithImpl<$Res>
    implements _$MyProgressSummaryCopyWith<$Res> {
  __$MyProgressSummaryCopyWithImpl(this._self, this._then);

  final _MyProgressSummary _self;
  final $Res Function(_MyProgressSummary) _then;

/// Create a copy of MyProgressSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? muid = null,Object? karma = null,Object? level = freezed,Object? profilePicUrl = freezed,Object? rank = freezed,Object? percentile = freezed,}) {
  return _then(_MyProgressSummary(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as int,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String?,profilePicUrl: freezed == profilePicUrl ? _self.profilePicUrl : profilePicUrl // ignore: cast_nullable_to_non_nullable
as String?,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int?,percentile: freezed == percentile ? _self.percentile : percentile // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
