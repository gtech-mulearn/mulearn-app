// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_venue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventVenue {

 String get venueType; String? get venueAddress; String? get venueCity; String? get venueMapsUrl; String? get venueOnlineLink; String? get venuePlatform;
/// Create a copy of EventVenue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventVenueCopyWith<EventVenue> get copyWith => _$EventVenueCopyWithImpl<EventVenue>(this as EventVenue, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventVenue&&(identical(other.venueType, venueType) || other.venueType == venueType)&&(identical(other.venueAddress, venueAddress) || other.venueAddress == venueAddress)&&(identical(other.venueCity, venueCity) || other.venueCity == venueCity)&&(identical(other.venueMapsUrl, venueMapsUrl) || other.venueMapsUrl == venueMapsUrl)&&(identical(other.venueOnlineLink, venueOnlineLink) || other.venueOnlineLink == venueOnlineLink)&&(identical(other.venuePlatform, venuePlatform) || other.venuePlatform == venuePlatform));
}


@override
int get hashCode => Object.hash(runtimeType,venueType,venueAddress,venueCity,venueMapsUrl,venueOnlineLink,venuePlatform);

@override
String toString() {
  return 'EventVenue(venueType: $venueType, venueAddress: $venueAddress, venueCity: $venueCity, venueMapsUrl: $venueMapsUrl, venueOnlineLink: $venueOnlineLink, venuePlatform: $venuePlatform)';
}


}

/// @nodoc
abstract mixin class $EventVenueCopyWith<$Res>  {
  factory $EventVenueCopyWith(EventVenue value, $Res Function(EventVenue) _then) = _$EventVenueCopyWithImpl;
@useResult
$Res call({
 String venueType, String? venueAddress, String? venueCity, String? venueMapsUrl, String? venueOnlineLink, String? venuePlatform
});




}
/// @nodoc
class _$EventVenueCopyWithImpl<$Res>
    implements $EventVenueCopyWith<$Res> {
  _$EventVenueCopyWithImpl(this._self, this._then);

  final EventVenue _self;
  final $Res Function(EventVenue) _then;

/// Create a copy of EventVenue
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


/// Adds pattern-matching-related methods to [EventVenue].
extension EventVenuePatterns on EventVenue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventVenue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventVenue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventVenue value)  $default,){
final _that = this;
switch (_that) {
case _EventVenue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventVenue value)?  $default,){
final _that = this;
switch (_that) {
case _EventVenue() when $default != null:
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
case _EventVenue() when $default != null:
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
case _EventVenue():
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
case _EventVenue() when $default != null:
return $default(_that.venueType,_that.venueAddress,_that.venueCity,_that.venueMapsUrl,_that.venueOnlineLink,_that.venuePlatform);case _:
  return null;

}
}

}

/// @nodoc


class _EventVenue implements EventVenue {
  const _EventVenue({required this.venueType, this.venueAddress, this.venueCity, this.venueMapsUrl, this.venueOnlineLink, this.venuePlatform});
  

@override final  String venueType;
@override final  String? venueAddress;
@override final  String? venueCity;
@override final  String? venueMapsUrl;
@override final  String? venueOnlineLink;
@override final  String? venuePlatform;

/// Create a copy of EventVenue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventVenueCopyWith<_EventVenue> get copyWith => __$EventVenueCopyWithImpl<_EventVenue>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventVenue&&(identical(other.venueType, venueType) || other.venueType == venueType)&&(identical(other.venueAddress, venueAddress) || other.venueAddress == venueAddress)&&(identical(other.venueCity, venueCity) || other.venueCity == venueCity)&&(identical(other.venueMapsUrl, venueMapsUrl) || other.venueMapsUrl == venueMapsUrl)&&(identical(other.venueOnlineLink, venueOnlineLink) || other.venueOnlineLink == venueOnlineLink)&&(identical(other.venuePlatform, venuePlatform) || other.venuePlatform == venuePlatform));
}


@override
int get hashCode => Object.hash(runtimeType,venueType,venueAddress,venueCity,venueMapsUrl,venueOnlineLink,venuePlatform);

@override
String toString() {
  return 'EventVenue(venueType: $venueType, venueAddress: $venueAddress, venueCity: $venueCity, venueMapsUrl: $venueMapsUrl, venueOnlineLink: $venueOnlineLink, venuePlatform: $venuePlatform)';
}


}

/// @nodoc
abstract mixin class _$EventVenueCopyWith<$Res> implements $EventVenueCopyWith<$Res> {
  factory _$EventVenueCopyWith(_EventVenue value, $Res Function(_EventVenue) _then) = __$EventVenueCopyWithImpl;
@override @useResult
$Res call({
 String venueType, String? venueAddress, String? venueCity, String? venueMapsUrl, String? venueOnlineLink, String? venuePlatform
});




}
/// @nodoc
class __$EventVenueCopyWithImpl<$Res>
    implements _$EventVenueCopyWith<$Res> {
  __$EventVenueCopyWithImpl(this._self, this._then);

  final _EventVenue _self;
  final $Res Function(_EventVenue) _then;

/// Create a copy of EventVenue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? venueType = null,Object? venueAddress = freezed,Object? venueCity = freezed,Object? venueMapsUrl = freezed,Object? venueOnlineLink = freezed,Object? venuePlatform = freezed,}) {
  return _then(_EventVenue(
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
