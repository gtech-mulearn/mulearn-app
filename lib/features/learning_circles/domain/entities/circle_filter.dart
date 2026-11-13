import 'package:freezed_annotation/freezed_annotation.dart';

part 'circle_filter.freezed.dart';

/// Circle discovery filters (LearningCircleView.get): [status] is one of the
/// backend's `joined`, `pending`, `not_joined` (null = all), [igId] an
/// interest group, [search] matched against titles. Empty values aren't sent.
@freezed
abstract class CircleFilter with _$CircleFilter {
  const factory CircleFilter({
    String? status,
    String? igId,
    @Default('') String search,
  }) = _CircleFilter;

  const CircleFilter._();

  /// Discovery starts on circles the user hasn't joined or asked to join.
  static const discover = CircleFilter(status: 'not_joined');

  /// The query parameters for this filter.
  Map<String, Object> get query => {
        if (status != null) 'status': status!,
        if (igId != null) 'ig': igId!,
        if (search.trim().isNotEmpty) 'search': search.trim(),
      };
}
