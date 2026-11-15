#!/usr/bin/env bash
# dart format check, excluding generated and vendored code.
#
#   bash .github/scripts/format_check.sh <base-sha>  # blocking: only Dart files
#                                                    # changed since <base-sha>
#   bash .github/scripts/format_check.sh             # report-only: whole repo,
#                                                    # warns but never fails
#
# Why two modes: much of the existing code predates a format gate (2026-11:
# ~280 of ~620 files), so a whole-repo blocking check would fail every build.
# PRs must leave every file they touch formatted, which ratchets the codebase
# toward clean without one giant conflict-prone reformat.
set -euo pipefail
source "$(dirname "$0")/lib.sh"

base=${1:-}

if [ -n "$base" ]; then
  git cat-file -e "${base}^{commit}" 2>/dev/null ||
    die "Base commit ${base} is not in this checkout (needs fetch-depth: 0)."
  mapfile -t candidates < <(git diff --name-only --diff-filter=ACMR "${base}...HEAD" -- '*.dart')
else
  mapfile -t candidates < <(git ls-files -- '*.dart')
fi

files=()
for f in "${candidates[@]}"; do
  case "$f" in
    *.g.dart | *.freezed.dart | third_party/*) continue ;;
  esac
  [ -f "$f" ] || continue
  # Any other generated file (e.g. tool/gen_tokens.dart output) starts with a
  # "// GENERATED" header — don't hold generator output to the format gate.
  head -n 1 "$f" | grep -q '^// GENERATED' && continue
  files+=("$f")
done

if [ ${#files[@]} -eq 0 ]; then
  echo "No Dart files to check."
  exit 0
fi

echo "Checking formatting of ${#files[@]} Dart file(s)…"
# Batches keep the command line short; xargs exits non-zero if any batch
# has changes, which we read from the "Changed" lines instead.
output=$(printf '%s\0' "${files[@]}" |
  xargs -0 -n 200 dart format --output=none --set-exit-if-changed 2>&1 || true)
mapfile -t changed < <(printf '%s\n' "$output" | sed -n 's/^Changed //p')

if printf '%s\n' "$output" | grep -qiE '^(error|Could not format)'; then
  printf '%s\n' "$output"
  die "dart format could not parse some files."
fi

if [ ${#changed[@]} -eq 0 ]; then
  echo "All ${#files[@]} file(s) are formatted."
  exit 0
fi

if [ -n "$base" ]; then
  for f in "${changed[@]}"; do
    echo "::error file=${f}::Not formatted. Run: dart format ${f}"
  done
  echo
  echo "Fix with (format named files only — never a folder, it rewrites generated code):"
  echo "  dart format ${changed[*]}"
  exit 1
fi

echo "::warning::${#changed[@]} of ${#files[@]} Dart files are not dart-formatted (report only; PRs must format the files they touch)."
printf '  %s\n' "${changed[@]}"
