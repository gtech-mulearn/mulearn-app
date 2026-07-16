// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'featured_event_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeaturedEventDto {

 String get id; String get title; String get slug; String get status; String get eventScope; String get startDatetime; String get endDatetime; EventVenueDto get venue; EventOrganizerDto get organizer; bool get isCollaboration; int get interestCount; List<String> get tags; String? get coverImage; int? get minKarma;
/// Create a copy of FeaturedEventDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeaturedEventDtoCopyWith<FeaturedEventDto> get copyWith => _$FeaturedEventDtoCopyWithImpl<FeaturedEventDto>(this as FeaturedEventDto, _$identity);

  /// Serializes this FeaturedEventDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeaturedEventDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.status, status) || other.status == status)&&(identical(other.eventScope, eventScope) || other.eventScope == eventScope)&&(identical(other.startDatetime, startDatetime) || other.startDatetime == startDatetime)&&(identical(other.endDatetime, endDatetime) || other.endDatetime == endDatetime)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.organizer, organizer) || other.organizer == organizer)&&(identical(other.isCollaboration, isCollaboration) || other.isCollaboration == isCollaboration)&&(identical(other.interestCount, interestCount) || other.interestCount == interestCount)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.coverImage, coverImage) || other.coverImage == coverImage)&&(identical(other.minKarma, minKarma) || other.minKarma == minKarma));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,slug,status,eventScope,startDatetime,endDatetime,venue,organizer,isCollaboration,interestCount,const DeepCollectionEquality().hash(tags),coverImage,minKarma);

@override
String toString() {
  return 'FeaturedEventDto(id: $id, title: $title, slug: $slug, status: $status, eventScope: $eventScope, startDatetime: $startDatetime, endDatetime: $endDatetime, venue: $venue, organizer: $organizer, isCollaboration: $isCollaboration, interestCount: $interestCount, tags: $tags, coverImage: $coverImage, minKarma: $minKarma)';
}


}

/// @nodoc
abstract mixin class $FeaturedEventDtoCopyWith<$Res>  {
  factory $FeaturedEventDtoCopyWith(FeaturedEventDto value, $Res Function(FeaturedEventDto) _then) = _$FeaturedEventDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String slug, String status, String eventScope, String startDatetime, String endDatetime, EventVenueDto venue, EventOrganizerDto organizer, bool isCollaboration, int interestCount, List<String> tags, String? coverImage, int? minKarma
});


$EventVenueDtoCopyWith<$Res> get venue;$EventOrganizerDtoCopyWith<$Res> get organizer;

}
/// @nodoc
class _$FeaturedEventDtoCopyWithImpl<$Res>
    implements $FeaturedEventDtoCopyWith<$Res> {
  _$FeaturedEventDtoCopyWithImpl(this._self, this._then);

  final FeaturedEventDto _self;
  final $Res Function(FeaturedEventDto) _then;

/// Create a copy of FeaturedEventDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? slug = null,Object? status = null,Object? eventScope = null,Object? startDatetime = null,Object? endDatetime = null,Object? venue = null,Object? organizer = null,Object? isCollaboration = null,Object? interestCount = null,Object? tags = null,Object? coverImage = freezed,Object? minKarma = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,eventScope: null == eventScope ? _self.eventScope : eventScope // ignore: cast_nullable_to_non_nullable
as String,startDatetime: null == startDatetime ? _self.startDatetime : startDatetime // ignore: cast_nullable_to_non_nullable
as String,endDatetime: null == endDatetime ? _self.endDatetime : endDatetime // ignore: cast_nullable_to_non_nullable
as String,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as EventVenueDto,organizer: null == organizer ? _self.organizer : organizer // ignore: cast_nullable_to_non_nullable
as EventOrganizerDto,isCollaboration: null == isCollaboration ? _self.isCollaboration : isCollaboration // ignore: cast_nullable_to_non_nullable
as bool,interestCount: null == interestCount ? _self.interestCount : interestCount // ignore: cast_nullable_to_non_nullable
as int,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,coverImage: freezed == coverImage ? _self.coverImage : coverImage // ignore: cast_nullable_to_non_nullable
as String?,minKarma: freezed == minKarma ? _self.minKarma : minKarma // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of FeaturedEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventVenueDtoCopyWith<$Res> get venue {
  
  return $EventVenueDtoCopyWith<$Res>(_self.venue, (value) {
    return _then(_self.copyWith(venue: value));
  });
}/// Create a copy of FeaturedEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventOrganizerDtoCopyWith<$Res> get organizer {
  
  return $EventOrganizerDtoCopyWith<$Res>(_self.organizer, (value) {
    return _then(_self.copyWith(organizer: value));
  });
}
}


/// Adds pattern-matching-related methods to [FeaturedEventDto].
extension FeaturedEventDtoPatterns on FeaturedEventDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeaturedEventDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeaturedEventDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeaturedEventDto value)  $default,){
final _that = this;
switch (_that) {
case _FeaturedEventDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeaturedEventDto value)?  $default,){
final _that = this;
switch (_that) {
case _FeaturedEventDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String slug,  String status,  String eventScope,  String startDatetime,  String endDatetime,  EventVenueDto venue,  EventOrganizerDto organizer,  bool isCollaboration,  int interestCount,  List<String> tags,  String? coverImage,  int? minKarma)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeaturedEventDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String slug,  String status,  String eventScope,  String startDatetime,  String endDatetime,  EventVenueDto venue,  EventOrganizerDto organizer,  bool isCollaboration,  int interestCount,  List<String> tags,  String? coverImage,  int? minKarma)  $default,) {final _that = this;
switch (_that) {
case _FeaturedEventDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String slug,  String status,  String eventScope,  String startDatetime,  String endDatetime,  EventVenueDto venue,  EventOrganizerDto organizer,  bool isCollaboration,  int interestCount,  List<String> tags,  String? coverImage,  int? minKarma)?  $default,) {final _that = this;
switch (_that) {
case _FeaturedEventDto() when $default != null:
return $default(_that.id,_that.title,_that.slug,_that.status,_that.eventScope,_that.startDatetime,_that.endDatetime,_that.venue,_that.organizer,_that.isCollaboration,_that.interestCount,_that.tags,_that.coverImage,_that.minKarma);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeaturedEventDto extends FeaturedEventDto {
  const _FeaturedEventDto({required this.id, required this.title, required this.slug, required this.status, required this.eventScope, required this.startDatetime, required this.endDatetime, required this.venue, required this.organizer, this.isCollaboration = false, this.interestCount = 0, final  List<String> tags = const [], this.coverImage, this.minKarma}): _tags = tags,super._();
  factory _FeaturedEventDto.fromJson(Map<String, dynamic> json) => _$FeaturedEventDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  String slug;
@override final  String status;
@override final  String eventScope;
@override final  String startDatetime;
@override final  String endDatetime;
@override final  EventVenueDto venue;
@override final  EventOrganizerDto organizer;
@override@JsonKey() final  bool isCollaboration;
@override@JsonKey() final  int interestCount;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  String? coverImage;
@override final  int? minKarma;

/// Create a copy of FeaturedEventDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeaturedEventDtoCopyWith<_FeaturedEventDto> get copyWith => __$FeaturedEventDtoCopyWithImpl<_FeaturedEventDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeaturedEventDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeaturedEventDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.status, status) || other.status == status)&&(identical(other.eventScope, eventScope) || other.eventScope == eventScope)&&(identical(other.startDatetime, startDatetime) || other.startDatetime == startDatetime)&&(identical(other.endDatetime, endDatetime) || other.endDatetime == endDatetime)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.organizer, organizer) || other.organizer == organizer)&&(identical(other.isCollaboration, isCollaboration) || other.isCollaboration == isCollaboration)&&(identical(other.interestCount, interestCount) || other.interestCount == interestCount)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.coverImage, coverImage) || other.coverImage == coverImage)&&(identical(other.minKarma, minKarma) || other.minKarma == minKarma));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,slug,status,eventScope,startDatetime,endDatetime,venue,organizer,isCollaboration,interestCount,const DeepCollectionEquality().hash(_tags),coverImage,minKarma);

@override
String toString() {
  return 'FeaturedEventDto(id: $id, title: $title, slug: $slug, status: $status, eventScope: $eventScope, startDatetime: $startDatetime, endDatetime: $endDatetime, venue: $venue, organizer: $organizer, isCollaboration: $isCollaboration, interestCount: $interestCount, tags: $tags, coverImage: $coverImage, minKarma: $minKarma)';
}


}

/// @nodoc
abstract mixin class _$FeaturedEventDtoCopyWith<$Res> implements $FeaturedEventDtoCopyWith<$Res> {
  factory _$FeaturedEventDtoCopyWith(_FeaturedEventDto value, $Res Function(_FeaturedEventDto) _then) = __$FeaturedEventDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String slug, String status, String eventScope, String startDatetime, String endDatetime, EventVenueDto venue, EventOrganizerDto organizer, bool isCollaboration, int interestCount, List<String> tags, String? coverImage, int? minKarma
});


@override $EventVenueDtoCopyWith<$Res> get venue;@override $EventOrganizerDtoCopyWith<$Res> get organizer;

}
/// @nodoc
class __$FeaturedEventDtoCopyWithImpl<$Res>
    implements _$FeaturedEventDtoCopyWith<$Res> {
  __$FeaturedEventDtoCopyWithImpl(this._self, this._then);

  final _FeaturedEventDto _self;
  final $Res Function(_FeaturedEventDto) _then;

/// Create a copy of FeaturedEventDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? slug = null,Object? status = null,Object? eventScope = null,Object? startDatetime = null,Object? endDatetime = null,Object? venue = null,Object? organizer = null,Object? isCollaboration = null,Object? interestCount = null,Object? tags = null,Object? coverImage = freezed,Object? minKarma = freezed,}) {
  return _then(_FeaturedEventDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,eventScope: null == eventScope ? _self.eventScope : eventScope // ignore: cast_nullable_to_non_nullable
as String,startDatetime: null == startDatetime ? _self.startDatetime : startDatetime // ignore: cast_nullable_to_non_nullable
as String,endDatetime: null == endDatetime ? _self.endDatetime : endDatetime // ignore: cast_nullable_to_non_nullable
as String,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as EventVenueDto,organizer: null == organizer ? _self.organizer : organizer // ignore: cast_nullable_to_non_nullable
as EventOrganizerDto,isCollaboration: null == isCollaboration ? _self.isCollaboration : isCollaboration // ignore: cast_nullable_to_non_nullable
as bool,interestCount: null == interestCount ? _self.interestCount : interestCount // ignore: cast_nullable_to_non_nullable
as int,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,coverImage: freezed == coverImage ? _self.coverImage : coverImage // ignore: cast_nullable_to_non_nullable
as String?,minKarma: freezed == minKarma ? _self.minKarma : minKarma // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of FeaturedEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventVenueDtoCopyWith<$Res> get venue {
  
  return $EventVenueDtoCopyWith<$Res>(_self.venue, (value) {
    return _then(_self.copyWith(venue: value));
  });
}/// Create a copy of FeaturedEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventOrganizerDtoCopyWith<$Res> get organizer {
  
  return $EventOrganizerDtoCopyWith<$Res>(_self.organizer, (value) {
    return _then(_self.copyWith(organizer: value));
  });
}
}

// dart format on
