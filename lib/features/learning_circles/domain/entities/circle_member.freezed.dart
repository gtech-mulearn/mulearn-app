// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'circle_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CircleMember {

 String get id; String get fullName; String get muid; String? get profilePicUrl; int? get igKarma; bool get isLeader;
/// Create a copy of CircleMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CircleMemberCopyWith<CircleMember> get copyWith => _$CircleMemberCopyWithImpl<CircleMember>(this as CircleMember, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CircleMember&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.profilePicUrl, profilePicUrl) || other.profilePicUrl == profilePicUrl)&&(identical(other.igKarma, igKarma) || other.igKarma == igKarma)&&(identical(other.isLeader, isLeader) || other.isLeader == isLeader));
}


@override
int get hashCode => Object.hash(runtimeType,id,fullName,muid,profilePicUrl,igKarma,isLeader);

@override
String toString() {
  return 'CircleMember(id: $id, fullName: $fullName, muid: $muid, profilePicUrl: $profilePicUrl, igKarma: $igKarma, isLeader: $isLeader)';
}


}

/// @nodoc
abstract mixin class $CircleMemberCopyWith<$Res>  {
  factory $CircleMemberCopyWith(CircleMember value, $Res Function(CircleMember) _then) = _$CircleMemberCopyWithImpl;
@useResult
$Res call({
 String id, String fullName, String muid, String? profilePicUrl, int? igKarma, bool isLeader
});




}
/// @nodoc
class _$CircleMemberCopyWithImpl<$Res>
    implements $CircleMemberCopyWith<$Res> {
  _$CircleMemberCopyWithImpl(this._self, this._then);

  final CircleMember _self;
  final $Res Function(CircleMember) _then;

/// Create a copy of CircleMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? muid = null,Object? profilePicUrl = freezed,Object? igKarma = freezed,Object? isLeader = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,profilePicUrl: freezed == profilePicUrl ? _self.profilePicUrl : profilePicUrl // ignore: cast_nullable_to_non_nullable
as String?,igKarma: freezed == igKarma ? _self.igKarma : igKarma // ignore: cast_nullable_to_non_nullable
as int?,isLeader: null == isLeader ? _self.isLeader : isLeader // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CircleMember].
extension CircleMemberPatterns on CircleMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CircleMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CircleMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CircleMember value)  $default,){
final _that = this;
switch (_that) {
case _CircleMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CircleMember value)?  $default,){
final _that = this;
switch (_that) {
case _CircleMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fullName,  String muid,  String? profilePicUrl,  int? igKarma,  bool isLeader)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CircleMember() when $default != null:
return $default(_that.id,_that.fullName,_that.muid,_that.profilePicUrl,_that.igKarma,_that.isLeader);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fullName,  String muid,  String? profilePicUrl,  int? igKarma,  bool isLeader)  $default,) {final _that = this;
switch (_that) {
case _CircleMember():
return $default(_that.id,_that.fullName,_that.muid,_that.profilePicUrl,_that.igKarma,_that.isLeader);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fullName,  String muid,  String? profilePicUrl,  int? igKarma,  bool isLeader)?  $default,) {final _that = this;
switch (_that) {
case _CircleMember() when $default != null:
return $default(_that.id,_that.fullName,_that.muid,_that.profilePicUrl,_that.igKarma,_that.isLeader);case _:
  return null;

}
}

}

/// @nodoc


class _CircleMember implements CircleMember {
  const _CircleMember({required this.id, required this.fullName, required this.muid, this.profilePicUrl, this.igKarma, this.isLeader = false});
  

@override final  String id;
@override final  String fullName;
@override final  String muid;
@override final  String? profilePicUrl;
@override final  int? igKarma;
@override@JsonKey() final  bool isLeader;

/// Create a copy of CircleMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CircleMemberCopyWith<_CircleMember> get copyWith => __$CircleMemberCopyWithImpl<_CircleMember>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CircleMember&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muid, muid) || other.muid == muid)&&(identical(other.profilePicUrl, profilePicUrl) || other.profilePicUrl == profilePicUrl)&&(identical(other.igKarma, igKarma) || other.igKarma == igKarma)&&(identical(other.isLeader, isLeader) || other.isLeader == isLeader));
}


@override
int get hashCode => Object.hash(runtimeType,id,fullName,muid,profilePicUrl,igKarma,isLeader);

@override
String toString() {
  return 'CircleMember(id: $id, fullName: $fullName, muid: $muid, profilePicUrl: $profilePicUrl, igKarma: $igKarma, isLeader: $isLeader)';
}


}

/// @nodoc
abstract mixin class _$CircleMemberCopyWith<$Res> implements $CircleMemberCopyWith<$Res> {
  factory _$CircleMemberCopyWith(_CircleMember value, $Res Function(_CircleMember) _then) = __$CircleMemberCopyWithImpl;
@override @useResult
$Res call({
 String id, String fullName, String muid, String? profilePicUrl, int? igKarma, bool isLeader
});




}
/// @nodoc
class __$CircleMemberCopyWithImpl<$Res>
    implements _$CircleMemberCopyWith<$Res> {
  __$CircleMemberCopyWithImpl(this._self, this._then);

  final _CircleMember _self;
  final $Res Function(_CircleMember) _then;

/// Create a copy of CircleMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? muid = null,Object? profilePicUrl = freezed,Object? igKarma = freezed,Object? isLeader = null,}) {
  return _then(_CircleMember(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muid: null == muid ? _self.muid : muid // ignore: cast_nullable_to_non_nullable
as String,profilePicUrl: freezed == profilePicUrl ? _self.profilePicUrl : profilePicUrl // ignore: cast_nullable_to_non_nullable
as String?,igKarma: freezed == igKarma ? _self.igKarma : igKarma // ignore: cast_nullable_to_non_nullable
as int?,isLeader: null == isLeader ? _self.isLeader : isLeader // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
