import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'local_prefs_provider.g.dart';

/// Local, non-sensitive key/value store for small UI-state flags (e.g. "was
/// this popup already shown today") — kept separate from
/// `secure_storage_provider.dart`, which rules.md §1 reserves for tokens
/// only. `shared_preferences` is a new dependency added for this, flagged
/// per rules.md §9 rather than pulled in silently.
///
/// [SharedPreferencesAsync] needs no `getInstance()`/init step (unlike the
/// older `SharedPreferences` API), so this provider can stay synchronous.
@Riverpod(keepAlive: true)
SharedPreferencesAsync localPrefs(Ref ref) => SharedPreferencesAsync();
