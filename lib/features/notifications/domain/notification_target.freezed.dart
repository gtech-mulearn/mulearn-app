// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_target.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationTarget {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationTarget);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationTarget()';
}


}

/// @nodoc
class $NotificationTargetCopyWith<$Res>  {
$NotificationTargetCopyWith(NotificationTarget _, $Res Function(NotificationTarget) __);
}


/// Adds pattern-matching-related methods to [NotificationTarget].
extension NotificationTargetPatterns on NotificationTarget {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AppRoute value)?  appRoute,TResult Function( WebPage value)?  webPage,TResult Function( NoTarget value)?  none,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AppRoute() when appRoute != null:
return appRoute(_that);case WebPage() when webPage != null:
return webPage(_that);case NoTarget() when none != null:
return none(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AppRoute value)  appRoute,required TResult Function( WebPage value)  webPage,required TResult Function( NoTarget value)  none,}){
final _that = this;
switch (_that) {
case AppRoute():
return appRoute(_that);case WebPage():
return webPage(_that);case NoTarget():
return none(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AppRoute value)?  appRoute,TResult? Function( WebPage value)?  webPage,TResult? Function( NoTarget value)?  none,}){
final _that = this;
switch (_that) {
case AppRoute() when appRoute != null:
return appRoute(_that);case WebPage() when webPage != null:
return webPage(_that);case NoTarget() when none != null:
return none(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String location)?  appRoute,TResult Function( Uri uri)?  webPage,TResult Function()?  none,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AppRoute() when appRoute != null:
return appRoute(_that.location);case WebPage() when webPage != null:
return webPage(_that.uri);case NoTarget() when none != null:
return none();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String location)  appRoute,required TResult Function( Uri uri)  webPage,required TResult Function()  none,}) {final _that = this;
switch (_that) {
case AppRoute():
return appRoute(_that.location);case WebPage():
return webPage(_that.uri);case NoTarget():
return none();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String location)?  appRoute,TResult? Function( Uri uri)?  webPage,TResult? Function()?  none,}) {final _that = this;
switch (_that) {
case AppRoute() when appRoute != null:
return appRoute(_that.location);case WebPage() when webPage != null:
return webPage(_that.uri);case NoTarget() when none != null:
return none();case _:
  return null;

}
}

}

/// @nodoc


class AppRoute implements NotificationTarget {
  const AppRoute(this.location);
  

 final  String location;

/// Create a copy of NotificationTarget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppRouteCopyWith<AppRoute> get copyWith => _$AppRouteCopyWithImpl<AppRoute>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppRoute&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,location);

@override
String toString() {
  return 'NotificationTarget.appRoute(location: $location)';
}


}

/// @nodoc
abstract mixin class $AppRouteCopyWith<$Res> implements $NotificationTargetCopyWith<$Res> {
  factory $AppRouteCopyWith(AppRoute value, $Res Function(AppRoute) _then) = _$AppRouteCopyWithImpl;
@useResult
$Res call({
 String location
});




}
/// @nodoc
class _$AppRouteCopyWithImpl<$Res>
    implements $AppRouteCopyWith<$Res> {
  _$AppRouteCopyWithImpl(this._self, this._then);

  final AppRoute _self;
  final $Res Function(AppRoute) _then;

/// Create a copy of NotificationTarget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? location = null,}) {
  return _then(AppRoute(
null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class WebPage implements NotificationTarget {
  const WebPage(this.uri);
  

 final  Uri uri;

/// Create a copy of NotificationTarget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WebPageCopyWith<WebPage> get copyWith => _$WebPageCopyWithImpl<WebPage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WebPage&&(identical(other.uri, uri) || other.uri == uri));
}


@override
int get hashCode => Object.hash(runtimeType,uri);

@override
String toString() {
  return 'NotificationTarget.webPage(uri: $uri)';
}


}

/// @nodoc
abstract mixin class $WebPageCopyWith<$Res> implements $NotificationTargetCopyWith<$Res> {
  factory $WebPageCopyWith(WebPage value, $Res Function(WebPage) _then) = _$WebPageCopyWithImpl;
@useResult
$Res call({
 Uri uri
});




}
/// @nodoc
class _$WebPageCopyWithImpl<$Res>
    implements $WebPageCopyWith<$Res> {
  _$WebPageCopyWithImpl(this._self, this._then);

  final WebPage _self;
  final $Res Function(WebPage) _then;

/// Create a copy of NotificationTarget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? uri = null,}) {
  return _then(WebPage(
null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as Uri,
  ));
}


}

/// @nodoc


class NoTarget implements NotificationTarget {
  const NoTarget();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoTarget);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationTarget.none()';
}


}




// dart format on
