import 'dart:collection';

import 'package:flutter_riverpod/misc.dart' show KeepAliveLink;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recent_results.g.dart';

/// How long a kept result counts as fresh.
const recentResultsTtl = Duration(minutes: 2);

/// The last few search results kept in memory, so backspacing to an
/// earlier query or switching back to a tab shows them at once instead of
/// asking the server again. Only the newest [max] are kept; older ones are
/// released (and disposed once nothing shows them).
class RecentResults {
  /// Keeps up to [max] results.
  RecentResults({this.max = 12});

  /// How many results stay in memory.
  final int max;

  final _links = Queue<KeepAliveLink>();

  void _add(KeepAliveLink link) {
    _links.addLast(link);
    while (_links.length > max) {
      _links.removeFirst().close();
    }
  }

  void _remove(KeepAliveLink link) => _links.remove(link);
}

/// The app-wide [RecentResults].
@Riverpod(keepAlive: true)
RecentResults recentResults(Ref ref) => RecentResults();

/// Keeps a search provider's result in memory for a while; see [RecentResults].
extension KeepRecentResults on Ref {
  /// Call first in a query-keyed provider's build. A kept result older than
  /// [ttl] refetches when a screen shows it again.
  void keepRecent({Duration ttl = recentResultsTtl}) {
    final link = keepAlive();
    final recent = read(recentResultsProvider).._add(link);
    final at = DateTime.now();
    onDispose(() => recent._remove(link));
    onResume(() {
      if (DateTime.now().difference(at) > ttl) invalidateSelf();
    });
  }
}
