// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventFilter {

 String get search; String? get eventType; String? get igId; DateTime? get from; bool get eligibleOnly;
/// Create a copy of EventFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventFilterCopyWith<EventFilter> get copyWith => _$EventFilterCopyWithImpl<EventFilter>(this as EventFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventFilter&&(identical(other.search, search) || other.search == search)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.igId, igId) || other.igId == igId)&&(identical(other.from, from) || other.from == from)&&(identical(other.eligibleOnly, eligibleOnly) || other.eligibleOnly == eligibleOnly));
}


@override
int get hashCode => Object.hash(runtimeType,search,eventType,igId,from,eligibleOnly);

@override
String toString() {
  return 'EventFilter(search: $search, eventType: $eventType, igId: $igId, from: $from, eligibleOnly: $eligibleOnly)';
}


}

/// @nodoc
abstract mixin class $EventFilterCopyWith<$Res>  {
  factory $EventFilterCopyWith(EventFilter value, $Res Function(EventFilter) _then) = _$EventFilterCopyWithImpl;
@useResult
$Res call({
 String search, String? eventType, String? igId, DateTime? from, bool eligibleOnly
});




}
/// @nodoc
class _$EventFilterCopyWithImpl<$Res>
    implements $EventFilterCopyWith<$Res> {
  _$EventFilterCopyWithImpl(this._self, this._then);

  final EventFilter _self;
  final $Res Function(EventFilter) _then;

/// Create a copy of EventFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? search = null,Object? eventType = freezed,Object? igId = freezed,Object? from = freezed,Object? eligibleOnly = null,}) {
  return _then(_self.copyWith(
search: null == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String,eventType: freezed == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as String?,igId: freezed == igId ? _self.igId : igId // ignore: cast_nullable_to_non_nullable
as String?,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime?,eligibleOnly: null == eligibleOnly ? _self.eligibleOnly : eligibleOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EventFilter].
extension EventFilterPatterns on EventFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventFilter value)  $default,){
final _that = this;
switch (_that) {
case _EventFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventFilter value)?  $default,){
final _that = this;
switch (_that) {
case _EventFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String search,  String? eventType,  String? igId,  DateTime? from,  bool eligibleOnly)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventFilter() when $default != null:
return $default(_that.search,_that.eventType,_that.igId,_that.from,_that.eligibleOnly);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String search,  String? eventType,  String? igId,  DateTime? from,  bool eligibleOnly)  $default,) {final _that = this;
switch (_that) {
case _EventFilter():
return $default(_that.search,_that.eventType,_that.igId,_that.from,_that.eligibleOnly);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String search,  String? eventType,  String? igId,  DateTime? from,  bool eligibleOnly)?  $default,) {final _that = this;
switch (_that) {
case _EventFilter() when $default != null:
return $default(_that.search,_that.eventType,_that.igId,_that.from,_that.eligibleOnly);case _:
  return null;

}
}

}

/// @nodoc


class _EventFilter extends EventFilter {
  const _EventFilter({this.search = '', this.eventType, this.igId, this.from, this.eligibleOnly = false}): super._();
  

@override@JsonKey() final  String search;
@override final  String? eventType;
@override final  String? igId;
@override final  DateTime? from;
@override@JsonKey() final  bool eligibleOnly;

/// Create a copy of EventFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventFilterCopyWith<_EventFilter> get copyWith => __$EventFilterCopyWithImpl<_EventFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventFilter&&(identical(other.search, search) || other.search == search)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.igId, igId) || other.igId == igId)&&(identical(other.from, from) || other.from == from)&&(identical(other.eligibleOnly, eligibleOnly) || other.eligibleOnly == eligibleOnly));
}


@override
int get hashCode => Object.hash(runtimeType,search,eventType,igId,from,eligibleOnly);

@override
String toString() {
  return 'EventFilter(search: $search, eventType: $eventType, igId: $igId, from: $from, eligibleOnly: $eligibleOnly)';
}


}

/// @nodoc
abstract mixin class _$EventFilterCopyWith<$Res> implements $EventFilterCopyWith<$Res> {
  factory _$EventFilterCopyWith(_EventFilter value, $Res Function(_EventFilter) _then) = __$EventFilterCopyWithImpl;
@override @useResult
$Res call({
 String search, String? eventType, String? igId, DateTime? from, bool eligibleOnly
});




}
/// @nodoc
class __$EventFilterCopyWithImpl<$Res>
    implements _$EventFilterCopyWith<$Res> {
  __$EventFilterCopyWithImpl(this._self, this._then);

  final _EventFilter _self;
  final $Res Function(_EventFilter) _then;

/// Create a copy of EventFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? search = null,Object? eventType = freezed,Object? igId = freezed,Object? from = freezed,Object? eligibleOnly = null,}) {
  return _then(_EventFilter(
search: null == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String,eventType: freezed == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as String?,igId: freezed == igId ? _self.igId : igId // ignore: cast_nullable_to_non_nullable
as String?,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime?,eligibleOnly: null == eligibleOnly ? _self.eligibleOnly : eligibleOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
