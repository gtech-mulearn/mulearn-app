import 'package:dio/dio.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';

/// Dev-flavor only: warns when a response carries a list longer than
/// [threshold] — an endpoint the app reads whole that will grow with
/// production (every college, a user's entire karma history…). Lists that
/// can grow must be paged or capped on the server, and built lazily
/// (`MuPagedListView`); see rules.md §3 "Lists that grow". Nothing is
/// changed or blocked; it surfaces the next unbounded list in testing
/// rather than in production.
class LargeListInterceptor extends Interceptor {
  LargeListInterceptor({this.threshold = 200, void Function(String)? warn})
    : _warn = warn ?? appLogger.w;

  final int threshold;
  final void Function(String) _warn;

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final longest = _longestList(response.data, depth: 0);
    if (longest > threshold) {
      _warn(
        'Large list: ${response.requestOptions.method} '
        '${response.requestOptions.path} returned $longest rows in one '
        'response. If it grows with production, page it and build it '
        'lazily (rules.md §3).',
      );
    }
    handler.next(response);
  }

  /// The longest list in the envelope's payload (two levels down covers
  /// `response`, `response.data` and `response.colleges`-style keys).
  static int _longestList(Object? node, {required int depth}) {
    if (node is List) return node.length;
    if (node is Map && depth < 3) {
      var longest = 0;
      for (final v in node.values) {
        final n = _longestList(v, depth: depth + 1);
        if (n > longest) longest = n;
      }
      return longest;
    }
    return 0;
  }
}
