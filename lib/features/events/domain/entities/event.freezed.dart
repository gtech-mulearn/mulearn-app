// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Event {

 String get id; String get title; String get slug; String get status; String get eventScope; String get eventType; String get startDatetime; String get endDatetime; EventVenue get venue; EventOrganizer get organizer; bool get isFeatured; bool get isCollaboration; int get interestCount; String get viewerInterestStatus; List<String> get tags; String? get coverImage; String? get bannerImage; String? get description; String? get categoryName; String? get registrationUrl; String? get registrationDeadline; int? get minKarma; int? get userLimit;
/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventCopyWith<Event> get copyWith => _$EventCopyWithImpl<Event>(this as Event, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Event&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.status, status) || other.status == status)&&(identical(other.eventScope, eventScope) || other.eventScope == eventScope)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.startDatetime, startDatetime) || other.startDatetime == startDatetime)&&(identical(other.endDatetime, endDatetime) || other.endDatetime == endDatetime)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.organizer, organizer) || other.organizer == organizer)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.isCollaboration, isCollaboration) || other.isCollaboration == isCollaboration)&&(identical(other.interestCount, interestCount) || other.interestCount == interestCount)&&(identical(other.viewerInterestStatus, viewerInterestStatus) || other.viewerInterestStatus == viewerInterestStatus)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.coverImage, coverImage) || other.coverImage == coverImage)&&(identical(other.bannerImage, bannerImage) || other.bannerImage == bannerImage)&&(identical(other.description, description) || other.description == description)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.registrationUrl, registrationUrl) || other.registrationUrl == registrationUrl)&&(identical(other.registrationDeadline, registrationDeadline) || other.registrationDeadline == registrationDeadline)&&(identical(other.minKarma, minKarma) || other.minKarma == minKarma)&&(identical(other.userLimit, userLimit) || other.userLimit == userLimit));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,title,slug,status,eventScope,eventType,startDatetime,endDatetime,venue,organizer,isFeatured,isCollaboration,interestCount,viewerInterestStatus,const DeepCollectionEquality().hash(tags),coverImage,bannerImage,description,categoryName,registrationUrl,registrationDeadline,minKarma,userLimit]);

@override
String toString() {
  return 'Event(id: $id, title: $title, slug: $slug, status: $status, eventScope: $eventScope, eventType: $eventType, startDatetime: $startDatetime, endDatetime: $endDatetime, venue: $venue, organizer: $organizer, isFeatured: $isFeatured, isCollaboration: $isCollaboration, interestCount: $interestCount, viewerInterestStatus: $viewerInterestStatus, tags: $tags, coverImage: $coverImage, bannerImage: $bannerImage, description: $description, categoryName: $categoryName, registrationUrl: $registrationUrl, registrationDeadline: $registrationDeadline, minKarma: $minKarma, userLimit: $userLimit)';
}


}

/// @nodoc
abstract mixin class $EventCopyWith<$Res>  {
  factory $EventCopyWith(Event value, $Res Function(Event) _then) = _$EventCopyWithImpl;
@useResult
$Res call({
 String id, String title, String slug, String status, String eventScope, String eventType, String startDatetime, String endDatetime, EventVenue venue, EventOrganizer organizer, bool isFeatured, bool isCollaboration, int interestCount, String viewerInterestStatus, List<String> tags, String? coverImage, String? bannerImage, String? description, String? categoryName, String? registrationUrl, String? registrationDeadline, int? minKarma, int? userLimit
});


$EventVenueCopyWith<$Res> get venue;$EventOrganizerCopyWith<$Res> get organizer;

}
/// @nodoc
class _$EventCopyWithImpl<$Res>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._self, this._then);

  final Event _self;
  final $Res Function(Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? slug = null,Object? status = null,Object? eventScope = null,Object? eventType = null,Object? startDatetime = null,Object? endDatetime = null,Object? venue = null,Object? organizer = null,Object? isFeatured = null,Object? isCollaboration = null,Object? interestCount = null,Object? viewerInterestStatus = null,Object? tags = null,Object? coverImage = freezed,Object? bannerImage = freezed,Object? description = freezed,Object? categoryName = freezed,Object? registrationUrl = freezed,Object? registrationDeadline = freezed,Object? minKarma = freezed,Object? userLimit = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,eventScope: null == eventScope ? _self.eventScope : eventScope // ignore: cast_nullable_to_non_nullable
as String,eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as String,startDatetime: null == startDatetime ? _self.startDatetime : startDatetime // ignore: cast_nullable_to_non_nullable
as String,endDatetime: null == endDatetime ? _self.endDatetime : endDatetime // ignore: cast_nullable_to_non_nullable
as String,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as EventVenue,organizer: null == organizer ? _self.organizer : organizer // ignore: cast_nullable_to_non_nullable
as EventOrganizer,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,isCollaboration: null == isCollaboration ? _self.isCollaboration : isCollaboration // ignore: cast_nullable_to_non_nullable
as bool,interestCount: null == interestCount ? _self.interestCount : interestCount // ignore: cast_nullable_to_non_nullable
as int,viewerInterestStatus: null == viewerInterestStatus ? _self.viewerInterestStatus : viewerInterestStatus // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,coverImage: freezed == coverImage ? _self.coverImage : coverImage // ignore: cast_nullable_to_non_nullable
as String?,bannerImage: freezed == bannerImage ? _self.bannerImage : bannerImage // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,registrationUrl: freezed == registrationUrl ? _self.registrationUrl : registrationUrl // ignore: cast_nullable_to_non_nullable
as String?,registrationDeadline: freezed == registrationDeadline ? _self.registrationDeadline : registrationDeadline // ignore: cast_nullable_to_non_nullable
as String?,minKarma: freezed == minKarma ? _self.minKarma : minKarma // ignore: cast_nullable_to_non_nullable
as int?,userLimit: freezed == userLimit ? _self.userLimit : userLimit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventVenueCopyWith<$Res> get venue {
  
  return $EventVenueCopyWith<$Res>(_self.venue, (value) {
    return _then(_self.copyWith(venue: value));
  });
}/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventOrganizerCopyWith<$Res> get organizer {
  
  return $EventOrganizerCopyWith<$Res>(_self.organizer, (value) {
    return _then(_self.copyWith(organizer: value));
  });
}
}


/// Adds pattern-matching-related methods to [Event].
extension EventPatterns on Event {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Event value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Event() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Event value)  $default,){
final _that = this;
switch (_that) {
case _Event():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Event value)?  $default,){
final _that = this;
switch (_that) {
case _Event() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String slug,  String status,  String eventScope,  String eventType,  String startDatetime,  String endDatetime,  EventVenue venue,  EventOrganizer organizer,  bool isFeatured,  bool isCollaboration,  int interestCount,  String viewerInterestStatus,  List<String> tags,  String? coverImage,  String? bannerImage,  String? description,  String? categoryName,  String? registrationUrl,  String? registrationDeadline,  int? minKarma,  int? userLimit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that.id,_that.title,_that.slug,_that.status,_that.eventScope,_that.eventType,_that.startDatetime,_that.endDatetime,_that.venue,_that.organizer,_that.isFeatured,_that.isCollaboration,_that.interestCount,_that.viewerInterestStatus,_that.tags,_that.coverImage,_that.bannerImage,_that.description,_that.categoryName,_that.registrationUrl,_that.registrationDeadline,_that.minKarma,_that.userLimit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String slug,  String status,  String eventScope,  String eventType,  String startDatetime,  String endDatetime,  EventVenue venue,  EventOrganizer organizer,  bool isFeatured,  bool isCollaboration,  int interestCount,  String viewerInterestStatus,  List<String> tags,  String? coverImage,  String? bannerImage,  String? description,  String? categoryName,  String? registrationUrl,  String? registrationDeadline,  int? minKarma,  int? userLimit)  $default,) {final _that = this;
switch (_that) {
case _Event():
return $default(_that.id,_that.title,_that.slug,_that.status,_that.eventScope,_that.eventType,_that.startDatetime,_that.endDatetime,_that.venue,_that.organizer,_that.isFeatured,_that.isCollaboration,_that.interestCount,_that.viewerInterestStatus,_that.tags,_that.coverImage,_that.bannerImage,_that.description,_that.categoryName,_that.registrationUrl,_that.registrationDeadline,_that.minKarma,_that.userLimit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String slug,  String status,  String eventScope,  String eventType,  String startDatetime,  String endDatetime,  EventVenue venue,  EventOrganizer organizer,  bool isFeatured,  bool isCollaboration,  int interestCount,  String viewerInterestStatus,  List<String> tags,  String? coverImage,  String? bannerImage,  String? description,  String? categoryName,  String? registrationUrl,  String? registrationDeadline,  int? minKarma,  int? userLimit)?  $default,) {final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that.id,_that.title,_that.slug,_that.status,_that.eventScope,_that.eventType,_that.startDatetime,_that.endDatetime,_that.venue,_that.organizer,_that.isFeatured,_that.isCollaboration,_that.interestCount,_that.viewerInterestStatus,_that.tags,_that.coverImage,_that.bannerImage,_that.description,_that.categoryName,_that.registrationUrl,_that.registrationDeadline,_that.minKarma,_that.userLimit);case _:
  return null;

}
}

}

/// @nodoc


class _Event extends Event {
  const _Event({required this.id, required this.title, required this.slug, required this.status, required this.eventScope, required this.eventType, required this.startDatetime, required this.endDatetime, required this.venue, required this.organizer, required this.isFeatured, required this.isCollaboration, required this.interestCount, required this.viewerInterestStatus, final  List<String> tags = const [], this.coverImage, this.bannerImage, this.description, this.categoryName, this.registrationUrl, this.registrationDeadline, this.minKarma, this.userLimit}): _tags = tags,super._();
  

@override final  String id;
@override final  String title;
@override final  String slug;
@override final  String status;
@override final  String eventScope;
@override final  String eventType;
@override final  String startDatetime;
@override final  String endDatetime;
@override final  EventVenue venue;
@override final  EventOrganizer organizer;
@override final  bool isFeatured;
@override final  bool isCollaboration;
@override final  int interestCount;
@override final  String viewerInterestStatus;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  String? coverImage;
@override final  String? bannerImage;
@override final  String? description;
@override final  String? categoryName;
@override final  String? registrationUrl;
@override final  String? registrationDeadline;
@override final  int? minKarma;
@override final  int? userLimit;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventCopyWith<_Event> get copyWith => __$EventCopyWithImpl<_Event>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Event&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.status, status) || other.status == status)&&(identical(other.eventScope, eventScope) || other.eventScope == eventScope)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.startDatetime, startDatetime) || other.startDatetime == startDatetime)&&(identical(other.endDatetime, endDatetime) || other.endDatetime == endDatetime)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.organizer, organizer) || other.organizer == organizer)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.isCollaboration, isCollaboration) || other.isCollaboration == isCollaboration)&&(identical(other.interestCount, interestCount) || other.interestCount == interestCount)&&(identical(other.viewerInterestStatus, viewerInterestStatus) || other.viewerInterestStatus == viewerInterestStatus)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.coverImage, coverImage) || other.coverImage == coverImage)&&(identical(other.bannerImage, bannerImage) || other.bannerImage == bannerImage)&&(identical(other.description, description) || other.description == description)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.registrationUrl, registrationUrl) || other.registrationUrl == registrationUrl)&&(identical(other.registrationDeadline, registrationDeadline) || other.registrationDeadline == registrationDeadline)&&(identical(other.minKarma, minKarma) || other.minKarma == minKarma)&&(identical(other.userLimit, userLimit) || other.userLimit == userLimit));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,title,slug,status,eventScope,eventType,startDatetime,endDatetime,venue,organizer,isFeatured,isCollaboration,interestCount,viewerInterestStatus,const DeepCollectionEquality().hash(_tags),coverImage,bannerImage,description,categoryName,registrationUrl,registrationDeadline,minKarma,userLimit]);

@override
String toString() {
  return 'Event(id: $id, title: $title, slug: $slug, status: $status, eventScope: $eventScope, eventType: $eventType, startDatetime: $startDatetime, endDatetime: $endDatetime, venue: $venue, organizer: $organizer, isFeatured: $isFeatured, isCollaboration: $isCollaboration, interestCount: $interestCount, viewerInterestStatus: $viewerInterestStatus, tags: $tags, coverImage: $coverImage, bannerImage: $bannerImage, description: $description, categoryName: $categoryName, registrationUrl: $registrationUrl, registrationDeadline: $registrationDeadline, minKarma: $minKarma, userLimit: $userLimit)';
}


}

/// @nodoc
abstract mixin class _$EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$EventCopyWith(_Event value, $Res Function(_Event) _then) = __$EventCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String slug, String status, String eventScope, String eventType, String startDatetime, String endDatetime, EventVenue venue, EventOrganizer organizer, bool isFeatured, bool isCollaboration, int interestCount, String viewerInterestStatus, List<String> tags, String? coverImage, String? bannerImage, String? description, String? categoryName, String? registrationUrl, String? registrationDeadline, int? minKarma, int? userLimit
});


@override $EventVenueCopyWith<$Res> get venue;@override $EventOrganizerCopyWith<$Res> get organizer;

}
/// @nodoc
class __$EventCopyWithImpl<$Res>
    implements _$EventCopyWith<$Res> {
  __$EventCopyWithImpl(this._self, this._then);

  final _Event _self;
  final $Res Function(_Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? slug = null,Object? status = null,Object? eventScope = null,Object? eventType = null,Object? startDatetime = null,Object? endDatetime = null,Object? venue = null,Object? organizer = null,Object? isFeatured = null,Object? isCollaboration = null,Object? interestCount = null,Object? viewerInterestStatus = null,Object? tags = null,Object? coverImage = freezed,Object? bannerImage = freezed,Object? description = freezed,Object? categoryName = freezed,Object? registrationUrl = freezed,Object? registrationDeadline = freezed,Object? minKarma = freezed,Object? userLimit = freezed,}) {
  return _then(_Event(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,eventScope: null == eventScope ? _self.eventScope : eventScope // ignore: cast_nullable_to_non_nullable
as String,eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as String,startDatetime: null == startDatetime ? _self.startDatetime : startDatetime // ignore: cast_nullable_to_non_nullable
as String,endDatetime: null == endDatetime ? _self.endDatetime : endDatetime // ignore: cast_nullable_to_non_nullable
as String,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as EventVenue,organizer: null == organizer ? _self.organizer : organizer // ignore: cast_nullable_to_non_nullable
as EventOrganizer,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,isCollaboration: null == isCollaboration ? _self.isCollaboration : isCollaboration // ignore: cast_nullable_to_non_nullable
as bool,interestCount: null == interestCount ? _self.interestCount : interestCount // ignore: cast_nullable_to_non_nullable
as int,viewerInterestStatus: null == viewerInterestStatus ? _self.viewerInterestStatus : viewerInterestStatus // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,coverImage: freezed == coverImage ? _self.coverImage : coverImage // ignore: cast_nullable_to_non_nullable
as String?,bannerImage: freezed == bannerImage ? _self.bannerImage : bannerImage // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,registrationUrl: freezed == registrationUrl ? _self.registrationUrl : registrationUrl // ignore: cast_nullable_to_non_nullable
as String?,registrationDeadline: freezed == registrationDeadline ? _self.registrationDeadline : registrationDeadline // ignore: cast_nullable_to_non_nullable
as String?,minKarma: freezed == minKarma ? _self.minKarma : minKarma // ignore: cast_nullable_to_non_nullable
as int?,userLimit: freezed == userLimit ? _self.userLimit : userLimit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventVenueCopyWith<$Res> get venue {
  
  return $EventVenueCopyWith<$Res>(_self.venue, (value) {
    return _then(_self.copyWith(venue: value));
  });
}/// Create a copy of Event
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
