# Releases

μLearn ships through two fully separate GitHub release channels, driven by
GitHub Actions in [.github/workflows/](../.github/workflows/):

| Channel | Trigger | Flavor | Artifacts | Release type |
|---|---|---|---|---|
| Development | push to `dev` | `dev` (μLearn Dev, `org.mulearn.app.dev`, dev API) | APK | Pre-release, rolling `dev-latest` tag |
| Production | push a `v*` tag (from `production`) | `prod` (μLearn, `org.mulearn.app`, prod API) | APK + AAB | Stable release named after the tag |

A third workflow, `ci.yml`, runs `flutter analyze` + `flutter test` on every
pull request and on pushes to feature branches (rules.md §7).

---

## Development Release

Every push (or merged PR) to:

```
dev
```

automatically:

- Builds the release APK of the **dev flavor**
  (`flutter build apk --release --flavor dev -t lib/main_dev.dart`)
- Creates/updates the GitHub **Pre-release** tagged `dev-latest`
- Uploads the APK, named `mulearn-vX.Y.Z-dev.<run_number>.apk`

No manual work required.

The pre-release is *rolling*: each push deletes and recreates `dev-latest` on
the new commit, so there is always exactly one development release and testers
download from a stable URL:

```
https://github.com/<owner>/<repo>/releases/tag/dev-latest
```

The workflow run number is used as the Android `versionCode`, so each new dev
build installs cleanly over the previous one. The dev flavor uses the `.dev`
application-id suffix, so it coexists with the production app on one device.

---

## Production Release

Production releases happen **only** when a version tag is pushed — merging to
`production` alone does not release anything.

Steps:

1. Update `pubspec.yaml`

   ```yaml
   version: 1.5.0+24
   ```

   (Bump both the version name and the build number — the build number becomes
   the Android `versionCode` and must increase on every Play Store upload.)

2. Commit

3. Push (to `production`)

4. Create tag

   ```
   git tag v1.5.0
   ```

5. Push tag

   ```
   git push origin v1.5.0
   ```

GitHub Actions (`release-prod.yml`) will:

- Verify the tag matches the `pubspec.yaml` version (fails fast on mismatch)
- Run `flutter analyze` and `flutter test`
- Build the production APK
  (`flutter build apk --release --flavor prod -t lib/main_prod.dart`)
- Build the production AAB
  (`flutter build appbundle --release --flavor prod -t lib/main_prod.dart`)
- Create a stable GitHub Release named after the tag, with **auto-generated
  release notes**
- Upload `mulearn-vX.Y.Z.apk` and `mulearn-vX.Y.Z.aab`

The AAB is what you upload to the Google Play Console; the APK is for direct
distribution / sideloading.

---

## Required GitHub Secrets

| Secret | Value |
|---|---|
| `ANDROID_KEYSTORE` | The release keystore (`.jks`), **base64-encoded** (see below) |
| `ANDROID_KEYSTORE_PASSWORD` | Keystore (store) password chosen when creating it |
| `ANDROID_KEY_ALIAS` | Key alias inside the keystore (e.g. `upload`) |
| `ANDROID_KEY_PASSWORD` | Password for that key (often the same as the store password) |

`GITHUB_TOKEN` is built-in and used to publish releases — no setup needed.

### Where to add them

**Repository-wide (simplest):** GitHub repo → **Settings** →
**Secrets and variables → Actions** → **Secrets** tab →
**New repository secret**. Add each of the four secrets by name. Both release
workflows will see them.

**Environment-scoped (recommended):** the release jobs already run in GitHub
environments, so secrets can be isolated per channel. Go to **Settings →
Environments**, create/open **Production** (spelling must match the workflow
exactly), and add the four secrets under **Environment secrets**. Repeat for
**Development** if dev builds should be release-signed too — recommended with
a shared keystore, otherwise dev APKs are debug-signed and testers must
uninstall/reinstall when the signature changes.

**If the signing secrets are missing, the workflows still run** but sign with
debug keys and emit a warning. Debug-signed builds are fine for early internal
testing but **cannot be uploaded to Google Play**, and switching keystores
later means testers must uninstall/reinstall (signature mismatch). Set the
secrets up before relying on either channel.

No secret is needed for the API host: `envied` output (`lib/core/config/env.g.dart`)
is committed, and CI does not run `build_runner`. If CI is ever changed to run
`build_runner`, it will additionally need `.env.prod` provided (e.g. from a
secret), since that file is intentionally not committed.

### Creating the keystore (one-time)

```bash
keytool -genkey -v -keystore upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 -alias upload

# Base64-encode it for the ANDROID_KEYSTORE secret:
base64 -w 0 upload-keystore.jks          # Linux
base64 -i upload-keystore.jks | tr -d '\n'  # macOS
[Convert]::ToBase64String([IO.File]::ReadAllBytes("upload-keystore.jks")) | Set-Clipboard  # PowerShell (copies to clipboard)
```

Keep the `.jks` file and passwords in a password manager. Never commit them —
`.gitignore` already excludes `android/key.properties` and `*.jks`.

### Local release signing (optional)

To produce a properly signed build locally, place the keystore at
`android/app/upload-keystore.jks` and create `android/key.properties`:

```properties
storeFile=upload-keystore.jks
storePassword=<store password>
keyAlias=upload
keyPassword=<key password>
```

Without this file, release builds fall back to debug signing (so
`flutter run --release` keeps working with zero setup).

---

## GitHub Environments

The release jobs run in GitHub environments:

- `Development` — used by `release-dev.yml`
- `Production` — used by `release-prod.yml`

GitHub creates them automatically on first run. Scope the signing secrets per
environment to keep production credentials isolated (see "Where to add them"
above). On the `Production` environment you can additionally enable
**required reviewers** to gate releases behind a manual approval.

---

## Future improvements

- **Protect the release branches**: require PRs + green CI into `dev` and
  `production` so untested code can't reach a release build.
- **Play Store delivery**: add a step (e.g. `r0adkll/upload-google-play` or
  Fastlane `supply`) to push the AAB to a Play internal testing track
  automatically.
- **Pin the Flutter version**: workflows currently track the latest stable
  channel; pin an exact `flutter-version` in the workflows for fully
  reproducible builds, and bump it deliberately.
- **Changelog discipline**: auto-generated notes are compiled from merged PR
  titles — keep PR titles user-readable, or adopt release-drafter /
  conventional commits for richer notes.
- **Obfuscation**: consider `--obfuscate --split-debug-info=...` for production
  builds once crash reporting that can symbolicate is in place.
