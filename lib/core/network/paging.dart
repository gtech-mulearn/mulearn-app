import 'package:freezed_annotation/freezed_annotation.dart';

part 'paging.freezed.dart';

/// What the backend says about the page it just returned.
@freezed
abstract class PageInfo with _$PageInfo {
  const factory PageInfo({
    required bool hasNext,
    required int totalPages,
    required int count,
  }) = _PageInfo;
}

/// The backend's main pagination convention, used by every endpoint built on
/// `CommonUtils.get_paginated_queryset` (`utils/utils.py:45-151`): the page is
/// chosen with `pageIndex` and `perPage` (a `page` parameter is ignored), and
/// the reply carries `{data, pagination: {count, totalPages, isNext, isPrev,
/// nextPage}}` under `response`.
abstract final class PageIndexPaging {
  const PageIndexPaging._();

  static const int defaultPerPage = 20;

  static Map<String, Object> query(int pageIndex, {int perPage = defaultPerPage}) =>
      {'pageIndex': pageIndex, 'perPage': perPage};

  static PageInfo parse(Map<String, dynamic>? pagination) => PageInfo(
        hasNext: pagination?['isNext'] as bool? ?? false,
        totalPages: pagination?['totalPages'] as int? ?? 1,
        count: pagination?['count'] as int? ?? 0,
      );
}

/// A list built up page by page. A failed "load more" keeps [items] and
/// records [loadMoreError], so the screen can offer a retry instead of
/// replacing what the user already sees with an error.
@freezed
abstract class PagedState<T> with _$PagedState<T> {
  const factory PagedState({
    required List<T> items,
    required bool hasMore,
    @Default(false) bool isLoadingMore,
    Object? loadMoreError,
  }) = _PagedState<T>;
}

/// [current] followed by the items of [incoming] whose [key] isn't already
/// present. The first occurrence wins and order is preserved.
List<T> mergeUniqueBy<T, K>(List<T> current, List<T> incoming, K Function(T) key) {
  final seen = {for (final item in current) key(item)};
  return [
    ...current,
    for (final item in incoming)
      if (seen.add(key(item))) item,
  ];
}
