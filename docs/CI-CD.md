# CI/CD

How μLearn's Android app is checked, built, signed and released. Everything
runs on GitHub Actions; the files live in [.github/](../.github/).

- [Architecture](#architecture)
- [Branch strategy](#branch-strategy)
- [Channels at a glance](#channels-at-a-glance)
- [Development builds (staging)](#development-builds-staging)
- [Stable builds (master)](#stable-builds-master)
- [Nightly builds](#nightly-builds)
- [Creating a release](#creating-a-release)
- [Release notes](#release-notes)
- [Versioning](#versioning)
- [Secrets and repository settings](#secrets-and-repository-settings)
- [Downloading and installing APKs](#downloading-and-installing-apks)
- [Troubleshooting](#troubleshooting)
- [Reproducing a build locally](#reproducing-a-build-locally)
- [Rotating signing credentials](#rotating-signing-credentials)

---

## Architecture

One reusable workflow does the real work; small caller workflows decide
*when* it runs and *what happens to the result*.

```
                      ┌──────────────────────── android-build.yml (reusable) ───────────────────────┐
ci.yml           ───► │  validate: format · analyze · test  ──►  build: APK (+AAB) · upload artifact │
build-dev.yml    ───► │                                            │                                 │
nightly.yml      ───► │  (build only starts when validate passed)  └─ signing from the job's         │
build-stable.yml ───► │                                               GitHub environment             │
release.yml      ───► └─────────────────────────────────────────────────────────────────────────────┘
                              build-dev.yml ──► publish: rolling `dev-latest` pre-release
                              release.yml   ──► check-tag (before) · publish: GitHub Release (after)
```

| File | Purpose |
|---|---|
| [`workflows/android-build.yml`](../.github/workflows/android-build.yml) | Reusable: pins Flutter 3.47.9 + JDK 21, validates, builds, uploads. The only place the toolchain is pinned. |
| [`workflows/ci.yml`](../.github/workflows/ci.yml) | Pull requests (any base) and feature-branch pushes. |
| [`workflows/build-dev.yml`](../.github/workflows/build-dev.yml) | Push to `staging`, or manual. |
| [`workflows/nightly.yml`](../.github/workflows/nightly.yml) | 20:30 UTC daily, builds `staging` if it moved. |
| [`workflows/build-stable.yml`](../.github/workflows/build-stable.yml) | Push to `master`, or manual. |
| [`workflows/release.yml`](../.github/workflows/release.yml) | Push of a `vX.Y.Z` tag on `master`. |
| [`workflows/triage.yml`](../.github/workflows/triage.yml) | Adds new issues/PRs to the Delivery board (unrelated to builds). |
| [`scripts/version.sh`](../.github/scripts/version.sh) | versionName, versionCode and artifact name per channel. |
| [`scripts/format_check.sh`](../.github/scripts/format_check.sh) | `dart format` gate (changed files) / report (whole repo). |
| [`scripts/setup_signing.sh`](../.github/scripts/setup_signing.sh) | Writes `android/key.properties` + keystore from the environment. |
| [`scripts/check_release_tag.sh`](../.github/scripts/check_release_tag.sh) | Refuses bad release tags before anything is built. |
| [`scripts/release_notes.sh`](../.github/scripts/release_notes.sh) | Categorised notes from commits since the previous tag. |
| [`dependabot.yml`](../.github/dependabot.yml) | Monthly PR into `dev` bumping the SHA-pinned actions. |

Security baseline: every third-party action is pinned to a full commit SHA;
every workflow defaults to `contents: read` and only the two publish jobs get
`contents: write`; signing secrets exist only in GitHub *environments*, and
`ci.yml` (pull requests, including forks) never receives any; the keystore is
written to `$RUNNER_TEMP`, outside the workspace, and removed after the build.

## Branch strategy

```
feature/*  ──PR──►  dev  ──PR──►  staging  ──PR──►  master  ──tag vX.Y.Z──►  GitHub Release
                   (no builds)       │                 │
                                     ├ dev build       └ stable build (signed, artifact only)
                                     │   + dev-latest
                                     └ nightly
```

- **`dev`** — default branch and integration branch. PRs into it are
  validated (format, analyze, test) but **nothing is built**.
- **`staging`** — QA. Every merge produces a dev-flavor build (artifact +
  `dev-latest`), and the nightly builds it.
- **`master`** — always production-ready. Every merge produces a signed stable
  APK; nothing is published until someone tags it.
- **Hotfix** — branch from `master`, PR into `master`, release, then bring the
  fix back with PRs `master → staging → dev` (or cherry-pick into `dev`).

Commit messages follow Conventional Commits (`feat(scope): …`, `fix: …` —
[rules.md §7](rules.md)); release notes are built from them.

## Channels at a glance

| | CI | Dev | Nightly | Stable | Release |
|---|---|---|---|---|---|
| Trigger | PR (any base); push to other branches | push to `staging`; manual | 20:30 UTC if `staging` moved; manual | push to `master`; manual | push tag `vX.Y.Z` on `master` |
| Flavor / app ID | dev | dev — `org.mulearn.muapp.dev` | dev — `org.mulearn.muapp.dev` | prod — `org.mulearn.muapp` | prod — `org.mulearn.muapp` |
| Signing | debug (none) | Development test key | Development test key | **Production key (required)** | **Production key (required)** |
| versionName | `1.0.0-ci.84` | `1.0.0-dev.84` | `1.0.0-nightly.20261115` | `1.0.0-stable.5af882d` | `1.0.0` |
| versionCode | commit count | commit count | commit count | pubspec `+N` | pubspec `+N` |
| Output | nothing (build check on PRs into `staging`/`master` only) | `mulearn-dev-1.0.0-84.apk` | `mulearn-nightly-1.0.0-20261115-5af882d.apk` | `mulearn-stable-1.0.0-1.apk` | `mulearn-1.0.0.apk`, `.aab`, `SHA256SUMS.txt` |
| Kept | — | 14 days + `dev-latest` | 14 days | 30 days | GitHub Release (forever) + 30-day artifact |
| GitHub Release | no | rolling `dev-latest` **pre-release** | no | no | yes |

The dev flavor has its own application ID, so Mulearn Dev and Mulearn install
side by side.

## Development builds (staging)

Every push to `staging` (normally a merged `dev → staging` PR):

1. validate — format report, `flutter analyze`, `flutter test`;
2. build the dev-flavor release APK, signed with the Development test key;
3. upload `mulearn-dev-<version>-<build>.apk` as a workflow artifact (14 days);
4. recreate the **`dev-latest`** pre-release with that APK. Testers bookmark
   <https://github.com/gtech-mulearn/mulearn-app/releases/tag/dev-latest>.

The run summary and the `dev-latest` notes list the branch, commit,
versionName, versionCode, build time (UTC) and APK SHA-256.

**Manual dev build of any branch** (e.g. a feature branch for QA): Actions →
*Dev build* → *Run workflow* → pick the branch. It uploads an artifact only;
`dev-latest` is refreshed by pushes to `staging` alone.

## Stable builds (master)

Every push to `master`: validate, then build the prod-flavor APK signed with
the **production key** and upload `mulearn-stable-<version>-<build>.apk`
(30 days). No GitHub Release is created. The build job runs in the
`Production` environment, so it waits for a reviewer's approval (see
[repository settings](#repository-settings)), then fails outright if the
signing values are missing — a stable APK is never debug-signed.

## Nightly builds

At **20:30 UTC (02:00 IST)** every day, `nightly.yml`:

1. resolves the current head of `staging` — and **fails with an error** if
   `staging` doesn't exist;
2. **skips the night** when that commit already has an unexpired nightly
   artifact (staging hasn't moved). A failed night leaves no artifact, so the
   next night tries again;
3. otherwise validates and builds that exact commit (dev flavor, test key) and
   uploads `mulearn-nightly-<version>-<yyyymmdd>-<sha>.apk`, kept 14 days.

The versionName is `<version>-nightly.<yyyymmdd>`, so a nightly is
distinguishable from staging-push or manual dev builds both by file name and
in the app's version. No release is created. Run one on demand with Actions →
*Nightly build* → *Run workflow* (tick *force* to rebuild an unchanged
commit).

GitHub runs schedules from the default branch (`dev`), so the copy of
`nightly.yml` on `dev` is the one that counts. GitHub also pauses schedules in
public repositories after 60 days without activity; re-enable from the
Actions tab.

## Creating a release

Releases are cut **only** from `master`, **only** by pushing a tag.

1. **Bump the version** in `pubspec.yaml`, in a PR into `dev`:

   ```yaml
   version: 1.1.0+2   # MAJOR.MINOR.PATCH+BUILD
   ```

   - MAJOR for breaking changes, MINOR for features, PATCH for fixes.
   - BUILD is the Android versionCode. It must be **greater** than the last
     release's — the release workflow refuses it otherwise.

   ```bash
   git switch dev && git pull --ff-only
   git switch -c chore/release-1.1.0
   # edit pubspec.yaml → version: 1.1.0+2
   git commit -am "chore(release): 1.1.0"
   git push -u origin chore/release-1.1.0
   gh pr create --base dev --title "chore(release): 1.1.0" --body "Version bump for v1.1.0"
   ```

2. **Promote `dev` → `staging`**, let QA test the `dev-latest` build, then
   **promote `staging` → `master`**:

   ```bash
   gh pr create --base staging --head dev     --title "Staging: 1.1.0"
   # …QA on dev-latest…
   gh pr create --base master  --head staging --title "Release 1.1.0"
   ```

   Merge each after CI passes (and review, per branch protection).

3. **Tag the merged commit on `master` and push the tag:**

   ```bash
   git switch master
   git pull --ff-only
   grep '^version:' pubspec.yaml          # must show 1.1.0+<build>
   git tag -a v1.1.0 -m "μLearn 1.1.0"
   git push origin v1.1.0
   ```

4. **Approve** the `Production` deployment when the run asks for it
   (Actions → *Release* → *Review deployments*).

`release.yml` then:

- checks the tag is `vMAJOR.MINOR.PATCH`, equals the pubspec version, points
  at a commit on `master`, and that version and build number both exceed the
  previous release tag's;
- validates the tagged commit (analyze, test, format report);
- builds the signed prod APK and AAB;
- creates the GitHub Release **μLearn 1.1.0** for the tag, with notes and
  `mulearn-1.1.0.apk`, `mulearn-1.1.0.aab`, `SHA256SUMS.txt` attached.

**If the release run fails before publishing**, fix the cause, get it onto
`master`, then move the tag:

```bash
git push origin :refs/tags/v1.1.0   # delete the remote tag
git tag -d v1.1.0
# …fix merged to master, pull…
git tag -a v1.1.0 -m "μLearn 1.1.0"
git push origin v1.1.0
```

**Once a release is published, never reuse its tag or build number** —
installed copies already carry that versionCode. Ship a new patch version
instead.

## Release notes

[`release_notes.sh`](../.github/scripts/release_notes.sh) reads the commits
between the previous `vX.Y.Z` tag reachable from the new tag and the new tag
(merge commits skipped), and sorts them by Conventional Commit type:

| Section | Commit types |
|---|---|
| Breaking changes | any type with `!` (`feat!:`), or a `BREAKING CHANGE:` footer |
| Features | `feat` |
| Improvements | `refactor`, `style`, `improve`, `enhance`, `ui`, `ux` |
| Bug fixes | `fix` |
| Performance | `perf` |
| Other changes | everything else — `docs`, `test`, `chore`, `ci`, `build`, … and **every commit without a conventional prefix**, listed verbatim |

Nothing is rewritten or summarised: each line is the commit subject with a
link to the commit. When more than half the commits lack a prefix, the notes
say so. The first release (no earlier tag) lists the whole history. The
release body starts with a table of version, versionCode, application ID,
commit, build time and run link.

Preview the notes before tagging:

```bash
git fetch --tags
bash .github/scripts/release_notes.sh origin/master   # what the next tag would get
```

Current state (2026-11): about half of the history uses conventional prefixes,
so expect a long *Other changes* section until that improves.

## Versioning

- **The first release is `1.0.0+1`.** The installed versionName and
  versionCode show at the bottom of Settings (`core/config/app_version.dart`),
  so testers can quote the exact build.
- **versionName / versionCode come from `pubspec.yaml`** (`version: X.Y.Z+N`)
  — no version is hardcoded anywhere else. Rules per channel are in
  [`version.sh`](../.github/scripts/version.sh); run it locally to see exactly
  what CI would use:

  ```bash
  bash .github/scripts/version.sh dev      # or ci | nightly | stable | release
  ```

- **Release and stable** builds use `X.Y.Z` and the pubspec build number `N`,
  bumped by hand per release and enforced to grow by `check_release_tag.sh`.
  A stable APK built after `v1.1.0` but before the next bump carries the same
  versionCode as `v1.1.0`, so either installs over the other.
- **Dev and nightly** builds use the number of commits on the built commit
  (`git rev-list --count HEAD`) as versionCode: it only grows on `staging`, is
  the same for a dev and a nightly build of the same commit, and can be
  reproduced locally. A force-push that removes commits from `staging` would
  make it go down — don't force-push `staging`.

## Secrets and repository settings

### Secrets

Signing values live in GitHub **environments** (Settings → Environments →
*name*). Both environments use the same names:

| Name | Kind | Value |
|---|---|---|
| `ANDROID_KEYSTORE` | secret | The `.jks` keystore, base64-encoded on one line |
| `ANDROID_KEYSTORE_PASSWORD` | secret | Keystore password |
| `ANDROID_KEY_PASSWORD` | secret | Key password (same as the keystore password for PKCS12 keystores) |
| `ANDROID_KEY_ALIAS` | **variable** | Key alias inside the keystore |

The alias is deliberately a *variable*: GitHub masks secret values in every
log and output, and an alias such as `mulearn-dev` or `upload` appears in
artifact names and step names — a masked job output is silently dropped.

| Environment | Holds | Used by |
|---|---|---|
| `Production` | the production key for `org.mulearn.muapp` | stable, release |
| `Development` | a separate test key, never used for production | dev (staging), nightly, manual dev |

Repository secret `ADD_TO_PROJECT_TOKEN` is used only by `triage.yml`.
`GITHUB_TOKEN` is built in. No secret is needed for API hosts: the envied
output `lib/core/config/env.g.dart` is committed and CI doesn't run
`build_runner`.

Creating a keystore and its values (JDK `keytool`, GitHub CLI):

```bash
keytool -genkeypair -v -keystore upload.jks -storetype PKCS12 \
  -keyalg RSA -keysize 4096 -validity 10000 -alias upload \
  -dname "CN=muLearn Android, O=GTech muLearn, C=IN"
# keytool prompts for the password; for PKCS12 the key password is the same.

base64 -w0 upload.jks | gh secret set ANDROID_KEYSTORE -e Production
gh secret set ANDROID_KEYSTORE_PASSWORD -e Production   # paste when prompted
gh secret set ANDROID_KEY_PASSWORD      -e Production   # same password
gh variable set ANDROID_KEY_ALIAS       -e Production --body upload
```

Keep the `.jks` and its password in the team password manager. Never commit
either — `.gitignore` excludes `*.jks`, `*.keystore` and `key.properties`.

### Repository settings

| Setting | Value |
|---|---|
| Default branch | `dev` (PRs target it by default; the nightly schedule runs from it) |
| Environment `Production` | deployment branches: `master` and tags `v*`; required reviewer before a job may use it |
| Environment `Development` | no restrictions (holds only the test key) |
| Branch protection `master` | PR required, 1 approval, checks `Android / Validate` + `Android / Build APK`, no force-push or deletion; admins may bypass |
| Branch protection `staging` | PR required, checks `Android / Validate` + `Android / Build APK`, no force-push or deletion |
| Branch protection `dev` | PR required, check `Android / Validate`, no force-push or deletion |

With one approval required, a PR author can't approve their own PR; an admin
can still merge with *bypass branch protections* when nobody else is available.

## Downloading and installing APKs

- **Latest dev build:** the `dev-latest` pre-release —
  <https://github.com/gtech-mulearn/mulearn-app/releases/tag/dev-latest>.
- **Any dev, nightly or stable build:** Actions → pick the run → *Artifacts*
  at the bottom of the summary page. Each artifact is the `.apk` itself, not a
  zip. Downloading artifacts requires a GitHub login. From a terminal (not
  `gh run download`, which tries to unzip the APK itself and fails):

  ```bash
  gh run list --workflow nightly.yml --limit 5
  gh api repos/gtech-mulearn/mulearn-app/actions/runs/<run-id>/artifacts --jq '.artifacts[] | "\(.id) \(.name)"'
  gh api repos/gtech-mulearn/mulearn-app/actions/artifacts/<artifact-id>/zip > mulearn.apk
  ```

- **Releases:** <https://github.com/gtech-mulearn/mulearn-app/releases> —
  check the file against `SHA256SUMS.txt` with `sha256sum -c`.

To install, open the APK on the phone (allow *install unknown apps* for the
browser/file manager) or `adb install -r <file>.apk`. Android refuses an
update signed with a different key, or with a lower versionCode — uninstall
first in that case (this happens once when dev builds move from the old
debug-signed builds to the Development key).

## Troubleshooting

Open the failed run; the first red step says which stage failed.

| Symptom | Cause / fix |
|---|---|
| **Check formatting** fails on a PR | Files the PR changed aren't `dart format`ted. Run the command printed in the log — `dart format <files>` — and push. Format named files only, never a folder (that rewrites generated code). Promotion PRs (`dev → staging`, `staging → master`) only get a report: their changes were already gated on the way into `dev`. |
| **Analyze** or **Test** fails | Reproduce with `flutter analyze` / `flutter test` locally (same Flutter 3.47.9). Nothing is built or published until they pass. |
| **Install dependencies** fails with a lockfile error | `pubspec.lock` doesn't match `pubspec.yaml`. Run `flutter pub get` locally and commit the lock file. |
| `Missing signing value(s)` (stable/release) | Production environment secrets or the `ANDROID_KEY_ALIAS` variable missing or misnamed — see [Secrets](#secrets). |
| `Missing signing value(s)` although the environment has them | The caller workflow lacks `secrets: inherit`. A reusable workflow only sees secrets its caller passes, even when its own job names the environment. |
| `The keystore did not open …` | `ANDROID_KEYSTORE_PASSWORD` or `ANDROID_KEY_ALIAS` doesn't match the keystore, or `ANDROID_KEYSTORE` isn't the base64 of the `.jks`. |
| A job output is empty / `Artifact not found for name: .apk` | The output contained a secret's value and GitHub dropped it ("Skip output … since it may contain secret"). Don't store non-secret values (like the alias) as secrets. |
| Gradle: `Prod release builds need android/key.properties` | A prod release was built without signing. In CI this means `signing: required` was bypassed; locally, create `android/key.properties`. |
| Run waits on **Review deployments** | Production needs an approval. Approve it from the run page. |
| `Branch "…" is not allowed to deploy to Production` | Stable/release builds only run from `master` or a `v*` tag. Don't run *Stable build* manually on another branch. |
| **Check tag** fails | Message says which rule: tag format, pubspec mismatch, commit not on `master`, or version/build number not above the previous release. Fix, then move the tag ([Creating a release](#creating-a-release)). |
| `Shallow clone: …` | A job that needs history was checked out with `fetch-depth: 1`. Keep `fetch-depth: 0` in the build job. |
| Nightly didn't build | `staging` unchanged since the last nightly (the run says *skipping tonight*), schedule paused after 60 days of inactivity, `nightly.yml` missing on `dev`, or `staging` missing (the run fails with an error). |
| Phone says *App not installed* | Different signing key or lower versionCode than the installed copy. Uninstall, then install. |
| `dev-latest` didn't update | Only pushes to `staging` refresh it (not manual runs), and a newer push cancels an older run. |
| Nothing built after merging into `dev` | By design: `dev` builds nothing. Promote to `staging`. |

## Reproducing a build locally

With Flutter **3.47.9** and JDK 21 (what CI pins):

```bash
flutter pub get --enforce-lockfile

# validation, as CI runs it
bash .github/scripts/format_check.sh origin/dev   # files changed vs dev (blocking in PRs)
bash .github/scripts/format_check.sh              # whole-repo report
flutter analyze
flutter test

# the exact version numbers CI would use
bash .github/scripts/version.sh dev

# dev APK (debug-signed unless android/key.properties exists)
flutter build apk --release --flavor dev -t lib/main_dev.dart \
  --build-name 1.0.0-dev.84 --build-number 84
# → build/app/outputs/flutter-apk/app-dev-release.apk

# prod APK / AAB — needs android/key.properties (below)
flutter build apk --release --flavor prod -t lib/main_prod.dart
flutter build appbundle --release --flavor prod -t lib/main_prod.dart
# → build/app/outputs/bundle/prodRelease/app-prod-release.aab
```

For a signed local build create `android/key.properties` (gitignored):

```properties
storeFile=/absolute/path/to/upload.jks
storePassword=<password>
keyAlias=upload
keyPassword=<password>
```

A relative `storeFile` is resolved from `android/app/`. Delete the file when
you're done.

## Rotating signing credentials

**Passwords only** (same key): copy the key into a new keystore with a new
password — reliable for PKCS12, where store and key password are one.

```bash
keytool -importkeystore -srckeystore upload.jks -destkeystore upload-new.jks \
  -deststoretype PKCS12          # prompts: new password, then the old one
keytool -list -keystore upload-new.jks   # check it opens with the new password
base64 -w0 upload-new.jks | gh secret set ANDROID_KEYSTORE -e Production
gh secret set ANDROID_KEYSTORE_PASSWORD -e Production
gh secret set ANDROID_KEY_PASSWORD -e Production
```

**Development test key:** generate a new keystore (as in [Secrets](#secrets)),
replace the `Development` secrets and alias variable, and tell testers to
uninstall Mulearn Dev once before installing the next build.

**Production key:** treat it as permanent. Every installed copy of
`org.mulearn.muapp` only accepts updates signed with it.

- *If it leaks or is lost and the app is on Google Play with Play App
  Signing:* it is the upload key; request an upload-key reset in Play Console,
  then replace the `Production` values with the new key.
- *For APKs installed from GitHub Releases:* a new key means users must
  uninstall and reinstall. Android 9+ supports signing-key rotation (APK
  Signature Scheme v3, `apksigner rotate` lineage), but the Gradle setup here
  doesn't do it; that would be a separate change.

After replacing values, run *Stable build* manually on `master` to confirm the
new key works before the next release.
