// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campus_search_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CampusSearchResult {

 String get id; String get title; String get code; int get learners; int get karma; bool get isSchool; String? get district; String? get zone; String? get state;
/// Create a copy of CampusSearchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampusSearchResultCopyWith<CampusSearchResult> get copyWith => _$CampusSearchResultCopyWithImpl<CampusSearchResult>(this as CampusSearchResult, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CampusSearchResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampusSearchResult&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.learners, _this.learners) || other.learners == _this.learners)&&(identical(other.karma, _this.karma) || other.karma == _this.karma)&&(identical(other.isSchool, _this.isSchool) || other.isSchool == _this.isSchool)&&(identical(other.district, _this.district) || other.district == _this.district)&&(identical(other.zone, _this.zone) || other.zone == _this.zone)&&(identical(other.state, _this.state) || other.state == _this.state));
}


@override
int get hashCode {
  final _this = this as CampusSearchResult;
  return Object.hash(runtimeType,_this.id,_this.title,_this.code,_this.learners,_this.karma,_this.isSchool,_this.district,_this.zone,_this.state);
}

@override
String toString() {
  final _this = this as CampusSearchResult;
  return 'CampusSearchResult(id: ${_this.id}, title: ${_this.title}, code: ${_this.code}, learners: ${_this.learners}, karma: ${_this.karma}, isSchool: ${_this.isSchool}, district: ${_this.district}, zone: ${_this.zone}, state: ${_this.state})';
}


}

/// @nodoc
abstract mixin class $CampusSearchResultCopyWith<$Res>  {
  factory $CampusSearchResultCopyWith(CampusSearchResult value, $Res Function(CampusSearchResult) _then) = _$CampusSearchResultCopyWithImpl;
@useResult
$Res call({
 String id, String title, String code, int learners, int karma, bool isSchool, String? district, String? zone, String? state
});




}
/// @nodoc
class _$CampusSearchResultCopyWithImpl<$Res>
    implements $CampusSearchResultCopyWith<$Res> {
  _$CampusSearchResultCopyWithImpl(this._self, this._then);

  final CampusSearchResult _self;
  final $Res Function(CampusSearchResult) _then;

/// Create a copy of CampusSearchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? code = null,Object? learners = null,Object? karma = null,Object? isSchool = null,Object? district = freezed,Object? zone = freezed,Object? state = freezed,}) {
  return _then(CampusSearchResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,learners: null == learners ? _self.learners : learners // ignore: cast_nullable_to_non_nullable
as int,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as int,isSchool: null == isSchool ? _self.isSchool : isSchool // ignore: cast_nullable_to_non_nullable
as bool,district: freezed == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String?,zone: freezed == zone ? _self.zone : zone // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CampusSearchResult].
extension CampusSearchResultPatterns on CampusSearchResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampusSearchResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampusSearchResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampusSearchResult value)  $default,){
final _that = this;
switch (_that) {
case _CampusSearchResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampusSearchResult value)?  $default,){
final _that = this;
switch (_that) {
case _CampusSearchResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String code,  int learners,  int karma,  bool isSchool,  String? district,  String? zone,  String? state)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampusSearchResult() when $default != null:
return $default(_that.id,_that.title,_that.code,_that.learners,_that.karma,_that.isSchool,_that.district,_that.zone,_that.state);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String code,  int learners,  int karma,  bool isSchool,  String? district,  String? zone,  String? state)  $default,) {final _that = this;
switch (_that) {
case _CampusSearchResult():
return $default(_that.id,_that.title,_that.code,_that.learners,_that.karma,_that.isSchool,_that.district,_that.zone,_that.state);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String code,  int learners,  int karma,  bool isSchool,  String? district,  String? zone,  String? state)?  $default,) {final _that = this;
switch (_that) {
case _CampusSearchResult() when $default != null:
return $default(_that.id,_that.title,_that.code,_that.learners,_that.karma,_that.isSchool,_that.district,_that.zone,_that.state);case _:
  return null;

}
}

}

/// @nodoc


class _CampusSearchResult implements CampusSearchResult {
  const _CampusSearchResult({required this.id, required this.title, required this.code, required this.learners, required this.karma, required this.isSchool, this.district, this.zone, this.state});
  

@override final  String id;
@override final  String title;
@override final  String code;
@override final  int learners;
@override final  int karma;
@override final  bool isSchool;
@override final  String? district;
@override final  String? zone;
@override final  String? state;

/// Create a copy of CampusSearchResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampusSearchResultCopyWith<_CampusSearchResult> get copyWith => __$CampusSearchResultCopyWithImpl<_CampusSearchResult>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampusSearchResult&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.code, code) || other.code == code)&&(identical(other.learners, learners) || other.learners == learners)&&(identical(other.karma, karma) || other.karma == karma)&&(identical(other.isSchool, isSchool) || other.isSchool == isSchool)&&(identical(other.district, district) || other.district == district)&&(identical(other.zone, zone) || other.zone == zone)&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,code,learners,karma,isSchool,district,zone,state);
}

@override
String toString() {
    return 'CampusSearchResult(id: $id, title: $title, code: $code, learners: $learners, karma: $karma, isSchool: $isSchool, district: $district, zone: $zone, state: $state)';
}


}

/// @nodoc
abstract mixin class _$CampusSearchResultCopyWith<$Res> implements $CampusSearchResultCopyWith<$Res> {
  factory _$CampusSearchResultCopyWith(_CampusSearchResult value, $Res Function(_CampusSearchResult) _then) = __$CampusSearchResultCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String code, int learners, int karma, bool isSchool, String? district, String? zone, String? state
});




}
/// @nodoc
class __$CampusSearchResultCopyWithImpl<$Res>
    implements _$CampusSearchResultCopyWith<$Res> {
  __$CampusSearchResultCopyWithImpl(this._self, this._then);

  final _CampusSearchResult _self;
  final $Res Function(_CampusSearchResult) _then;

/// Create a copy of CampusSearchResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? code = null,Object? learners = null,Object? karma = null,Object? isSchool = null,Object? district = freezed,Object? zone = freezed,Object? state = freezed,}) {
  return _then(_CampusSearchResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,learners: null == learners ? _self.learners : learners // ignore: cast_nullable_to_non_nullable
as int,karma: null == karma ? _self.karma : karma // ignore: cast_nullable_to_non_nullable
as int,isSchool: null == isSchool ? _self.isSchool : isSchool // ignore: cast_nullable_to_non_nullable
as bool,district: freezed == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String?,zone: freezed == zone ? _self.zone : zone // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$CampusSearchPage {

 List<CampusSearchResult> get results; bool get hasMore;
/// Create a copy of CampusSearchPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CampusSearchPageCopyWith<CampusSearchPage> get copyWith => _$CampusSearchPageCopyWithImpl<CampusSearchPage>(this as CampusSearchPage, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CampusSearchPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CampusSearchPage&&const DeepCollectionEquality().equals(other.results, _this.results)&&(identical(other.hasMore, _this.hasMore) || other.hasMore == _this.hasMore));
}


@override
int get hashCode {
  final _this = this as CampusSearchPage;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.results),_this.hasMore);
}

@override
String toString() {
  final _this = this as CampusSearchPage;
  return 'CampusSearchPage(results: ${_this.results}, hasMore: ${_this.hasMore})';
}


}

/// @nodoc
abstract mixin class $CampusSearchPageCopyWith<$Res>  {
  factory $CampusSearchPageCopyWith(CampusSearchPage value, $Res Function(CampusSearchPage) _then) = _$CampusSearchPageCopyWithImpl;
@useResult
$Res call({
 List<CampusSearchResult> results, bool hasMore
});




}
/// @nodoc
class _$CampusSearchPageCopyWithImpl<$Res>
    implements $CampusSearchPageCopyWith<$Res> {
  _$CampusSearchPageCopyWithImpl(this._self, this._then);

  final CampusSearchPage _self;
  final $Res Function(CampusSearchPage) _then;

/// Create a copy of CampusSearchPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? results = null,Object? hasMore = null,}) {
  return _then(CampusSearchPage(
results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<CampusSearchResult>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CampusSearchPage].
extension CampusSearchPagePatterns on CampusSearchPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CampusSearchPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CampusSearchPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CampusSearchPage value)  $default,){
final _that = this;
switch (_that) {
case _CampusSearchPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CampusSearchPage value)?  $default,){
final _that = this;
switch (_that) {
case _CampusSearchPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CampusSearchResult> results,  bool hasMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CampusSearchPage() when $default != null:
return $default(_that.results,_that.hasMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CampusSearchResult> results,  bool hasMore)  $default,) {final _that = this;
switch (_that) {
case _CampusSearchPage():
return $default(_that.results,_that.hasMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CampusSearchResult> results,  bool hasMore)?  $default,) {final _that = this;
switch (_that) {
case _CampusSearchPage() when $default != null:
return $default(_that.results,_that.hasMore);case _:
  return null;

}
}

}

/// @nodoc


class _CampusSearchPage implements CampusSearchPage {
  const _CampusSearchPage({required  List<CampusSearchResult> results, required this.hasMore}): _results = results;
  

 final  List<CampusSearchResult> _results;
@override List<CampusSearchResult> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override final  bool hasMore;

/// Create a copy of CampusSearchPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CampusSearchPageCopyWith<_CampusSearchPage> get copyWith => __$CampusSearchPageCopyWithImpl<_CampusSearchPage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CampusSearchPage&&const DeepCollectionEquality().equals(other.results, _results)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_results),hasMore);
}

@override
String toString() {
    return 'CampusSearchPage(results: $results, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class _$CampusSearchPageCopyWith<$Res> implements $CampusSearchPageCopyWith<$Res> {
  factory _$CampusSearchPageCopyWith(_CampusSearchPage value, $Res Function(_CampusSearchPage) _then) = __$CampusSearchPageCopyWithImpl;
@override @useResult
$Res call({
 List<CampusSearchResult> results, bool hasMore
});




}
/// @nodoc
class __$CampusSearchPageCopyWithImpl<$Res>
    implements _$CampusSearchPageCopyWith<$Res> {
  __$CampusSearchPageCopyWithImpl(this._self, this._then);

  final _CampusSearchPage _self;
  final $Res Function(_CampusSearchPage) _then;

/// Create a copy of CampusSearchPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? results = null,Object? hasMore = null,}) {
  return _then(_CampusSearchPage(
results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<CampusSearchResult>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
