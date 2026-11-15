import 'package:freezed_annotation/freezed_annotation.dart';

part 'campus_search_result.freezed.dart';

/// A college or school found by campus search
/// (`organisation/institutes/<college|school>/`, InstitutionSerializer).
@freezed
abstract class CampusSearchResult with _$CampusSearchResult {
  const factory CampusSearchResult({
    required String id,
    required String title,
    required String code,
    required int learners,
    required int karma,
    required bool isSchool,
    String? district,
    String? zone,
    String? state,
  }) = _CampusSearchResult;
}

/// A page of campus results and whether another follows.
@freezed
abstract class CampusSearchPage with _$CampusSearchPage {
  const factory CampusSearchPage({
    required List<CampusSearchResult> results,
    required bool hasMore,
  }) = _CampusSearchPage;
}
