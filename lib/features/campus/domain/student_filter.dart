import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_filter.freezed.dart';

/// The students list's order; [query] is `student-details`'s `sortBy`.
enum StudentSort {
  karma('Karma', '-karma'),
  level('Level', '-level'),
  newest('Newest', '-join_date'),
  name('Name', 'full_name');

  const StudentSort(this.label, this.query);
  final String label;
  final String query;
}

/// What the students list asks for: a search, an order, and alumni only
/// ([alumni] true) or everyone (null).
@freezed
abstract class StudentFilter with _$StudentFilter {
  const factory StudentFilter({
    @Default('') String search,
    @Default(StudentSort.karma) StudentSort sort,
    bool? alumni,
  }) = _StudentFilter;
}
