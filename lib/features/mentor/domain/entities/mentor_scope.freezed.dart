// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mentor_scope.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MentorScope {

 MentorScopeType get type; String get id; String get name; MentorScopeMetrics get metrics;
/// Create a copy of MentorScope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MentorScopeCopyWith<MentorScope> get copyWith => _$MentorScopeCopyWithImpl<MentorScope>(this as MentorScope, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MentorScope&&(identical(other.type, type) || other.type == type)&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.metrics, metrics) || other.metrics == metrics));
}


@override
int get hashCode => Object.hash(runtimeType,type,id,name,metrics);

@override
String toString() {
  return 'MentorScope(type: $type, id: $id, name: $name, metrics: $metrics)';
}


}

/// @nodoc
abstract mixin class $MentorScopeCopyWith<$Res>  {
  factory $MentorScopeCopyWith(MentorScope value, $Res Function(MentorScope) _then) = _$MentorScopeCopyWithImpl;
@useResult
$Res call({
 MentorScopeType type, String id, String name, MentorScopeMetrics metrics
});


$MentorScopeMetricsCopyWith<$Res> get metrics;

}
/// @nodoc
class _$MentorScopeCopyWithImpl<$Res>
    implements $MentorScopeCopyWith<$Res> {
  _$MentorScopeCopyWithImpl(this._self, this._then);

  final MentorScope _self;
  final $Res Function(MentorScope) _then;

/// Create a copy of MentorScope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? id = null,Object? name = null,Object? metrics = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MentorScopeType,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as MentorScopeMetrics,
  ));
}
/// Create a copy of MentorScope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MentorScopeMetricsCopyWith<$Res> get metrics {
  
  return $MentorScopeMetricsCopyWith<$Res>(_self.metrics, (value) {
    return _then(_self.copyWith(metrics: value));
  });
}
}


/// Adds pattern-matching-related methods to [MentorScope].
extension MentorScopePatterns on MentorScope {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MentorScope value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MentorScope() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MentorScope value)  $default,){
final _that = this;
switch (_that) {
case _MentorScope():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MentorScope value)?  $default,){
final _that = this;
switch (_that) {
case _MentorScope() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MentorScopeType type,  String id,  String name,  MentorScopeMetrics metrics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MentorScope() when $default != null:
return $default(_that.type,_that.id,_that.name,_that.metrics);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MentorScopeType type,  String id,  String name,  MentorScopeMetrics metrics)  $default,) {final _that = this;
switch (_that) {
case _MentorScope():
return $default(_that.type,_that.id,_that.name,_that.metrics);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MentorScopeType type,  String id,  String name,  MentorScopeMetrics metrics)?  $default,) {final _that = this;
switch (_that) {
case _MentorScope() when $default != null:
return $default(_that.type,_that.id,_that.name,_that.metrics);case _:
  return null;

}
}

}

/// @nodoc


class _MentorScope implements MentorScope {
  const _MentorScope({required this.type, required this.id, required this.name, required this.metrics});
  

@override final  MentorScopeType type;
@override final  String id;
@override final  String name;
@override final  MentorScopeMetrics metrics;

/// Create a copy of MentorScope
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MentorScopeCopyWith<_MentorScope> get copyWith => __$MentorScopeCopyWithImpl<_MentorScope>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MentorScope&&(identical(other.type, type) || other.type == type)&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.metrics, metrics) || other.metrics == metrics));
}


@override
int get hashCode => Object.hash(runtimeType,type,id,name,metrics);

@override
String toString() {
  return 'MentorScope(type: $type, id: $id, name: $name, metrics: $metrics)';
}


}

/// @nodoc
abstract mixin class _$MentorScopeCopyWith<$Res> implements $MentorScopeCopyWith<$Res> {
  factory _$MentorScopeCopyWith(_MentorScope value, $Res Function(_MentorScope) _then) = __$MentorScopeCopyWithImpl;
@override @useResult
$Res call({
 MentorScopeType type, String id, String name, MentorScopeMetrics metrics
});


@override $MentorScopeMetricsCopyWith<$Res> get metrics;

}
/// @nodoc
class __$MentorScopeCopyWithImpl<$Res>
    implements _$MentorScopeCopyWith<$Res> {
  __$MentorScopeCopyWithImpl(this._self, this._then);

  final _MentorScope _self;
  final $Res Function(_MentorScope) _then;

/// Create a copy of MentorScope
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? id = null,Object? name = null,Object? metrics = null,}) {
  return _then(_MentorScope(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MentorScopeType,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as MentorScopeMetrics,
  ));
}

/// Create a copy of MentorScope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MentorScopeMetricsCopyWith<$Res> get metrics {
  
  return $MentorScopeMetricsCopyWith<$Res>(_self.metrics, (value) {
    return _then(_self.copyWith(metrics: value));
  });
}
}

/// @nodoc
mixin _$MentorScopeMetrics {

 int get totalIgLearners; int get activeIgLearners; int get upcomingSessions; int get completedSessions; int get pendingTasks; int get igLearningCircles; int get openOpportunities; int get igTasks;
/// Create a copy of MentorScopeMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MentorScopeMetricsCopyWith<MentorScopeMetrics> get copyWith => _$MentorScopeMetricsCopyWithImpl<MentorScopeMetrics>(this as MentorScopeMetrics, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MentorScopeMetrics&&(identical(other.totalIgLearners, totalIgLearners) || other.totalIgLearners == totalIgLearners)&&(identical(other.activeIgLearners, activeIgLearners) || other.activeIgLearners == activeIgLearners)&&(identical(other.upcomingSessions, upcomingSessions) || other.upcomingSessions == upcomingSessions)&&(identical(other.completedSessions, completedSessions) || other.completedSessions == completedSessions)&&(identical(other.pendingTasks, pendingTasks) || other.pendingTasks == pendingTasks)&&(identical(other.igLearningCircles, igLearningCircles) || other.igLearningCircles == igLearningCircles)&&(identical(other.openOpportunities, openOpportunities) || other.openOpportunities == openOpportunities)&&(identical(other.igTasks, igTasks) || other.igTasks == igTasks));
}


@override
int get hashCode => Object.hash(runtimeType,totalIgLearners,activeIgLearners,upcomingSessions,completedSessions,pendingTasks,igLearningCircles,openOpportunities,igTasks);

@override
String toString() {
  return 'MentorScopeMetrics(totalIgLearners: $totalIgLearners, activeIgLearners: $activeIgLearners, upcomingSessions: $upcomingSessions, completedSessions: $completedSessions, pendingTasks: $pendingTasks, igLearningCircles: $igLearningCircles, openOpportunities: $openOpportunities, igTasks: $igTasks)';
}


}

/// @nodoc
abstract mixin class $MentorScopeMetricsCopyWith<$Res>  {
  factory $MentorScopeMetricsCopyWith(MentorScopeMetrics value, $Res Function(MentorScopeMetrics) _then) = _$MentorScopeMetricsCopyWithImpl;
@useResult
$Res call({
 int totalIgLearners, int activeIgLearners, int upcomingSessions, int completedSessions, int pendingTasks, int igLearningCircles, int openOpportunities, int igTasks
});




}
/// @nodoc
class _$MentorScopeMetricsCopyWithImpl<$Res>
    implements $MentorScopeMetricsCopyWith<$Res> {
  _$MentorScopeMetricsCopyWithImpl(this._self, this._then);

  final MentorScopeMetrics _self;
  final $Res Function(MentorScopeMetrics) _then;

/// Create a copy of MentorScopeMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalIgLearners = null,Object? activeIgLearners = null,Object? upcomingSessions = null,Object? completedSessions = null,Object? pendingTasks = null,Object? igLearningCircles = null,Object? openOpportunities = null,Object? igTasks = null,}) {
  return _then(_self.copyWith(
totalIgLearners: null == totalIgLearners ? _self.totalIgLearners : totalIgLearners // ignore: cast_nullable_to_non_nullable
as int,activeIgLearners: null == activeIgLearners ? _self.activeIgLearners : activeIgLearners // ignore: cast_nullable_to_non_nullable
as int,upcomingSessions: null == upcomingSessions ? _self.upcomingSessions : upcomingSessions // ignore: cast_nullable_to_non_nullable
as int,completedSessions: null == completedSessions ? _self.completedSessions : completedSessions // ignore: cast_nullable_to_non_nullable
as int,pendingTasks: null == pendingTasks ? _self.pendingTasks : pendingTasks // ignore: cast_nullable_to_non_nullable
as int,igLearningCircles: null == igLearningCircles ? _self.igLearningCircles : igLearningCircles // ignore: cast_nullable_to_non_nullable
as int,openOpportunities: null == openOpportunities ? _self.openOpportunities : openOpportunities // ignore: cast_nullable_to_non_nullable
as int,igTasks: null == igTasks ? _self.igTasks : igTasks // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MentorScopeMetrics].
extension MentorScopeMetricsPatterns on MentorScopeMetrics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MentorScopeMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MentorScopeMetrics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MentorScopeMetrics value)  $default,){
final _that = this;
switch (_that) {
case _MentorScopeMetrics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MentorScopeMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _MentorScopeMetrics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalIgLearners,  int activeIgLearners,  int upcomingSessions,  int completedSessions,  int pendingTasks,  int igLearningCircles,  int openOpportunities,  int igTasks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MentorScopeMetrics() when $default != null:
return $default(_that.totalIgLearners,_that.activeIgLearners,_that.upcomingSessions,_that.completedSessions,_that.pendingTasks,_that.igLearningCircles,_that.openOpportunities,_that.igTasks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalIgLearners,  int activeIgLearners,  int upcomingSessions,  int completedSessions,  int pendingTasks,  int igLearningCircles,  int openOpportunities,  int igTasks)  $default,) {final _that = this;
switch (_that) {
case _MentorScopeMetrics():
return $default(_that.totalIgLearners,_that.activeIgLearners,_that.upcomingSessions,_that.completedSessions,_that.pendingTasks,_that.igLearningCircles,_that.openOpportunities,_that.igTasks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalIgLearners,  int activeIgLearners,  int upcomingSessions,  int completedSessions,  int pendingTasks,  int igLearningCircles,  int openOpportunities,  int igTasks)?  $default,) {final _that = this;
switch (_that) {
case _MentorScopeMetrics() when $default != null:
return $default(_that.totalIgLearners,_that.activeIgLearners,_that.upcomingSessions,_that.completedSessions,_that.pendingTasks,_that.igLearningCircles,_that.openOpportunities,_that.igTasks);case _:
  return null;

}
}

}

/// @nodoc


class _MentorScopeMetrics implements MentorScopeMetrics {
  const _MentorScopeMetrics({this.totalIgLearners = 0, this.activeIgLearners = 0, this.upcomingSessions = 0, this.completedSessions = 0, this.pendingTasks = 0, this.igLearningCircles = 0, this.openOpportunities = 0, this.igTasks = 0});
  

@override@JsonKey() final  int totalIgLearners;
@override@JsonKey() final  int activeIgLearners;
@override@JsonKey() final  int upcomingSessions;
@override@JsonKey() final  int completedSessions;
@override@JsonKey() final  int pendingTasks;
@override@JsonKey() final  int igLearningCircles;
@override@JsonKey() final  int openOpportunities;
@override@JsonKey() final  int igTasks;

/// Create a copy of MentorScopeMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MentorScopeMetricsCopyWith<_MentorScopeMetrics> get copyWith => __$MentorScopeMetricsCopyWithImpl<_MentorScopeMetrics>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MentorScopeMetrics&&(identical(other.totalIgLearners, totalIgLearners) || other.totalIgLearners == totalIgLearners)&&(identical(other.activeIgLearners, activeIgLearners) || other.activeIgLearners == activeIgLearners)&&(identical(other.upcomingSessions, upcomingSessions) || other.upcomingSessions == upcomingSessions)&&(identical(other.completedSessions, completedSessions) || other.completedSessions == completedSessions)&&(identical(other.pendingTasks, pendingTasks) || other.pendingTasks == pendingTasks)&&(identical(other.igLearningCircles, igLearningCircles) || other.igLearningCircles == igLearningCircles)&&(identical(other.openOpportunities, openOpportunities) || other.openOpportunities == openOpportunities)&&(identical(other.igTasks, igTasks) || other.igTasks == igTasks));
}


@override
int get hashCode => Object.hash(runtimeType,totalIgLearners,activeIgLearners,upcomingSessions,completedSessions,pendingTasks,igLearningCircles,openOpportunities,igTasks);

@override
String toString() {
  return 'MentorScopeMetrics(totalIgLearners: $totalIgLearners, activeIgLearners: $activeIgLearners, upcomingSessions: $upcomingSessions, completedSessions: $completedSessions, pendingTasks: $pendingTasks, igLearningCircles: $igLearningCircles, openOpportunities: $openOpportunities, igTasks: $igTasks)';
}


}

/// @nodoc
abstract mixin class _$MentorScopeMetricsCopyWith<$Res> implements $MentorScopeMetricsCopyWith<$Res> {
  factory _$MentorScopeMetricsCopyWith(_MentorScopeMetrics value, $Res Function(_MentorScopeMetrics) _then) = __$MentorScopeMetricsCopyWithImpl;
@override @useResult
$Res call({
 int totalIgLearners, int activeIgLearners, int upcomingSessions, int completedSessions, int pendingTasks, int igLearningCircles, int openOpportunities, int igTasks
});




}
/// @nodoc
class __$MentorScopeMetricsCopyWithImpl<$Res>
    implements _$MentorScopeMetricsCopyWith<$Res> {
  __$MentorScopeMetricsCopyWithImpl(this._self, this._then);

  final _MentorScopeMetrics _self;
  final $Res Function(_MentorScopeMetrics) _then;

/// Create a copy of MentorScopeMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalIgLearners = null,Object? activeIgLearners = null,Object? upcomingSessions = null,Object? completedSessions = null,Object? pendingTasks = null,Object? igLearningCircles = null,Object? openOpportunities = null,Object? igTasks = null,}) {
  return _then(_MentorScopeMetrics(
totalIgLearners: null == totalIgLearners ? _self.totalIgLearners : totalIgLearners // ignore: cast_nullable_to_non_nullable
as int,activeIgLearners: null == activeIgLearners ? _self.activeIgLearners : activeIgLearners // ignore: cast_nullable_to_non_nullable
as int,upcomingSessions: null == upcomingSessions ? _self.upcomingSessions : upcomingSessions // ignore: cast_nullable_to_non_nullable
as int,completedSessions: null == completedSessions ? _self.completedSessions : completedSessions // ignore: cast_nullable_to_non_nullable
as int,pendingTasks: null == pendingTasks ? _self.pendingTasks : pendingTasks // ignore: cast_nullable_to_non_nullable
as int,igLearningCircles: null == igLearningCircles ? _self.igLearningCircles : igLearningCircles // ignore: cast_nullable_to_non_nullable
as int,openOpportunities: null == openOpportunities ? _self.openOpportunities : openOpportunities // ignore: cast_nullable_to_non_nullable
as int,igTasks: null == igTasks ? _self.igTasks : igTasks // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
