// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_catalog_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskCatalogItem {

 String get id; String get title; num get karma; bool get completed; TaskCategory get category; String? get description; String? get hashtag; String? get channel; String? get discordId;/// Work-type tag, e.g. "General Enablement", "Volunteering", "IGLU",
/// "Contribution", "Participation", "Event".
 String? get type;/// Raw level gate as the backend sends it, e.g. `"lvl1"` — kept
/// unparsed since nothing currently needs it as an int.
 String? get level; String? get interestGroupName;
/// Create a copy of TaskCatalogItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskCatalogItemCopyWith<TaskCatalogItem> get copyWith => _$TaskCatalogItemCopyWithImpl<TaskCatalogItem>(this as TaskCatalogItem, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TaskCatalogItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskCatalogItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.karma, _this.karma) || other.karma == _this.karma)&&(identical(other.completed, _this.completed) || other.completed == _this.completed)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.hashtag, _this.hashtag) || other.hashtag == _this.hashtag)&&(identical(other.channel, _this.channel) || other.channel == _this.channel)&&(identical(other.discordId, _this.discordId) || other.discordId == _this.discordId)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.level, _this.level) || other.level == _this.level)&&(identical(other.interestGroupName, _this.interestGroupName) || other.interestGroupName == _this.interestGroupName));
}


@override
int get hashCode {
  final _this = this as TaskCatalogItem;
  return Object.hash(runtimeType,_this.id,_this.title,_this.karma,_this.completed,_this.category,_this.description,_this.hashtag,_this.channel,_this.discordId,_this.type,_this.level,_this.interestGroupName);
}

@override
String toString() {
  final _this = this as TaskCatalogItem;
  return 'TaskCatalogItem(id: ${_this.id}, title: ${_this.title}, karma: ${_this.karma}, completed: ${_this.completed}, category: ${_this.category}, description: ${_this.description}, hashtag: ${_this.hashtag}, channel: ${_this.channel}, discordId: ${_this.discordId}, type: ${_this.type}, level: ${_this.level}, interestGroupName: ${_this.interestGroupName})';
}


}

/// @nodoc
abstract mixin class $TaskCatalogItemCopyWith<$Res>  {
  factory $TaskCatalogItemCopyWith(TaskCatalogItem value, $Res Function(TaskCatalogItem) _then) = _$TaskCatalogItemCopyWithImpl;
@useResult
$Res call({
 String id, String title, num karma, bool completed, TaskCategory category, String? description, String? hashtag, String? channel, String? discordId, String? type, String? level, String? interestGroupName
});




}
/// @nodoc
class _$TaskCatalogItemCopyWithImpl<$Res>
    implements $TaskCatalogItemCopyWith<$Res> {
  _$TaskCatalogItemCopyWithImpl(this._self, this._then);

  final TaskCatalogItem _self;
  final $Res Function(TaskCatalogItem) _then;

/// Create a copy of TaskCatalogItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? karma = null,Object? completed = null,Object? category = null,Object? description = freezed,Object? hashtag = freezed,Object? channel = freezed,Object? discordId = freezed,Object? type = freezed,Object? level = freezed,Object? interestGroupName = freezed,}) {
  return _then(TaskCatalogItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TaskCategory,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,hashtag: freezed == hashtag ? _self.hashtag : hashtag // ignore: cast_nullable_to_non_nullable
as String?,channel: freezed == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String?,discordId: freezed == discordId ? _self.discordId : discordId // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String?,interestGroupName: freezed == interestGroupName ? _self.interestGroupName : interestGroupName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskCatalogItem].
extension TaskCatalogItemPatterns on TaskCatalogItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskCatalogItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskCatalogItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskCatalogItem value)  $default,){
final _that = this;
switch (_that) {
case _TaskCatalogItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskCatalogItem value)?  $default,){
final _that = this;
switch (_that) {
case _TaskCatalogItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  num karma,  bool completed,  TaskCategory category,  String? description,  String? hashtag,  String? channel,  String? discordId,  String? type,  String? level,  String? interestGroupName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskCatalogItem() when $default != null:
return $default(_that.id,_that.title,_that.karma,_that.completed,_that.category,_that.description,_that.hashtag,_that.channel,_that.discordId,_that.type,_that.level,_that.interestGroupName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  num karma,  bool completed,  TaskCategory category,  String? description,  String? hashtag,  String? channel,  String? discordId,  String? type,  String? level,  String? interestGroupName)  $default,) {final _that = this;
switch (_that) {
case _TaskCatalogItem():
return $default(_that.id,_that.title,_that.karma,_that.completed,_that.category,_that.description,_that.hashtag,_that.channel,_that.discordId,_that.type,_that.level,_that.interestGroupName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  num karma,  bool completed,  TaskCategory category,  String? description,  String? hashtag,  String? channel,  String? discordId,  String? type,  String? level,  String? interestGroupName)?  $default,) {final _that = this;
switch (_that) {
case _TaskCatalogItem() when $default != null:
return $default(_that.id,_that.title,_that.karma,_that.completed,_that.category,_that.description,_that.hashtag,_that.channel,_that.discordId,_that.type,_that.level,_that.interestGroupName);case _:
  return null;

}
}

}

/// @nodoc


class _TaskCatalogItem implements TaskCatalogItem {
  const _TaskCatalogItem({required this.id, required this.title, required this.karma, required this.completed, required this.category, this.description, this.hashtag, this.channel, this.discordId, this.type, this.level, this.interestGroupName});
  

@override final  String id;
@override final  String title;
@override final  num karma;
@override final  bool completed;
@override final  TaskCategory category;
@override final  String? description;
@override final  String? hashtag;
@override final  String? channel;
@override final  String? discordId;
/// Work-type tag, e.g. "General Enablement", "Volunteering", "IGLU",
/// "Contribution", "Participation", "Event".
@override final  String? type;
/// Raw level gate as the backend sends it, e.g. `"lvl1"` — kept
/// unparsed since nothing currently needs it as an int.
@override final  String? level;
@override final  String? interestGroupName;

/// Create a copy of TaskCatalogItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskCatalogItemCopyWith<_TaskCatalogItem> get copyWith => __$TaskCatalogItemCopyWithImpl<_TaskCatalogItem>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskCatalogItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&(identical(other.hashtag, hashtag) || other.hashtag == hashtag)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.discordId, discordId) || other.discordId == discordId)&&(identical(other.type, type) || other.type == type)&&(identical(other.level, level) || other.level == level)&&(identical(other.interestGroupName, interestGroupName) || other.interestGroupName == interestGroupName));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,karma,completed,category,description,hashtag,channel,discordId,type,level,interestGroupName);
}

@override
String toString() {
    return 'TaskCatalogItem(id: $id, title: $title, karma: $karma, completed: $completed, category: $category, description: $description, hashtag: $hashtag, channel: $channel, discordId: $discordId, type: $type, level: $level, interestGroupName: $interestGroupName)';
}


}

/// @nodoc
abstract mixin class _$TaskCatalogItemCopyWith<$Res> implements $TaskCatalogItemCopyWith<$Res> {
  factory _$TaskCatalogItemCopyWith(_TaskCatalogItem value, $Res Function(_TaskCatalogItem) _then) = __$TaskCatalogItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, num karma, bool completed, TaskCategory category, String? description, String? hashtag, String? channel, String? discordId, String? type, String? level, String? interestGroupName
});




}
/// @nodoc
class __$TaskCatalogItemCopyWithImpl<$Res>
    implements _$TaskCatalogItemCopyWith<$Res> {
  __$TaskCatalogItemCopyWithImpl(this._self, this._then);

  final _TaskCatalogItem _self;
  final $Res Function(_TaskCatalogItem) _then;

/// Create a copy of TaskCatalogItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? karma = null,Object? completed = null,Object? category = null,Object? description = freezed,Object? hashtag = freezed,Object? channel = freezed,Object? discordId = freezed,Object? type = freezed,Object? level = freezed,Object? interestGroupName = freezed,}) {
  return _then(_TaskCatalogItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as num,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TaskCategory,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,hashtag: freezed == hashtag ? _self.hashtag : hashtag // ignore: cast_nullable_to_non_nullable
as String?,channel: freezed == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String?,discordId: freezed == discordId ? _self.discordId : discordId // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String?,interestGroupName: freezed == interestGroupName ? _self.interestGroupName : interestGroupName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
