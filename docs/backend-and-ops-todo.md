# Backend and ops TODO for the app

Work the app needs but can't do itself: this round changes no backend, authserver or hosting (spec §2). Each item gives the ask, why the app needs it, and what the app does once it exists. Keep this file current; Plan close-outs update it.

## Platform asks

### 1. Push notifications (FCM/APNs) — FEAT-16
- **Ask (backend):**
  - Register and unregister device tokens, e.g. `POST/DELETE /api/v1/notification/devices/ {token, platform, app_version}`. A token is scoped to the signed-in user and removed on logout.
  - Add an FCM delivery adapter to `NotificationService.dispatch()`. `TypeMeta` already lists `PUSH` as eligible, and `templates.py` reserves PUSH copy for "Phase 2".
  - Send a data payload carrying `type`, `entity_type`, `entity_id`, `redirect_url` and the new `unread_count`. The app then updates its badge without calling `unread-count`.
- **Ask (ops):**
  - a Firebase project with the dev and prod Android apps (`org.mulearn.muapp.dev`, `org.mulearn.muapp`) → `google-services.json` per flavour;
  - an APNs auth key for iOS;
  - FCM server credentials stored in the backend environment.
- **Why:** the app refreshes notifications only on user actions, with no polling (Plan 3, Task 1). About 70k members share one backend, and a 60 s poll per foreground user is load for a number that rarely changes. Push gives real-time badges and background alerts with no polling: the OS keeps one shared connection per device.
- **App side once available:**
  - `firebase_messaging` (+ `flutter_local_notifications` for foreground display);
  - the permission prompt asked at a meaningful moment, not at launch;
  - register the token after sign-in and on token refresh; unregister in `SessionActions.signOut` before tokens are cleared;
  - a tap routes through `notificationTarget()` (Plan 3, Task 2);
  - a data message updates `UnreadNotifications` locally.
- **Status:** not started; blocked on the backend endpoints and the Firebase project.

### 2. Real-time notifications for the web dashboard (optional)
- **Ask (backend):**
  - A per-user Channels group, e.g. `ws/v1/notifications/`, authenticated with the JWT. Channels and a Redis channel layer already run for `landing-stats` and the circle chat, and the `WEBSOCKET` templates exist, but no consumer delivers notifications.
  - `dispatch()` does a `group_send` on write.
- **Why:** the dashboard polls the feed and the unread count every 60 s per open tab (`use-notification.ts`, `REFETCH_INTERVAL`). On mobile, FCM (item 1) is the better fit than holding a socket.

### 3. Discord connect App Link — UX-02
- **Ask (ops):** host `/.well-known/assetlinks.json` (and `apple-app-site-association` for iOS) on the host Discord redirects to.
  - **Dev:** the dev dashboard (`mulearn-dashboard.vercel.app`) sends Discord back to `https://mulearn-dev.vercel.app/dashboard/connect-discord`, an old Vite build outside this workspace. Either host the file there, or point the dev backend's `FR_DOMAIN` and the Discord app's redirect at `mulearn-dashboard.vercel.app` and add the file to `mulearn-dashboard/public/.well-known/` (feature branch from `dev`).
  - **Prod:** `app.mulearn.org` (`mulearn-dashboard`, Netlify) needs the file with the **Play App Signing SHA-256** fingerprint.
- **Also needed:** the production `DISCORD_AUTH_URL` for `.env.prod`.
- **App side:** done in Plan 3, Task 4 (intent-filter, in-app code exchange). Until the file is hosted, Android opens the web page instead of the app.

### 4. Google sign-in on Android — AUTH-02
- **Ask (ops):** the Google OAuth **web** client id for `GOOGLE_SERVER_CLIENT_ID`, plus Android OAuth clients registered with the app's signing fingerprints.
- **App side:** ready since Plan 1; the button stays hidden on Android until the value is set.

### 5. Crash reporting — ARCH-04
- **Ask (ops):** a Sentry DSN or a Firebase Crashlytics setup (it can share the item 1 project).
- **App side:** swap `LoggingCrashReporter` for the real reporter (Plan 2 hook). Filter user-input failures (`ApiErrorKind.validation`, `unauthorized`) so they aren't reported.

## Backend gaps the app works around

| # | Gap | What the app does today | Ask |
|---|---|---|---|
| 6 | Changing the password via `/dashboard/profile/change-password/` may not reach authserver logins (to be verified in Plan 3, Task 3) | Hides "Change password" if the new password can't sign in | Make password change and login use the same credential store |
| 7 | Account deletion: `DELETE /dashboard/profile/` hard-deletes with cascade (SEC-14) | "Delete account" emails support (`info@mulearn.org`) | A soft-delete request endpoint with a grace period, then deletion |
| 8 | Verifiable credentials can only be issued through the unauthenticated QSeverse proxy with client-chosen content (SEC-04) | "Issue" is hidden (`FeatureFlags.vcIssuance = false`) | A server-side issue endpoint that builds the credential itself |
| 9 | Email verification isn't deployed on dev (AUTH-04) | Not built | Deploy it to dev so it can be verified |
| 10 | `profile/user-log/` is unpaginated (PERF-02) | Loads the whole log | Page it (`pageIndex/perPage`) |
| 11 | Interest-group join cap: `InterestGroupMembershipAPI.post` checks the 3-group cap only when no link exists, so reactivating an old inactive link can exceed 3 (`dash_ig_view.py:1275`) | Enforces 3 in the UI (Plan 3, Task 11) | Apply the cap on reactivation too |
| 12 | `unread-count` counts personal notifications only, while the feed also has unread broadcasts | Badge = `unread_count`, like the dashboard | Include unread broadcasts, or document the rule |
| 13 | No `ETag`/`Last-Modified` on read endpoints | Refetches full bodies on refresh | Conditional GETs (`304`) for the profile, summary, feed and catalogs |
