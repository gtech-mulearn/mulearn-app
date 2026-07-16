// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'circle_member_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CircleMemberDto {

 String get id; String get muid; String? get fullName; String? get profilePic; int? get igKarma; bool get isLeader;
/// Create a copy of CircleMemberDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CircleMemberDtoCopyWith<CircleMemberDto> get copyWith => _$CircleMemberDtoCopyWithImpl<CircleMemberDto>(this as CircleMemberDto, _$identity);

  /// Serializes this CircleMemberDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CircleMemberDto&&(identical(other.id, id) || other.id == id)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic)&&(identical(other.igKarma, igKarma) || other.igKarma == igKarma)&&(identical(other.isLeader, isLeader) || other.isLeader == isLeader));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,muid,fullName,profilePic,igKarma,isLeader);

@override
String toString() {
  return 'CircleMemberDto(id: $id, muid: $muid, fullName: $fullName, profilePic: $profilePic, igKarma: $igKarma, isLeader: $isLeader)';
}


}

/// @nodoc
abstract mixin class $CircleMemberDtoCopyWith<$Res>  {
  factory $CircleMemberDtoCopyWith(CircleMemberDto value, $Res Function(CircleMemberDto) _then) = _$CircleMemberDtoCopyWithImpl;
@useResult
$Res call({
 String id, String muid, String? fullName, String? profilePic, int? igKarma, bool isLeader
});




}
/// @nodoc
class _$CircleMemberDtoCopyWithImpl<$Res>
    implements $CircleMemberDtoCopyWith<$Res> {
  _$CircleMemberDtoCopyWithImpl(this._self, this._then);

  final CircleMemberDto _self;
  final $Res Function(CircleMemberDto) _then;

/// Create a copy of CircleMemberDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? muid = null,Object? fullName = freezed,Object? profilePic = freezed,Object? igKarma = freezed,Object? isLeader = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,igKarma: freezed == igKarma ? _self.igKarma : igKarma // ignore: cast_nullable_to_non_nullable
as int?,isLeader: null == isLeader ? _self.isLeader : isLeader // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CircleMemberDto].
extension CircleMemberDtoPatterns on CircleMemberDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CircleMemberDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CircleMemberDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CircleMemberDto value)  $default,){
final _that = this;
switch (_that) {
case _CircleMemberDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CircleMemberDto value)?  $default,){
final _that = this;
switch (_that) {
case _CircleMemberDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String muid,  String? fullName,  String? profilePic,  int? igKarma,  bool isLeader)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CircleMemberDto() when $default != null:
return $default(_that.id,_that.muid,_that.fullName,_that.profilePic,_that.igKarma,_that.isLeader);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String muid,  String? fullName,  String? profilePic,  int? igKarma,  bool isLeader)  $default,) {final _that = this;
switch (_that) {
case _CircleMemberDto():
return $default(_that.id,_that.muid,_that.fullName,_that.profilePic,_that.igKarma,_that.isLeader);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String muid,  String? fullName,  String? profilePic,  int? igKarma,  bool isLeader)?  $default,) {final _that = this;
switch (_that) {
case _CircleMemberDto() when $default != null:
return $default(_that.id,_that.muid,_that.fullName,_that.profilePic,_that.igKarma,_that.isLeader);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CircleMemberDto extends CircleMemberDto {
  const _CircleMemberDto({required this.id, required this.muid, this.fullName, this.profilePic, this.igKarma, this.isLeader = false}): super._();
  factory _CircleMemberDto.fromJson(Map<String, dynamic> json) => _$CircleMemberDtoFromJson(json);

@override final  String id;
@override final  String muid;
@override final  String? fullName;
@override final  String? profilePic;
@override final  int? igKarma;
@override@JsonKey() final  bool isLeader;

/// Create a copy of CircleMemberDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CircleMemberDtoCopyWith<_CircleMemberDto> get copyWith => __$CircleMemberDtoCopyWithImpl<_CircleMemberDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CircleMemberDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CircleMemberDto&&(identical(other.id, id) || other.id == id)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic)&&(identical(other.igKarma, igKarma) || other.igKarma == igKarma)&&(identical(other.isLeader, isLeader) || other.isLeader == isLeader));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,muid,fullName,profilePic,igKarma,isLeader);

@override
String toString() {
  return 'CircleMemberDto(id: $id, muid: $muid, fullName: $fullName, profilePic: $profilePic, igKarma: $igKarma, isLeader: $isLeader)';
}


}

/// @nodoc
abstract mixin class _$CircleMemberDtoCopyWith<$Res> implements $CircleMemberDtoCopyWith<$Res> {
  factory _$CircleMemberDtoCopyWith(_CircleMemberDto value, $Res Function(_CircleMemberDto) _then) = __$CircleMemberDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String muid, String? fullName, String? profilePic, int? igKarma, bool isLeader
});




}
/// @nodoc
class __$CircleMemberDtoCopyWithImpl<$Res>
    implements _$CircleMemberDtoCopyWith<$Res> {
  __$CircleMemberDtoCopyWithImpl(this._self, this._then);

  final _CircleMemberDto _self;
  final $Res Function(_CircleMemberDto) _then;

/// Create a copy of CircleMemberDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? muid = null,Object? fullName = freezed,Object? profilePic = freezed,Object? igKarma = freezed,Object? isLeader = null,}) {
  return _then(_CircleMemberDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,igKarma: freezed == igKarma ? _self.igKarma : igKarma // ignore: cast_nullable_to_non_nullable
as int?,isLeader: null == isLeader ? _self.isLeader : isLeader // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
