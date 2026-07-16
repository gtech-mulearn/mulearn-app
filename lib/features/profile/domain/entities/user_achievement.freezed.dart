// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_achievement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserAchievement {

 String get id; String get userId; Achievement get achievement; bool get isIssued; String? get vcUrl;
/// Create a copy of UserAchievement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserAchievementCopyWith<UserAchievement> get copyWith => _$UserAchievementCopyWithImpl<UserAchievement>(this as UserAchievement, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAchievement&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.achievement, achievement) || other.achievement == achievement)&&(identical(other.isIssued, isIssued) || other.isIssued == isIssued)&&(identical(other.vcUrl, vcUrl) || other.vcUrl == vcUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,achievement,isIssued,vcUrl);

@override
String toString() {
  return 'UserAchievement(id: $id, userId: $userId, achievement: $achievement, isIssued: $isIssued, vcUrl: $vcUrl)';
}


}

/// @nodoc
abstract mixin class $UserAchievementCopyWith<$Res>  {
  factory $UserAchievementCopyWith(UserAchievement value, $Res Function(UserAchievement) _then) = _$UserAchievementCopyWithImpl;
@useResult
$Res call({
 String id, String userId, Achievement achievement, bool isIssued, String? vcUrl
});


$AchievementCopyWith<$Res> get achievement;

}
/// @nodoc
class _$UserAchievementCopyWithImpl<$Res>
    implements $UserAchievementCopyWith<$Res> {
  _$UserAchievementCopyWithImpl(this._self, this._then);

  final UserAchievement _self;
  final $Res Function(UserAchievement) _then;

/// Create a copy of UserAchievement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? achievement = null,Object? isIssued = null,Object? vcUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,achievement: null == achievement ? _self.achievement : achievement // ignore: cast_nullable_to_non_nullable
as Achievement,isIssued: null == isIssued ? _self.isIssued : isIssued // ignore: cast_nullable_to_non_nullable
as bool,vcUrl: freezed == vcUrl ? _self.vcUrl : vcUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of UserAchievement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AchievementCopyWith<$Res> get achievement {
  
  return $AchievementCopyWith<$Res>(_self.achievement, (value) {
    return _then(_self.copyWith(achievement: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserAchievement].
extension UserAchievementPatterns on UserAchievement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserAchievement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserAchievement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserAchievement value)  $default,){
final _that = this;
switch (_that) {
case _UserAchievement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserAchievement value)?  $default,){
final _that = this;
switch (_that) {
case _UserAchievement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  Achievement achievement,  bool isIssued,  String? vcUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserAchievement() when $default != null:
return $default(_that.id,_that.userId,_that.achievement,_that.isIssued,_that.vcUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  Achievement achievement,  bool isIssued,  String? vcUrl)  $default,) {final _that = this;
switch (_that) {
case _UserAchievement():
return $default(_that.id,_that.userId,_that.achievement,_that.isIssued,_that.vcUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  Achievement achievement,  bool isIssued,  String? vcUrl)?  $default,) {final _that = this;
switch (_that) {
case _UserAchievement() when $default != null:
return $default(_that.id,_that.userId,_that.achievement,_that.isIssued,_that.vcUrl);case _:
  return null;

}
}

}

/// @nodoc


class _UserAchievement implements UserAchievement {
  const _UserAchievement({required this.id, required this.userId, required this.achievement, required this.isIssued, this.vcUrl});
  

@override final  String id;
@override final  String userId;
@override final  Achievement achievement;
@override final  bool isIssued;
@override final  String? vcUrl;

/// Create a copy of UserAchievement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserAchievementCopyWith<_UserAchievement> get copyWith => __$UserAchievementCopyWithImpl<_UserAchievement>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserAchievement&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.achievement, achievement) || other.achievement == achievement)&&(identical(other.isIssued, isIssued) || other.isIssued == isIssued)&&(identical(other.vcUrl, vcUrl) || other.vcUrl == vcUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,achievement,isIssued,vcUrl);

@override
String toString() {
  return 'UserAchievement(id: $id, userId: $userId, achievement: $achievement, isIssued: $isIssued, vcUrl: $vcUrl)';
}


}

/// @nodoc
abstract mixin class _$UserAchievementCopyWith<$Res> implements $UserAchievementCopyWith<$Res> {
  factory _$UserAchievementCopyWith(_UserAchievement value, $Res Function(_UserAchievement) _then) = __$UserAchievementCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, Achievement achievement, bool isIssued, String? vcUrl
});


@override $AchievementCopyWith<$Res> get achievement;

}
/// @nodoc
class __$UserAchievementCopyWithImpl<$Res>
    implements _$UserAchievementCopyWith<$Res> {
  __$UserAchievementCopyWithImpl(this._self, this._then);

  final _UserAchievement _self;
  final $Res Function(_UserAchievement) _then;

/// Create a copy of UserAchievement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? achievement = null,Object? isIssued = null,Object? vcUrl = freezed,}) {
  return _then(_UserAchievement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,achievement: null == achievement ? _self.achievement : achievement // ignore: cast_nullable_to_non_nullable
as Achievement,isIssued: null == isIssued ? _self.isIssued : isIssued // ignore: cast_nullable_to_non_nullable
as bool,vcUrl: freezed == vcUrl ? _self.vcUrl : vcUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of UserAchievement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AchievementCopyWith<$Res> get achievement {
  
  return $AchievementCopyWith<$Res>(_self.achievement, (value) {
    return _then(_self.copyWith(achievement: value));
  });
}
}

// dart format on
