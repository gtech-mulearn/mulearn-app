// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workspace_access.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WorkspaceAccess {

 WorkspaceState get mentor; WorkspaceState get campus; WorkspaceState get enablerCampuses;/// Campus Lead held **and** verified: college-link approvals and
/// collaboration invites (backend `role_required([Admin, Campus Lead])`).
 bool get campusLead;/// Every campus role held but not verified yet, in naming order. Each
/// gets its own banner, even when another held role opens the campus
/// (the dashboard checks Enabler verification on its own).
 List<String> get pendingCampusRoles;
/// Create a copy of WorkspaceAccess
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkspaceAccessCopyWith<WorkspaceAccess> get copyWith => _$WorkspaceAccessCopyWithImpl<WorkspaceAccess>(this as WorkspaceAccess, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkspaceAccess&&(identical(other.mentor, mentor) || other.mentor == mentor)&&(identical(other.campus, campus) || other.campus == campus)&&(identical(other.enablerCampuses, enablerCampuses) || other.enablerCampuses == enablerCampuses)&&(identical(other.campusLead, campusLead) || other.campusLead == campusLead)&&const DeepCollectionEquality().equals(other.pendingCampusRoles, pendingCampusRoles));
}


@override
int get hashCode => Object.hash(runtimeType,mentor,campus,enablerCampuses,campusLead,const DeepCollectionEquality().hash(pendingCampusRoles));

@override
String toString() {
  return 'WorkspaceAccess(mentor: $mentor, campus: $campus, enablerCampuses: $enablerCampuses, campusLead: $campusLead, pendingCampusRoles: $pendingCampusRoles)';
}


}

/// @nodoc
abstract mixin class $WorkspaceAccessCopyWith<$Res>  {
  factory $WorkspaceAccessCopyWith(WorkspaceAccess value, $Res Function(WorkspaceAccess) _then) = _$WorkspaceAccessCopyWithImpl;
@useResult
$Res call({
 WorkspaceState mentor, WorkspaceState campus, WorkspaceState enablerCampuses, bool campusLead, List<String> pendingCampusRoles
});




}
/// @nodoc
class _$WorkspaceAccessCopyWithImpl<$Res>
    implements $WorkspaceAccessCopyWith<$Res> {
  _$WorkspaceAccessCopyWithImpl(this._self, this._then);

  final WorkspaceAccess _self;
  final $Res Function(WorkspaceAccess) _then;

/// Create a copy of WorkspaceAccess
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mentor = null,Object? campus = null,Object? enablerCampuses = null,Object? campusLead = null,Object? pendingCampusRoles = null,}) {
  return _then(_self.copyWith(
mentor: null == mentor ? _self.mentor : mentor // ignore: cast_nullable_to_non_nullable
as WorkspaceState,campus: null == campus ? _self.campus : campus // ignore: cast_nullable_to_non_nullable
as WorkspaceState,enablerCampuses: null == enablerCampuses ? _self.enablerCampuses : enablerCampuses // ignore: cast_nullable_to_non_nullable
as WorkspaceState,campusLead: null == campusLead ? _self.campusLead : campusLead // ignore: cast_nullable_to_non_nullable
as bool,pendingCampusRoles: null == pendingCampusRoles ? _self.pendingCampusRoles : pendingCampusRoles // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkspaceAccess].
extension WorkspaceAccessPatterns on WorkspaceAccess {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkspaceAccess value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkspaceAccess() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkspaceAccess value)  $default,){
final _that = this;
switch (_that) {
case _WorkspaceAccess():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkspaceAccess value)?  $default,){
final _that = this;
switch (_that) {
case _WorkspaceAccess() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( WorkspaceState mentor,  WorkspaceState campus,  WorkspaceState enablerCampuses,  bool campusLead,  List<String> pendingCampusRoles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkspaceAccess() when $default != null:
return $default(_that.mentor,_that.campus,_that.enablerCampuses,_that.campusLead,_that.pendingCampusRoles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( WorkspaceState mentor,  WorkspaceState campus,  WorkspaceState enablerCampuses,  bool campusLead,  List<String> pendingCampusRoles)  $default,) {final _that = this;
switch (_that) {
case _WorkspaceAccess():
return $default(_that.mentor,_that.campus,_that.enablerCampuses,_that.campusLead,_that.pendingCampusRoles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( WorkspaceState mentor,  WorkspaceState campus,  WorkspaceState enablerCampuses,  bool campusLead,  List<String> pendingCampusRoles)?  $default,) {final _that = this;
switch (_that) {
case _WorkspaceAccess() when $default != null:
return $default(_that.mentor,_that.campus,_that.enablerCampuses,_that.campusLead,_that.pendingCampusRoles);case _:
  return null;

}
}

}

/// @nodoc


class _WorkspaceAccess implements WorkspaceAccess {
  const _WorkspaceAccess({required this.mentor, required this.campus, required this.enablerCampuses, required this.campusLead, final  List<String> pendingCampusRoles = const <String>[]}): _pendingCampusRoles = pendingCampusRoles;
  

@override final  WorkspaceState mentor;
@override final  WorkspaceState campus;
@override final  WorkspaceState enablerCampuses;
/// Campus Lead held **and** verified: college-link approvals and
/// collaboration invites (backend `role_required([Admin, Campus Lead])`).
@override final  bool campusLead;
/// Every campus role held but not verified yet, in naming order. Each
/// gets its own banner, even when another held role opens the campus
/// (the dashboard checks Enabler verification on its own).
 final  List<String> _pendingCampusRoles;
/// Every campus role held but not verified yet, in naming order. Each
/// gets its own banner, even when another held role opens the campus
/// (the dashboard checks Enabler verification on its own).
@override@JsonKey() List<String> get pendingCampusRoles {
  if (_pendingCampusRoles is EqualUnmodifiableListView) return _pendingCampusRoles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pendingCampusRoles);
}


/// Create a copy of WorkspaceAccess
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkspaceAccessCopyWith<_WorkspaceAccess> get copyWith => __$WorkspaceAccessCopyWithImpl<_WorkspaceAccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkspaceAccess&&(identical(other.mentor, mentor) || other.mentor == mentor)&&(identical(other.campus, campus) || other.campus == campus)&&(identical(other.enablerCampuses, enablerCampuses) || other.enablerCampuses == enablerCampuses)&&(identical(other.campusLead, campusLead) || other.campusLead == campusLead)&&const DeepCollectionEquality().equals(other._pendingCampusRoles, _pendingCampusRoles));
}


@override
int get hashCode => Object.hash(runtimeType,mentor,campus,enablerCampuses,campusLead,const DeepCollectionEquality().hash(_pendingCampusRoles));

@override
String toString() {
  return 'WorkspaceAccess(mentor: $mentor, campus: $campus, enablerCampuses: $enablerCampuses, campusLead: $campusLead, pendingCampusRoles: $pendingCampusRoles)';
}


}

/// @nodoc
abstract mixin class _$WorkspaceAccessCopyWith<$Res> implements $WorkspaceAccessCopyWith<$Res> {
  factory _$WorkspaceAccessCopyWith(_WorkspaceAccess value, $Res Function(_WorkspaceAccess) _then) = __$WorkspaceAccessCopyWithImpl;
@override @useResult
$Res call({
 WorkspaceState mentor, WorkspaceState campus, WorkspaceState enablerCampuses, bool campusLead, List<String> pendingCampusRoles
});




}
/// @nodoc
class __$WorkspaceAccessCopyWithImpl<$Res>
    implements _$WorkspaceAccessCopyWith<$Res> {
  __$WorkspaceAccessCopyWithImpl(this._self, this._then);

  final _WorkspaceAccess _self;
  final $Res Function(_WorkspaceAccess) _then;

/// Create a copy of WorkspaceAccess
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mentor = null,Object? campus = null,Object? enablerCampuses = null,Object? campusLead = null,Object? pendingCampusRoles = null,}) {
  return _then(_WorkspaceAccess(
mentor: null == mentor ? _self.mentor : mentor // ignore: cast_nullable_to_non_nullable
as WorkspaceState,campus: null == campus ? _self.campus : campus // ignore: cast_nullable_to_non_nullable
as WorkspaceState,enablerCampuses: null == enablerCampuses ? _self.enablerCampuses : enablerCampuses // ignore: cast_nullable_to_non_nullable
as WorkspaceState,campusLead: null == campusLead ? _self.campusLead : campusLead // ignore: cast_nullable_to_non_nullable
as bool,pendingCampusRoles: null == pendingCampusRoles ? _self._pendingCampusRoles : pendingCampusRoles // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
