// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_progress_summary_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MyProgressSummaryDto {

 String get fullName; String get muid; num? get karma; String? get level; String? get profilePic; num? get rank; num? get percentile;
/// Create a copy of MyProgressSummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyProgressSummaryDtoCopyWith<MyProgressSummaryDto> get copyWith => _$MyProgressSummaryDtoCopyWithImpl<MyProgressSummaryDto>(this as MyProgressSummaryDto, _$identity);

  /// Serializes this MyProgressSummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyProgressSummaryDto&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.level, level) || other.level == level)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.percentile, percentile) || other.percentile == percentile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,muid,karma,level,profilePic,rank,percentile);

@override
String toString() {
  return 'MyProgressSummaryDto(fullName: $fullName, muid: $muid, karma: $karma, level: $level, profilePic: $profilePic, rank: $rank, percentile: $percentile)';
}


}

/// @nodoc
abstract mixin class $MyProgressSummaryDtoCopyWith<$Res>  {
  factory $MyProgressSummaryDtoCopyWith(MyProgressSummaryDto value, $Res Function(MyProgressSummaryDto) _then) = _$MyProgressSummaryDtoCopyWithImpl;
@useResult
$Res call({
 String fullName, String muid, num? karma, String? level, String? profilePic, num? rank, num? percentile
});




}
/// @nodoc
class _$MyProgressSummaryDtoCopyWithImpl<$Res>
    implements $MyProgressSummaryDtoCopyWith<$Res> {
  _$MyProgressSummaryDtoCopyWithImpl(this._self, this._then);

  final MyProgressSummaryDto _self;
  final $Res Function(MyProgressSummaryDto) _then;

/// Create a copy of MyProgressSummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? muid = null,Object? karma = freezed,Object? level = freezed,Object? profilePic = freezed,Object? rank = freezed,Object? percentile = freezed,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,karma: freezed == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num?,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String?,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as num?,percentile: freezed == percentile ? _self.percentile : percentile // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

}


/// Adds pattern-matching-related methods to [MyProgressSummaryDto].
extension MyProgressSummaryDtoPatterns on MyProgressSummaryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyProgressSummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyProgressSummaryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyProgressSummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _MyProgressSummaryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyProgressSummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _MyProgressSummaryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fullName,  String muid,  num? karma,  String? level,  String? profilePic,  num? rank,  num? percentile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyProgressSummaryDto() when $default != null:
return $default(_that.fullName,_that.muid,_that.karma,_that.level,_that.profilePic,_that.rank,_that.percentile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fullName,  String muid,  num? karma,  String? level,  String? profilePic,  num? rank,  num? percentile)  $default,) {final _that = this;
switch (_that) {
case _MyProgressSummaryDto():
return $default(_that.fullName,_that.muid,_that.karma,_that.level,_that.profilePic,_that.rank,_that.percentile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fullName,  String muid,  num? karma,  String? level,  String? profilePic,  num? rank,  num? percentile)?  $default,) {final _that = this;
switch (_that) {
case _MyProgressSummaryDto() when $default != null:
return $default(_that.fullName,_that.muid,_that.karma,_that.level,_that.profilePic,_that.rank,_that.percentile);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MyProgressSummaryDto extends MyProgressSummaryDto {
  const _MyProgressSummaryDto({required this.fullName, required this.muid, this.karma, this.level, this.profilePic, this.rank, this.percentile}): super._();
  factory _MyProgressSummaryDto.fromJson(Map<String, dynamic> json) => _$MyProgressSummaryDtoFromJson(json);

@override final  String fullName;
@override final  String muid;
@override final  num? karma;
@override final  String? level;
@override final  String? profilePic;
@override final  num? rank;
@override final  num? percentile;

/// Create a copy of MyProgressSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyProgressSummaryDtoCopyWith<_MyProgressSummaryDto> get copyWith => __$MyProgressSummaryDtoCopyWithImpl<_MyProgressSummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MyProgressSummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyProgressSummaryDto&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.level, level) || other.level == level)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.percentile, percentile) || other.percentile == percentile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,muid,karma,level,profilePic,rank,percentile);

@override
String toString() {
  return 'MyProgressSummaryDto(fullName: $fullName, muid: $muid, karma: $karma, level: $level, profilePic: $profilePic, rank: $rank, percentile: $percentile)';
}


}

/// @nodoc
abstract mixin class _$MyProgressSummaryDtoCopyWith<$Res> implements $MyProgressSummaryDtoCopyWith<$Res> {
  factory _$MyProgressSummaryDtoCopyWith(_MyProgressSummaryDto value, $Res Function(_MyProgressSummaryDto) _then) = __$MyProgressSummaryDtoCopyWithImpl;
@override @useResult
$Res call({
 String fullName, String muid, num? karma, String? level, String? profilePic, num? rank, num? percentile
});




}
/// @nodoc
class __$MyProgressSummaryDtoCopyWithImpl<$Res>
    implements _$MyProgressSummaryDtoCopyWith<$Res> {
  __$MyProgressSummaryDtoCopyWithImpl(this._self, this._then);

  final _MyProgressSummaryDto _self;
  final $Res Function(_MyProgressSummaryDto) _then;

/// Create a copy of MyProgressSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? muid = null,Object? karma = freezed,Object? level = freezed,Object? profilePic = freezed,Object? rank = freezed,Object? percentile = freezed,}) {
  return _then(_MyProgressSummaryDto(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,karma: freezed == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num?,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String?,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as num?,percentile: freezed == percentile ? _self.percentile : percentile // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}

// dart format on
