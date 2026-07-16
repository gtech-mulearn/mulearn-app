// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'achievement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Achievement {

 String get id; String get achievementName; String? get description; String? get icon; String? get levelId; List<String> get tags; String? get templateId;
/// Create a copy of Achievement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AchievementCopyWith<Achievement> get copyWith => _$AchievementCopyWithImpl<Achievement>(this as Achievement, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Achievement&&(identical(other.id, id) || other.id == id)&&(identical(other.achievementName, achievementName) || other.achievementName == achievementName)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.levelId, levelId) || other.levelId == levelId)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.templateId, templateId) || other.templateId == templateId));
}


@override
int get hashCode => Object.hash(runtimeType,id,achievementName,description,icon,levelId,const DeepCollectionEquality().hash(tags),templateId);

@override
String toString() {
  return 'Achievement(id: $id, achievementName: $achievementName, description: $description, icon: $icon, levelId: $levelId, tags: $tags, templateId: $templateId)';
}


}

/// @nodoc
abstract mixin class $AchievementCopyWith<$Res>  {
  factory $AchievementCopyWith(Achievement value, $Res Function(Achievement) _then) = _$AchievementCopyWithImpl;
@useResult
$Res call({
 String id, String achievementName, String? description, String? icon, String? levelId, List<String> tags, String? templateId
});




}
/// @nodoc
class _$AchievementCopyWithImpl<$Res>
    implements $AchievementCopyWith<$Res> {
  _$AchievementCopyWithImpl(this._self, this._then);

  final Achievement _self;
  final $Res Function(Achievement) _then;

/// Create a copy of Achievement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? achievementName = null,Object? description = freezed,Object? icon = freezed,Object? levelId = freezed,Object? tags = null,Object? templateId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,achievementName: null == achievementName ? _self.achievementName : achievementName // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,levelId: freezed == levelId ? _self.levelId : levelId // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,templateId: freezed == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Achievement].
extension AchievementPatterns on Achievement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Achievement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Achievement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Achievement value)  $default,){
final _that = this;
switch (_that) {
case _Achievement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Achievement value)?  $default,){
final _that = this;
switch (_that) {
case _Achievement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String achievementName,  String? description,  String? icon,  String? levelId,  List<String> tags,  String? templateId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Achievement() when $default != null:
return $default(_that.id,_that.achievementName,_that.description,_that.icon,_that.levelId,_that.tags,_that.templateId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String achievementName,  String? description,  String? icon,  String? levelId,  List<String> tags,  String? templateId)  $default,) {final _that = this;
switch (_that) {
case _Achievement():
return $default(_that.id,_that.achievementName,_that.description,_that.icon,_that.levelId,_that.tags,_that.templateId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String achievementName,  String? description,  String? icon,  String? levelId,  List<String> tags,  String? templateId)?  $default,) {final _that = this;
switch (_that) {
case _Achievement() when $default != null:
return $default(_that.id,_that.achievementName,_that.description,_that.icon,_that.levelId,_that.tags,_that.templateId);case _:
  return null;

}
}

}

/// @nodoc


class _Achievement implements Achievement {
  const _Achievement({required this.id, required this.achievementName, this.description, this.icon, this.levelId, final  List<String> tags = const [], this.templateId}): _tags = tags;
  

@override final  String id;
@override final  String achievementName;
@override final  String? description;
@override final  String? icon;
@override final  String? levelId;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  String? templateId;

/// Create a copy of Achievement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AchievementCopyWith<_Achievement> get copyWith => __$AchievementCopyWithImpl<_Achievement>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Achievement&&(identical(other.id, id) || other.id == id)&&(identical(other.achievementName, achievementName) || other.achievementName == achievementName)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.levelId, levelId) || other.levelId == levelId)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.templateId, templateId) || other.templateId == templateId));
}


@override
int get hashCode => Object.hash(runtimeType,id,achievementName,description,icon,levelId,const DeepCollectionEquality().hash(_tags),templateId);

@override
String toString() {
  return 'Achievement(id: $id, achievementName: $achievementName, description: $description, icon: $icon, levelId: $levelId, tags: $tags, templateId: $templateId)';
}


}

/// @nodoc
abstract mixin class _$AchievementCopyWith<$Res> implements $AchievementCopyWith<$Res> {
  factory _$AchievementCopyWith(_Achievement value, $Res Function(_Achievement) _then) = __$AchievementCopyWithImpl;
@override @useResult
$Res call({
 String id, String achievementName, String? description, String? icon, String? levelId, List<String> tags, String? templateId
});




}
/// @nodoc
class __$AchievementCopyWithImpl<$Res>
    implements _$AchievementCopyWith<$Res> {
  __$AchievementCopyWithImpl(this._self, this._then);

  final _Achievement _self;
  final $Res Function(_Achievement) _then;

/// Create a copy of Achievement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? achievementName = null,Object? description = freezed,Object? icon = freezed,Object? levelId = freezed,Object? tags = null,Object? templateId = freezed,}) {
  return _then(_Achievement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,achievementName: null == achievementName ? _self.achievementName : achievementName // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,levelId: freezed == levelId ? _self.levelId : levelId // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,templateId: freezed == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
