// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'learning_circle_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LearningCircleDetail {

 String get id; String get ig; String get title; String get description; CircleUserRef get createdBy; String? get org; bool? get isRecurring; int? get rank; int? get totalKarma; int? get totalMembers; bool? get nextMeetupScheduled; String? get nextMeetupTime;
/// Create a copy of LearningCircleDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LearningCircleDetailCopyWith<LearningCircleDetail> get copyWith => _$LearningCircleDetailCopyWithImpl<LearningCircleDetail>(this as LearningCircleDetail, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LearningCircleDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.ig, ig) || other.ig == ig)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.org, org) || other.org == org)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.totalKarma, totalKarma) || other.totalKarma == totalKarma)&&(identical(other.totalMembers, totalMembers) || other.totalMembers == totalMembers)&&(identical(other.nextMeetupScheduled, nextMeetupScheduled) || other.nextMeetupScheduled == nextMeetupScheduled)&&(identical(other.nextMeetupTime, nextMeetupTime) || other.nextMeetupTime == nextMeetupTime));
}


@override
int get hashCode => Object.hash(runtimeType,id,ig,title,description,createdBy,org,isRecurring,rank,totalKarma,totalMembers,nextMeetupScheduled,nextMeetupTime);

@override
String toString() {
  return 'LearningCircleDetail(id: $id, ig: $ig, title: $title, description: $description, createdBy: $createdBy, org: $org, isRecurring: $isRecurring, rank: $rank, totalKarma: $totalKarma, totalMembers: $totalMembers, nextMeetupScheduled: $nextMeetupScheduled, nextMeetupTime: $nextMeetupTime)';
}


}

/// @nodoc
abstract mixin class $LearningCircleDetailCopyWith<$Res>  {
  factory $LearningCircleDetailCopyWith(LearningCircleDetail value, $Res Function(LearningCircleDetail) _then) = _$LearningCircleDetailCopyWithImpl;
@useResult
$Res call({
 String id, String ig, String title, String description, CircleUserRef createdBy, String? org, bool? isRecurring, int? rank, int? totalKarma, int? totalMembers, bool? nextMeetupScheduled, String? nextMeetupTime
});


$CircleUserRefCopyWith<$Res> get createdBy;

}
/// @nodoc
class _$LearningCircleDetailCopyWithImpl<$Res>
    implements $LearningCircleDetailCopyWith<$Res> {
  _$LearningCircleDetailCopyWithImpl(this._self, this._then);

  final LearningCircleDetail _self;
  final $Res Function(LearningCircleDetail) _then;

/// Create a copy of LearningCircleDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ig = null,Object? title = null,Object? description = null,Object? createdBy = null,Object? org = freezed,Object? isRecurring = freezed,Object? rank = freezed,Object? totalKarma = freezed,Object? totalMembers = freezed,Object? nextMeetupScheduled = freezed,Object? nextMeetupTime = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ig: null == ig ? _self.ig : ig // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as CircleUserRef,org: freezed == org ? _self.org : org // ignore: cast_nullable_to_non_nullable
as String?,isRecurring: freezed == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool?,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int?,totalKarma: freezed == totalKarma ? _self.totalKarma : totalKarma // ignore: cast_nullable_to_non_nullable
as int?,totalMembers: freezed == totalMembers ? _self.totalMembers : totalMembers // ignore: cast_nullable_to_non_nullable
as int?,nextMeetupScheduled: freezed == nextMeetupScheduled ? _self.nextMeetupScheduled : nextMeetupScheduled // ignore: cast_nullable_to_non_nullable
as bool?,nextMeetupTime: freezed == nextMeetupTime ? _self.nextMeetupTime : nextMeetupTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of LearningCircleDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CircleUserRefCopyWith<$Res> get createdBy {
  
  return $CircleUserRefCopyWith<$Res>(_self.createdBy, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [LearningCircleDetail].
extension LearningCircleDetailPatterns on LearningCircleDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LearningCircleDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LearningCircleDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LearningCircleDetail value)  $default,){
final _that = this;
switch (_that) {
case _LearningCircleDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LearningCircleDetail value)?  $default,){
final _that = this;
switch (_that) {
case _LearningCircleDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ig,  String title,  String description,  CircleUserRef createdBy,  String? org,  bool? isRecurring,  int? rank,  int? totalKarma,  int? totalMembers,  bool? nextMeetupScheduled,  String? nextMeetupTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LearningCircleDetail() when $default != null:
return $default(_that.id,_that.ig,_that.title,_that.description,_that.createdBy,_that.org,_that.isRecurring,_that.rank,_that.totalKarma,_that.totalMembers,_that.nextMeetupScheduled,_that.nextMeetupTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ig,  String title,  String description,  CircleUserRef createdBy,  String? org,  bool? isRecurring,  int? rank,  int? totalKarma,  int? totalMembers,  bool? nextMeetupScheduled,  String? nextMeetupTime)  $default,) {final _that = this;
switch (_that) {
case _LearningCircleDetail():
return $default(_that.id,_that.ig,_that.title,_that.description,_that.createdBy,_that.org,_that.isRecurring,_that.rank,_that.totalKarma,_that.totalMembers,_that.nextMeetupScheduled,_that.nextMeetupTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ig,  String title,  String description,  CircleUserRef createdBy,  String? org,  bool? isRecurring,  int? rank,  int? totalKarma,  int? totalMembers,  bool? nextMeetupScheduled,  String? nextMeetupTime)?  $default,) {final _that = this;
switch (_that) {
case _LearningCircleDetail() when $default != null:
return $default(_that.id,_that.ig,_that.title,_that.description,_that.createdBy,_that.org,_that.isRecurring,_that.rank,_that.totalKarma,_that.totalMembers,_that.nextMeetupScheduled,_that.nextMeetupTime);case _:
  return null;

}
}

}

/// @nodoc


class _LearningCircleDetail implements LearningCircleDetail {
  const _LearningCircleDetail({required this.id, required this.ig, required this.title, required this.description, required this.createdBy, this.org, this.isRecurring, this.rank, this.totalKarma, this.totalMembers, this.nextMeetupScheduled, this.nextMeetupTime});
  

@override final  String id;
@override final  String ig;
@override final  String title;
@override final  String description;
@override final  CircleUserRef createdBy;
@override final  String? org;
@override final  bool? isRecurring;
@override final  int? rank;
@override final  int? totalKarma;
@override final  int? totalMembers;
@override final  bool? nextMeetupScheduled;
@override final  String? nextMeetupTime;

/// Create a copy of LearningCircleDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LearningCircleDetailCopyWith<_LearningCircleDetail> get copyWith => __$LearningCircleDetailCopyWithImpl<_LearningCircleDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LearningCircleDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.ig, ig) || other.ig == ig)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.org, org) || other.org == org)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.totalKarma, totalKarma) || other.totalKarma == totalKarma)&&(identical(other.totalMembers, totalMembers) || other.totalMembers == totalMembers)&&(identical(other.nextMeetupScheduled, nextMeetupScheduled) || other.nextMeetupScheduled == nextMeetupScheduled)&&(identical(other.nextMeetupTime, nextMeetupTime) || other.nextMeetupTime == nextMeetupTime));
}


@override
int get hashCode => Object.hash(runtimeType,id,ig,title,description,createdBy,org,isRecurring,rank,totalKarma,totalMembers,nextMeetupScheduled,nextMeetupTime);

@override
String toString() {
  return 'LearningCircleDetail(id: $id, ig: $ig, title: $title, description: $description, createdBy: $createdBy, org: $org, isRecurring: $isRecurring, rank: $rank, totalKarma: $totalKarma, totalMembers: $totalMembers, nextMeetupScheduled: $nextMeetupScheduled, nextMeetupTime: $nextMeetupTime)';
}


}

/// @nodoc
abstract mixin class _$LearningCircleDetailCopyWith<$Res> implements $LearningCircleDetailCopyWith<$Res> {
  factory _$LearningCircleDetailCopyWith(_LearningCircleDetail value, $Res Function(_LearningCircleDetail) _then) = __$LearningCircleDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String ig, String title, String description, CircleUserRef createdBy, String? org, bool? isRecurring, int? rank, int? totalKarma, int? totalMembers, bool? nextMeetupScheduled, String? nextMeetupTime
});


@override $CircleUserRefCopyWith<$Res> get createdBy;

}
/// @nodoc
class __$LearningCircleDetailCopyWithImpl<$Res>
    implements _$LearningCircleDetailCopyWith<$Res> {
  __$LearningCircleDetailCopyWithImpl(this._self, this._then);

  final _LearningCircleDetail _self;
  final $Res Function(_LearningCircleDetail) _then;

/// Create a copy of LearningCircleDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ig = null,Object? title = null,Object? description = null,Object? createdBy = null,Object? org = freezed,Object? isRecurring = freezed,Object? rank = freezed,Object? totalKarma = freezed,Object? totalMembers = freezed,Object? nextMeetupScheduled = freezed,Object? nextMeetupTime = freezed,}) {
  return _then(_LearningCircleDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ig: null == ig ? _self.ig : ig // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as CircleUserRef,org: freezed == org ? _self.org : org // ignore: cast_nullable_to_non_nullable
as String?,isRecurring: freezed == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool?,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int?,totalKarma: freezed == totalKarma ? _self.totalKarma : totalKarma // ignore: cast_nullable_to_non_nullable
as int?,totalMembers: freezed == totalMembers ? _self.totalMembers : totalMembers // ignore: cast_nullable_to_non_nullable
as int?,nextMeetupScheduled: freezed == nextMeetupScheduled ? _self.nextMeetupScheduled : nextMeetupScheduled // ignore: cast_nullable_to_non_nullable
as bool?,nextMeetupTime: freezed == nextMeetupTime ? _self.nextMeetupTime : nextMeetupTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of LearningCircleDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CircleUserRefCopyWith<$Res> get createdBy {
  
  return $CircleUserRefCopyWith<$Res>(_self.createdBy, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}

// dart format on
