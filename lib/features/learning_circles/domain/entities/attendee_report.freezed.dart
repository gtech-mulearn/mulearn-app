// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendee_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AttendeeReport {

 String? get report; String? get reportLink;
/// Create a copy of AttendeeReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendeeReportCopyWith<AttendeeReport> get copyWith => _$AttendeeReportCopyWithImpl<AttendeeReport>(this as AttendeeReport, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendeeReport&&(identical(other.report, report) || other.report == report)&&(identical(other.reportLink, reportLink) || other.reportLink == reportLink));
}


@override
int get hashCode => Object.hash(runtimeType,report,reportLink);

@override
String toString() {
  return 'AttendeeReport(report: $report, reportLink: $reportLink)';
}


}

/// @nodoc
abstract mixin class $AttendeeReportCopyWith<$Res>  {
  factory $AttendeeReportCopyWith(AttendeeReport value, $Res Function(AttendeeReport) _then) = _$AttendeeReportCopyWithImpl;
@useResult
$Res call({
 String? report, String? reportLink
});




}
/// @nodoc
class _$AttendeeReportCopyWithImpl<$Res>
    implements $AttendeeReportCopyWith<$Res> {
  _$AttendeeReportCopyWithImpl(this._self, this._then);

  final AttendeeReport _self;
  final $Res Function(AttendeeReport) _then;

/// Create a copy of AttendeeReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? report = freezed,Object? reportLink = freezed,}) {
  return _then(_self.copyWith(
report: freezed == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as String?,reportLink: freezed == reportLink ? _self.reportLink : reportLink // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendeeReport].
extension AttendeeReportPatterns on AttendeeReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendeeReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendeeReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendeeReport value)  $default,){
final _that = this;
switch (_that) {
case _AttendeeReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendeeReport value)?  $default,){
final _that = this;
switch (_that) {
case _AttendeeReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? report,  String? reportLink)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendeeReport() when $default != null:
return $default(_that.report,_that.reportLink);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? report,  String? reportLink)  $default,) {final _that = this;
switch (_that) {
case _AttendeeReport():
return $default(_that.report,_that.reportLink);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? report,  String? reportLink)?  $default,) {final _that = this;
switch (_that) {
case _AttendeeReport() when $default != null:
return $default(_that.report,_that.reportLink);case _:
  return null;

}
}

}

/// @nodoc


class _AttendeeReport implements AttendeeReport {
  const _AttendeeReport({this.report, this.reportLink});
  

@override final  String? report;
@override final  String? reportLink;

/// Create a copy of AttendeeReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendeeReportCopyWith<_AttendeeReport> get copyWith => __$AttendeeReportCopyWithImpl<_AttendeeReport>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendeeReport&&(identical(other.report, report) || other.report == report)&&(identical(other.reportLink, reportLink) || other.reportLink == reportLink));
}


@override
int get hashCode => Object.hash(runtimeType,report,reportLink);

@override
String toString() {
  return 'AttendeeReport(report: $report, reportLink: $reportLink)';
}


}

/// @nodoc
abstract mixin class _$AttendeeReportCopyWith<$Res> implements $AttendeeReportCopyWith<$Res> {
  factory _$AttendeeReportCopyWith(_AttendeeReport value, $Res Function(_AttendeeReport) _then) = __$AttendeeReportCopyWithImpl;
@override @useResult
$Res call({
 String? report, String? reportLink
});




}
/// @nodoc
class __$AttendeeReportCopyWithImpl<$Res>
    implements _$AttendeeReportCopyWith<$Res> {
  __$AttendeeReportCopyWithImpl(this._self, this._then);

  final _AttendeeReport _self;
  final $Res Function(_AttendeeReport) _then;

/// Create a copy of AttendeeReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? report = freezed,Object? reportLink = freezed,}) {
  return _then(_AttendeeReport(
report: freezed == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as String?,reportLink: freezed == reportLink ? _self.reportLink : reportLink // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
