// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_venue_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventVenueDto {

 String get venueType; String? get venueAddress; String? get venueCity; String? get venueMapsUrl; String? get venueOnlineLink; String? get venuePlatform;
/// Create a copy of EventVenueDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventVenueDtoCopyWith<EventVenueDto> get copyWith => _$EventVenueDtoCopyWithImpl<EventVenueDto>(this as EventVenueDto, _$identity);

  /// Serializes this EventVenueDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventVenueDto&&(identical(other.venueType, venueType) || other.venueType == venueType)&&(identical(other.venueAddress, venueAddress) || other.venueAddress == venueAddress)&&(identical(other.venueCity, venueCity) || other.venueCity == venueCity)&&(identical(other.venueMapsUrl, venueMapsUrl) || other.venueMapsUrl == venueMapsUrl)&&(identical(other.venueOnlineLink, venueOnlineLink) || other.venueOnlineLink == venueOnlineLink)&&(identical(other.venuePlatform, venuePlatform) || other.venuePlatform == venuePlatform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,venueType,venueAddress,venueCity,venueMapsUrl,venueOnlineLink,venuePlatform);

@override
String toString() {
  return 'EventVenueDto(venueType: $venueType, venueAddress: $venueAddress, venueCity: $venueCity, venueMapsUrl: $venueMapsUrl, venueOnlineLink: $venueOnlineLink, venuePlatform: $venuePlatform)';
}


}

/// @nodoc
abstract mixin class $EventVenueDtoCopyWith<$Res>  {
  factory $EventVenueDtoCopyWith(EventVenueDto value, $Res Function(EventVenueDto) _then) = _$EventVenueDtoCopyWithImpl;
@useResult
$Res call({
 String venueType, String? venueAddress, String? venueCity, String? venueMapsUrl, String? venueOnlineLink, String? venuePlatform
});




}
/// @nodoc
class _$EventVenueDtoCopyWithImpl<$Res>
    implements $EventVenueDtoCopyWith<$Res> {
  _$EventVenueDtoCopyWithImpl(this._self, this._then);

  final EventVenueDto _self;
  final $Res Function(EventVenueDto) _then;

/// Create a copy of EventVenueDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? venueType = null,Object? venueAddress = freezed,Object? venueCity = freezed,Object? venueMapsUrl = freezed,Object? venueOnlineLink = freezed,Object? venuePlatform = freezed,}) {
  return _then(_self.copyWith(
venueType: null == venueType ? _self.venueType : venueType // ignore: cast_nullable_to_non_nullable
as String,venueAddress: freezed == venueAddress ? _self.venueAddress : venueAddress // ignore: cast_nullable_to_non_nullable
as String?,venueCity: freezed == venueCity ? _self.venueCity : venueCity // ignore: cast_nullable_to_non_nullable
as String?,venueMapsUrl: freezed == venueMapsUrl ? _self.venueMapsUrl : venueMapsUrl // ignore: cast_nullable_to_non_nullable
as String?,venueOnlineLink: freezed == venueOnlineLink ? _self.venueOnlineLink : venueOnlineLink // ignore: cast_nullable_to_non_nullable
as String?,venuePlatform: freezed == venuePlatform ? _self.venuePlatform : venuePlatform // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EventVenueDto].
extension EventVenueDtoPatterns on EventVenueDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventVenueDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventVenueDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventVenueDto value)  $default,){
final _that = this;
switch (_that) {
case _EventVenueDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventVenueDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventVenueDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String venueType,  String? venueAddress,  String? venueCity,  String? venueMapsUrl,  String? venueOnlineLink,  String? venuePlatform)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventVenueDto() when $default != null:
return $default(_that.venueType,_that.venueAddress,_that.venueCity,_that.venueMapsUrl,_that.venueOnlineLink,_that.venuePlatform);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String venueType,  String? venueAddress,  String? venueCity,  String? venueMapsUrl,  String? venueOnlineLink,  String? venuePlatform)  $default,) {final _that = this;
switch (_that) {
case _EventVenueDto():
return $default(_that.venueType,_that.venueAddress,_that.venueCity,_that.venueMapsUrl,_that.venueOnlineLink,_that.venuePlatform);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String venueType,  String? venueAddress,  String? venueCity,  String? venueMapsUrl,  String? venueOnlineLink,  String? venuePlatform)?  $default,) {final _that = this;
switch (_that) {
case _EventVenueDto() when $default != null:
return $default(_that.venueType,_that.venueAddress,_that.venueCity,_that.venueMapsUrl,_that.venueOnlineLink,_that.venuePlatform);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventVenueDto extends EventVenueDto {
  const _EventVenueDto({required this.venueType, this.venueAddress, this.venueCity, this.venueMapsUrl, this.venueOnlineLink, this.venuePlatform}): super._();
  factory _EventVenueDto.fromJson(Map<String, dynamic> json) => _$EventVenueDtoFromJson(json);

@override final  String venueType;
@override final  String? venueAddress;
@override final  String? venueCity;
@override final  String? venueMapsUrl;
@override final  String? venueOnlineLink;
@override final  String? venuePlatform;

/// Create a copy of EventVenueDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventVenueDtoCopyWith<_EventVenueDto> get copyWith => __$EventVenueDtoCopyWithImpl<_EventVenueDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventVenueDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventVenueDto&&(identical(other.venueType, venueType) || other.venueType == venueType)&&(identical(other.venueAddress, venueAddress) || other.venueAddress == venueAddress)&&(identical(other.venueCity, venueCity) || other.venueCity == venueCity)&&(identical(other.venueMapsUrl, venueMapsUrl) || other.venueMapsUrl == venueMapsUrl)&&(identical(other.venueOnlineLink, venueOnlineLink) || other.venueOnlineLink == venueOnlineLink)&&(identical(other.venuePlatform, venuePlatform) || other.venuePlatform == venuePlatform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,venueType,venueAddress,venueCity,venueMapsUrl,venueOnlineLink,venuePlatform);

@override
String toString() {
  return 'EventVenueDto(venueType: $venueType, venueAddress: $venueAddress, venueCity: $venueCity, venueMapsUrl: $venueMapsUrl, venueOnlineLink: $venueOnlineLink, venuePlatform: $venuePlatform)';
}


}

/// @nodoc
abstract mixin class _$EventVenueDtoCopyWith<$Res> implements $EventVenueDtoCopyWith<$Res> {
  factory _$EventVenueDtoCopyWith(_EventVenueDto value, $Res Function(_EventVenueDto) _then) = __$EventVenueDtoCopyWithImpl;
@override @useResult
$Res call({
 String venueType, String? venueAddress, String? venueCity, String? venueMapsUrl, String? venueOnlineLink, String? venuePlatform
});




}
/// @nodoc
class __$EventVenueDtoCopyWithImpl<$Res>
    implements _$EventVenueDtoCopyWith<$Res> {
  __$EventVenueDtoCopyWithImpl(this._self, this._then);

  final _EventVenueDto _self;
  final $Res Function(_EventVenueDto) _then;

/// Create a copy of EventVenueDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? venueType = null,Object? venueAddress = freezed,Object? venueCity = freezed,Object? venueMapsUrl = freezed,Object? venueOnlineLink = freezed,Object? venuePlatform = freezed,}) {
  return _then(_EventVenueDto(
venueType: null == venueType ? _self.venueType : venueType // ignore: cast_nullable_to_non_nullable
as String,venueAddress: freezed == venueAddress ? _self.venueAddress : venueAddress // ignore: cast_nullable_to_non_nullable
as String?,venueCity: freezed == venueCity ? _self.venueCity : venueCity // ignore: cast_nullable_to_non_nullable
as String?,venueMapsUrl: freezed == venueMapsUrl ? _self.venueMapsUrl : venueMapsUrl // ignore: cast_nullable_to_non_nullable
as String?,venueOnlineLink: freezed == venueOnlineLink ? _self.venueOnlineLink : venueOnlineLink // ignore: cast_nullable_to_non_nullable
as String?,venuePlatform: freezed == venuePlatform ? _self.venuePlatform : venuePlatform // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
