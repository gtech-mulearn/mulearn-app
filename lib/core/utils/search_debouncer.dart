import 'dart:async';

/// How long typing has to pause before a search goes to the server.
const searchDebounce = Duration(milliseconds: 350);

/// Turns keystrokes into server searches without flooding the server.
///
/// It waits for a pause in typing, trims and collapses spaces, and skips a
/// query that hasn't changed (a trailing space, retyping the same word).
/// It also waits for a second character, because one letter matches nearly
/// everyone. Clearing the field applies at once, and so does the keyboard's
/// search key ([submit]).
class SearchDebouncer {
  /// Calls [_apply] with each settled query.
  SearchDebouncer(
    this._apply, {
    this.delay = searchDebounce,
    this.minLength = 2,
  });

  final void Function(String query) _apply;

  /// The pause that counts as "done typing".
  final Duration delay;

  /// The shortest query worth a request.
  final int minLength;

  String _last = '';
  Timer? _timer;

  /// [text] with its ends trimmed and inner runs of spaces collapsed.
  static String normalize(String text) =>
      text.trim().replaceAll(RegExp(r'\s+'), ' ');

  /// The field changed.
  void onChanged(String text) {
    _timer?.cancel();
    final query = normalize(text);
    if (query.isEmpty) return _emit(query);
    if (query.length < minLength) return;
    _timer = Timer(delay, () => _emit(query));
  }

  /// The search key: run now, even a one-letter query or a repeat.
  void submit(String text) {
    _timer?.cancel();
    _last = normalize(text);
    _apply(_last);
  }

  /// Forget a pending search and the last query (filters were cleared).
  void reset() {
    _timer?.cancel();
    _last = '';
  }

  void _emit(String query) {
    if (query == _last) return;
    _last = query;
    _apply(query);
  }

  /// Cancels a pending search.
  void dispose() => _timer?.cancel();
}
