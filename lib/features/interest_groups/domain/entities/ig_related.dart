import 'package:freezed_annotation/freezed_annotation.dart';

part 'ig_related.freezed.dart';

/// A circle in an interest group (first page of `learningcircle/list/?ig=`).
@freezed
abstract class IgCircleRef with _$IgCircleRef {
  const factory IgCircleRef({required String id, required String title, int? totalMembers}) = _IgCircleRef;
}

/// An event scoped to an interest group (first page of `events/?ig_id=`).
@freezed
abstract class IgEventRef with _$IgEventRef {
  const factory IgEventRef({required String id, required String title, DateTime? startsAt}) = _IgEventRef;
}
