# μLearn Flutter App — Architecture Proposal

**Stack:** Riverpod 3.0 (code‑gen) · go_router · envied · Dio + Retrofit · Freezed
**Pattern:** Feature‑first Clean Architecture (Data / Domain / Presentation)

---

## 1. Why this stack

| Concern | Choice | Why |
|---|---|---|
| State management | **Riverpod 3.0** (`riverpod_generator`) | Compile-time safety, no `BuildContext` dependency, first‑class async (`AsyncNotifier`/`AsyncValue`), scoped overrides make testing trivial. This is the Flutter-team-endorsed default for new apps in 2026 — Bloc is heavier ceremony you don't need unless you have audit/compliance requirements, and GetX's maintainer/repo instability this year is a real cautionary tale for anything you plan to run for years. |
| Routing | **go_router** | Maintained by the Flutter team itself, declarative, built-in deep linking, nested navigators (great for a bottom-nav shell), and `redirect` reads straight from Riverpod providers for auth guards. |
| Env config | **envied** (keep, upgrade from dotenv-style) | Values are baked in at build time via code-gen + obfuscation, instead of shipping a plaintext `.env` in assets. Type-safe (`String`, `bool`, `int` fields, not string parsing at runtime). Pairs with `--dart-define` for CI secrets. |
| Networking | **Dio + Retrofit** | Interceptors for auth headers/refresh-token logic, typed API clients generated from annotations, easy to mock in tests. |
| Models | **Freezed + json_serializable** | Immutable domain models, union types for `AsyncValue`-style states, `copyWith` for free, exhaustive `when`/`map` pattern matching. |
| HTTP response cache | **dio_cache_interceptor** + Hive store | Caches API responses per-endpoint policy — see section 12. No offline-first datastore needed since the app requires network. |
| Secure storage | **flutter_secure_storage** | Tokens, refresh tokens — never in SharedPreferences. |
| Testing | **mocktail + riverpod's `ProviderContainer` overrides** | No codegen needed for mocks, very ergonomic with Riverpod. |
| Lints | **very_good_analysis** or **flutter_lints** (strict) | Enforced style, catches footguns pre-review. |
| Images/SVG | **flutter_svg + cached_network_image** | μLearn's brand assets (rocket/UFO illustrations, gradient icons) are likely SVG — this renders them natively instead of rasterizing. |
| Fonts | **google_fonts** or bundled variable font | Matches the `--font-display` token from your CSS. |
| Crash/analytics | **Firebase Crashlytics + Analytics**, or **Sentry** | Pick one; Sentry is nicer if you're not otherwise in the Firebase ecosystem. |

---

## 2. Folder Structure

Feature-first, not layer-first at the top level — this is what actually scales with team size, because two engineers can work on `auth/` and `leaderboard/` without touching the same files.

```
lib/
├── main.dart
├── main_dev.dart / main_prod.dart      # flavor entrypoints
├── bootstrap.dart                      # shared init: envied, cache store, error handlers
│
├── core/
│   ├── config/
│   │   ├── env.dart                    # envied @Envied class
│   │   └── flavor_config.dart
│   ├── theme/
│   │   ├── mulearn_colors.dart         # ports your CSS tokens 1:1
│   │   ├── mulearn_typography.dart
│   │   ├── mulearn_theme.dart          # ThemeData
│   │   └── mulearn_gradients.dart      # the trusty-blue → duke-purple gradient
│   ├── network/
│   │   ├── dio_provider.dart
│   │   ├── auth_interceptor.dart       # token refresh
│   │   └── api_exception.dart
│   ├── router/
│   │   ├── app_router.dart             # go_router config + redirect guards
│   │   └── route_paths.dart
│   ├── storage/
│   │   ├── secure_storage_provider.dart
│   │   └── cache_store_provider.dart   # dio_cache_interceptor Hive store instance
│   ├── widgets/                        # shared dumb widgets (buttons, cards, shimmer)
│   ├── utils/
│   └── extensions/
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── auth_remote_datasource.dart   # Retrofit interface
│   │   │   ├── dtos/
│   │   │   │   └── auth_response_dto.dart        # freezed + json_serializable
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── user.dart                     # pure Dart, freezed
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart          # abstract contract
│   │   │   └── usecases/
│   │   │       └── sign_in_usecase.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── auth_controller.dart          # @riverpod AsyncNotifier
│   │       ├── screens/
│   │       │   └── sign_in_screen.dart
│   │       └── widgets/
│   │
│   ├── dashboard/           # karma, streaks, level
│   ├── leaderboard/
│   ├── courses/             # or "learning_paths"
│   ├── events/
│   ├── profile/
│   └── ...
│
└── l10n/                    # if μLearn supports multiple languages
```

**Rule of thumb:** `core/` never imports from `features/`. `features/*` can share via `core/` only — never import directly from one feature into another. If two features need the same logic, promote it to `core/` or a shared package.

---

## 3. Layer responsibilities (per feature)

```
presentation → domain → data
     ↑                     ↓
     └──── never skips a layer ────┘
```

- **domain/** — pure Dart, zero Flutter/Dio imports. Entities are immutable (Freezed). Repository *contracts* are abstract classes here; the actual HTTP implementation lives in `data/`. This is what makes the domain layer unit-testable with zero mocking of Flutter.
- **data/** — DTOs (raw API shape) are separate from domain entities on purpose, so a backend field rename doesn't ripple through your UI — you only update the `toDomain()` mapper.
- **presentation/** — Riverpod `@riverpod` controllers (`AsyncNotifier`) call use cases, expose `AsyncValue<T>` to widgets. Widgets are dumb: `ref.watch(controllerProvider)` → `.when(data:, error:, loading:)`.

---

## 4. State management pattern

Use **code-gen Riverpod** (`@riverpod` annotations), not manual `StateNotifierProvider` — less boilerplate, better IDE support, and it's the direction Riverpod itself has moved toward as the default.

```dart
@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<User?> build() => ref.watch(authRepositoryProvider).currentUser();

  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).signIn(email, password),
    );
  }
}
```

Screens never call repositories directly — always through a controller. This keeps every side-effect testable via `ProviderContainer` overrides without touching widgets.

---

## 5. Routing — go_router + auth guard

```dart
final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final loggedIn = authState.valueOrNull != null;
      final loggingIn = state.matchedLocation == '/sign-in';
      if (!loggedIn && !loggingIn) return '/sign-in';
      if (loggedIn && loggingIn) return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/sign-in', builder: (_, __) => const SignInScreen()),
      ShellRoute(
        builder: (_, __, child) => AppShell(child: child), // bottom nav
        routes: [
          GoRoute(path: '/home', builder: (_, __) => const DashboardScreen()),
          GoRoute(path: '/leaderboard', builder: (_, __) => const LeaderboardScreen()),
          GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
        ],
      ),
    ],
  );
});
```

Because `redirect` reads a Riverpod provider directly, you can test the entire auth-guard logic by overriding `authControllerProvider` in a `ProviderContainer` — no widget pump needed.

---

## 6. Backend integration — Django REST + SimpleJWT + drf-spectacular

Since the backend is Django REST Framework with **SimpleJWT** and **drf-spectacular** already exposing an OpenAPI schema, two things change from a generic setup:

### 6a. Generate the API client — don't hand-write Retrofit interfaces

Point a generator at the live schema (`/api/schema/` is the default drf-spectacular URL) and regenerate whenever the backend changes, instead of maintaining Retrofit annotations by hand:

```yaml
# openapi-generator config (or use the `openapi_generator` Dart package as a build_runner step)
generatorName: dart-dio
inputSpec: https://api.mulearn.org/api/schema/
outputDir: lib/core/network/generated
```

This gets you typed request/response models and an API client that can't silently drift from the backend. Treat `lib/core/network/generated/` as a build artifact — regenerate on schema changes, don't hand-edit it. Your hand-written `domain/` entities stay separate from these generated DTOs; a thin mapper (`toDomain()`) sits between them, same as in the Freezed DTO pattern from section 3. That mapper layer is what protects your app if the backend renames a field — you fix one mapper function, not every screen that used that field.

If the generated Dio client feels heavier than you want for every endpoint, it's fine to mix: use the generated client for CRUD-heavy resources (courses, events, profile) and a couple of hand-written Retrofit interfaces for anything with unusual request shapes.

### 6b. JWT refresh flow

SimpleJWT gives you a short-lived access token + longer-lived refresh token. The interceptor needs to catch a 401, attempt a silent refresh, and retry the original request exactly once (to avoid infinite loops on a truly expired refresh token):

```dart
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._dio, this._secureStorage);
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;
  bool _isRefreshing = false;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await _secureStorage.read(key: 'access_token');
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;
      try {
        final refreshToken = await _secureStorage.read(key: 'refresh_token');
        final response = await _dio.post(
          '/api/token/refresh/',
          data: {'refresh': refreshToken},
          options: Options(headers: {'skipAuth': true}), // avoid recursive interceptor call
        );
        final newAccess = response.data['access'] as String;
        await _secureStorage.write(key: 'access_token', value: newAccess);

        // retry original request with new token
        final retryOptions = err.requestOptions
          ..headers['Authorization'] = 'Bearer $newAccess';
        final retryResponse = await _dio.fetch(retryOptions);
        _isRefreshing = false;
        return handler.resolve(retryResponse);
      } catch (_) {
        _isRefreshing = false;
        await _secureStorage.deleteAll();
        // trigger sign-out via authControllerProvider, which flips go_router's redirect
        return handler.next(err);
      }
    }
    handler.next(err);
  }
}
```

The `_isRefreshing` flag prevents a refresh-storm if multiple requests 401 simultaneously — without it, five concurrent failed requests trigger five parallel refresh calls. A more robust version queues the pending requests and replays them all after one refresh completes; worth doing once you have more than a couple of screens firing concurrent requests (e.g. a dashboard loading karma + leaderboard + events at once).

On unrecoverable refresh failure, clear secure storage and let `authControllerProvider`'s state flip to unauthenticated — the go_router `redirect` from section 5 picks that up automatically and bounces to `/sign-in`, no manual navigation call needed.

---

## 7. Environment config — envied

```dart
@Envied(path: '.env.dev', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'API_BASE_URL')
  static const String apiBaseUrl = _Env.apiBaseUrl;

  @EnviedField(varName: 'MULEARN_API_KEY', obfuscate: true)
  static const String apiKey = _Env.apiKey;
}
```

Pair with **Flutter flavors** (`flutter run --flavor dev -t lib/main_dev.dart`) so dev/staging/prod point at different `.env.*` files and different app icons/bundle IDs. Never commit `.env.prod` — inject prod secrets via CI `--dart-define-from-file` at build time.

---

## 8. Theming — ported from your landing page tokens

Your CSS custom properties map directly onto a Dart `ThemeExtension`, so the app and the web landing page stay visually identical:

```dart
class MulearnColors {
  static const primary = Color(0xFF0961F5);
  static const trustyBlue = Color(0xFF2E85FE);
  static const dukePurple = Color(0xFFAF2EE6);
  static const greyish = Color(0xFFC4C4C4);
  static const blackish = Color(0xFF1A1A1A);
  static const whitish = Color(0xFFFEFEFE);
  static const gray600 = Color(0xFF666771);

  static const trustyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [trustyBlue, dukePurple], // 135deg 0% → 100%
  );
}
```

Keep this in `core/theme/mulearn_colors.dart` as the single source of truth — same idea as your `:root` block, just Dart-side. Radius (`0.625rem` → ~10px), heading weights (black/bold/semibold per `h1`–`h5`), and the gradient direction all carry over 1:1.

---

## 9. Testing strategy

- **Domain/usecases:** pure unit tests, no mocks needed if repos are interfaces.
- **Controllers:** `ProviderContainer(overrides: [...])` + mocktail for repository mocks.
- **Widgets:** `flutter_test` + `patrol` if you need real device interactions (deep links, permissions) beyond what `WidgetTester` covers.
- **Golden tests:** worth it for brand-critical screens (onboarding, leaderboard) so the gradient/typography never regresses silently.

---

## 10. CI/CD suggestion

- **Fastlane** or **Codemagic** for build/release automation (both have solid Flutter support).
- Lint + `flutter analyze` + `flutter test --coverage` as required PR checks.
- `build_runner` (Freezed/Riverpod/Retrofit codegen) run in CI, not committed — keep generated `.g.dart`/`.freezed.dart` out of version control if your team is disciplined about running codegen locally, or commit them if onboarding friction matters more (common for smaller teams — μLearn's contributor base is probably mostly volunteers, so committing generated files may actually reduce setup pain).

---

## 11. Package list (pubspec)

```yaml
dependencies:
  flutter_riverpod: ^3.0.0
  riverpod_annotation: ^3.0.0
  go_router: ^15.0.0
  dio: ^5.7.0
  retrofit: ^4.4.0        # for the handful of hand-written, non-standard endpoints
  freezed_annotation: ^2.4.4
  json_annotation: ^4.9.0
  envied: ^0.5.4
  flutter_secure_storage: ^9.2.2
  cached_network_image: ^3.4.1
  flutter_svg: ^2.0.10
  google_fonts: ^6.2.1
  intl: ^0.19.0

dev_dependencies:
  build_runner: ^2.4.13
  riverpod_generator: ^3.0.0
  freezed: ^2.5.7
  json_serializable: ^6.8.0
  retrofit_generator: ^9.1.5
  # generates the Dio API client from the live drf-spectacular OpenAPI schema —
  # see section 6a; regenerate lib/core/network/generated/ whenever the schema changes
  openapi_generator: ^5.0.0
  envied_generator: ^0.5.4
  mocktail: ^1.0.4
  very_good_analysis: ^6.0.0
```

*(Pin exact versions at implementation time — check pub.dev for whatever's current when you actually start the project, since I'm giving you the shape of the stack, not a live version lock.)*

---

## 12. Caching — client side

Since the app requires network (no offline-first), Isar/Drift as a full offline datastore is overkill — drop it. What you actually need is an **HTTP cache layer**, which is a much smaller piece: cache API *responses*, not build a local source of truth.

### 12a. `dio_cache_interceptor`

This sits in the Dio interceptor chain (alongside the auth interceptor from section 6b) and transparently caches GET responses per-endpoint policy:

```dart
final cacheStore = HiveCacheStore(cacheDirPath); // or MemCacheStore for RAM-only

final cacheOptions = CacheOptions(
  store: cacheStore,
  policy: CachePolicy.request,        // honor server Cache-Control by default
  hitCacheOnErrorExcept: [401, 403],  // serve stale cache if network fails, except auth errors
  maxStale: const Duration(days: 3),  // hard ceiling even if server says cache longer
);

dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));
```

Order matters: put the cache interceptor **before** the auth interceptor in the chain, so a cache hit skips the token-attach/refresh logic entirely — that's most of the latency win.

### 12b. Per-endpoint policy, not one global rule

Different μLearn resources have very different staleness tolerance — don't use one TTL for everything:

| Resource | Policy | Why |
|---|---|---|
| Leaderboard | short TTL (~30–60s) or `refresh` on pull-to-refresh | Changes often, users notice stale rank |
| Course/learning-path content | long TTL (hours) or `forceCache` | Rarely changes once published |
| User profile / karma | `CachePolicy.request` + cache-bust on any mutation | Must reflect the user's own recent actions immediately |
| Events list | medium TTL (~5 min) | Changes moderately |

Override `CacheOptions` per-request rather than globally:
```dart
dio.get('/api/leaderboard/', options: CacheOptions(policy: CachePolicy.refresh).toOptions());
```

### 12c. Cache invalidation on writes

The interceptor caches GETs; it does nothing automatically when a POST/PATCH changes the same data. After any mutation, explicitly delete the affected cache key(s):
```dart
await cacheStore.delete(CacheOptions(store: cacheStore).keyBuilder(RequestOptions(path: '/api/profile/')));
```
Wrap this in your repository layer (`data/repositories/`) right after a successful mutation call — that's the one place that knows both "what changed" and "what cache keys that affects," so it shouldn't leak into controllers.

### 12d. Stale-while-revalidate feel

For screens where a slightly-stale-but-instant load beats a spinner (dashboard, leaderboard), show the cached `AsyncValue.data` immediately while a background refresh runs, rather than blocking on `AsyncLoading`. Riverpod's `AsyncNotifier` supports this pattern via `state = AsyncData(cachedValue, isRefreshing: true)` conceptually — practically, keep last-good state visible and only show a small inline refresh indicator, not a full-screen loader, on refetch.

---

## 13. Caching — server side (Django)

Client caching only helps if the server sets sane cache headers, and Django's own cache layer reduces DB load regardless of what the client does.

### 13a. Cache backend

Use **Redis** (`django-redis`) as `CACHES['default']` — it's the standard choice, supports TTL natively, and can double as your Celery broker if μLearn already uses one, avoiding a second piece of infra.

### 13b. View-level caching

For read-heavy public endpoints (leaderboard, public course catalog):
```python
from django.utils.decorators import method_decorator
from django.views.decorators.cache import cache_page
from django.views.decorators.vary import vary_on_headers

@method_decorator(cache_page(60), name='list')        # 60s server-side cache
@method_decorator(vary_on_headers("Authorization"), name='list')
class LeaderboardViewSet(viewsets.ReadOnlyModelViewSet):
    ...
```
`vary_on_headers("Authorization")` matters — without it, Django's cache can leak one user's response to another if the endpoint is ever auth-aware.

### 13c. Send proper Cache-Control headers so the client interceptor has something to honor

```python
from django.utils.cache import patch_response_headers

def list(self, request, *args, **kwargs):
    response = super().list(request, *args, **kwargs)
    patch_response_headers(response, cache_timeout=60)
    return response
```
This is what makes section 12a's `CachePolicy.request` actually useful — the client respects whatever `Cache-Control: max-age=60` the server sends, so you tune staleness in one place (Django) instead of hardcoding TTLs on both ends.

### 13d. Cache invalidation on the backend

Mirror the client-side approach: bust the relevant Redis keys on write, via Django signals:
```python
from django.core.cache import cache
from django.db.models.signals import post_save
from django.dispatch import receiver

@receiver(post_save, sender=KarmaLog)
def invalidate_leaderboard_cache(sender, **kwargs):
    cache.delete_pattern("*leaderboard*")  # requires django-redis's delete_pattern
```

### 13e. ETags for conditional requests

For endpoints where payload is large but changes infrequently (course content, user profile), Django's `ConditionalGetMiddleware` + DRF's `django-rest-framework` supports `ETag`/`If-None-Match`, so the client gets a cheap `304 Not Modified` instead of re-downloading the full payload when nothing changed — pairs well with `dio_cache_interceptor`, which understands ETags out of the box.

### 13f. CDN in front, for truly public data

If leaderboard/course-catalog data is public (no auth required to view), put Cloudflare or similar in front of those specific endpoints — edge caching means most requests never even hit Django. Don't do this for anything auth-scoped; keep the CDN layer strictly to public, unauthenticated reads.

---

## 14. Updated package additions

```yaml
dependencies:
  dio_cache_interceptor: ^3.5.1
  dio_cache_interceptor_hive_store: ^3.2.2   # persistent cache store backed by Hive
```

The package list and folder structure in earlier sections have been updated above to reflect this — no offline datastore, just the HTTP cache layer. If a specific feature later needs true offline capability (e.g. drafting a post with no signal), that's a narrow, local decision for that feature, not a blanket architecture choice.
