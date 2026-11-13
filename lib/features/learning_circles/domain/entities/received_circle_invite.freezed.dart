// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'received_circle_invite.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReceivedCircleInvite {

 String get linkId; String get circleId; String get circleTitle; String? get igName; bool get isLeadInvite; String? get invitedByName; String? get invitedByProfilePic; String? get createdAt;
/// Create a copy of ReceivedCircleInvite
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceivedCircleInviteCopyWith<ReceivedCircleInvite> get copyWith => _$ReceivedCircleInviteCopyWithImpl<ReceivedCircleInvite>(this as ReceivedCircleInvite, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceivedCircleInvite&&(identical(other.linkId, linkId) || other.linkId == linkId)&&(identical(other.circleId, circleId) || other.circleId == circleId)&&(identical(other.circleTitle, circleTitle) || other.circleTitle == circleTitle)&&(identical(other.igName, igName) || other.igName == igName)&&(identical(other.isLeadInvite, isLeadInvite) || other.isLeadInvite == isLeadInvite)&&(identical(other.invitedByName, invitedByName) || other.invitedByName == invitedByName)&&(identical(other.invitedByProfilePic, invitedByProfilePic) || other.invitedByProfilePic == invitedByProfilePic)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,linkId,circleId,circleTitle,igName,isLeadInvite,invitedByName,invitedByProfilePic,createdAt);

@override
String toString() {
  return 'ReceivedCircleInvite(linkId: $linkId, circleId: $circleId, circleTitle: $circleTitle, igName: $igName, isLeadInvite: $isLeadInvite, invitedByName: $invitedByName, invitedByProfilePic: $invitedByProfilePic, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ReceivedCircleInviteCopyWith<$Res>  {
  factory $ReceivedCircleInviteCopyWith(ReceivedCircleInvite value, $Res Function(ReceivedCircleInvite) _then) = _$ReceivedCircleInviteCopyWithImpl;
@useResult
$Res call({
 String linkId, String circleId, String circleTitle, String? igName, bool isLeadInvite, String? invitedByName, String? invitedByProfilePic, String? createdAt
});




}
/// @nodoc
class _$ReceivedCircleInviteCopyWithImpl<$Res>
    implements $ReceivedCircleInviteCopyWith<$Res> {
  _$ReceivedCircleInviteCopyWithImpl(this._self, this._then);

  final ReceivedCircleInvite _self;
  final $Res Function(ReceivedCircleInvite) _then;

/// Create a copy of ReceivedCircleInvite
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? linkId = null,Object? circleId = null,Object? circleTitle = null,Object? igName = freezed,Object? isLeadInvite = null,Object? invitedByName = freezed,Object? invitedByProfilePic = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
linkId: null == linkId ? _self.linkId : linkId // ignore: cast_nullable_to_non_nullable
as String,circleId: null == circleId ? _self.circleId : circleId // ignore: cast_nullable_to_non_nullable
as String,circleTitle: null == circleTitle ? _self.circleTitle : circleTitle // ignore: cast_nullable_to_non_nullable
as String,igName: freezed == igName ? _self.igName : igName // ignore: cast_nullable_to_non_nullable
as String?,isLeadInvite: null == isLeadInvite ? _self.isLeadInvite : isLeadInvite // ignore: cast_nullable_to_non_nullable
as bool,invitedByName: freezed == invitedByName ? _self.invitedByName : invitedByName // ignore: cast_nullable_to_non_nullable
as String?,invitedByProfilePic: freezed == invitedByProfilePic ? _self.invitedByProfilePic : invitedByProfilePic // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReceivedCircleInvite].
extension ReceivedCircleInvitePatterns on ReceivedCircleInvite {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReceivedCircleInvite value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReceivedCircleInvite() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReceivedCircleInvite value)  $default,){
final _that = this;
switch (_that) {
case _ReceivedCircleInvite():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReceivedCircleInvite value)?  $default,){
final _that = this;
switch (_that) {
case _ReceivedCircleInvite() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String linkId,  String circleId,  String circleTitle,  String? igName,  bool isLeadInvite,  String? invitedByName,  String? invitedByProfilePic,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReceivedCircleInvite() when $default != null:
return $default(_that.linkId,_that.circleId,_that.circleTitle,_that.igName,_that.isLeadInvite,_that.invitedByName,_that.invitedByProfilePic,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String linkId,  String circleId,  String circleTitle,  String? igName,  bool isLeadInvite,  String? invitedByName,  String? invitedByProfilePic,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _ReceivedCircleInvite():
return $default(_that.linkId,_that.circleId,_that.circleTitle,_that.igName,_that.isLeadInvite,_that.invitedByName,_that.invitedByProfilePic,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String linkId,  String circleId,  String circleTitle,  String? igName,  bool isLeadInvite,  String? invitedByName,  String? invitedByProfilePic,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ReceivedCircleInvite() when $default != null:
return $default(_that.linkId,_that.circleId,_that.circleTitle,_that.igName,_that.isLeadInvite,_that.invitedByName,_that.invitedByProfilePic,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _ReceivedCircleInvite implements ReceivedCircleInvite {
  const _ReceivedCircleInvite({required this.linkId, required this.circleId, required this.circleTitle, this.igName, this.isLeadInvite = false, this.invitedByName, this.invitedByProfilePic, this.createdAt});
  

@override final  String linkId;
@override final  String circleId;
@override final  String circleTitle;
@override final  String? igName;
@override@JsonKey() final  bool isLeadInvite;
@override final  String? invitedByName;
@override final  String? invitedByProfilePic;
@override final  String? createdAt;

/// Create a copy of ReceivedCircleInvite
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReceivedCircleInviteCopyWith<_ReceivedCircleInvite> get copyWith => __$ReceivedCircleInviteCopyWithImpl<_ReceivedCircleInvite>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReceivedCircleInvite&&(identical(other.linkId, linkId) || other.linkId == linkId)&&(identical(other.circleId, circleId) || other.circleId == circleId)&&(identical(other.circleTitle, circleTitle) || other.circleTitle == circleTitle)&&(identical(other.igName, igName) || other.igName == igName)&&(identical(other.isLeadInvite, isLeadInvite) || other.isLeadInvite == isLeadInvite)&&(identical(other.invitedByName, invitedByName) || other.invitedByName == invitedByName)&&(identical(other.invitedByProfilePic, invitedByProfilePic) || other.invitedByProfilePic == invitedByProfilePic)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,linkId,circleId,circleTitle,igName,isLeadInvite,invitedByName,invitedByProfilePic,createdAt);

@override
String toString() {
  return 'ReceivedCircleInvite(linkId: $linkId, circleId: $circleId, circleTitle: $circleTitle, igName: $igName, isLeadInvite: $isLeadInvite, invitedByName: $invitedByName, invitedByProfilePic: $invitedByProfilePic, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ReceivedCircleInviteCopyWith<$Res> implements $ReceivedCircleInviteCopyWith<$Res> {
  factory _$ReceivedCircleInviteCopyWith(_ReceivedCircleInvite value, $Res Function(_ReceivedCircleInvite) _then) = __$ReceivedCircleInviteCopyWithImpl;
@override @useResult
$Res call({
 String linkId, String circleId, String circleTitle, String? igName, bool isLeadInvite, String? invitedByName, String? invitedByProfilePic, String? createdAt
});




}
/// @nodoc
class __$ReceivedCircleInviteCopyWithImpl<$Res>
    implements _$ReceivedCircleInviteCopyWith<$Res> {
  __$ReceivedCircleInviteCopyWithImpl(this._self, this._then);

  final _ReceivedCircleInvite _self;
  final $Res Function(_ReceivedCircleInvite) _then;

/// Create a copy of ReceivedCircleInvite
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? linkId = null,Object? circleId = null,Object? circleTitle = null,Object? igName = freezed,Object? isLeadInvite = null,Object? invitedByName = freezed,Object? invitedByProfilePic = freezed,Object? createdAt = freezed,}) {
  return _then(_ReceivedCircleInvite(
linkId: null == linkId ? _self.linkId : linkId // ignore: cast_nullable_to_non_nullable
as String,circleId: null == circleId ? _self.circleId : circleId // ignore: cast_nullable_to_non_nullable
as String,circleTitle: null == circleTitle ? _self.circleTitle : circleTitle // ignore: cast_nullable_to_non_nullable
as String,igName: freezed == igName ? _self.igName : igName // ignore: cast_nullable_to_non_nullable
as String?,isLeadInvite: null == isLeadInvite ? _self.isLeadInvite : isLeadInvite // ignore: cast_nullable_to_non_nullable
as bool,invitedByName: freezed == invitedByName ? _self.invitedByName : invitedByName // ignore: cast_nullable_to_non_nullable
as String?,invitedByProfilePic: freezed == invitedByProfilePic ? _self.invitedByProfilePic : invitedByProfilePic // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
