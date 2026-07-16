// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarEntry {

 String get id; String get title; String get start; String get end; String get status; CalendarEntryKind get kind; String? get venueType; String? get organiserName; String? get categoryName; bool get isFeatured;
/// Create a copy of CalendarEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarEntryCopyWith<CalendarEntry> get copyWith => _$CalendarEntryCopyWithImpl<CalendarEntry>(this as CalendarEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.status, status) || other.status == status)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.venueType, venueType) || other.venueType == venueType)&&(identical(other.organiserName, organiserName) || other.organiserName == organiserName)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,start,end,status,kind,venueType,organiserName,categoryName,isFeatured);

@override
String toString() {
  return 'CalendarEntry(id: $id, title: $title, start: $start, end: $end, status: $status, kind: $kind, venueType: $venueType, organiserName: $organiserName, categoryName: $categoryName, isFeatured: $isFeatured)';
}


}

/// @nodoc
abstract mixin class $CalendarEntryCopyWith<$Res>  {
  factory $CalendarEntryCopyWith(CalendarEntry value, $Res Function(CalendarEntry) _then) = _$CalendarEntryCopyWithImpl;
@useResult
$Res call({
 String id, String title, String start, String end, String status, CalendarEntryKind kind, String? venueType, String? organiserName, String? categoryName, bool isFeatured
});




}
/// @nodoc
class _$CalendarEntryCopyWithImpl<$Res>
    implements $CalendarEntryCopyWith<$Res> {
  _$CalendarEntryCopyWithImpl(this._self, this._then);

  final CalendarEntry _self;
  final $Res Function(CalendarEntry) _then;

/// Create a copy of CalendarEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? start = null,Object? end = null,Object? status = null,Object? kind = null,Object? venueType = freezed,Object? organiserName = freezed,Object? categoryName = freezed,Object? isFeatured = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as String,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as CalendarEntryKind,venueType: freezed == venueType ? _self.venueType : venueType // ignore: cast_nullable_to_non_nullable
as String?,organiserName: freezed == organiserName ? _self.organiserName : organiserName // ignore: cast_nullable_to_non_nullable
as String?,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarEntry].
extension CalendarEntryPatterns on CalendarEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarEntry value)  $default,){
final _that = this;
switch (_that) {
case _CalendarEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarEntry value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String start,  String end,  String status,  CalendarEntryKind kind,  String? venueType,  String? organiserName,  String? categoryName,  bool isFeatured)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarEntry() when $default != null:
return $default(_that.id,_that.title,_that.start,_that.end,_that.status,_that.kind,_that.venueType,_that.organiserName,_that.categoryName,_that.isFeatured);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String start,  String end,  String status,  CalendarEntryKind kind,  String? venueType,  String? organiserName,  String? categoryName,  bool isFeatured)  $default,) {final _that = this;
switch (_that) {
case _CalendarEntry():
return $default(_that.id,_that.title,_that.start,_that.end,_that.status,_that.kind,_that.venueType,_that.organiserName,_that.categoryName,_that.isFeatured);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String start,  String end,  String status,  CalendarEntryKind kind,  String? venueType,  String? organiserName,  String? categoryName,  bool isFeatured)?  $default,) {final _that = this;
switch (_that) {
case _CalendarEntry() when $default != null:
return $default(_that.id,_that.title,_that.start,_that.end,_that.status,_that.kind,_that.venueType,_that.organiserName,_that.categoryName,_that.isFeatured);case _:
  return null;

}
}

}

/// @nodoc


class _CalendarEntry implements CalendarEntry {
  const _CalendarEntry({required this.id, required this.title, required this.start, required this.end, required this.status, required this.kind, this.venueType, this.organiserName, this.categoryName, this.isFeatured = false});
  

@override final  String id;
@override final  String title;
@override final  String start;
@override final  String end;
@override final  String status;
@override final  CalendarEntryKind kind;
@override final  String? venueType;
@override final  String? organiserName;
@override final  String? categoryName;
@override@JsonKey() final  bool isFeatured;

/// Create a copy of CalendarEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarEntryCopyWith<_CalendarEntry> get copyWith => __$CalendarEntryCopyWithImpl<_CalendarEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.status, status) || other.status == status)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.venueType, venueType) || other.venueType == venueType)&&(identical(other.organiserName, organiserName) || other.organiserName == organiserName)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,start,end,status,kind,venueType,organiserName,categoryName,isFeatured);

@override
String toString() {
  return 'CalendarEntry(id: $id, title: $title, start: $start, end: $end, status: $status, kind: $kind, venueType: $venueType, organiserName: $organiserName, categoryName: $categoryName, isFeatured: $isFeatured)';
}


}

/// @nodoc
abstract mixin class _$CalendarEntryCopyWith<$Res> implements $CalendarEntryCopyWith<$Res> {
  factory _$CalendarEntryCopyWith(_CalendarEntry value, $Res Function(_CalendarEntry) _then) = __$CalendarEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String start, String end, String status, CalendarEntryKind kind, String? venueType, String? organiserName, String? categoryName, bool isFeatured
});




}
/// @nodoc
class __$CalendarEntryCopyWithImpl<$Res>
    implements _$CalendarEntryCopyWith<$Res> {
  __$CalendarEntryCopyWithImpl(this._self, this._then);

  final _CalendarEntry _self;
  final $Res Function(_CalendarEntry) _then;

/// Create a copy of CalendarEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? start = null,Object? end = null,Object? status = null,Object? kind = null,Object? venueType = freezed,Object? organiserName = freezed,Object? categoryName = freezed,Object? isFeatured = null,}) {
  return _then(_CalendarEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as String,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as CalendarEntryKind,venueType: freezed == venueType ? _self.venueType : venueType // ignore: cast_nullable_to_non_nullable
as String?,organiserName: freezed == organiserName ? _self.organiserName : organiserName // ignore: cast_nullable_to_non_nullable
as String?,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
