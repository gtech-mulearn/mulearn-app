#!/usr/bin/env bash
# Derives the Android versionName / versionCode and artifact name for a build
# channel from pubspec.yaml + git. Prints key=value lines (append them to
# $GITHUB_OUTPUT in CI; run it locally to see what CI would produce).
#
#   bash .github/scripts/version.sh <ci|dev|nightly|stable|release>
#
# versionCode rules (see docs/CI-CD.md "Versioning"):
#   dev, nightly, ci  -> number of commits reachable from HEAD. Monotonic on
#                        dev, identical for the same commit across dev and
#                        nightly, reproducible locally. Needs full history.
#   stable, release   -> the +N build number from pubspec.yaml, bumped by hand
#                        for every release (release.yml enforces it grows).
set -euo pipefail
source "$(dirname "$0")/lib.sh"

channel=${1:-}
read_pubspec_version

sha=$(git rev-parse HEAD)
short_sha=${sha:0:7}
date=$(date -u +%Y%m%d)

commit_count() {
  if [ "$(git rev-parse --is-shallow-repository)" = "true" ]; then
    die "Shallow clone: the ${channel} build number is the commit count, so check out with fetch-depth: 0."
  fi
  git rev-list --count HEAD
}

case "$channel" in
  ci)
    flavor=dev
    build_number=$(commit_count)
    build_name="${PUBSPEC_VERSION}-ci.${build_number}"
    artifact="mulearn-ci-${PUBSPEC_VERSION}-${build_number}"
    ;;
  dev)
    flavor=dev
    build_number=$(commit_count)
    build_name="${PUBSPEC_VERSION}-dev.${build_number}"
    artifact="mulearn-dev-${PUBSPEC_VERSION}-${build_number}"
    ;;
  nightly)
    flavor=dev
    build_number=$(commit_count)
    build_name="${PUBSPEC_VERSION}-nightly.${date}"
    artifact="mulearn-nightly-${PUBSPEC_VERSION}-${date}-${short_sha}"
    ;;
  stable)
    flavor=prod
    build_number=$PUBSPEC_BUILD
    build_name="${PUBSPEC_VERSION}-stable.${short_sha}"
    artifact="mulearn-stable-${PUBSPEC_VERSION}-${build_number}"
    ;;
  release)
    flavor=prod
    build_number=$PUBSPEC_BUILD
    build_name=$PUBSPEC_VERSION
    artifact="mulearn-${PUBSPEC_VERSION}"
    ;;
  *)
    die "Unknown channel '${channel}'. Use ci, dev, nightly, stable or release."
    ;;
esac

cat <<EOF
channel=${channel}
flavor=${flavor}
version=${PUBSPEC_VERSION}
build_name=${build_name}
build_number=${build_number}
artifact=${artifact}
sha=${sha}
short_sha=${short_sha}
built_at=$(date -u +%Y-%m-%dT%H:%M:%SZ)
EOF
