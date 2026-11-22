// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'featured_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeaturedEvent {

 String get id; String get title; String get slug; String get status; String get eventScope; String get startDatetime; String get endDatetime; EventVenue get venue; EventOrganizer get organizer; bool get isCollaboration; int get interestCount; List<String> get tags; String? get coverImage; int? get minKarma;
/// Create a copy of FeaturedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeaturedEventCopyWith<FeaturedEvent> get copyWith => _$FeaturedEventCopyWithImpl<FeaturedEvent>(this as FeaturedEvent, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FeaturedEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeaturedEvent&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.eventScope, _this.eventScope) || other.eventScope == _this.eventScope)&&(identical(other.startDatetime, _this.startDatetime) || other.startDatetime == _this.startDatetime)&&(identical(other.endDatetime, _this.endDatetime) || other.endDatetime == _this.endDatetime)&&(identical(other.venue, _this.venue) || other.venue == _this.venue)&&(identical(other.organizer, _this.organizer) || other.organizer == _this.organizer)&&(identical(other.isCollaboration, _this.isCollaboration) || other.isCollaboration == _this.isCollaboration)&&(identical(other.interestCount, _this.interestCount) || other.interestCount == _this.interestCount)&&const DeepCollectionEquality().equals(other.tags, _this.tags)&&(identical(other.coverImage, _this.coverImage) || other.coverImage == _this.coverImage)&&(identical(other.minKarma, _this.minKarma) || other.minKarma == _this.minKarma));
}


@override
int get hashCode {
  final _this = this as FeaturedEvent;
  return Object.hash(runtimeType,_this.id,_this.title,_this.slug,_this.status,_this.eventScope,_this.startDatetime,_this.endDatetime,_this.venue,_this.organizer,_this.isCollaboration,_this.interestCount,const DeepCollectionEquality().hash(_this.tags),_this.coverImage,_this.minKarma);
}

@override
String toString() {
  final _this = this as FeaturedEvent;
  return 'FeaturedEvent(id: ${_this.id}, title: ${_this.title}, slug: ${_this.slug}, status: ${_this.status}, eventScope: ${_this.eventScope}, startDatetime: ${_this.startDatetime}, endDatetime: ${_this.endDatetime}, venue: ${_this.venue}, organizer: ${_this.organizer}, isCollaboration: ${_this.isCollaboration}, interestCount: ${_this.interestCount}, tags: ${_this.tags}, coverImage: ${_this.coverImage}, minKarma: ${_this.minKarma})';
}


}

/// @nodoc
abstract mixin class $FeaturedEventCopyWith<$Res>  {
  factory $FeaturedEventCopyWith(FeaturedEvent value, $Res Function(FeaturedEvent) _then) = _$FeaturedEventCopyWithImpl;
@useResult
$Res call({
 String id, String title, String slug, String status, String eventScope, String startDatetime, String endDatetime, EventVenue venue, EventOrganizer organizer, bool isCollaboration, int interestCount, List<String> tags, String? coverImage, int? minKarma
});


$EventVenueCopyWith<$Res> get venue;$EventOrganizerCopyWith<$Res> get organizer;

}
/// @nodoc
class _$FeaturedEventCopyWithImpl<$Res>
    implements $FeaturedEventCopyWith<$Res> {
  _$FeaturedEventCopyWithImpl(this._self, this._then);

  final FeaturedEvent _self;
  final $Res Function(FeaturedEvent) _then;

/// Create a copy of FeaturedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? slug = null,Object? status = null,Object? eventScope = null,Object? startDatetime = null,Object? endDatetime = null,Object? venue = null,Object? organizer = null,Object? isCollaboration = null,Object? interestCount = null,Object? tags = null,Object? coverImage = freezed,Object? minKarma = freezed,}) {
  return _then(FeaturedEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,eventScope: null == eventScope ? _self.eventScope : eventScope // ignore: cast_nullable_to_non_nullable
as String,startDatetime: null == startDatetime ? _self.startDatetime : startDatetime // ignore: cast_nullable_to_non_nullable
as String,endDatetime: null == endDatetime ? _self.endDatetime : endDatetime // ignore: cast_nullable_to_non_nullable
as String,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as EventVenue,organizer: null == organizer ? _self.organizer : organizer // ignore: cast_nullable_to_non_nullable
as EventOrganizer,isCollaboration: null == isCollaboration ? _self.isCollaboration : isCollaboration // ignore: cast_nullable_to_non_nullable
as bool,interestCount: null == interestCount ? _self.interestCount : interestCount // ignore: cast_nullable_to_non_nullable
as int,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,coverImage: freezed == coverImage ? _self.coverImage : coverImage // ignore: cast_nullable_to_non_nullable
as String?,minKarma: freezed == minKarma ? _self.minKarma : minKarma // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of FeaturedEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventVenueCopyWith<$Res> get venue {
  
  return $EventVenueCopyWith<$Res>(_self.venue, (value) {
    return _then(_self.copyWith(venue: value));
  });
}/// Create a copy of FeaturedEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventOrganizerCopyWith<$Res> get organizer {
  
  return $EventOrganizerCopyWith<$Res>(_self.organizer, (value) {
    return _then(_self.copyWith(organizer: value));
  });
}
}


/// Adds pattern-matching-related methods to [FeaturedEvent].
extension FeaturedEventPatterns on FeaturedEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeaturedEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeaturedEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeaturedEvent value)  $default,){
final _that = this;
switch (_that) {
case _FeaturedEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeaturedEvent value)?  $default,){
final _that = this;
switch (_that) {
case _FeaturedEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String slug,  String status,  String eventScope,  String startDatetime,  String endDatetime,  EventVenue venue,  EventOrganizer organizer,  bool isCollaboration,  int interestCount,  List<String> tags,  String? coverImage,  int? minKarma)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeaturedEvent() when $default != null:
return $default(_that.id,_that.title,_that.slug,_that.status,_that.eventScope,_that.startDatetime,_that.endDatetime,_that.venue,_that.organizer,_that.isCollaboration,_that.interestCount,_that.tags,_that.coverImage,_that.minKarma);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String slug,  String status,  String eventScope,  String startDatetime,  String endDatetime,  EventVenue venue,  EventOrganizer organizer,  bool isCollaboration,  int interestCount,  List<String> tags,  String? coverImage,  int? minKarma)  $default,) {final _that = this;
switch (_that) {
case _FeaturedEvent():
return $default(_that.id,_that.title,_that.slug,_that.status,_that.eventScope,_that.startDatetime,_that.endDatetime,_that.venue,_that.organizer,_that.isCollaboration,_that.interestCount,_that.tags,_that.coverImage,_that.minKarma);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String slug,  String status,  String eventScope,  String startDatetime,  String endDatetime,  EventVenue venue,  EventOrganizer organizer,  bool isCollaboration,  int interestCount,  List<String> tags,  String? coverImage,  int? minKarma)?  $default,) {final _that = this;
switch (_that) {
case _FeaturedEvent() when $default != null:
return $default(_that.id,_that.title,_that.slug,_that.status,_that.eventScope,_that.startDatetime,_that.endDatetime,_that.venue,_that.organizer,_that.isCollaboration,_that.interestCount,_that.tags,_that.coverImage,_that.minKarma);case _:
  return null;

}
}

}

/// @nodoc


class _FeaturedEvent implements FeaturedEvent {
  const _FeaturedEvent({required this.id, required this.title, required this.slug, required this.status, required this.eventScope, required this.startDatetime, required this.endDatetime, required this.venue, required this.organizer, required this.isCollaboration, required this.interestCount,  List<String> tags = const [], this.coverImage, this.minKarma}): _tags = tags;
  

@override final  String id;
@override final  String title;
@override final  String slug;
@override final  String status;
@override final  String eventScope;
@override final  String startDatetime;
@override final  String endDatetime;
@override final  EventVenue venue;
@override final  EventOrganizer organizer;
@override final  bool isCollaboration;
@override final  int interestCount;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  String? coverImage;
@override final  int? minKarma;

/// Create a copy of FeaturedEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeaturedEventCopyWith<_FeaturedEvent> get copyWith => __$FeaturedEventCopyWithImpl<_FeaturedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeaturedEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.status, status) || other.status == status)&&(identical(other.eventScope, eventScope) || other.eventScope == eventScope)&&(identical(other.startDatetime, startDatetime) || other.startDatetime == startDatetime)&&(identical(other.endDatetime, endDatetime) || other.endDatetime == endDatetime)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.organizer, organizer) || other.organizer == organizer)&&(identical(other.isCollaboration, isCollaboration) || other.isCollaboration == isCollaboration)&&(identical(other.interestCount, interestCount) || other.interestCount == interestCount)&&const DeepCollectionEquality().equals(other.tags, _tags)&&(identical(other.coverImage, coverImage) || other.coverImage == coverImage)&&(identical(other.minKarma, minKarma) || other.minKarma == minKarma));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,slug,status,eventScope,startDatetime,endDatetime,venue,organizer,isCollaboration,interestCount,const DeepCollectionEquality().hash(_tags),coverImage,minKarma);
}

@override
String toString() {
    return 'FeaturedEvent(id: $id, title: $title, slug: $slug, status: $status, eventScope: $eventScope, startDatetime: $startDatetime, endDatetime: $endDatetime, venue: $venue, organizer: $organizer, isCollaboration: $isCollaboration, interestCount: $interestCount, tags: $tags, coverImage: $coverImage, minKarma: $minKarma)';
}


}

/// @nodoc
abstract mixin class _$FeaturedEventCopyWith<$Res> implements $FeaturedEventCopyWith<$Res> {
  factory _$FeaturedEventCopyWith(_FeaturedEvent value, $Res Function(_FeaturedEvent) _then) = __$FeaturedEventCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String slug, String status, String eventScope, String startDatetime, String endDatetime, EventVenue venue, EventOrganizer organizer, bool isCollaboration, int interestCount, List<String> tags, String? coverImage, int? minKarma
});


@override $EventVenueCopyWith<$Res> get venue;@override $EventOrganizerCopyWith<$Res> get organizer;

}
/// @nodoc
class __$FeaturedEventCopyWithImpl<$Res>
    implements _$FeaturedEventCopyWith<$Res> {
  __$FeaturedEventCopyWithImpl(this._self, this._then);

  final _FeaturedEvent _self;
  final $Res Function(_FeaturedEvent) _then;

/// Create a copy of FeaturedEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? slug = null,Object? status = null,Object? eventScope = null,Object? startDatetime = null,Object? endDatetime = null,Object? venue = null,Object? organizer = null,Object? isCollaboration = null,Object? interestCount = null,Object? tags = null,Object? coverImage = freezed,Object? minKarma = freezed,}) {
  return _then(_FeaturedEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,eventScope: null == eventScope ? _self.eventScope : eventScope // ignore: cast_nullable_to_non_nullable
as String,startDatetime: null == startDatetime ? _self.startDatetime : startDatetime // ignore: cast_nullable_to_non_nullable
as String,endDatetime: null == endDatetime ? _self.endDatetime : endDatetime // ignore: cast_nullable_to_non_nullable
as String,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as EventVenue,organizer: null == organizer ? _self.organizer : organizer // ignore: cast_nullable_to_non_nullable
as EventOrganizer,isCollaboration: null == isCollaboration ? _self.isCollaboration : isCollaboration // ignore: cast_nullable_to_non_nullable
as bool,interestCount: null == interestCount ? _self.interestCount : interestCount // ignore: cast_nullable_to_non_nullable
as int,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,coverImage: freezed == coverImage ? _self.coverImage : coverImage // ignore: cast_nullable_to_non_nullable
as String?,minKarma: freezed == minKarma ? _self.minKarma : minKarma // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of FeaturedEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventVenueCopyWith<$Res> get venue {
  
  return $EventVenueCopyWith<$Res>(_self.venue, (value) {
    return _then(_self.copyWith(venue: value));
  });
}/// Create a copy of FeaturedEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventOrganizerCopyWith<$Res> get organizer {
  
  return $EventOrganizerCopyWith<$Res>(_self.organizer, (value) {
    return _then(_self.copyWith(organizer: value));
  });
}
}

// dart format on
