// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'received_circle_invite_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReceivedCircleInviteDto {

 String get linkId; String get circleId; String get circleTitle; String? get ig; bool get isLeadInvite; CircleInviterDto? get invitedBy; String? get createdAt;
/// Create a copy of ReceivedCircleInviteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceivedCircleInviteDtoCopyWith<ReceivedCircleInviteDto> get copyWith => _$ReceivedCircleInviteDtoCopyWithImpl<ReceivedCircleInviteDto>(this as ReceivedCircleInviteDto, _$identity);

  /// Serializes this ReceivedCircleInviteDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceivedCircleInviteDto&&(identical(other.linkId, linkId) || other.linkId == linkId)&&(identical(other.circleId, circleId) || other.circleId == circleId)&&(identical(other.circleTitle, circleTitle) || other.circleTitle == circleTitle)&&(identical(other.ig, ig) || other.ig == ig)&&(identical(other.isLeadInvite, isLeadInvite) || other.isLeadInvite == isLeadInvite)&&(identical(other.invitedBy, invitedBy) || other.invitedBy == invitedBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,linkId,circleId,circleTitle,ig,isLeadInvite,invitedBy,createdAt);

@override
String toString() {
  return 'ReceivedCircleInviteDto(linkId: $linkId, circleId: $circleId, circleTitle: $circleTitle, ig: $ig, isLeadInvite: $isLeadInvite, invitedBy: $invitedBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ReceivedCircleInviteDtoCopyWith<$Res>  {
  factory $ReceivedCircleInviteDtoCopyWith(ReceivedCircleInviteDto value, $Res Function(ReceivedCircleInviteDto) _then) = _$ReceivedCircleInviteDtoCopyWithImpl;
@useResult
$Res call({
 String linkId, String circleId, String circleTitle, String? ig, bool isLeadInvite, CircleInviterDto? invitedBy, String? createdAt
});


$CircleInviterDtoCopyWith<$Res>? get invitedBy;

}
/// @nodoc
class _$ReceivedCircleInviteDtoCopyWithImpl<$Res>
    implements $ReceivedCircleInviteDtoCopyWith<$Res> {
  _$ReceivedCircleInviteDtoCopyWithImpl(this._self, this._then);

  final ReceivedCircleInviteDto _self;
  final $Res Function(ReceivedCircleInviteDto) _then;

/// Create a copy of ReceivedCircleInviteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? linkId = null,Object? circleId = null,Object? circleTitle = null,Object? ig = freezed,Object? isLeadInvite = null,Object? invitedBy = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
linkId: null == linkId ? _self.linkId : linkId // ignore: cast_nullable_to_non_nullable
as String,circleId: null == circleId ? _self.circleId : circleId // ignore: cast_nullable_to_non_nullable
as String,circleTitle: null == circleTitle ? _self.circleTitle : circleTitle // ignore: cast_nullable_to_non_nullable
as String,ig: freezed == ig ? _self.ig : ig // ignore: cast_nullable_to_non_nullable
as String?,isLeadInvite: null == isLeadInvite ? _self.isLeadInvite : isLeadInvite // ignore: cast_nullable_to_non_nullable
as bool,invitedBy: freezed == invitedBy ? _self.invitedBy : invitedBy // ignore: cast_nullable_to_non_nullable
as CircleInviterDto?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ReceivedCircleInviteDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CircleInviterDtoCopyWith<$Res>? get invitedBy {
    if (_self.invitedBy == null) {
    return null;
  }

  return $CircleInviterDtoCopyWith<$Res>(_self.invitedBy!, (value) {
    return _then(_self.copyWith(invitedBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReceivedCircleInviteDto].
extension ReceivedCircleInviteDtoPatterns on ReceivedCircleInviteDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReceivedCircleInviteDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReceivedCircleInviteDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReceivedCircleInviteDto value)  $default,){
final _that = this;
switch (_that) {
case _ReceivedCircleInviteDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReceivedCircleInviteDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReceivedCircleInviteDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String linkId,  String circleId,  String circleTitle,  String? ig,  bool isLeadInvite,  CircleInviterDto? invitedBy,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReceivedCircleInviteDto() when $default != null:
return $default(_that.linkId,_that.circleId,_that.circleTitle,_that.ig,_that.isLeadInvite,_that.invitedBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String linkId,  String circleId,  String circleTitle,  String? ig,  bool isLeadInvite,  CircleInviterDto? invitedBy,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _ReceivedCircleInviteDto():
return $default(_that.linkId,_that.circleId,_that.circleTitle,_that.ig,_that.isLeadInvite,_that.invitedBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String linkId,  String circleId,  String circleTitle,  String? ig,  bool isLeadInvite,  CircleInviterDto? invitedBy,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ReceivedCircleInviteDto() when $default != null:
return $default(_that.linkId,_that.circleId,_that.circleTitle,_that.ig,_that.isLeadInvite,_that.invitedBy,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReceivedCircleInviteDto extends ReceivedCircleInviteDto {
  const _ReceivedCircleInviteDto({required this.linkId, required this.circleId, required this.circleTitle, this.ig, this.isLeadInvite = false, this.invitedBy, this.createdAt}): super._();
  factory _ReceivedCircleInviteDto.fromJson(Map<String, dynamic> json) => _$ReceivedCircleInviteDtoFromJson(json);

@override final  String linkId;
@override final  String circleId;
@override final  String circleTitle;
@override final  String? ig;
@override@JsonKey() final  bool isLeadInvite;
@override final  CircleInviterDto? invitedBy;
@override final  String? createdAt;

/// Create a copy of ReceivedCircleInviteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReceivedCircleInviteDtoCopyWith<_ReceivedCircleInviteDto> get copyWith => __$ReceivedCircleInviteDtoCopyWithImpl<_ReceivedCircleInviteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReceivedCircleInviteDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReceivedCircleInviteDto&&(identical(other.linkId, linkId) || other.linkId == linkId)&&(identical(other.circleId, circleId) || other.circleId == circleId)&&(identical(other.circleTitle, circleTitle) || other.circleTitle == circleTitle)&&(identical(other.ig, ig) || other.ig == ig)&&(identical(other.isLeadInvite, isLeadInvite) || other.isLeadInvite == isLeadInvite)&&(identical(other.invitedBy, invitedBy) || other.invitedBy == invitedBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,linkId,circleId,circleTitle,ig,isLeadInvite,invitedBy,createdAt);

@override
String toString() {
  return 'ReceivedCircleInviteDto(linkId: $linkId, circleId: $circleId, circleTitle: $circleTitle, ig: $ig, isLeadInvite: $isLeadInvite, invitedBy: $invitedBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ReceivedCircleInviteDtoCopyWith<$Res> implements $ReceivedCircleInviteDtoCopyWith<$Res> {
  factory _$ReceivedCircleInviteDtoCopyWith(_ReceivedCircleInviteDto value, $Res Function(_ReceivedCircleInviteDto) _then) = __$ReceivedCircleInviteDtoCopyWithImpl;
@override @useResult
$Res call({
 String linkId, String circleId, String circleTitle, String? ig, bool isLeadInvite, CircleInviterDto? invitedBy, String? createdAt
});


@override $CircleInviterDtoCopyWith<$Res>? get invitedBy;

}
/// @nodoc
class __$ReceivedCircleInviteDtoCopyWithImpl<$Res>
    implements _$ReceivedCircleInviteDtoCopyWith<$Res> {
  __$ReceivedCircleInviteDtoCopyWithImpl(this._self, this._then);

  final _ReceivedCircleInviteDto _self;
  final $Res Function(_ReceivedCircleInviteDto) _then;

/// Create a copy of ReceivedCircleInviteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? linkId = null,Object? circleId = null,Object? circleTitle = null,Object? ig = freezed,Object? isLeadInvite = null,Object? invitedBy = freezed,Object? createdAt = freezed,}) {
  return _then(_ReceivedCircleInviteDto(
linkId: null == linkId ? _self.linkId : linkId // ignore: cast_nullable_to_non_nullable
as String,circleId: null == circleId ? _self.circleId : circleId // ignore: cast_nullable_to_non_nullable
as String,circleTitle: null == circleTitle ? _self.circleTitle : circleTitle // ignore: cast_nullable_to_non_nullable
as String,ig: freezed == ig ? _self.ig : ig // ignore: cast_nullable_to_non_nullable
as String?,isLeadInvite: null == isLeadInvite ? _self.isLeadInvite : isLeadInvite // ignore: cast_nullable_to_non_nullable
as bool,invitedBy: freezed == invitedBy ? _self.invitedBy : invitedBy // ignore: cast_nullable_to_non_nullable
as CircleInviterDto?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ReceivedCircleInviteDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CircleInviterDtoCopyWith<$Res>? get invitedBy {
    if (_self.invitedBy == null) {
    return null;
  }

  return $CircleInviterDtoCopyWith<$Res>(_self.invitedBy!, (value) {
    return _then(_self.copyWith(invitedBy: value));
  });
}
}


/// @nodoc
mixin _$CircleInviterDto {

 String? get userId; String? get fullName; String? get profilePic;
/// Create a copy of CircleInviterDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CircleInviterDtoCopyWith<CircleInviterDto> get copyWith => _$CircleInviterDtoCopyWithImpl<CircleInviterDto>(this as CircleInviterDto, _$identity);

  /// Serializes this CircleInviterDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CircleInviterDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,fullName,profilePic);

@override
String toString() {
  return 'CircleInviterDto(userId: $userId, fullName: $fullName, profilePic: $profilePic)';
}


}

/// @nodoc
abstract mixin class $CircleInviterDtoCopyWith<$Res>  {
  factory $CircleInviterDtoCopyWith(CircleInviterDto value, $Res Function(CircleInviterDto) _then) = _$CircleInviterDtoCopyWithImpl;
@useResult
$Res call({
 String? userId, String? fullName, String? profilePic
});




}
/// @nodoc
class _$CircleInviterDtoCopyWithImpl<$Res>
    implements $CircleInviterDtoCopyWith<$Res> {
  _$CircleInviterDtoCopyWithImpl(this._self, this._then);

  final CircleInviterDto _self;
  final $Res Function(CircleInviterDto) _then;

/// Create a copy of CircleInviterDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = freezed,Object? fullName = freezed,Object? profilePic = freezed,}) {
  return _then(_self.copyWith(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CircleInviterDto].
extension CircleInviterDtoPatterns on CircleInviterDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CircleInviterDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CircleInviterDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CircleInviterDto value)  $default,){
final _that = this;
switch (_that) {
case _CircleInviterDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CircleInviterDto value)?  $default,){
final _that = this;
switch (_that) {
case _CircleInviterDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? userId,  String? fullName,  String? profilePic)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CircleInviterDto() when $default != null:
return $default(_that.userId,_that.fullName,_that.profilePic);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? userId,  String? fullName,  String? profilePic)  $default,) {final _that = this;
switch (_that) {
case _CircleInviterDto():
return $default(_that.userId,_that.fullName,_that.profilePic);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? userId,  String? fullName,  String? profilePic)?  $default,) {final _that = this;
switch (_that) {
case _CircleInviterDto() when $default != null:
return $default(_that.userId,_that.fullName,_that.profilePic);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CircleInviterDto implements CircleInviterDto {
  const _CircleInviterDto({this.userId, this.fullName, this.profilePic});
  factory _CircleInviterDto.fromJson(Map<String, dynamic> json) => _$CircleInviterDtoFromJson(json);

@override final  String? userId;
@override final  String? fullName;
@override final  String? profilePic;

/// Create a copy of CircleInviterDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CircleInviterDtoCopyWith<_CircleInviterDto> get copyWith => __$CircleInviterDtoCopyWithImpl<_CircleInviterDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CircleInviterDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CircleInviterDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.profilePic, profilePic) || other.profilePic == profilePic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,fullName,profilePic);

@override
String toString() {
  return 'CircleInviterDto(userId: $userId, fullName: $fullName, profilePic: $profilePic)';
}


}

/// @nodoc
abstract mixin class _$CircleInviterDtoCopyWith<$Res> implements $CircleInviterDtoCopyWith<$Res> {
  factory _$CircleInviterDtoCopyWith(_CircleInviterDto value, $Res Function(_CircleInviterDto) _then) = __$CircleInviterDtoCopyWithImpl;
@override @useResult
$Res call({
 String? userId, String? fullName, String? profilePic
});




}
/// @nodoc
class __$CircleInviterDtoCopyWithImpl<$Res>
    implements _$CircleInviterDtoCopyWith<$Res> {
  __$CircleInviterDtoCopyWithImpl(this._self, this._then);

  final _CircleInviterDto _self;
  final $Res Function(_CircleInviterDto) _then;

/// Create a copy of CircleInviterDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = freezed,Object? fullName = freezed,Object? profilePic = freezed,}) {
  return _then(_CircleInviterDto(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,profilePic: freezed == profilePic ? _self.profilePic : profilePic // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
