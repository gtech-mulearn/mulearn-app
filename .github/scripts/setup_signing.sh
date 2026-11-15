#!/usr/bin/env bash
# Writes android/key.properties + the keystore for a release-signed build,
# from the environment-scoped secrets ANDROID_KEYSTORE (base64 .jks),
# ANDROID_KEYSTORE_PASSWORD and ANDROID_KEY_PASSWORD, and the environment
# variable ANDROID_KEY_ALIAS (not secret, so it isn't masked in outputs).
#
#   bash .github/scripts/setup_signing.sh <none|optional|required>
#
#   none      never touch signing (debug keys) — PR / CI builds.
#   optional  sign when the secrets exist, else warn and use debug keys.
#   required  fail when any secret is missing or the keystore doesn't open.
#
# The keystore goes to $RUNNER_TEMP (outside the workspace, so no artifact
# glob can pick it up); cleanup_signing removes both files afterwards.
set -euo pipefail
source "$(dirname "$0")/lib.sh"

mode=${1:-}
case "$mode" in
  none)
    echo "Signing: none — debug keys (this build is not distributed)."
    exit 0
    ;;
  optional | required) ;;
  *) die "Unknown signing mode '${mode}'. Use none, optional or required." ;;
esac

missing=()
for name in ANDROID_KEYSTORE ANDROID_KEYSTORE_PASSWORD ANDROID_KEY_ALIAS ANDROID_KEY_PASSWORD; do
  [ -n "${!name:-}" ] || missing+=("$name")
done

if [ ${#missing[@]} -gt 0 ]; then
  if [ "$mode" = "required" ]; then
    die "Missing signing value(s): ${missing[*]}. Add them to this job's GitHub environment (docs/CI-CD.md, 'Secrets')."
  fi
  echo "::warning::Missing signing value(s): ${missing[*]} — signing with this runner's throwaway debug key. Testers must uninstall before installing the next build."
  exit 0
fi

: "${RUNNER_TEMP:?RUNNER_TEMP is not set (this script is meant for GitHub Actions)}"
keystore="${RUNNER_TEMP}/mulearn-signing.jks"

umask 077
printf '%s' "$ANDROID_KEYSTORE" | tr -d '[:space:]' | base64 --decode >"$keystore" ||
  die "ANDROID_KEYSTORE is not valid base64."

# Fail early, with a clear message, on a wrong store password or alias.
if ! keytool -list -keystore "$keystore" -storepass:env ANDROID_KEYSTORE_PASSWORD \
  -alias "$ANDROID_KEY_ALIAS" >/dev/null 2>&1; then
  rm -f "$keystore"
  die "The keystore did not open with ANDROID_KEYSTORE_PASSWORD, or has no key '${ANDROID_KEY_ALIAS}'."
fi

# key.properties is a Java .properties file: a backslash is an escape there.
escape() { printf '%s' "${1//\\/\\\\}"; }
{
  echo "storeFile=${keystore}"
  echo "storePassword=$(escape "$ANDROID_KEYSTORE_PASSWORD")"
  echo "keyAlias=$(escape "$ANDROID_KEY_ALIAS")"
  echo "keyPassword=$(escape "$ANDROID_KEY_PASSWORD")"
} >android/key.properties

echo "Signing: release keystore (alias ${ANDROID_KEY_ALIAS})."
