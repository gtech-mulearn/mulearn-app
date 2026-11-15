// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JobRuleCheck {

/// `min_karma`, `max_karma`, `min_level`, `max_level`, `skill`.
 String get ruleType; String get ruleValue; bool get met;/// Why it isn't met ("Insufficient Karma. Minimum 500 required.").
 String? get message;
/// Create a copy of JobRuleCheck
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobRuleCheckCopyWith<JobRuleCheck> get copyWith => _$JobRuleCheckCopyWithImpl<JobRuleCheck>(this as JobRuleCheck, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as JobRuleCheck;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobRuleCheck&&(identical(other.ruleType, _this.ruleType) || other.ruleType == _this.ruleType)&&(identical(other.ruleValue, _this.ruleValue) || other.ruleValue == _this.ruleValue)&&(identical(other.met, _this.met) || other.met == _this.met)&&(identical(other.message, _this.message) || other.message == _this.message));
}


@override
int get hashCode {
  final _this = this as JobRuleCheck;
  return Object.hash(runtimeType,_this.ruleType,_this.ruleValue,_this.met,_this.message);
}

@override
String toString() {
  final _this = this as JobRuleCheck;
  return 'JobRuleCheck(ruleType: ${_this.ruleType}, ruleValue: ${_this.ruleValue}, met: ${_this.met}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $JobRuleCheckCopyWith<$Res>  {
  factory $JobRuleCheckCopyWith(JobRuleCheck value, $Res Function(JobRuleCheck) _then) = _$JobRuleCheckCopyWithImpl;
@useResult
$Res call({
 String ruleType, String ruleValue, bool met, String? message
});




}
/// @nodoc
class _$JobRuleCheckCopyWithImpl<$Res>
    implements $JobRuleCheckCopyWith<$Res> {
  _$JobRuleCheckCopyWithImpl(this._self, this._then);

  final JobRuleCheck _self;
  final $Res Function(JobRuleCheck) _then;

/// Create a copy of JobRuleCheck
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ruleType = null,Object? ruleValue = null,Object? met = null,Object? message = freezed,}) {
  return _then(JobRuleCheck(
ruleType: null == ruleType ? _self.ruleType : ruleType // ignore: cast_nullable_to_non_nullable
as String,ruleValue: null == ruleValue ? _self.ruleValue : ruleValue // ignore: cast_nullable_to_non_nullable
as String,met: null == met ? _self.met : met // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [JobRuleCheck].
extension JobRuleCheckPatterns on JobRuleCheck {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobRuleCheck value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobRuleCheck() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobRuleCheck value)  $default,){
final _that = this;
switch (_that) {
case _JobRuleCheck():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobRuleCheck value)?  $default,){
final _that = this;
switch (_that) {
case _JobRuleCheck() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ruleType,  String ruleValue,  bool met,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobRuleCheck() when $default != null:
return $default(_that.ruleType,_that.ruleValue,_that.met,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ruleType,  String ruleValue,  bool met,  String? message)  $default,) {final _that = this;
switch (_that) {
case _JobRuleCheck():
return $default(_that.ruleType,_that.ruleValue,_that.met,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ruleType,  String ruleValue,  bool met,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _JobRuleCheck() when $default != null:
return $default(_that.ruleType,_that.ruleValue,_that.met,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _JobRuleCheck implements JobRuleCheck {
  const _JobRuleCheck({required this.ruleType, required this.ruleValue, required this.met, this.message});
  

/// `min_karma`, `max_karma`, `min_level`, `max_level`, `skill`.
@override final  String ruleType;
@override final  String ruleValue;
@override final  bool met;
/// Why it isn't met ("Insufficient Karma. Minimum 500 required.").
@override final  String? message;

/// Create a copy of JobRuleCheck
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobRuleCheckCopyWith<_JobRuleCheck> get copyWith => __$JobRuleCheckCopyWithImpl<_JobRuleCheck>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobRuleCheck&&(identical(other.ruleType, ruleType) || other.ruleType == ruleType)&&(identical(other.ruleValue, ruleValue) || other.ruleValue == ruleValue)&&(identical(other.met, met) || other.met == met)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,ruleType,ruleValue,met,message);
}

@override
String toString() {
    return 'JobRuleCheck(ruleType: $ruleType, ruleValue: $ruleValue, met: $met, message: $message)';
}


}

/// @nodoc
abstract mixin class _$JobRuleCheckCopyWith<$Res> implements $JobRuleCheckCopyWith<$Res> {
  factory _$JobRuleCheckCopyWith(_JobRuleCheck value, $Res Function(_JobRuleCheck) _then) = __$JobRuleCheckCopyWithImpl;
@override @useResult
$Res call({
 String ruleType, String ruleValue, bool met, String? message
});




}
/// @nodoc
class __$JobRuleCheckCopyWithImpl<$Res>
    implements _$JobRuleCheckCopyWith<$Res> {
  __$JobRuleCheckCopyWithImpl(this._self, this._then);

  final _JobRuleCheck _self;
  final $Res Function(_JobRuleCheck) _then;

/// Create a copy of JobRuleCheck
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ruleType = null,Object? ruleValue = null,Object? met = null,Object? message = freezed,}) {
  return _then(_JobRuleCheck(
ruleType: null == ruleType ? _self.ruleType : ruleType // ignore: cast_nullable_to_non_nullable
as String,ruleValue: null == ruleValue ? _self.ruleValue : ruleValue // ignore: cast_nullable_to_non_nullable
as String,met: null == met ? _self.met : met // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$Job {

 String get id; String get title; String? get companyName; String? get companyLogo;/// Hybrid, Full-Time, Remote, Part-Time, Internship, Gig.
 String? get jobType; String? get location; String? get salaryRange; String? get stipend; String? get experience; String? get description; int? get durationValue;/// days, weeks, months.
 String? get durationUnit; String? get hourlyRate; List<String> get deliverables; bool get certificateProvided; DateTime? get createdAt; DateTime? get expiresAt;/// Null when the backend didn't check (signed out); otherwise whether
/// every rule in [checks] is met.
 bool? get eligible; List<JobRuleCheck> get checks;
/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobCopyWith<Job> get copyWith => _$JobCopyWithImpl<Job>(this as Job, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Job;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Job&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.companyName, _this.companyName) || other.companyName == _this.companyName)&&(identical(other.companyLogo, _this.companyLogo) || other.companyLogo == _this.companyLogo)&&(identical(other.jobType, _this.jobType) || other.jobType == _this.jobType)&&(identical(other.location, _this.location) || other.location == _this.location)&&(identical(other.salaryRange, _this.salaryRange) || other.salaryRange == _this.salaryRange)&&(identical(other.stipend, _this.stipend) || other.stipend == _this.stipend)&&(identical(other.experience, _this.experience) || other.experience == _this.experience)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.durationValue, _this.durationValue) || other.durationValue == _this.durationValue)&&(identical(other.durationUnit, _this.durationUnit) || other.durationUnit == _this.durationUnit)&&(identical(other.hourlyRate, _this.hourlyRate) || other.hourlyRate == _this.hourlyRate)&&const DeepCollectionEquality().equals(other.deliverables, _this.deliverables)&&(identical(other.certificateProvided, _this.certificateProvided) || other.certificateProvided == _this.certificateProvided)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt)&&(identical(other.eligible, _this.eligible) || other.eligible == _this.eligible)&&const DeepCollectionEquality().equals(other.checks, _this.checks));
}


@override
int get hashCode {
  final _this = this as Job;
  return Object.hashAll([runtimeType,_this.id,_this.title,_this.companyName,_this.companyLogo,_this.jobType,_this.location,_this.salaryRange,_this.stipend,_this.experience,_this.description,_this.durationValue,_this.durationUnit,_this.hourlyRate,const DeepCollectionEquality().hash(_this.deliverables),_this.certificateProvided,_this.createdAt,_this.expiresAt,_this.eligible,const DeepCollectionEquality().hash(_this.checks)]);
}

@override
String toString() {
  final _this = this as Job;
  return 'Job(id: ${_this.id}, title: ${_this.title}, companyName: ${_this.companyName}, companyLogo: ${_this.companyLogo}, jobType: ${_this.jobType}, location: ${_this.location}, salaryRange: ${_this.salaryRange}, stipend: ${_this.stipend}, experience: ${_this.experience}, description: ${_this.description}, durationValue: ${_this.durationValue}, durationUnit: ${_this.durationUnit}, hourlyRate: ${_this.hourlyRate}, deliverables: ${_this.deliverables}, certificateProvided: ${_this.certificateProvided}, createdAt: ${_this.createdAt}, expiresAt: ${_this.expiresAt}, eligible: ${_this.eligible}, checks: ${_this.checks})';
}


}

/// @nodoc
abstract mixin class $JobCopyWith<$Res>  {
  factory $JobCopyWith(Job value, $Res Function(Job) _then) = _$JobCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? companyName, String? companyLogo, String? jobType, String? location, String? salaryRange, String? stipend, String? experience, String? description, int? durationValue, String? durationUnit, String? hourlyRate, List<String> deliverables, bool certificateProvided, DateTime? createdAt, DateTime? expiresAt, bool? eligible, List<JobRuleCheck> checks
});




}
/// @nodoc
class _$JobCopyWithImpl<$Res>
    implements $JobCopyWith<$Res> {
  _$JobCopyWithImpl(this._self, this._then);

  final Job _self;
  final $Res Function(Job) _then;

/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? companyName = freezed,Object? companyLogo = freezed,Object? jobType = freezed,Object? location = freezed,Object? salaryRange = freezed,Object? stipend = freezed,Object? experience = freezed,Object? description = freezed,Object? durationValue = freezed,Object? durationUnit = freezed,Object? hourlyRate = freezed,Object? deliverables = null,Object? certificateProvided = null,Object? createdAt = freezed,Object? expiresAt = freezed,Object? eligible = freezed,Object? checks = null,}) {
  return _then(Job(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,companyLogo: freezed == companyLogo ? _self.companyLogo : companyLogo // ignore: cast_nullable_to_non_nullable
as String?,jobType: freezed == jobType ? _self.jobType : jobType // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,salaryRange: freezed == salaryRange ? _self.salaryRange : salaryRange // ignore: cast_nullable_to_non_nullable
as String?,stipend: freezed == stipend ? _self.stipend : stipend // ignore: cast_nullable_to_non_nullable
as String?,experience: freezed == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,durationValue: freezed == durationValue ? _self.durationValue : durationValue // ignore: cast_nullable_to_non_nullable
as int?,durationUnit: freezed == durationUnit ? _self.durationUnit : durationUnit // ignore: cast_nullable_to_non_nullable
as String?,hourlyRate: freezed == hourlyRate ? _self.hourlyRate : hourlyRate // ignore: cast_nullable_to_non_nullable
as String?,deliverables: null == deliverables ? _self.deliverables : deliverables // ignore: cast_nullable_to_non_nullable
as List<String>,certificateProvided: null == certificateProvided ? _self.certificateProvided : certificateProvided // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,eligible: freezed == eligible ? _self.eligible : eligible // ignore: cast_nullable_to_non_nullable
as bool?,checks: null == checks ? _self.checks : checks // ignore: cast_nullable_to_non_nullable
as List<JobRuleCheck>,
  ));
}

}


/// Adds pattern-matching-related methods to [Job].
extension JobPatterns on Job {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Job value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Job() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Job value)  $default,){
final _that = this;
switch (_that) {
case _Job():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Job value)?  $default,){
final _that = this;
switch (_that) {
case _Job() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? companyName,  String? companyLogo,  String? jobType,  String? location,  String? salaryRange,  String? stipend,  String? experience,  String? description,  int? durationValue,  String? durationUnit,  String? hourlyRate,  List<String> deliverables,  bool certificateProvided,  DateTime? createdAt,  DateTime? expiresAt,  bool? eligible,  List<JobRuleCheck> checks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Job() when $default != null:
return $default(_that.id,_that.title,_that.companyName,_that.companyLogo,_that.jobType,_that.location,_that.salaryRange,_that.stipend,_that.experience,_that.description,_that.durationValue,_that.durationUnit,_that.hourlyRate,_that.deliverables,_that.certificateProvided,_that.createdAt,_that.expiresAt,_that.eligible,_that.checks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? companyName,  String? companyLogo,  String? jobType,  String? location,  String? salaryRange,  String? stipend,  String? experience,  String? description,  int? durationValue,  String? durationUnit,  String? hourlyRate,  List<String> deliverables,  bool certificateProvided,  DateTime? createdAt,  DateTime? expiresAt,  bool? eligible,  List<JobRuleCheck> checks)  $default,) {final _that = this;
switch (_that) {
case _Job():
return $default(_that.id,_that.title,_that.companyName,_that.companyLogo,_that.jobType,_that.location,_that.salaryRange,_that.stipend,_that.experience,_that.description,_that.durationValue,_that.durationUnit,_that.hourlyRate,_that.deliverables,_that.certificateProvided,_that.createdAt,_that.expiresAt,_that.eligible,_that.checks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? companyName,  String? companyLogo,  String? jobType,  String? location,  String? salaryRange,  String? stipend,  String? experience,  String? description,  int? durationValue,  String? durationUnit,  String? hourlyRate,  List<String> deliverables,  bool certificateProvided,  DateTime? createdAt,  DateTime? expiresAt,  bool? eligible,  List<JobRuleCheck> checks)?  $default,) {final _that = this;
switch (_that) {
case _Job() when $default != null:
return $default(_that.id,_that.title,_that.companyName,_that.companyLogo,_that.jobType,_that.location,_that.salaryRange,_that.stipend,_that.experience,_that.description,_that.durationValue,_that.durationUnit,_that.hourlyRate,_that.deliverables,_that.certificateProvided,_that.createdAt,_that.expiresAt,_that.eligible,_that.checks);case _:
  return null;

}
}

}

/// @nodoc


class _Job implements Job {
  const _Job({required this.id, required this.title, this.companyName, this.companyLogo, this.jobType, this.location, this.salaryRange, this.stipend, this.experience, this.description, this.durationValue, this.durationUnit, this.hourlyRate,  List<String> deliverables = const <String>[], this.certificateProvided = false, this.createdAt, this.expiresAt, this.eligible,  List<JobRuleCheck> checks = const <JobRuleCheck>[]}): _deliverables = deliverables,_checks = checks;
  

@override final  String id;
@override final  String title;
@override final  String? companyName;
@override final  String? companyLogo;
/// Hybrid, Full-Time, Remote, Part-Time, Internship, Gig.
@override final  String? jobType;
@override final  String? location;
@override final  String? salaryRange;
@override final  String? stipend;
@override final  String? experience;
@override final  String? description;
@override final  int? durationValue;
/// days, weeks, months.
@override final  String? durationUnit;
@override final  String? hourlyRate;
 final  List<String> _deliverables;
@override@JsonKey() List<String> get deliverables {
  if (_deliverables is EqualUnmodifiableListView) return _deliverables;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_deliverables);
}

@override@JsonKey() final  bool certificateProvided;
@override final  DateTime? createdAt;
@override final  DateTime? expiresAt;
/// Null when the backend didn't check (signed out); otherwise whether
/// every rule in [checks] is met.
@override final  bool? eligible;
 final  List<JobRuleCheck> _checks;
@override@JsonKey() List<JobRuleCheck> get checks {
  if (_checks is EqualUnmodifiableListView) return _checks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_checks);
}


/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobCopyWith<_Job> get copyWith => __$JobCopyWithImpl<_Job>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Job&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.companyLogo, companyLogo) || other.companyLogo == companyLogo)&&(identical(other.jobType, jobType) || other.jobType == jobType)&&(identical(other.location, location) || other.location == location)&&(identical(other.salaryRange, salaryRange) || other.salaryRange == salaryRange)&&(identical(other.stipend, stipend) || other.stipend == stipend)&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.description, description) || other.description == description)&&(identical(other.durationValue, durationValue) || other.durationValue == durationValue)&&(identical(other.durationUnit, durationUnit) || other.durationUnit == durationUnit)&&(identical(other.hourlyRate, hourlyRate) || other.hourlyRate == hourlyRate)&&const DeepCollectionEquality().equals(other.deliverables, _deliverables)&&(identical(other.certificateProvided, certificateProvided) || other.certificateProvided == certificateProvided)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.eligible, eligible) || other.eligible == eligible)&&const DeepCollectionEquality().equals(other.checks, _checks));
}


@override
int get hashCode {
    return Object.hashAll([runtimeType,id,title,companyName,companyLogo,jobType,location,salaryRange,stipend,experience,description,durationValue,durationUnit,hourlyRate,const DeepCollectionEquality().hash(_deliverables),certificateProvided,createdAt,expiresAt,eligible,const DeepCollectionEquality().hash(_checks)]);
}

@override
String toString() {
    return 'Job(id: $id, title: $title, companyName: $companyName, companyLogo: $companyLogo, jobType: $jobType, location: $location, salaryRange: $salaryRange, stipend: $stipend, experience: $experience, description: $description, durationValue: $durationValue, durationUnit: $durationUnit, hourlyRate: $hourlyRate, deliverables: $deliverables, certificateProvided: $certificateProvided, createdAt: $createdAt, expiresAt: $expiresAt, eligible: $eligible, checks: $checks)';
}


}

/// @nodoc
abstract mixin class _$JobCopyWith<$Res> implements $JobCopyWith<$Res> {
  factory _$JobCopyWith(_Job value, $Res Function(_Job) _then) = __$JobCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? companyName, String? companyLogo, String? jobType, String? location, String? salaryRange, String? stipend, String? experience, String? description, int? durationValue, String? durationUnit, String? hourlyRate, List<String> deliverables, bool certificateProvided, DateTime? createdAt, DateTime? expiresAt, bool? eligible, List<JobRuleCheck> checks
});




}
/// @nodoc
class __$JobCopyWithImpl<$Res>
    implements _$JobCopyWith<$Res> {
  __$JobCopyWithImpl(this._self, this._then);

  final _Job _self;
  final $Res Function(_Job) _then;

/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? companyName = freezed,Object? companyLogo = freezed,Object? jobType = freezed,Object? location = freezed,Object? salaryRange = freezed,Object? stipend = freezed,Object? experience = freezed,Object? description = freezed,Object? durationValue = freezed,Object? durationUnit = freezed,Object? hourlyRate = freezed,Object? deliverables = null,Object? certificateProvided = null,Object? createdAt = freezed,Object? expiresAt = freezed,Object? eligible = freezed,Object? checks = null,}) {
  return _then(_Job(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,companyLogo: freezed == companyLogo ? _self.companyLogo : companyLogo // ignore: cast_nullable_to_non_nullable
as String?,jobType: freezed == jobType ? _self.jobType : jobType // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,salaryRange: freezed == salaryRange ? _self.salaryRange : salaryRange // ignore: cast_nullable_to_non_nullable
as String?,stipend: freezed == stipend ? _self.stipend : stipend // ignore: cast_nullable_to_non_nullable
as String?,experience: freezed == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,durationValue: freezed == durationValue ? _self.durationValue : durationValue // ignore: cast_nullable_to_non_nullable
as int?,durationUnit: freezed == durationUnit ? _self.durationUnit : durationUnit // ignore: cast_nullable_to_non_nullable
as String?,hourlyRate: freezed == hourlyRate ? _self.hourlyRate : hourlyRate // ignore: cast_nullable_to_non_nullable
as String?,deliverables: null == deliverables ? _self._deliverables : deliverables // ignore: cast_nullable_to_non_nullable
as List<String>,certificateProvided: null == certificateProvided ? _self.certificateProvided : certificateProvided // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,eligible: freezed == eligible ? _self.eligible : eligible // ignore: cast_nullable_to_non_nullable
as bool?,checks: null == checks ? _self._checks : checks // ignore: cast_nullable_to_non_nullable
as List<JobRuleCheck>,
  ));
}


}

/// @nodoc
mixin _$JobApplication {

 String get id; Job get job; ApplicationStatus get status;/// The backend's own word, for anything [status] doesn't name.
 String get rawStatus; String? get resumeLink; String? get coverLetter; String? get rejectionReason; DateTime? get appliedAt;
/// Create a copy of JobApplication
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobApplicationCopyWith<JobApplication> get copyWith => _$JobApplicationCopyWithImpl<JobApplication>(this as JobApplication, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as JobApplication;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobApplication&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.job, _this.job) || other.job == _this.job)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.rawStatus, _this.rawStatus) || other.rawStatus == _this.rawStatus)&&(identical(other.resumeLink, _this.resumeLink) || other.resumeLink == _this.resumeLink)&&(identical(other.coverLetter, _this.coverLetter) || other.coverLetter == _this.coverLetter)&&(identical(other.rejectionReason, _this.rejectionReason) || other.rejectionReason == _this.rejectionReason)&&(identical(other.appliedAt, _this.appliedAt) || other.appliedAt == _this.appliedAt));
}


@override
int get hashCode {
  final _this = this as JobApplication;
  return Object.hash(runtimeType,_this.id,_this.job,_this.status,_this.rawStatus,_this.resumeLink,_this.coverLetter,_this.rejectionReason,_this.appliedAt);
}

@override
String toString() {
  final _this = this as JobApplication;
  return 'JobApplication(id: ${_this.id}, job: ${_this.job}, status: ${_this.status}, rawStatus: ${_this.rawStatus}, resumeLink: ${_this.resumeLink}, coverLetter: ${_this.coverLetter}, rejectionReason: ${_this.rejectionReason}, appliedAt: ${_this.appliedAt})';
}


}

/// @nodoc
abstract mixin class $JobApplicationCopyWith<$Res>  {
  factory $JobApplicationCopyWith(JobApplication value, $Res Function(JobApplication) _then) = _$JobApplicationCopyWithImpl;
@useResult
$Res call({
 String id, Job job, ApplicationStatus status, String rawStatus, String? resumeLink, String? coverLetter, String? rejectionReason, DateTime? appliedAt
});


$JobCopyWith<$Res> get job;

}
/// @nodoc
class _$JobApplicationCopyWithImpl<$Res>
    implements $JobApplicationCopyWith<$Res> {
  _$JobApplicationCopyWithImpl(this._self, this._then);

  final JobApplication _self;
  final $Res Function(JobApplication) _then;

/// Create a copy of JobApplication
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? job = null,Object? status = null,Object? rawStatus = null,Object? resumeLink = freezed,Object? coverLetter = freezed,Object? rejectionReason = freezed,Object? appliedAt = freezed,}) {
  return _then(JobApplication(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,job: null == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as Job,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApplicationStatus,rawStatus: null == rawStatus ? _self.rawStatus : rawStatus // ignore: cast_nullable_to_non_nullable
as String,resumeLink: freezed == resumeLink ? _self.resumeLink : resumeLink // ignore: cast_nullable_to_non_nullable
as String?,coverLetter: freezed == coverLetter ? _self.coverLetter : coverLetter // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,appliedAt: freezed == appliedAt ? _self.appliedAt : appliedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of JobApplication
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobCopyWith<$Res> get job {
  
  return $JobCopyWith<$Res>(_self.job, (value) {
    return _then(_self.copyWith(job: value));
  });
}
}


/// Adds pattern-matching-related methods to [JobApplication].
extension JobApplicationPatterns on JobApplication {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobApplication value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobApplication() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobApplication value)  $default,){
final _that = this;
switch (_that) {
case _JobApplication():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobApplication value)?  $default,){
final _that = this;
switch (_that) {
case _JobApplication() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  Job job,  ApplicationStatus status,  String rawStatus,  String? resumeLink,  String? coverLetter,  String? rejectionReason,  DateTime? appliedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobApplication() when $default != null:
return $default(_that.id,_that.job,_that.status,_that.rawStatus,_that.resumeLink,_that.coverLetter,_that.rejectionReason,_that.appliedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  Job job,  ApplicationStatus status,  String rawStatus,  String? resumeLink,  String? coverLetter,  String? rejectionReason,  DateTime? appliedAt)  $default,) {final _that = this;
switch (_that) {
case _JobApplication():
return $default(_that.id,_that.job,_that.status,_that.rawStatus,_that.resumeLink,_that.coverLetter,_that.rejectionReason,_that.appliedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  Job job,  ApplicationStatus status,  String rawStatus,  String? resumeLink,  String? coverLetter,  String? rejectionReason,  DateTime? appliedAt)?  $default,) {final _that = this;
switch (_that) {
case _JobApplication() when $default != null:
return $default(_that.id,_that.job,_that.status,_that.rawStatus,_that.resumeLink,_that.coverLetter,_that.rejectionReason,_that.appliedAt);case _:
  return null;

}
}

}

/// @nodoc


class _JobApplication implements JobApplication {
  const _JobApplication({required this.id, required this.job, required this.status, required this.rawStatus, this.resumeLink, this.coverLetter, this.rejectionReason, this.appliedAt});
  

@override final  String id;
@override final  Job job;
@override final  ApplicationStatus status;
/// The backend's own word, for anything [status] doesn't name.
@override final  String rawStatus;
@override final  String? resumeLink;
@override final  String? coverLetter;
@override final  String? rejectionReason;
@override final  DateTime? appliedAt;

/// Create a copy of JobApplication
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobApplicationCopyWith<_JobApplication> get copyWith => __$JobApplicationCopyWithImpl<_JobApplication>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobApplication&&(identical(other.id, id) || other.id == id)&&(identical(other.job, job) || other.job == job)&&(identical(other.status, status) || other.status == status)&&(identical(other.rawStatus, rawStatus) || other.rawStatus == rawStatus)&&(identical(other.resumeLink, resumeLink) || other.resumeLink == resumeLink)&&(identical(other.coverLetter, coverLetter) || other.coverLetter == coverLetter)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.appliedAt, appliedAt) || other.appliedAt == appliedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,job,status,rawStatus,resumeLink,coverLetter,rejectionReason,appliedAt);
}

@override
String toString() {
    return 'JobApplication(id: $id, job: $job, status: $status, rawStatus: $rawStatus, resumeLink: $resumeLink, coverLetter: $coverLetter, rejectionReason: $rejectionReason, appliedAt: $appliedAt)';
}


}

/// @nodoc
abstract mixin class _$JobApplicationCopyWith<$Res> implements $JobApplicationCopyWith<$Res> {
  factory _$JobApplicationCopyWith(_JobApplication value, $Res Function(_JobApplication) _then) = __$JobApplicationCopyWithImpl;
@override @useResult
$Res call({
 String id, Job job, ApplicationStatus status, String rawStatus, String? resumeLink, String? coverLetter, String? rejectionReason, DateTime? appliedAt
});


@override $JobCopyWith<$Res> get job;

}
/// @nodoc
class __$JobApplicationCopyWithImpl<$Res>
    implements _$JobApplicationCopyWith<$Res> {
  __$JobApplicationCopyWithImpl(this._self, this._then);

  final _JobApplication _self;
  final $Res Function(_JobApplication) _then;

/// Create a copy of JobApplication
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? job = null,Object? status = null,Object? rawStatus = null,Object? resumeLink = freezed,Object? coverLetter = freezed,Object? rejectionReason = freezed,Object? appliedAt = freezed,}) {
  return _then(_JobApplication(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,job: null == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as Job,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApplicationStatus,rawStatus: null == rawStatus ? _self.rawStatus : rawStatus // ignore: cast_nullable_to_non_nullable
as String,resumeLink: freezed == resumeLink ? _self.resumeLink : resumeLink // ignore: cast_nullable_to_non_nullable
as String?,coverLetter: freezed == coverLetter ? _self.coverLetter : coverLetter // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,appliedAt: freezed == appliedAt ? _self.appliedAt : appliedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of JobApplication
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobCopyWith<$Res> get job {
  
  return $JobCopyWith<$Res>(_self.job, (value) {
    return _then(_self.copyWith(job: value));
  });
}
}

/// @nodoc
mixin _$OpportunityPage<T> {

 List<T> get items; bool get hasNext; int get count;
/// Create a copy of OpportunityPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpportunityPageCopyWith<T, OpportunityPage<T>> get copyWith => _$OpportunityPageCopyWithImpl<T, OpportunityPage<T>>(this as OpportunityPage<T>, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as OpportunityPage<T>;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpportunityPage<T>&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.hasNext, _this.hasNext) || other.hasNext == _this.hasNext)&&(identical(other.count, _this.count) || other.count == _this.count));
}


@override
int get hashCode {
  final _this = this as OpportunityPage<T>;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.hasNext,_this.count);
}

@override
String toString() {
  final _this = this as OpportunityPage<T>;
  return 'OpportunityPage<$T>(items: ${_this.items}, hasNext: ${_this.hasNext}, count: ${_this.count})';
}


}

/// @nodoc
abstract mixin class $OpportunityPageCopyWith<T,$Res>  {
  factory $OpportunityPageCopyWith(OpportunityPage<T> value, $Res Function(OpportunityPage<T>) _then) = _$OpportunityPageCopyWithImpl;
@useResult
$Res call({
 List<T> items, bool hasNext, int count
});




}
/// @nodoc
class _$OpportunityPageCopyWithImpl<T,$Res>
    implements $OpportunityPageCopyWith<T, $Res> {
  _$OpportunityPageCopyWithImpl(this._self, this._then);

  final OpportunityPage<T> _self;
  final $Res Function(OpportunityPage<T>) _then;

/// Create a copy of OpportunityPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? hasNext = null,Object? count = null,}) {
  return _then(OpportunityPage(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<T>,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OpportunityPage].
extension OpportunityPagePatterns<T> on OpportunityPage<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpportunityPage<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpportunityPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpportunityPage<T> value)  $default,){
final _that = this;
switch (_that) {
case _OpportunityPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpportunityPage<T> value)?  $default,){
final _that = this;
switch (_that) {
case _OpportunityPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<T> items,  bool hasNext,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpportunityPage() when $default != null:
return $default(_that.items,_that.hasNext,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<T> items,  bool hasNext,  int count)  $default,) {final _that = this;
switch (_that) {
case _OpportunityPage():
return $default(_that.items,_that.hasNext,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<T> items,  bool hasNext,  int count)?  $default,) {final _that = this;
switch (_that) {
case _OpportunityPage() when $default != null:
return $default(_that.items,_that.hasNext,_that.count);case _:
  return null;

}
}

}

/// @nodoc


class _OpportunityPage<T> implements OpportunityPage<T> {
  const _OpportunityPage({required  List<T> items, required this.hasNext, required this.count}): _items = items;
  

 final  List<T> _items;
@override List<T> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  bool hasNext;
@override final  int count;

/// Create a copy of OpportunityPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpportunityPageCopyWith<T, _OpportunityPage<T>> get copyWith => __$OpportunityPageCopyWithImpl<T, _OpportunityPage<T>>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpportunityPage<T>&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),hasNext,count);
}

@override
String toString() {
    return 'OpportunityPage<$T>(items: $items, hasNext: $hasNext, count: $count)';
}


}

/// @nodoc
abstract mixin class _$OpportunityPageCopyWith<T,$Res> implements $OpportunityPageCopyWith<T, $Res> {
  factory _$OpportunityPageCopyWith(_OpportunityPage<T> value, $Res Function(_OpportunityPage<T>) _then) = __$OpportunityPageCopyWithImpl;
@override @useResult
$Res call({
 List<T> items, bool hasNext, int count
});




}
/// @nodoc
class __$OpportunityPageCopyWithImpl<T,$Res>
    implements _$OpportunityPageCopyWith<T, $Res> {
  __$OpportunityPageCopyWithImpl(this._self, this._then);

  final _OpportunityPage<T> _self;
  final $Res Function(_OpportunityPage<T>) _then;

/// Create a copy of OpportunityPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? hasNext = null,Object? count = null,}) {
  return _then(_OpportunityPage<T>(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<T>,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
