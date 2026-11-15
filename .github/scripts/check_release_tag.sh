#!/usr/bin/env bash
# Guards a production release tag before anything is built.
#
#   bash .github/scripts/check_release_tag.sh <tag>
#
# Checks, against the checked-out (tagged) commit:
#   1. the tag is vMAJOR.MINOR.PATCH;
#   2. it equals the pubspec.yaml version;
#   3. the commit is on master (releases ship only production-ready code);
#   4. version and build number (Android versionCode) are both greater than
#      the previous release tag's, so every published APK can update the last.
# Needs full history and tags (fetch-depth: 0).
set -euo pipefail
source "$(dirname "$0")/lib.sh"

tag=${1:-}
release_ref=${RELEASE_BRANCH_REF:-origin/master}

[[ $tag =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]] ||
  die "Tag '${tag}' is not a release tag. Use vMAJOR.MINOR.PATCH, e.g. v1.4.0."
version=${tag#v}

read_pubspec_version
[ "$PUBSPEC_VERSION" = "$version" ] ||
  die "Tag ${tag} does not match pubspec.yaml (${PUBSPEC_VERSION}+${PUBSPEC_BUILD}). Bump pubspec.yaml, promote it to master, then tag that commit."

git rev-parse --verify --quiet "${release_ref}^{commit}" >/dev/null ||
  die "${release_ref} is not in this checkout (needs fetch-depth: 0)."
git merge-base --is-ancestor HEAD "$release_ref" ||
  die "Tag ${tag} points at $(git rev-parse --short HEAD), which is not on master. Release tags must be cut from master."

prev=""
if git rev-parse --verify --quiet HEAD^ >/dev/null; then
  prev=$(git describe --tags --abbrev=0 --match 'v[0-9]*.[0-9]*.[0-9]*' HEAD^ 2>/dev/null || true)
fi

if [ -z "$prev" ]; then
  echo "First release: ${tag} (versionCode ${PUBSPEC_BUILD})."
  exit 0
fi

prev_version=${prev#v}
version_build=$PUBSPEC_BUILD
prev_pubspec=$(mktemp)
trap 'rm -f "$prev_pubspec"' EXIT
git show "${prev}:pubspec.yaml" >"$prev_pubspec"
read_pubspec_version "$prev_pubspec"
prev_build=$PUBSPEC_BUILD
PUBSPEC_BUILD=$version_build

newest=$(printf '%s\n%s\n' "$prev_version" "$version" | sort -V | tail -n 1)
if [ "$version" = "$prev_version" ] || [ "$newest" != "$version" ]; then
  die "Version ${version} must be greater than the previous release ${prev}."
fi
if [ "$PUBSPEC_BUILD" -le "$prev_build" ]; then
  die "Build number +${PUBSPEC_BUILD} must be greater than ${prev}'s +${prev_build} (it is the Android versionCode). Bump it in pubspec.yaml."
fi

echo "OK: ${tag} (versionCode ${PUBSPEC_BUILD}) follows ${prev} (versionCode ${prev_build})."
