// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_organizer_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventOrganizerDto {

 String get organiserType; String? get organiserIg; String? get organiserCampus; EventOrganizerCompanyDto? get organiserCompany; String? get organiserCiId;
/// Create a copy of EventOrganizerDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventOrganizerDtoCopyWith<EventOrganizerDto> get copyWith => _$EventOrganizerDtoCopyWithImpl<EventOrganizerDto>(this as EventOrganizerDto, _$identity);

  /// Serializes this EventOrganizerDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventOrganizerDto&&(identical(other.organiserType, organiserType) || other.organiserType == organiserType)&&(identical(other.organiserIg, organiserIg) || other.organiserIg == organiserIg)&&(identical(other.organiserCampus, organiserCampus) || other.organiserCampus == organiserCampus)&&(identical(other.organiserCompany, organiserCompany) || other.organiserCompany == organiserCompany)&&(identical(other.organiserCiId, organiserCiId) || other.organiserCiId == organiserCiId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organiserType,organiserIg,organiserCampus,organiserCompany,organiserCiId);

@override
String toString() {
  return 'EventOrganizerDto(organiserType: $organiserType, organiserIg: $organiserIg, organiserCampus: $organiserCampus, organiserCompany: $organiserCompany, organiserCiId: $organiserCiId)';
}


}

/// @nodoc
abstract mixin class $EventOrganizerDtoCopyWith<$Res>  {
  factory $EventOrganizerDtoCopyWith(EventOrganizerDto value, $Res Function(EventOrganizerDto) _then) = _$EventOrganizerDtoCopyWithImpl;
@useResult
$Res call({
 String organiserType, String? organiserIg, String? organiserCampus, EventOrganizerCompanyDto? organiserCompany, String? organiserCiId
});


$EventOrganizerCompanyDtoCopyWith<$Res>? get organiserCompany;

}
/// @nodoc
class _$EventOrganizerDtoCopyWithImpl<$Res>
    implements $EventOrganizerDtoCopyWith<$Res> {
  _$EventOrganizerDtoCopyWithImpl(this._self, this._then);

  final EventOrganizerDto _self;
  final $Res Function(EventOrganizerDto) _then;

/// Create a copy of EventOrganizerDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? organiserType = null,Object? organiserIg = freezed,Object? organiserCampus = freezed,Object? organiserCompany = freezed,Object? organiserCiId = freezed,}) {
  return _then(_self.copyWith(
organiserType: null == organiserType ? _self.organiserType : organiserType // ignore: cast_nullable_to_non_nullable
as String,organiserIg: freezed == organiserIg ? _self.organiserIg : organiserIg // ignore: cast_nullable_to_non_nullable
as String?,organiserCampus: freezed == organiserCampus ? _self.organiserCampus : organiserCampus // ignore: cast_nullable_to_non_nullable
as String?,organiserCompany: freezed == organiserCompany ? _self.organiserCompany : organiserCompany // ignore: cast_nullable_to_non_nullable
as EventOrganizerCompanyDto?,organiserCiId: freezed == organiserCiId ? _self.organiserCiId : organiserCiId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of EventOrganizerDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventOrganizerCompanyDtoCopyWith<$Res>? get organiserCompany {
    if (_self.organiserCompany == null) {
    return null;
  }

  return $EventOrganizerCompanyDtoCopyWith<$Res>(_self.organiserCompany!, (value) {
    return _then(_self.copyWith(organiserCompany: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventOrganizerDto].
extension EventOrganizerDtoPatterns on EventOrganizerDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventOrganizerDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventOrganizerDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventOrganizerDto value)  $default,){
final _that = this;
switch (_that) {
case _EventOrganizerDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventOrganizerDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventOrganizerDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String organiserType,  String? organiserIg,  String? organiserCampus,  EventOrganizerCompanyDto? organiserCompany,  String? organiserCiId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventOrganizerDto() when $default != null:
return $default(_that.organiserType,_that.organiserIg,_that.organiserCampus,_that.organiserCompany,_that.organiserCiId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String organiserType,  String? organiserIg,  String? organiserCampus,  EventOrganizerCompanyDto? organiserCompany,  String? organiserCiId)  $default,) {final _that = this;
switch (_that) {
case _EventOrganizerDto():
return $default(_that.organiserType,_that.organiserIg,_that.organiserCampus,_that.organiserCompany,_that.organiserCiId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String organiserType,  String? organiserIg,  String? organiserCampus,  EventOrganizerCompanyDto? organiserCompany,  String? organiserCiId)?  $default,) {final _that = this;
switch (_that) {
case _EventOrganizerDto() when $default != null:
return $default(_that.organiserType,_that.organiserIg,_that.organiserCampus,_that.organiserCompany,_that.organiserCiId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventOrganizerDto extends EventOrganizerDto {
  const _EventOrganizerDto({required this.organiserType, this.organiserIg, this.organiserCampus, this.organiserCompany, this.organiserCiId}): super._();
  factory _EventOrganizerDto.fromJson(Map<String, dynamic> json) => _$EventOrganizerDtoFromJson(json);

@override final  String organiserType;
@override final  String? organiserIg;
@override final  String? organiserCampus;
@override final  EventOrganizerCompanyDto? organiserCompany;
@override final  String? organiserCiId;

/// Create a copy of EventOrganizerDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventOrganizerDtoCopyWith<_EventOrganizerDto> get copyWith => __$EventOrganizerDtoCopyWithImpl<_EventOrganizerDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventOrganizerDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventOrganizerDto&&(identical(other.organiserType, organiserType) || other.organiserType == organiserType)&&(identical(other.organiserIg, organiserIg) || other.organiserIg == organiserIg)&&(identical(other.organiserCampus, organiserCampus) || other.organiserCampus == organiserCampus)&&(identical(other.organiserCompany, organiserCompany) || other.organiserCompany == organiserCompany)&&(identical(other.organiserCiId, organiserCiId) || other.organiserCiId == organiserCiId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organiserType,organiserIg,organiserCampus,organiserCompany,organiserCiId);

@override
String toString() {
  return 'EventOrganizerDto(organiserType: $organiserType, organiserIg: $organiserIg, organiserCampus: $organiserCampus, organiserCompany: $organiserCompany, organiserCiId: $organiserCiId)';
}


}

/// @nodoc
abstract mixin class _$EventOrganizerDtoCopyWith<$Res> implements $EventOrganizerDtoCopyWith<$Res> {
  factory _$EventOrganizerDtoCopyWith(_EventOrganizerDto value, $Res Function(_EventOrganizerDto) _then) = __$EventOrganizerDtoCopyWithImpl;
@override @useResult
$Res call({
 String organiserType, String? organiserIg, String? organiserCampus, EventOrganizerCompanyDto? organiserCompany, String? organiserCiId
});


@override $EventOrganizerCompanyDtoCopyWith<$Res>? get organiserCompany;

}
/// @nodoc
class __$EventOrganizerDtoCopyWithImpl<$Res>
    implements _$EventOrganizerDtoCopyWith<$Res> {
  __$EventOrganizerDtoCopyWithImpl(this._self, this._then);

  final _EventOrganizerDto _self;
  final $Res Function(_EventOrganizerDto) _then;

/// Create a copy of EventOrganizerDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? organiserType = null,Object? organiserIg = freezed,Object? organiserCampus = freezed,Object? organiserCompany = freezed,Object? organiserCiId = freezed,}) {
  return _then(_EventOrganizerDto(
organiserType: null == organiserType ? _self.organiserType : organiserType // ignore: cast_nullable_to_non_nullable
as String,organiserIg: freezed == organiserIg ? _self.organiserIg : organiserIg // ignore: cast_nullable_to_non_nullable
as String?,organiserCampus: freezed == organiserCampus ? _self.organiserCampus : organiserCampus // ignore: cast_nullable_to_non_nullable
as String?,organiserCompany: freezed == organiserCompany ? _self.organiserCompany : organiserCompany // ignore: cast_nullable_to_non_nullable
as EventOrganizerCompanyDto?,organiserCiId: freezed == organiserCiId ? _self.organiserCiId : organiserCiId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of EventOrganizerDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventOrganizerCompanyDtoCopyWith<$Res>? get organiserCompany {
    if (_self.organiserCompany == null) {
    return null;
  }

  return $EventOrganizerCompanyDtoCopyWith<$Res>(_self.organiserCompany!, (value) {
    return _then(_self.copyWith(organiserCompany: value));
  });
}
}

// dart format on
