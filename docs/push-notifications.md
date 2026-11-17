# Push notifications

The app receives Firebase Cloud Messaging pushes. The backend decides what to send, when, and how often: see `docs/push-notifications.md` in mulearnbackend for the engine, caps and quiet hours. This page covers the app side.

## Turning it on

Push is off in any build without Firebase config, and the app works the same either way.

1. **Firebase project.** In the Firebase console, add two Android apps to the same project:
   - `org.mulearn.muapp.dev` (dev flavor)
   - `org.mulearn.muapp` (prod)
2. **Client config, per flavor.** Copy each app's values into its `.env` file:

   | Variable | Where to find it |
   |---|---|
   | `FIREBASE_API_KEY` | Web API key |
   | `FIREBASE_APP_ID` | App ID, `1:…:android:…` |
   | `FIREBASE_MESSAGING_SENDER_ID` | Sender ID |
   | `FIREBASE_PROJECT_ID` | Project ID |

   - `.env.dev` is committed: these values are client config, not secrets.
   - `.env.prod` is injected in CI.
   - After editing either file, run `dart run build_runner build`. Commit only `env.g.dart`; other generated files rewritten with different line endings stay unchanged.
3. **Backend.** Set `FIREBASE_CREDENTIALS` to the same project's service-account JSON, and run one `celery-beat` process.

There is no `google-services.json` and no Google Services Gradle plugin. `bootstrap` calls `Firebase.initializeApp` with the options from `FlavorConfig.firebaseOptions`.

## How it behaves

| When | What happens |
|---|---|
| Signed in, permission granted | The FCM token is registered (`POST /api/v1/push/devices/`) once per app start and again when FCM rotates it. |
| Permission not asked yet | Home's "Get set up" shows **Turn on notifications**. The system prompt appears only when the user taps it; the app never asks on first launch. |
| App in the foreground | A push is shown as a local notification on the `mulearn_default` channel. |
| App in the background or closed | FCM shows the push itself (channel and icon set in `AndroidManifest.xml`). |
| A push is tapped | `PushOpenListener` opens its screen and reports the open (`POST /api/v1/push/opened/`), which feeds the backend's fatigue rule (details below). |
| Sign-out | The device is unregistered while the session is still valid, then the FCM token is deleted, so a shared phone never gets the previous account's pushes. |

How a tapped push opens its screen:
- Nudges and campaigns carry a `route` chosen by the server.
- Activity pushes carry the notification's type and entity, and open exactly where a tap in the notification feed would (`pushTarget` reuses `notificationTarget`).

The fatigue rule: unopened reminders make the backend send reminders less often.

Settings → **Notifications** shows:
- the phone's permission
- push on/off
- reminders on/off
- quiet hours
- which topics to hear about

These are stored server-side (`/api/v1/push/preferences/`), so they follow the account to a new phone.

## Code

- `lib/core/notifications/push/`
  - `push_messaging.dart`: `FirebasePushMessaging`, or `NoopPushMessaging` when there is no config
  - `push_controller.dart`: registration, permission, sign-out
  - `push_remote_datasource.dart`
  - `push_preferences.dart`
- `lib/app/widgets/push_open_listener.dart`: routes taps
- `lib/features/notifications/domain/push_target.dart`
- `lib/features/profile/presentation/providers/push_preferences_controller.dart`
- Tests:
  - `test/core/notifications/push/`
  - `test/features/notifications/domain/push_target_test.dart`

## Known follow-ups

- **Token API.** firebase_messaging 17 deprecates the token API (`getToken`, `onTokenRefresh`, `deleteToken`) in favour of `register()`/`onRegistered`, which uses Firebase Installation IDs for FCM direct send. The backend sends to registration tokens, so both sides should move together.
- **iOS.** It needs APNs setup in Firebase, the iOS app registered, and an iOS dev flavor (none exists yet).
- **Time zone.** The device doesn't send its time zone yet. That needs an IANA-name source (for example `flutter_timezone`). The backend uses the user's saved setting, or `Asia/Kolkata`.
