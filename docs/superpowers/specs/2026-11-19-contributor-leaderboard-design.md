# Contributor leaderboard in the README

**Intent.** Show who contributes to the app as a ranked list in the README, so
anyone can see the contributor leaderboard at a glance. That is the whole goal.
No rewards, badges or karma integration.

**Constraint.** `dev` requires a PR with the `Android / Validate` check. PRs
opened by `GITHUB_TOKEN` don't start workflows, so a bot PR that rewrites the
README would never get that check and could not merge without an admin bypass.

## Approaches

| | How | Trade-off |
|---|---|---|
| 1 | contrib.rocks avatar grid | One line, no upkeep; no ranks or numbers, so not a leaderboard |
| **2 (chosen)** | Workflow draws an SVG and pushes it to a separate `leaderboard` branch; the README embeds it | Real ranked board that stays current without touching `dev`; costs a workflow, a script and a branch |
| 3 | Script prints a Markdown table, pasted by hand in a PR | Simplest code; goes stale |

The user picked 2.

## Design

- **Ranking:** pull requests merged into `dev`, then commits on `dev`
  (GitHub's contributor count), then login.
  - PRs into `staging`/`master` are promotions or releases of work already
    counted, so they don't add points.
  - Bots (`type == "Bot"` or a `[bot]` login) are left out.
  - The top 25 are shown.
- **Drawing:** `.github/scripts/leaderboard.py`, Python standard library only
  (preinstalled on the runner). It writes `leaderboard-light.svg` and
  `leaderboard-dark.svg`.
  - Avatars are embedded as data URIs, because an SVG shown through `<img>`
    can't load other files.
  - Colours follow GitHub's light and dark palettes, with μLearn cobalt for
    the PR count.
- **Theme:** the README uses `<picture>` with a `prefers-color-scheme: dark`
  source, so GitHub shows the board that matches the viewer's theme.
- **Publishing:** `.github/workflows/leaderboard.yml` runs daily, on every
  push to `dev`, and on demand.
  - It force-pushes the SVGs as one commit to an orphan `leaderboard` branch,
    so the branch never grows history.
  - Only that job gets `contents: write`.
  - `ci.yml` ignores the branch.
- **Left to the builder:** sizes, spacing and the exact colours.
