// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campus_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CampusSummary {

 String get orgId; String get collegeName; String get campusCode; String get zone; List<StatCard> get stats; List<FunnelStage> get funnel; int get funnelMax; List<CircleHealth> get circleHealth; List<CampusActivity> get recentActivity;
/// Create a copy of CampusSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampusSummaryCopyWith<CampusSummary> get copyWith => _$CampusSummaryCopyWithImpl<CampusSummary>(this as CampusSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampusSummary&&(identical(other.orgId, orgId) || other.orgId == orgId)&&(identical(other.collegeName, collegeName) || other.collegeName == collegeName)&&(identical(other.campusCode, campusCode) || other.campusCode == campusCode)&&(identical(other.zone, zone) || other.zone == zone)&&const DeepCollectionEquality().equals(other.stats, stats)&&const DeepCollectionEquality().equals(other.funnel, funnel)&&(identical(other.funnelMax, funnelMax) || other.funnelMax == funnelMax)&&const DeepCollectionEquality().equals(other.circleHealth, circleHealth)&&const DeepCollectionEquality().equals(other.recentActivity, recentActivity));
}


@override
int get hashCode => Object.hash(runtimeType,orgId,collegeName,campusCode,zone,const DeepCollectionEquality().hash(stats),const DeepCollectionEquality().hash(funnel),funnelMax,const DeepCollectionEquality().hash(circleHealth),const DeepCollectionEquality().hash(recentActivity));

@override
String toString() {
  return 'CampusSummary(orgId: $orgId, collegeName: $collegeName, campusCode: $campusCode, zone: $zone, stats: $stats, funnel: $funnel, funnelMax: $funnelMax, circleHealth: $circleHealth, recentActivity: $recentActivity)';
}


}

/// @nodoc
abstract mixin class $CampusSummaryCopyWith<$Res>  {
  factory $CampusSummaryCopyWith(CampusSummary value, $Res Function(CampusSummary) _then) = _$CampusSummaryCopyWithImpl;
@useResult
$Res call({
 String orgId, String collegeName, String campusCode, String zone, List<StatCard> stats, List<FunnelStage> funnel, int funnelMax, List<CircleHealth> circleHealth, List<CampusActivity> recentActivity
});




}
/// @nodoc
class _$CampusSummaryCopyWithImpl<$Res>
    implements $CampusSummaryCopyWith<$Res> {
  _$CampusSummaryCopyWithImpl(this._self, this._then);

  final CampusSummary _self;
  final $Res Function(CampusSummary) _then;

/// Create a copy of CampusSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orgId = null,Object? collegeName = null,Object? campusCode = null,Object? zone = null,Object? stats = null,Object? funnel = null,Object? funnelMax = null,Object? circleHealth = null,Object? recentActivity = null,}) {
  return _then(_self.copyWith(
orgId: null == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String,collegeName: null == collegeName ? _self.collegeName : collegeName // ignore: cast_nullable_to_non_nullable
as String,campusCode: null == campusCode ? _self.campusCode : campusCode // ignore: cast_nullable_to_non_nullable
as String,zone: null == zone ? _self.zone : zone // ignore: cast_nullable_to_non_nullable
as String,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as List<StatCard>,funnel: null == funnel ? _self.funnel : funnel // ignore: cast_nullable_to_non_nullable
as List<FunnelStage>,funnelMax: null == funnelMax ? _self.funnelMax : funnelMax // ignore: cast_nullable_to_non_nullable
as int,circleHealth: null == circleHealth ? _self.circleHealth : circleHealth // ignore: cast_nullable_to_non_nullable
as List<CircleHealth>,recentActivity: null == recentActivity ? _self.recentActivity : recentActivity // ignore: cast_nullable_to_non_nullable
as List<CampusActivity>,
  ));
}

}


/// Adds pattern-matching-related methods to [CampusSummary].
extension CampusSummaryPatterns on CampusSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampusSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampusSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampusSummary value)  $default,){
final _that = this;
switch (_that) {
case _CampusSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampusSummary value)?  $default,){
final _that = this;
switch (_that) {
case _CampusSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String orgId,  String collegeName,  String campusCode,  String zone,  List<StatCard> stats,  List<FunnelStage> funnel,  int funnelMax,  List<CircleHealth> circleHealth,  List<CampusActivity> recentActivity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampusSummary() when $default != null:
return $default(_that.orgId,_that.collegeName,_that.campusCode,_that.zone,_that.stats,_that.funnel,_that.funnelMax,_that.circleHealth,_that.recentActivity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String orgId,  String collegeName,  String campusCode,  String zone,  List<StatCard> stats,  List<FunnelStage> funnel,  int funnelMax,  List<CircleHealth> circleHealth,  List<CampusActivity> recentActivity)  $default,) {final _that = this;
switch (_that) {
case _CampusSummary():
return $default(_that.orgId,_that.collegeName,_that.campusCode,_that.zone,_that.stats,_that.funnel,_that.funnelMax,_that.circleHealth,_that.recentActivity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String orgId,  String collegeName,  String campusCode,  String zone,  List<StatCard> stats,  List<FunnelStage> funnel,  int funnelMax,  List<CircleHealth> circleHealth,  List<CampusActivity> recentActivity)?  $default,) {final _that = this;
switch (_that) {
case _CampusSummary() when $default != null:
return $default(_that.orgId,_that.collegeName,_that.campusCode,_that.zone,_that.stats,_that.funnel,_that.funnelMax,_that.circleHealth,_that.recentActivity);case _:
  return null;

}
}

}

/// @nodoc


class _CampusSummary implements CampusSummary {
  const _CampusSummary({required this.orgId, required this.collegeName, required this.campusCode, required this.zone, required final  List<StatCard> stats, required final  List<FunnelStage> funnel, required this.funnelMax, required final  List<CircleHealth> circleHealth, required final  List<CampusActivity> recentActivity}): _stats = stats,_funnel = funnel,_circleHealth = circleHealth,_recentActivity = recentActivity;
  

@override final  String orgId;
@override final  String collegeName;
@override final  String campusCode;
@override final  String zone;
 final  List<StatCard> _stats;
@override List<StatCard> get stats {
  if (_stats is EqualUnmodifiableListView) return _stats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stats);
}

 final  List<FunnelStage> _funnel;
@override List<FunnelStage> get funnel {
  if (_funnel is EqualUnmodifiableListView) return _funnel;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_funnel);
}

@override final  int funnelMax;
 final  List<CircleHealth> _circleHealth;
@override List<CircleHealth> get circleHealth {
  if (_circleHealth is EqualUnmodifiableListView) return _circleHealth;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_circleHealth);
}

 final  List<CampusActivity> _recentActivity;
@override List<CampusActivity> get recentActivity {
  if (_recentActivity is EqualUnmodifiableListView) return _recentActivity;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentActivity);
}


/// Create a copy of CampusSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampusSummaryCopyWith<_CampusSummary> get copyWith => __$CampusSummaryCopyWithImpl<_CampusSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampusSummary&&(identical(other.orgId, orgId) || other.orgId == orgId)&&(identical(other.collegeName, collegeName) || other.collegeName == collegeName)&&(identical(other.campusCode, campusCode) || other.campusCode == campusCode)&&(identical(other.zone, zone) || other.zone == zone)&&const DeepCollectionEquality().equals(other._stats, _stats)&&const DeepCollectionEquality().equals(other._funnel, _funnel)&&(identical(other.funnelMax, funnelMax) || other.funnelMax == funnelMax)&&const DeepCollectionEquality().equals(other._circleHealth, _circleHealth)&&const DeepCollectionEquality().equals(other._recentActivity, _recentActivity));
}


@override
int get hashCode => Object.hash(runtimeType,orgId,collegeName,campusCode,zone,const DeepCollectionEquality().hash(_stats),const DeepCollectionEquality().hash(_funnel),funnelMax,const DeepCollectionEquality().hash(_circleHealth),const DeepCollectionEquality().hash(_recentActivity));

@override
String toString() {
  return 'CampusSummary(orgId: $orgId, collegeName: $collegeName, campusCode: $campusCode, zone: $zone, stats: $stats, funnel: $funnel, funnelMax: $funnelMax, circleHealth: $circleHealth, recentActivity: $recentActivity)';
}


}

/// @nodoc
abstract mixin class _$CampusSummaryCopyWith<$Res> implements $CampusSummaryCopyWith<$Res> {
  factory _$CampusSummaryCopyWith(_CampusSummary value, $Res Function(_CampusSummary) _then) = __$CampusSummaryCopyWithImpl;
@override @useResult
$Res call({
 String orgId, String collegeName, String campusCode, String zone, List<StatCard> stats, List<FunnelStage> funnel, int funnelMax, List<CircleHealth> circleHealth, List<CampusActivity> recentActivity
});




}
/// @nodoc
class __$CampusSummaryCopyWithImpl<$Res>
    implements _$CampusSummaryCopyWith<$Res> {
  __$CampusSummaryCopyWithImpl(this._self, this._then);

  final _CampusSummary _self;
  final $Res Function(_CampusSummary) _then;

/// Create a copy of CampusSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orgId = null,Object? collegeName = null,Object? campusCode = null,Object? zone = null,Object? stats = null,Object? funnel = null,Object? funnelMax = null,Object? circleHealth = null,Object? recentActivity = null,}) {
  return _then(_CampusSummary(
orgId: null == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String,collegeName: null == collegeName ? _self.collegeName : collegeName // ignore: cast_nullable_to_non_nullable
as String,campusCode: null == campusCode ? _self.campusCode : campusCode // ignore: cast_nullable_to_non_nullable
as String,zone: null == zone ? _self.zone : zone // ignore: cast_nullable_to_non_nullable
as String,stats: null == stats ? _self._stats : stats // ignore: cast_nullable_to_non_nullable
as List<StatCard>,funnel: null == funnel ? _self._funnel : funnel // ignore: cast_nullable_to_non_nullable
as List<FunnelStage>,funnelMax: null == funnelMax ? _self.funnelMax : funnelMax // ignore: cast_nullable_to_non_nullable
as int,circleHealth: null == circleHealth ? _self._circleHealth : circleHealth // ignore: cast_nullable_to_non_nullable
as List<CircleHealth>,recentActivity: null == recentActivity ? _self._recentActivity : recentActivity // ignore: cast_nullable_to_non_nullable
as List<CampusActivity>,
  ));
}


}

/// @nodoc
mixin _$StatCard {

 String get key; String get label; num? get value; num? get delta; String? get deltaType; String? get period;
/// Create a copy of StatCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatCardCopyWith<StatCard> get copyWith => _$StatCardCopyWithImpl<StatCard>(this as StatCard, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatCard&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.value, value) || other.value == value)&&(identical(other.delta, delta) || other.delta == delta)&&(identical(other.deltaType, deltaType) || other.deltaType == deltaType)&&(identical(other.period, period) || other.period == period));
}


@override
int get hashCode => Object.hash(runtimeType,key,label,value,delta,deltaType,period);

@override
String toString() {
  return 'StatCard(key: $key, label: $label, value: $value, delta: $delta, deltaType: $deltaType, period: $period)';
}


}

/// @nodoc
abstract mixin class $StatCardCopyWith<$Res>  {
  factory $StatCardCopyWith(StatCard value, $Res Function(StatCard) _then) = _$StatCardCopyWithImpl;
@useResult
$Res call({
 String key, String label, num? value, num? delta, String? deltaType, String? period
});




}
/// @nodoc
class _$StatCardCopyWithImpl<$Res>
    implements $StatCardCopyWith<$Res> {
  _$StatCardCopyWithImpl(this._self, this._then);

  final StatCard _self;
  final $Res Function(StatCard) _then;

/// Create a copy of StatCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? label = null,Object? value = freezed,Object? delta = freezed,Object? deltaType = freezed,Object? period = freezed,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num?,delta: freezed == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as num?,deltaType: freezed == deltaType ? _self.deltaType : deltaType // ignore: cast_nullable_to_non_nullable
as String?,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StatCard].
extension StatCardPatterns on StatCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatCard value)  $default,){
final _that = this;
switch (_that) {
case _StatCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatCard value)?  $default,){
final _that = this;
switch (_that) {
case _StatCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String label,  num? value,  num? delta,  String? deltaType,  String? period)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatCard() when $default != null:
return $default(_that.key,_that.label,_that.value,_that.delta,_that.deltaType,_that.period);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String label,  num? value,  num? delta,  String? deltaType,  String? period)  $default,) {final _that = this;
switch (_that) {
case _StatCard():
return $default(_that.key,_that.label,_that.value,_that.delta,_that.deltaType,_that.period);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String label,  num? value,  num? delta,  String? deltaType,  String? period)?  $default,) {final _that = this;
switch (_that) {
case _StatCard() when $default != null:
return $default(_that.key,_that.label,_that.value,_that.delta,_that.deltaType,_that.period);case _:
  return null;

}
}

}

/// @nodoc


class _StatCard implements StatCard {
  const _StatCard({required this.key, required this.label, this.value, this.delta, this.deltaType, this.period});
  

@override final  String key;
@override final  String label;
@override final  num? value;
@override final  num? delta;
@override final  String? deltaType;
@override final  String? period;

/// Create a copy of StatCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatCardCopyWith<_StatCard> get copyWith => __$StatCardCopyWithImpl<_StatCard>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatCard&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.value, value) || other.value == value)&&(identical(other.delta, delta) || other.delta == delta)&&(identical(other.deltaType, deltaType) || other.deltaType == deltaType)&&(identical(other.period, period) || other.period == period));
}


@override
int get hashCode => Object.hash(runtimeType,key,label,value,delta,deltaType,period);

@override
String toString() {
  return 'StatCard(key: $key, label: $label, value: $value, delta: $delta, deltaType: $deltaType, period: $period)';
}


}

/// @nodoc
abstract mixin class _$StatCardCopyWith<$Res> implements $StatCardCopyWith<$Res> {
  factory _$StatCardCopyWith(_StatCard value, $Res Function(_StatCard) _then) = __$StatCardCopyWithImpl;
@override @useResult
$Res call({
 String key, String label, num? value, num? delta, String? deltaType, String? period
});




}
/// @nodoc
class __$StatCardCopyWithImpl<$Res>
    implements _$StatCardCopyWith<$Res> {
  __$StatCardCopyWithImpl(this._self, this._then);

  final _StatCard _self;
  final $Res Function(_StatCard) _then;

/// Create a copy of StatCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? label = null,Object? value = freezed,Object? delta = freezed,Object? deltaType = freezed,Object? period = freezed,}) {
  return _then(_StatCard(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num?,delta: freezed == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as num?,deltaType: freezed == deltaType ? _self.deltaType : deltaType // ignore: cast_nullable_to_non_nullable
as String?,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$FunnelStage {

 String get key; String get label; int get count; double get percentage;
/// Create a copy of FunnelStage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FunnelStageCopyWith<FunnelStage> get copyWith => _$FunnelStageCopyWithImpl<FunnelStage>(this as FunnelStage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FunnelStage&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.count, count) || other.count == count)&&(identical(other.percentage, percentage) || other.percentage == percentage));
}


@override
int get hashCode => Object.hash(runtimeType,key,label,count,percentage);

@override
String toString() {
  return 'FunnelStage(key: $key, label: $label, count: $count, percentage: $percentage)';
}


}

/// @nodoc
abstract mixin class $FunnelStageCopyWith<$Res>  {
  factory $FunnelStageCopyWith(FunnelStage value, $Res Function(FunnelStage) _then) = _$FunnelStageCopyWithImpl;
@useResult
$Res call({
 String key, String label, int count, double percentage
});




}
/// @nodoc
class _$FunnelStageCopyWithImpl<$Res>
    implements $FunnelStageCopyWith<$Res> {
  _$FunnelStageCopyWithImpl(this._self, this._then);

  final FunnelStage _self;
  final $Res Function(FunnelStage) _then;

/// Create a copy of FunnelStage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? label = null,Object? count = null,Object? percentage = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [FunnelStage].
extension FunnelStagePatterns on FunnelStage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FunnelStage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FunnelStage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FunnelStage value)  $default,){
final _that = this;
switch (_that) {
case _FunnelStage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FunnelStage value)?  $default,){
final _that = this;
switch (_that) {
case _FunnelStage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String label,  int count,  double percentage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FunnelStage() when $default != null:
return $default(_that.key,_that.label,_that.count,_that.percentage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String label,  int count,  double percentage)  $default,) {final _that = this;
switch (_that) {
case _FunnelStage():
return $default(_that.key,_that.label,_that.count,_that.percentage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String label,  int count,  double percentage)?  $default,) {final _that = this;
switch (_that) {
case _FunnelStage() when $default != null:
return $default(_that.key,_that.label,_that.count,_that.percentage);case _:
  return null;

}
}

}

/// @nodoc


class _FunnelStage implements FunnelStage {
  const _FunnelStage({required this.key, required this.label, required this.count, required this.percentage});
  

@override final  String key;
@override final  String label;
@override final  int count;
@override final  double percentage;

/// Create a copy of FunnelStage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FunnelStageCopyWith<_FunnelStage> get copyWith => __$FunnelStageCopyWithImpl<_FunnelStage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FunnelStage&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.count, count) || other.count == count)&&(identical(other.percentage, percentage) || other.percentage == percentage));
}


@override
int get hashCode => Object.hash(runtimeType,key,label,count,percentage);

@override
String toString() {
  return 'FunnelStage(key: $key, label: $label, count: $count, percentage: $percentage)';
}


}

/// @nodoc
abstract mixin class _$FunnelStageCopyWith<$Res> implements $FunnelStageCopyWith<$Res> {
  factory _$FunnelStageCopyWith(_FunnelStage value, $Res Function(_FunnelStage) _then) = __$FunnelStageCopyWithImpl;
@override @useResult
$Res call({
 String key, String label, int count, double percentage
});




}
/// @nodoc
class __$FunnelStageCopyWithImpl<$Res>
    implements _$FunnelStageCopyWith<$Res> {
  __$FunnelStageCopyWithImpl(this._self, this._then);

  final _FunnelStage _self;
  final $Res Function(_FunnelStage) _then;

/// Create a copy of FunnelStage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? label = null,Object? count = null,Object? percentage = null,}) {
  return _then(_FunnelStage(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$CircleHealth {

 String get circleId; String get circleName; String get igName; int get memberCount; num get sessionsPerMonth; String get status; DateTime? get lastSessionAt;
/// Create a copy of CircleHealth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CircleHealthCopyWith<CircleHealth> get copyWith => _$CircleHealthCopyWithImpl<CircleHealth>(this as CircleHealth, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CircleHealth&&(identical(other.circleId, circleId) || other.circleId == circleId)&&(identical(other.circleName, circleName) || other.circleName == circleName)&&(identical(other.igName, igName) || other.igName == igName)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.sessionsPerMonth, sessionsPerMonth) || other.sessionsPerMonth == sessionsPerMonth)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastSessionAt, lastSessionAt) || other.lastSessionAt == lastSessionAt));
}


@override
int get hashCode => Object.hash(runtimeType,circleId,circleName,igName,memberCount,sessionsPerMonth,status,lastSessionAt);

@override
String toString() {
  return 'CircleHealth(circleId: $circleId, circleName: $circleName, igName: $igName, memberCount: $memberCount, sessionsPerMonth: $sessionsPerMonth, status: $status, lastSessionAt: $lastSessionAt)';
}


}

/// @nodoc
abstract mixin class $CircleHealthCopyWith<$Res>  {
  factory $CircleHealthCopyWith(CircleHealth value, $Res Function(CircleHealth) _then) = _$CircleHealthCopyWithImpl;
@useResult
$Res call({
 String circleId, String circleName, String igName, int memberCount, num sessionsPerMonth, String status, DateTime? lastSessionAt
});




}
/// @nodoc
class _$CircleHealthCopyWithImpl<$Res>
    implements $CircleHealthCopyWith<$Res> {
  _$CircleHealthCopyWithImpl(this._self, this._then);

  final CircleHealth _self;
  final $Res Function(CircleHealth) _then;

/// Create a copy of CircleHealth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? circleId = null,Object? circleName = null,Object? igName = null,Object? memberCount = null,Object? sessionsPerMonth = null,Object? status = null,Object? lastSessionAt = freezed,}) {
  return _then(_self.copyWith(
circleId: null == circleId ? _self.circleId : circleId // ignore: cast_nullable_to_non_nullable
as String,circleName: null == circleName ? _self.circleName : circleName // ignore: cast_nullable_to_non_nullable
as String,igName: null == igName ? _self.igName : igName // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,sessionsPerMonth: null == sessionsPerMonth ? _self.sessionsPerMonth : sessionsPerMonth // ignore: cast_nullable_to_non_nullable
as num,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,lastSessionAt: freezed == lastSessionAt ? _self.lastSessionAt : lastSessionAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CircleHealth].
extension CircleHealthPatterns on CircleHealth {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CircleHealth value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CircleHealth() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CircleHealth value)  $default,){
final _that = this;
switch (_that) {
case _CircleHealth():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CircleHealth value)?  $default,){
final _that = this;
switch (_that) {
case _CircleHealth() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String circleId,  String circleName,  String igName,  int memberCount,  num sessionsPerMonth,  String status,  DateTime? lastSessionAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CircleHealth() when $default != null:
return $default(_that.circleId,_that.circleName,_that.igName,_that.memberCount,_that.sessionsPerMonth,_that.status,_that.lastSessionAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String circleId,  String circleName,  String igName,  int memberCount,  num sessionsPerMonth,  String status,  DateTime? lastSessionAt)  $default,) {final _that = this;
switch (_that) {
case _CircleHealth():
return $default(_that.circleId,_that.circleName,_that.igName,_that.memberCount,_that.sessionsPerMonth,_that.status,_that.lastSessionAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String circleId,  String circleName,  String igName,  int memberCount,  num sessionsPerMonth,  String status,  DateTime? lastSessionAt)?  $default,) {final _that = this;
switch (_that) {
case _CircleHealth() when $default != null:
return $default(_that.circleId,_that.circleName,_that.igName,_that.memberCount,_that.sessionsPerMonth,_that.status,_that.lastSessionAt);case _:
  return null;

}
}

}

/// @nodoc


class _CircleHealth implements CircleHealth {
  const _CircleHealth({required this.circleId, required this.circleName, required this.igName, required this.memberCount, required this.sessionsPerMonth, required this.status, this.lastSessionAt});
  

@override final  String circleId;
@override final  String circleName;
@override final  String igName;
@override final  int memberCount;
@override final  num sessionsPerMonth;
@override final  String status;
@override final  DateTime? lastSessionAt;

/// Create a copy of CircleHealth
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CircleHealthCopyWith<_CircleHealth> get copyWith => __$CircleHealthCopyWithImpl<_CircleHealth>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CircleHealth&&(identical(other.circleId, circleId) || other.circleId == circleId)&&(identical(other.circleName, circleName) || other.circleName == circleName)&&(identical(other.igName, igName) || other.igName == igName)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.sessionsPerMonth, sessionsPerMonth) || other.sessionsPerMonth == sessionsPerMonth)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastSessionAt, lastSessionAt) || other.lastSessionAt == lastSessionAt));
}


@override
int get hashCode => Object.hash(runtimeType,circleId,circleName,igName,memberCount,sessionsPerMonth,status,lastSessionAt);

@override
String toString() {
  return 'CircleHealth(circleId: $circleId, circleName: $circleName, igName: $igName, memberCount: $memberCount, sessionsPerMonth: $sessionsPerMonth, status: $status, lastSessionAt: $lastSessionAt)';
}


}

/// @nodoc
abstract mixin class _$CircleHealthCopyWith<$Res> implements $CircleHealthCopyWith<$Res> {
  factory _$CircleHealthCopyWith(_CircleHealth value, $Res Function(_CircleHealth) _then) = __$CircleHealthCopyWithImpl;
@override @useResult
$Res call({
 String circleId, String circleName, String igName, int memberCount, num sessionsPerMonth, String status, DateTime? lastSessionAt
});




}
/// @nodoc
class __$CircleHealthCopyWithImpl<$Res>
    implements _$CircleHealthCopyWith<$Res> {
  __$CircleHealthCopyWithImpl(this._self, this._then);

  final _CircleHealth _self;
  final $Res Function(_CircleHealth) _then;

/// Create a copy of CircleHealth
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? circleId = null,Object? circleName = null,Object? igName = null,Object? memberCount = null,Object? sessionsPerMonth = null,Object? status = null,Object? lastSessionAt = freezed,}) {
  return _then(_CircleHealth(
circleId: null == circleId ? _self.circleId : circleId // ignore: cast_nullable_to_non_nullable
as String,circleName: null == circleName ? _self.circleName : circleName // ignore: cast_nullable_to_non_nullable
as String,igName: null == igName ? _self.igName : igName // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,sessionsPerMonth: null == sessionsPerMonth ? _self.sessionsPerMonth : sessionsPerMonth // ignore: cast_nullable_to_non_nullable
as num,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,lastSessionAt: freezed == lastSessionAt ? _self.lastSessionAt : lastSessionAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$CampusActivity {

 String get id; String get type; String get title; DateTime get createdAt; String? get actorName; String? get actorMuid;
/// Create a copy of CampusActivity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampusActivityCopyWith<CampusActivity> get copyWith => _$CampusActivityCopyWithImpl<CampusActivity>(this as CampusActivity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampusActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.actorName, actorName) || other.actorName == actorName)&&(identical(other.actorMuid, actorMuid) || other.actorMuid == actorMuid));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,title,createdAt,actorName,actorMuid);

@override
String toString() {
  return 'CampusActivity(id: $id, type: $type, title: $title, createdAt: $createdAt, actorName: $actorName, actorMuid: $actorMuid)';
}


}

/// @nodoc
abstract mixin class $CampusActivityCopyWith<$Res>  {
  factory $CampusActivityCopyWith(CampusActivity value, $Res Function(CampusActivity) _then) = _$CampusActivityCopyWithImpl;
@useResult
$Res call({
 String id, String type, String title, DateTime createdAt, String? actorName, String? actorMuid
});




}
/// @nodoc
class _$CampusActivityCopyWithImpl<$Res>
    implements $CampusActivityCopyWith<$Res> {
  _$CampusActivityCopyWithImpl(this._self, this._then);

  final CampusActivity _self;
  final $Res Function(CampusActivity) _then;

/// Create a copy of CampusActivity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? createdAt = null,Object? actorName = freezed,Object? actorMuid = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,actorName: freezed == actorName ? _self.actorName : actorName // ignore: cast_nullable_to_non_nullable
as String?,actorMuid: freezed == actorMuid ? _self.actorMuid : actorMuid // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CampusActivity].
extension CampusActivityPatterns on CampusActivity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampusActivity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampusActivity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampusActivity value)  $default,){
final _that = this;
switch (_that) {
case _CampusActivity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampusActivity value)?  $default,){
final _that = this;
switch (_that) {
case _CampusActivity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  String title,  DateTime createdAt,  String? actorName,  String? actorMuid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampusActivity() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.createdAt,_that.actorName,_that.actorMuid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  String title,  DateTime createdAt,  String? actorName,  String? actorMuid)  $default,) {final _that = this;
switch (_that) {
case _CampusActivity():
return $default(_that.id,_that.type,_that.title,_that.createdAt,_that.actorName,_that.actorMuid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  String title,  DateTime createdAt,  String? actorName,  String? actorMuid)?  $default,) {final _that = this;
switch (_that) {
case _CampusActivity() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.createdAt,_that.actorName,_that.actorMuid);case _:
  return null;

}
}

}

/// @nodoc


class _CampusActivity implements CampusActivity {
  const _CampusActivity({required this.id, required this.type, required this.title, required this.createdAt, this.actorName, this.actorMuid});
  

@override final  String id;
@override final  String type;
@override final  String title;
@override final  DateTime createdAt;
@override final  String? actorName;
@override final  String? actorMuid;

/// Create a copy of CampusActivity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampusActivityCopyWith<_CampusActivity> get copyWith => __$CampusActivityCopyWithImpl<_CampusActivity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampusActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.actorName, actorName) || other.actorName == actorName)&&(identical(other.actorMuid, actorMuid) || other.actorMuid == actorMuid));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,title,createdAt,actorName,actorMuid);

@override
String toString() {
  return 'CampusActivity(id: $id, type: $type, title: $title, createdAt: $createdAt, actorName: $actorName, actorMuid: $actorMuid)';
}


}

/// @nodoc
abstract mixin class _$CampusActivityCopyWith<$Res> implements $CampusActivityCopyWith<$Res> {
  factory _$CampusActivityCopyWith(_CampusActivity value, $Res Function(_CampusActivity) _then) = __$CampusActivityCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, String title, DateTime createdAt, String? actorName, String? actorMuid
});




}
/// @nodoc
class __$CampusActivityCopyWithImpl<$Res>
    implements _$CampusActivityCopyWith<$Res> {
  __$CampusActivityCopyWithImpl(this._self, this._then);

  final _CampusActivity _self;
  final $Res Function(_CampusActivity) _then;

/// Create a copy of CampusActivity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? createdAt = null,Object? actorName = freezed,Object? actorMuid = freezed,}) {
  return _then(_CampusActivity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,actorName: freezed == actorName ? _self.actorName : actorName // ignore: cast_nullable_to_non_nullable
as String?,actorMuid: freezed == actorMuid ? _self.actorMuid : actorMuid // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
