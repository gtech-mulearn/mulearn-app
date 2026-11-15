# Shared helpers for the CI scripts in this folder. Source it; don't run it.

# Print a GitHub Actions error annotation (plain text outside Actions) and exit 1.
die() {
  echo "::error::$*" >&2
  exit 1
}

# Read `version: X.Y.Z+N` from a pubspec (default: ./pubspec.yaml).
# Sets PUBSPEC_VERSION=X.Y.Z and PUBSPEC_BUILD=N.
read_pubspec_version() {
  local src=${1:-pubspec.yaml} line raw
  [ -f "$src" ] || die "${src} not found."
  line=$(grep -m1 -E '^version:' "$src" || true)
  [ -n "$line" ] || die "No 'version:' line in ${src}."
  raw=${line#version:}
  raw=$(printf '%s' "$raw" | tr -d "[:space:]\"'")
  if [[ ! $raw =~ ^([0-9]+\.[0-9]+\.[0-9]+)\+([0-9]+)$ ]]; then
    die "pubspec version '${raw}' must look like MAJOR.MINOR.PATCH+BUILD (e.g. 1.2.0+7)."
  fi
  PUBSPEC_VERSION=${BASH_REMATCH[1]}
  PUBSPEC_BUILD=${BASH_REMATCH[2]}
}
