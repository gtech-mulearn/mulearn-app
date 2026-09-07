import 'package:mulearn_app/core/storage/local_prefs_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'rank_popup_gate.g.dart';

/// Rate-limits the "your rank" celebratory popup on [LeaderboardScreen] to
/// at most once per calendar day — the user explicitly asked for "only one
/// time" within a day, reappearing "the next day". Backed by
/// `shared_preferences` (`core/storage/local_prefs_provider.dart`), not
/// `flutter_secure_storage`, since this is just a local UI-state flag, not
/// sensitive data (rules.md §1 reserves secure storage for tokens only).
class RankPopupGate {
  const RankPopupGate(this._prefs);

  final SharedPreferencesAsync _prefs;

  static const _key = 'leaderboard_rank_popup_last_shown_date';

  static String _dateKey(DateTime day) =>
      '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';

  /// True if the popup hasn't been shown yet today (device-local calendar
  /// day — not tied to any server clock).
  Future<bool> shouldShowToday() async {
    final last = await _prefs.getString(_key);
    return last != _dateKey(DateTime.now());
  }

  Future<void> markShownToday() =>
      _prefs.setString(_key, _dateKey(DateTime.now()));
}

@Riverpod(keepAlive: true)
RankPopupGate rankPopupGate(Ref ref) =>
    RankPopupGate(ref.watch(localPrefsProvider));
