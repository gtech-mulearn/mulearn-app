#!/usr/bin/env bash
# Release notes, in Markdown, from the commits between the previous release tag
# and <tag>. Categorised by Conventional Commit type (docs/rules.md §7);
# commits that don't follow the convention are listed verbatim under
# "Other changes" — nothing is invented or reworded.
#
#   bash .github/scripts/release_notes.sh <tag> [<previous-tag>]
#
# Without <previous-tag>, the nearest earlier vX.Y.Z tag reachable from <tag>
# is used; with none (first release), the full history up to <tag> is listed.
# Set GITHUB_REPOSITORY (owner/name) to get commit and compare links.
set -euo pipefail
source "$(dirname "$0")/lib.sh"

tag=${1:-}
[ -n "$tag" ] || die "Usage: release_notes.sh <tag> [<previous-tag>]"
git rev-parse --verify --quiet "${tag}^{commit}" >/dev/null || die "Unknown ref '${tag}'."

prev=${2:-}
if [ -z "$prev" ] && git rev-parse --verify --quiet "${tag}^" >/dev/null; then
  prev=$(git describe --tags --abbrev=0 --match 'v[0-9]*.[0-9]*.[0-9]*' "${tag}^" 2>/dev/null || true)
fi

range=$tag
[ -n "$prev" ] && range="${prev}..${tag}"

repo_url=""
[ -n "${GITHUB_REPOSITORY:-}" ] && repo_url="${GITHUB_SERVER_URL:-https://github.com}/${GITHUB_REPOSITORY}"

breaking=() features=() improvements=() fixes=() performance=() other=()
total=0 conventional=0

# Records: full sha \x1f subject \x1f body \x1e
while IFS=$'\x1f' read -r -d $'\x1e' sha subject body; do
  sha=${sha//$'\n'/}
  [ -n "$sha" ] || continue
  total=$((total + 1))
  short=${sha:0:7}
  ref=$short
  [ -n "$repo_url" ] && ref="[${short}](${repo_url}/commit/${sha})"

  if [[ $subject =~ ^([A-Za-z]+)(\(([^\)]*)\))?(!)?:[[:space:]]+(.+)$ ]]; then
    conventional=$((conventional + 1))
    type=$(printf '%s' "${BASH_REMATCH[1]}" | tr '[:upper:]' '[:lower:]')
    scope=${BASH_REMATCH[3]}
    bang=${BASH_REMATCH[4]}
    desc=${BASH_REMATCH[5]}
    line="- ${desc} (${ref})"
    [ -n "$scope" ] && line="- **${scope}:** ${desc} (${ref})"

    if [ -n "$bang" ] || printf '%s' "$body" | grep -qE '^BREAKING[ -]CHANGE:'; then
      breaking+=("$line")
      continue
    fi
    case "$type" in
      feat) features+=("$line") ;;
      fix) fixes+=("$line") ;;
      perf) performance+=("$line") ;;
      refactor | style | improve | improvement | enhance | ui | ux) improvements+=("$line") ;;
      *) other+=("- ${subject} (${ref})") ;;
    esac
  else
    other+=("- ${subject} (${ref})")
  fi
done < <(git log --no-merges --format='%H%x1f%s%x1f%b%x1e' "$range")

section() {
  local title=$1
  shift
  [ $# -gt 0 ] || return 0
  printf '### %s\n\n' "$title"
  printf '%s\n' "$@"
  printf '\n'
}

if [ -n "$prev" ]; then
  printf '## Changes since %s\n\n' "$prev"
else
  printf '## Changes\n\nFirst release — every commit up to %s.\n\n' "$tag"
fi

if [ "$total" -eq 0 ]; then
  printf 'No commits since %s.\n' "${prev:-the start of history}"
  exit 0
fi

section "Breaking changes" "${breaking[@]}"
section "Features" "${features[@]}"
section "Improvements" "${improvements[@]}"
section "Bug fixes" "${fixes[@]}"
section "Performance" "${performance[@]}"
section "Other changes" "${other[@]}"

if [ $((conventional * 2)) -lt "$total" ]; then
  printf '_%d of %d commits do not use Conventional Commit prefixes, so they are listed as-is under Other changes._\n\n' \
    "$((total - conventional))" "$total"
fi

if [ -n "$prev" ] && [ -n "$repo_url" ]; then
  printf '**Full diff:** %s/compare/%s...%s\n' "$repo_url" "$prev" "$tag"
fi
