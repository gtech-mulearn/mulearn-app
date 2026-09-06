// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_list_item_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskListItemDto {

 String get id; String get title; String? get hashtag; String? get description; num? get karma; String? get channel; String? get discordId; String? get type; String? get level; String? get ig; bool get completed;
/// Create a copy of TaskListItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskListItemDtoCopyWith<TaskListItemDto> get copyWith => _$TaskListItemDtoCopyWithImpl<TaskListItemDto>(this as TaskListItemDto, _$identity);

  /// Serializes this TaskListItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskListItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.hashtag, hashtag) || other.hashtag == hashtag)&&(identical(other.description, description) || other.description == description)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.discordId, discordId) || other.discordId == discordId)&&(identical(other.type, type) || other.type == type)&&(identical(other.level, level) || other.level == level)&&(identical(other.ig, ig) || other.ig == ig)&&(identical(other.completed, completed) || other.completed == completed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,hashtag,description,karma,channel,discordId,type,level,ig,completed);

@override
String toString() {
  return 'TaskListItemDto(id: $id, title: $title, hashtag: $hashtag, description: $description, karma: $karma, channel: $channel, discordId: $discordId, type: $type, level: $level, ig: $ig, completed: $completed)';
}


}

/// @nodoc
abstract mixin class $TaskListItemDtoCopyWith<$Res>  {
  factory $TaskListItemDtoCopyWith(TaskListItemDto value, $Res Function(TaskListItemDto) _then) = _$TaskListItemDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? hashtag, String? description, num? karma, String? channel, String? discordId, String? type, String? level, String? ig, bool completed
});




}
/// @nodoc
class _$TaskListItemDtoCopyWithImpl<$Res>
    implements $TaskListItemDtoCopyWith<$Res> {
  _$TaskListItemDtoCopyWithImpl(this._self, this._then);

  final TaskListItemDto _self;
  final $Res Function(TaskListItemDto) _then;

/// Create a copy of TaskListItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? hashtag = freezed,Object? description = freezed,Object? karma = freezed,Object? channel = freezed,Object? discordId = freezed,Object? type = freezed,Object? level = freezed,Object? ig = freezed,Object? completed = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,hashtag: freezed == hashtag ? _self.hashtag : hashtag // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,karma: freezed == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num?,channel: freezed == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String?,discordId: freezed == discordId ? _self.discordId : discordId // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String?,ig: freezed == ig ? _self.ig : ig // ignore: cast_nullable_to_non_nullable
as String?,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskListItemDto].
extension TaskListItemDtoPatterns on TaskListItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskListItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskListItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskListItemDto value)  $default,){
final _that = this;
switch (_that) {
case _TaskListItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskListItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _TaskListItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? hashtag,  String? description,  num? karma,  String? channel,  String? discordId,  String? type,  String? level,  String? ig,  bool completed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskListItemDto() when $default != null:
return $default(_that.id,_that.title,_that.hashtag,_that.description,_that.karma,_that.channel,_that.discordId,_that.type,_that.level,_that.ig,_that.completed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? hashtag,  String? description,  num? karma,  String? channel,  String? discordId,  String? type,  String? level,  String? ig,  bool completed)  $default,) {final _that = this;
switch (_that) {
case _TaskListItemDto():
return $default(_that.id,_that.title,_that.hashtag,_that.description,_that.karma,_that.channel,_that.discordId,_that.type,_that.level,_that.ig,_that.completed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? hashtag,  String? description,  num? karma,  String? channel,  String? discordId,  String? type,  String? level,  String? ig,  bool completed)?  $default,) {final _that = this;
switch (_that) {
case _TaskListItemDto() when $default != null:
return $default(_that.id,_that.title,_that.hashtag,_that.description,_that.karma,_that.channel,_that.discordId,_that.type,_that.level,_that.ig,_that.completed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskListItemDto extends TaskListItemDto {
  const _TaskListItemDto({required this.id, required this.title, this.hashtag, this.description, this.karma, this.channel, this.discordId, this.type, this.level, this.ig, this.completed = false}): super._();
  factory _TaskListItemDto.fromJson(Map<String, dynamic> json) => _$TaskListItemDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? hashtag;
@override final  String? description;
@override final  num? karma;
@override final  String? channel;
@override final  String? discordId;
@override final  String? type;
@override final  String? level;
@override final  String? ig;
@override@JsonKey() final  bool completed;

/// Create a copy of TaskListItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskListItemDtoCopyWith<_TaskListItemDto> get copyWith => __$TaskListItemDtoCopyWithImpl<_TaskListItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskListItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskListItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.hashtag, hashtag) || other.hashtag == hashtag)&&(identical(other.description, description) || other.description == description)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.discordId, discordId) || other.discordId == discordId)&&(identical(other.type, type) || other.type == type)&&(identical(other.level, level) || other.level == level)&&(identical(other.ig, ig) || other.ig == ig)&&(identical(other.completed, completed) || other.completed == completed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,hashtag,description,karma,channel,discordId,type,level,ig,completed);

@override
String toString() {
  return 'TaskListItemDto(id: $id, title: $title, hashtag: $hashtag, description: $description, karma: $karma, channel: $channel, discordId: $discordId, type: $type, level: $level, ig: $ig, completed: $completed)';
}


}

/// @nodoc
abstract mixin class _$TaskListItemDtoCopyWith<$Res> implements $TaskListItemDtoCopyWith<$Res> {
  factory _$TaskListItemDtoCopyWith(_TaskListItemDto value, $Res Function(_TaskListItemDto) _then) = __$TaskListItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? hashtag, String? description, num? karma, String? channel, String? discordId, String? type, String? level, String? ig, bool completed
});




}
/// @nodoc
class __$TaskListItemDtoCopyWithImpl<$Res>
    implements _$TaskListItemDtoCopyWith<$Res> {
  __$TaskListItemDtoCopyWithImpl(this._self, this._then);

  final _TaskListItemDto _self;
  final $Res Function(_TaskListItemDto) _then;

/// Create a copy of TaskListItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? hashtag = freezed,Object? description = freezed,Object? karma = freezed,Object? channel = freezed,Object? discordId = freezed,Object? type = freezed,Object? level = freezed,Object? ig = freezed,Object? completed = null,}) {
  return _then(_TaskListItemDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,hashtag: freezed == hashtag ? _self.hashtag : hashtag // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,karma: freezed == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num?,channel: freezed == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String?,discordId: freezed == discordId ? _self.discordId : discordId // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String?,ig: freezed == ig ? _self.ig : ig // ignore: cast_nullable_to_non_nullable
as String?,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
