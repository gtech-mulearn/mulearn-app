// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'learning_circle_detail_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LearningCircleDetailDto {

 String get id; String get ig; String get title; CircleUserRefDto get createdBy; String get description; String? get org; bool get isRecurring; int? get rank; int? get totalKarma; int? get totalMembers; Map<String, dynamic>? get nextMeetup;
/// Create a copy of LearningCircleDetailDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LearningCircleDetailDtoCopyWith<LearningCircleDetailDto> get copyWith => _$LearningCircleDetailDtoCopyWithImpl<LearningCircleDetailDto>(this as LearningCircleDetailDto, _$identity);

  /// Serializes this LearningCircleDetailDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LearningCircleDetailDto&&(identical(other.id, id) || other.id == id)&&(identical(other.ig, ig) || other.ig == ig)&&(identical(other.title, title) || other.title == title)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.description, description) || other.description == description)&&(identical(other.org, org) || other.org == org)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.totalKarma, totalKarma) || other.totalKarma == totalKarma)&&(identical(other.totalMembers, totalMembers) || other.totalMembers == totalMembers)&&const DeepCollectionEquality().equals(other.nextMeetup, nextMeetup));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ig,title,createdBy,description,org,isRecurring,rank,totalKarma,totalMembers,const DeepCollectionEquality().hash(nextMeetup));

@override
String toString() {
  return 'LearningCircleDetailDto(id: $id, ig: $ig, title: $title, createdBy: $createdBy, description: $description, org: $org, isRecurring: $isRecurring, rank: $rank, totalKarma: $totalKarma, totalMembers: $totalMembers, nextMeetup: $nextMeetup)';
}


}

/// @nodoc
abstract mixin class $LearningCircleDetailDtoCopyWith<$Res>  {
  factory $LearningCircleDetailDtoCopyWith(LearningCircleDetailDto value, $Res Function(LearningCircleDetailDto) _then) = _$LearningCircleDetailDtoCopyWithImpl;
@useResult
$Res call({
 String id, String ig, String title, CircleUserRefDto createdBy, String description, String? org, bool isRecurring, int? rank, int? totalKarma, int? totalMembers, Map<String, dynamic>? nextMeetup
});


$CircleUserRefDtoCopyWith<$Res> get createdBy;

}
/// @nodoc
class _$LearningCircleDetailDtoCopyWithImpl<$Res>
    implements $LearningCircleDetailDtoCopyWith<$Res> {
  _$LearningCircleDetailDtoCopyWithImpl(this._self, this._then);

  final LearningCircleDetailDto _self;
  final $Res Function(LearningCircleDetailDto) _then;

/// Create a copy of LearningCircleDetailDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ig = null,Object? title = null,Object? createdBy = null,Object? description = null,Object? org = freezed,Object? isRecurring = null,Object? rank = freezed,Object? totalKarma = freezed,Object? totalMembers = freezed,Object? nextMeetup = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ig: null == ig ? _self.ig : ig // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as CircleUserRefDto,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,org: freezed == org ? _self.org : org // ignore: cast_nullable_to_non_nullable
as String?,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int?,totalKarma: freezed == totalKarma ? _self.totalKarma : totalKarma // ignore: cast_nullable_to_non_nullable
as int?,totalMembers: freezed == totalMembers ? _self.totalMembers : totalMembers // ignore: cast_nullable_to_non_nullable
as int?,nextMeetup: freezed == nextMeetup ? _self.nextMeetup : nextMeetup // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}
/// Create a copy of LearningCircleDetailDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CircleUserRefDtoCopyWith<$Res> get createdBy {
  
  return $CircleUserRefDtoCopyWith<$Res>(_self.createdBy, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [LearningCircleDetailDto].
extension LearningCircleDetailDtoPatterns on LearningCircleDetailDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LearningCircleDetailDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LearningCircleDetailDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LearningCircleDetailDto value)  $default,){
final _that = this;
switch (_that) {
case _LearningCircleDetailDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LearningCircleDetailDto value)?  $default,){
final _that = this;
switch (_that) {
case _LearningCircleDetailDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ig,  String title,  CircleUserRefDto createdBy,  String description,  String? org,  bool isRecurring,  int? rank,  int? totalKarma,  int? totalMembers,  Map<String, dynamic>? nextMeetup)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LearningCircleDetailDto() when $default != null:
return $default(_that.id,_that.ig,_that.title,_that.createdBy,_that.description,_that.org,_that.isRecurring,_that.rank,_that.totalKarma,_that.totalMembers,_that.nextMeetup);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ig,  String title,  CircleUserRefDto createdBy,  String description,  String? org,  bool isRecurring,  int? rank,  int? totalKarma,  int? totalMembers,  Map<String, dynamic>? nextMeetup)  $default,) {final _that = this;
switch (_that) {
case _LearningCircleDetailDto():
return $default(_that.id,_that.ig,_that.title,_that.createdBy,_that.description,_that.org,_that.isRecurring,_that.rank,_that.totalKarma,_that.totalMembers,_that.nextMeetup);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ig,  String title,  CircleUserRefDto createdBy,  String description,  String? org,  bool isRecurring,  int? rank,  int? totalKarma,  int? totalMembers,  Map<String, dynamic>? nextMeetup)?  $default,) {final _that = this;
switch (_that) {
case _LearningCircleDetailDto() when $default != null:
return $default(_that.id,_that.ig,_that.title,_that.createdBy,_that.description,_that.org,_that.isRecurring,_that.rank,_that.totalKarma,_that.totalMembers,_that.nextMeetup);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LearningCircleDetailDto extends LearningCircleDetailDto {
  const _LearningCircleDetailDto({required this.id, required this.ig, required this.title, required this.createdBy, this.description = '', this.org, this.isRecurring = false, this.rank, this.totalKarma, this.totalMembers, final  Map<String, dynamic>? nextMeetup}): _nextMeetup = nextMeetup,super._();
  factory _LearningCircleDetailDto.fromJson(Map<String, dynamic> json) => _$LearningCircleDetailDtoFromJson(json);

@override final  String id;
@override final  String ig;
@override final  String title;
@override final  CircleUserRefDto createdBy;
@override@JsonKey() final  String description;
@override final  String? org;
@override@JsonKey() final  bool isRecurring;
@override final  int? rank;
@override final  int? totalKarma;
@override final  int? totalMembers;
 final  Map<String, dynamic>? _nextMeetup;
@override Map<String, dynamic>? get nextMeetup {
  final value = _nextMeetup;
  if (value == null) return null;
  if (_nextMeetup is EqualUnmodifiableMapView) return _nextMeetup;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of LearningCircleDetailDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LearningCircleDetailDtoCopyWith<_LearningCircleDetailDto> get copyWith => __$LearningCircleDetailDtoCopyWithImpl<_LearningCircleDetailDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LearningCircleDetailDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LearningCircleDetailDto&&(identical(other.id, id) || other.id == id)&&(identical(other.ig, ig) || other.ig == ig)&&(identical(other.title, title) || other.title == title)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.description, description) || other.description == description)&&(identical(other.org, org) || other.org == org)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.totalKarma, totalKarma) || other.totalKarma == totalKarma)&&(identical(other.totalMembers, totalMembers) || other.totalMembers == totalMembers)&&const DeepCollectionEquality().equals(other._nextMeetup, _nextMeetup));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ig,title,createdBy,description,org,isRecurring,rank,totalKarma,totalMembers,const DeepCollectionEquality().hash(_nextMeetup));

@override
String toString() {
  return 'LearningCircleDetailDto(id: $id, ig: $ig, title: $title, createdBy: $createdBy, description: $description, org: $org, isRecurring: $isRecurring, rank: $rank, totalKarma: $totalKarma, totalMembers: $totalMembers, nextMeetup: $nextMeetup)';
}


}

/// @nodoc
abstract mixin class _$LearningCircleDetailDtoCopyWith<$Res> implements $LearningCircleDetailDtoCopyWith<$Res> {
  factory _$LearningCircleDetailDtoCopyWith(_LearningCircleDetailDto value, $Res Function(_LearningCircleDetailDto) _then) = __$LearningCircleDetailDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String ig, String title, CircleUserRefDto createdBy, String description, String? org, bool isRecurring, int? rank, int? totalKarma, int? totalMembers, Map<String, dynamic>? nextMeetup
});


@override $CircleUserRefDtoCopyWith<$Res> get createdBy;

}
/// @nodoc
class __$LearningCircleDetailDtoCopyWithImpl<$Res>
    implements _$LearningCircleDetailDtoCopyWith<$Res> {
  __$LearningCircleDetailDtoCopyWithImpl(this._self, this._then);

  final _LearningCircleDetailDto _self;
  final $Res Function(_LearningCircleDetailDto) _then;

/// Create a copy of LearningCircleDetailDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ig = null,Object? title = null,Object? createdBy = null,Object? description = null,Object? org = freezed,Object? isRecurring = null,Object? rank = freezed,Object? totalKarma = freezed,Object? totalMembers = freezed,Object? nextMeetup = freezed,}) {
  return _then(_LearningCircleDetailDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ig: null == ig ? _self.ig : ig // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as CircleUserRefDto,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,org: freezed == org ? _self.org : org // ignore: cast_nullable_to_non_nullable
as String?,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int?,totalKarma: freezed == totalKarma ? _self.totalKarma : totalKarma // ignore: cast_nullable_to_non_nullable
as int?,totalMembers: freezed == totalMembers ? _self.totalMembers : totalMembers // ignore: cast_nullable_to_non_nullable
as int?,nextMeetup: freezed == nextMeetup ? _self._nextMeetup : nextMeetup // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

/// Create a copy of LearningCircleDetailDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CircleUserRefDtoCopyWith<$Res> get createdBy {
  
  return $CircleUserRefDtoCopyWith<$Res>(_self.createdBy, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}

// dart format on
