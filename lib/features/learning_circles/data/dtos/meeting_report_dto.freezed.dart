// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meeting_report_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MeetingReportDto {

 bool get isReportSubmitted; List<MeetingReportAttendeeDto> get attendees; String? get report;
/// Create a copy of MeetingReportDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingReportDtoCopyWith<MeetingReportDto> get copyWith => _$MeetingReportDtoCopyWithImpl<MeetingReportDto>(this as MeetingReportDto, _$identity);

  /// Serializes this MeetingReportDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeetingReportDto&&(identical(other.isReportSubmitted, isReportSubmitted) || other.isReportSubmitted == isReportSubmitted)&&const DeepCollectionEquality().equals(other.attendees, attendees)&&(identical(other.report, report) || other.report == report));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isReportSubmitted,const DeepCollectionEquality().hash(attendees),report);

@override
String toString() {
  return 'MeetingReportDto(isReportSubmitted: $isReportSubmitted, attendees: $attendees, report: $report)';
}


}

/// @nodoc
abstract mixin class $MeetingReportDtoCopyWith<$Res>  {
  factory $MeetingReportDtoCopyWith(MeetingReportDto value, $Res Function(MeetingReportDto) _then) = _$MeetingReportDtoCopyWithImpl;
@useResult
$Res call({
 bool isReportSubmitted, List<MeetingReportAttendeeDto> attendees, String? report
});




}
/// @nodoc
class _$MeetingReportDtoCopyWithImpl<$Res>
    implements $MeetingReportDtoCopyWith<$Res> {
  _$MeetingReportDtoCopyWithImpl(this._self, this._then);

  final MeetingReportDto _self;
  final $Res Function(MeetingReportDto) _then;

/// Create a copy of MeetingReportDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isReportSubmitted = null,Object? attendees = null,Object? report = freezed,}) {
  return _then(_self.copyWith(
isReportSubmitted: null == isReportSubmitted ? _self.isReportSubmitted : isReportSubmitted // ignore: cast_nullable_to_non_nullable
as bool,attendees: null == attendees ? _self.attendees : attendees // ignore: cast_nullable_to_non_nullable
as List<MeetingReportAttendeeDto>,report: freezed == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MeetingReportDto].
extension MeetingReportDtoPatterns on MeetingReportDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeetingReportDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeetingReportDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeetingReportDto value)  $default,){
final _that = this;
switch (_that) {
case _MeetingReportDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeetingReportDto value)?  $default,){
final _that = this;
switch (_that) {
case _MeetingReportDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isReportSubmitted,  List<MeetingReportAttendeeDto> attendees,  String? report)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeetingReportDto() when $default != null:
return $default(_that.isReportSubmitted,_that.attendees,_that.report);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isReportSubmitted,  List<MeetingReportAttendeeDto> attendees,  String? report)  $default,) {final _that = this;
switch (_that) {
case _MeetingReportDto():
return $default(_that.isReportSubmitted,_that.attendees,_that.report);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isReportSubmitted,  List<MeetingReportAttendeeDto> attendees,  String? report)?  $default,) {final _that = this;
switch (_that) {
case _MeetingReportDto() when $default != null:
return $default(_that.isReportSubmitted,_that.attendees,_that.report);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeetingReportDto extends MeetingReportDto {
  const _MeetingReportDto({this.isReportSubmitted = false, final  List<MeetingReportAttendeeDto> attendees = const [], this.report}): _attendees = attendees,super._();
  factory _MeetingReportDto.fromJson(Map<String, dynamic> json) => _$MeetingReportDtoFromJson(json);

@override@JsonKey() final  bool isReportSubmitted;
 final  List<MeetingReportAttendeeDto> _attendees;
@override@JsonKey() List<MeetingReportAttendeeDto> get attendees {
  if (_attendees is EqualUnmodifiableListView) return _attendees;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attendees);
}

@override final  String? report;

/// Create a copy of MeetingReportDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingReportDtoCopyWith<_MeetingReportDto> get copyWith => __$MeetingReportDtoCopyWithImpl<_MeetingReportDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeetingReportDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeetingReportDto&&(identical(other.isReportSubmitted, isReportSubmitted) || other.isReportSubmitted == isReportSubmitted)&&const DeepCollectionEquality().equals(other._attendees, _attendees)&&(identical(other.report, report) || other.report == report));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isReportSubmitted,const DeepCollectionEquality().hash(_attendees),report);

@override
String toString() {
  return 'MeetingReportDto(isReportSubmitted: $isReportSubmitted, attendees: $attendees, report: $report)';
}


}

/// @nodoc
abstract mixin class _$MeetingReportDtoCopyWith<$Res> implements $MeetingReportDtoCopyWith<$Res> {
  factory _$MeetingReportDtoCopyWith(_MeetingReportDto value, $Res Function(_MeetingReportDto) _then) = __$MeetingReportDtoCopyWithImpl;
@override @useResult
$Res call({
 bool isReportSubmitted, List<MeetingReportAttendeeDto> attendees, String? report
});




}
/// @nodoc
class __$MeetingReportDtoCopyWithImpl<$Res>
    implements _$MeetingReportDtoCopyWith<$Res> {
  __$MeetingReportDtoCopyWithImpl(this._self, this._then);

  final _MeetingReportDto _self;
  final $Res Function(_MeetingReportDto) _then;

/// Create a copy of MeetingReportDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isReportSubmitted = null,Object? attendees = null,Object? report = freezed,}) {
  return _then(_MeetingReportDto(
isReportSubmitted: null == isReportSubmitted ? _self.isReportSubmitted : isReportSubmitted // ignore: cast_nullable_to_non_nullable
as bool,attendees: null == attendees ? _self._attendees : attendees // ignore: cast_nullable_to_non_nullable
as List<MeetingReportAttendeeDto>,report: freezed == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
