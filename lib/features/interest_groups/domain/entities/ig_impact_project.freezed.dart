// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ig_impact_project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IgImpactProject {

 String get id; String get title; String? get description; String? get image; List<IgProjectLink> get links;
/// Create a copy of IgImpactProject
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IgImpactProjectCopyWith<IgImpactProject> get copyWith => _$IgImpactProjectCopyWithImpl<IgImpactProject>(this as IgImpactProject, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IgImpactProject&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.image, image) || other.image == image)&&const DeepCollectionEquality().equals(other.links, links));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,image,const DeepCollectionEquality().hash(links));

@override
String toString() {
  return 'IgImpactProject(id: $id, title: $title, description: $description, image: $image, links: $links)';
}


}

/// @nodoc
abstract mixin class $IgImpactProjectCopyWith<$Res>  {
  factory $IgImpactProjectCopyWith(IgImpactProject value, $Res Function(IgImpactProject) _then) = _$IgImpactProjectCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? description, String? image, List<IgProjectLink> links
});




}
/// @nodoc
class _$IgImpactProjectCopyWithImpl<$Res>
    implements $IgImpactProjectCopyWith<$Res> {
  _$IgImpactProjectCopyWithImpl(this._self, this._then);

  final IgImpactProject _self;
  final $Res Function(IgImpactProject) _then;

/// Create a copy of IgImpactProject
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? image = freezed,Object? links = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,links: null == links ? _self.links : links // ignore: cast_nullable_to_non_nullable
as List<IgProjectLink>,
  ));
}

}


/// Adds pattern-matching-related methods to [IgImpactProject].
extension IgImpactProjectPatterns on IgImpactProject {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IgImpactProject value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IgImpactProject() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IgImpactProject value)  $default,){
final _that = this;
switch (_that) {
case _IgImpactProject():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IgImpactProject value)?  $default,){
final _that = this;
switch (_that) {
case _IgImpactProject() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  String? image,  List<IgProjectLink> links)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IgImpactProject() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.image,_that.links);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  String? image,  List<IgProjectLink> links)  $default,) {final _that = this;
switch (_that) {
case _IgImpactProject():
return $default(_that.id,_that.title,_that.description,_that.image,_that.links);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? description,  String? image,  List<IgProjectLink> links)?  $default,) {final _that = this;
switch (_that) {
case _IgImpactProject() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.image,_that.links);case _:
  return null;

}
}

}

/// @nodoc


class _IgImpactProject implements IgImpactProject {
  const _IgImpactProject({required this.id, required this.title, this.description, this.image, final  List<IgProjectLink> links = const []}): _links = links;
  

@override final  String id;
@override final  String title;
@override final  String? description;
@override final  String? image;
 final  List<IgProjectLink> _links;
@override@JsonKey() List<IgProjectLink> get links {
  if (_links is EqualUnmodifiableListView) return _links;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_links);
}


/// Create a copy of IgImpactProject
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IgImpactProjectCopyWith<_IgImpactProject> get copyWith => __$IgImpactProjectCopyWithImpl<_IgImpactProject>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IgImpactProject&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.image, image) || other.image == image)&&const DeepCollectionEquality().equals(other._links, _links));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,image,const DeepCollectionEquality().hash(_links));

@override
String toString() {
  return 'IgImpactProject(id: $id, title: $title, description: $description, image: $image, links: $links)';
}


}

/// @nodoc
abstract mixin class _$IgImpactProjectCopyWith<$Res> implements $IgImpactProjectCopyWith<$Res> {
  factory _$IgImpactProjectCopyWith(_IgImpactProject value, $Res Function(_IgImpactProject) _then) = __$IgImpactProjectCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? description, String? image, List<IgProjectLink> links
});




}
/// @nodoc
class __$IgImpactProjectCopyWithImpl<$Res>
    implements _$IgImpactProjectCopyWith<$Res> {
  __$IgImpactProjectCopyWithImpl(this._self, this._then);

  final _IgImpactProject _self;
  final $Res Function(_IgImpactProject) _then;

/// Create a copy of IgImpactProject
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? image = freezed,Object? links = null,}) {
  return _then(_IgImpactProject(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,links: null == links ? _self._links : links // ignore: cast_nullable_to_non_nullable
as List<IgProjectLink>,
  ));
}


}

/// @nodoc
mixin _$IgProjectLink {

 String get label; String get url;
/// Create a copy of IgProjectLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IgProjectLinkCopyWith<IgProjectLink> get copyWith => _$IgProjectLinkCopyWithImpl<IgProjectLink>(this as IgProjectLink, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IgProjectLink&&(identical(other.label, label) || other.label == label)&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,label,url);

@override
String toString() {
  return 'IgProjectLink(label: $label, url: $url)';
}


}

/// @nodoc
abstract mixin class $IgProjectLinkCopyWith<$Res>  {
  factory $IgProjectLinkCopyWith(IgProjectLink value, $Res Function(IgProjectLink) _then) = _$IgProjectLinkCopyWithImpl;
@useResult
$Res call({
 String label, String url
});




}
/// @nodoc
class _$IgProjectLinkCopyWithImpl<$Res>
    implements $IgProjectLinkCopyWith<$Res> {
  _$IgProjectLinkCopyWithImpl(this._self, this._then);

  final IgProjectLink _self;
  final $Res Function(IgProjectLink) _then;

/// Create a copy of IgProjectLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? url = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [IgProjectLink].
extension IgProjectLinkPatterns on IgProjectLink {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IgProjectLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IgProjectLink() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IgProjectLink value)  $default,){
final _that = this;
switch (_that) {
case _IgProjectLink():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IgProjectLink value)?  $default,){
final _that = this;
switch (_that) {
case _IgProjectLink() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IgProjectLink() when $default != null:
return $default(_that.label,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  String url)  $default,) {final _that = this;
switch (_that) {
case _IgProjectLink():
return $default(_that.label,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  String url)?  $default,) {final _that = this;
switch (_that) {
case _IgProjectLink() when $default != null:
return $default(_that.label,_that.url);case _:
  return null;

}
}

}

/// @nodoc


class _IgProjectLink implements IgProjectLink {
  const _IgProjectLink({required this.label, required this.url});
  

@override final  String label;
@override final  String url;

/// Create a copy of IgProjectLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IgProjectLinkCopyWith<_IgProjectLink> get copyWith => __$IgProjectLinkCopyWithImpl<_IgProjectLink>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IgProjectLink&&(identical(other.label, label) || other.label == label)&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,label,url);

@override
String toString() {
  return 'IgProjectLink(label: $label, url: $url)';
}


}

/// @nodoc
abstract mixin class _$IgProjectLinkCopyWith<$Res> implements $IgProjectLinkCopyWith<$Res> {
  factory _$IgProjectLinkCopyWith(_IgProjectLink value, $Res Function(_IgProjectLink) _then) = __$IgProjectLinkCopyWithImpl;
@override @useResult
$Res call({
 String label, String url
});




}
/// @nodoc
class __$IgProjectLinkCopyWithImpl<$Res>
    implements _$IgProjectLinkCopyWith<$Res> {
  __$IgProjectLinkCopyWithImpl(this._self, this._then);

  final _IgProjectLink _self;
  final $Res Function(_IgProjectLink) _then;

/// Create a copy of IgProjectLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? url = null,}) {
  return _then(_IgProjectLink(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
