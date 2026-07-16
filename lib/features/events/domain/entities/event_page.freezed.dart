// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventPage {

 List<Event> get events; bool get hasNext; int get totalPages;
/// Create a copy of EventPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventPageCopyWith<EventPage> get copyWith => _$EventPageCopyWithImpl<EventPage>(this as EventPage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventPage&&const DeepCollectionEquality().equals(other.events, events)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(events),hasNext,totalPages);

@override
String toString() {
  return 'EventPage(events: $events, hasNext: $hasNext, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class $EventPageCopyWith<$Res>  {
  factory $EventPageCopyWith(EventPage value, $Res Function(EventPage) _then) = _$EventPageCopyWithImpl;
@useResult
$Res call({
 List<Event> events, bool hasNext, int totalPages
});




}
/// @nodoc
class _$EventPageCopyWithImpl<$Res>
    implements $EventPageCopyWith<$Res> {
  _$EventPageCopyWithImpl(this._self, this._then);

  final EventPage _self;
  final $Res Function(EventPage) _then;

/// Create a copy of EventPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? events = null,Object? hasNext = null,Object? totalPages = null,}) {
  return _then(_self.copyWith(
events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<Event>,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [EventPage].
extension EventPagePatterns on EventPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventPage value)  $default,){
final _that = this;
switch (_that) {
case _EventPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventPage value)?  $default,){
final _that = this;
switch (_that) {
case _EventPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Event> events,  bool hasNext,  int totalPages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventPage() when $default != null:
return $default(_that.events,_that.hasNext,_that.totalPages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Event> events,  bool hasNext,  int totalPages)  $default,) {final _that = this;
switch (_that) {
case _EventPage():
return $default(_that.events,_that.hasNext,_that.totalPages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Event> events,  bool hasNext,  int totalPages)?  $default,) {final _that = this;
switch (_that) {
case _EventPage() when $default != null:
return $default(_that.events,_that.hasNext,_that.totalPages);case _:
  return null;

}
}

}

/// @nodoc


class _EventPage implements EventPage {
  const _EventPage({required final  List<Event> events, required this.hasNext, required this.totalPages}): _events = events;
  

 final  List<Event> _events;
@override List<Event> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}

@override final  bool hasNext;
@override final  int totalPages;

/// Create a copy of EventPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventPageCopyWith<_EventPage> get copyWith => __$EventPageCopyWithImpl<_EventPage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventPage&&const DeepCollectionEquality().equals(other._events, _events)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_events),hasNext,totalPages);

@override
String toString() {
  return 'EventPage(events: $events, hasNext: $hasNext, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class _$EventPageCopyWith<$Res> implements $EventPageCopyWith<$Res> {
  factory _$EventPageCopyWith(_EventPage value, $Res Function(_EventPage) _then) = __$EventPageCopyWithImpl;
@override @useResult
$Res call({
 List<Event> events, bool hasNext, int totalPages
});




}
/// @nodoc
class __$EventPageCopyWithImpl<$Res>
    implements _$EventPageCopyWith<$Res> {
  __$EventPageCopyWithImpl(this._self, this._then);

  final _EventPage _self;
  final $Res Function(_EventPage) _then;

/// Create a copy of EventPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? events = null,Object? hasNext = null,Object? totalPages = null,}) {
  return _then(_EventPage(
events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<Event>,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
