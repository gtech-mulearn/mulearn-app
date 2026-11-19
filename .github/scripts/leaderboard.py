#!/usr/bin/env python3
"""Draw the README's contributor leaderboard as two SVGs (light and dark).

    GITHUB_TOKEN=... python3 .github/scripts/leaderboard.py <owner/repo> <out-dir>

People are ranked by pull requests merged into the default branch, then by
their commits on it (GitHub's contributor count), then by login. Bots are left
out. Avatars are embedded as data URIs: an SVG shown through <img> can't load
other files. Standard library only, so it runs on a bare Actions runner.

Run by .github/workflows/leaderboard.yml. Docs: docs/CI-CD.md
"""

import base64
import datetime
import json
import os
import sys
import urllib.error
import urllib.request
from xml.sax.saxutils import escape

API = "https://api.github.com"
TOP = 25
MAX_NAME = 26  # longer logins are cut with an ellipsis so they never reach the numbers

WIDTH = 560
HEAD_H = 44
ROW_H = 52
FOOT_H = 40
FONT = "-apple-system, BlinkMacSystemFont, 'Segoe UI', 'Noto Sans', Helvetica, Arial, sans-serif"

# GitHub's own palettes, so the board sits naturally on the README; μLearn
# cobalt marks the ranking number (merged PRs).
THEMES = {
    "light": {
        "bg": "#ffffff", "border": "#d1d9e0", "rule": "#e8ecf0", "ink": "#1f2328",
        "muted": "#59636e", "accent": "#0757db", "ring": "#d1d9e0", "avatar_bg": "#e8ecf0",
    },
    "dark": {
        "bg": "#0d1117", "border": "#3d444d", "rule": "#21262d", "ink": "#f0f6fc",
        "muted": "#9198a1", "accent": "#7aa8ff", "ring": "#3d444d", "avatar_bg": "#21262d",
    },
}
MEDALS = {1: "#e8a317", 2: "#a3acb9", 3: "#c27c3e"}


def api_get(path_or_url):
    """GET a GitHub API URL; returns (json, next-page URL or None)."""
    url = path_or_url if path_or_url.startswith("http") else API + path_or_url
    headers = {
        "Accept": "application/vnd.github+json",
        "X-GitHub-Api-Version": "2022-11-28",
        "User-Agent": "mulearn-app-leaderboard",
    }
    token = os.environ.get("GITHUB_TOKEN")
    if token:
        headers["Authorization"] = f"Bearer {token}"
    with urllib.request.urlopen(urllib.request.Request(url, headers=headers), timeout=30) as r:
        data = json.loads(r.read() or b"null")
        return data, next_link(r.headers.get("Link", ""))


def next_link(link_header):
    for part in link_header.split(","):
        if 'rel="next"' in part:
            return part.split(";")[0].strip()[1:-1]
    return None


def paged(path):
    url = path
    while url:
        data, url = api_get(url)
        yield from data or []


def is_bot(user):
    return not user or user.get("type") == "Bot" or user.get("login", "").endswith("[bot]")


def collect(repo):
    """Returns rows [{login, avatar, prs, commits}] in rank order."""
    default_branch = api_get(f"/repos/{repo}")[0]["default_branch"]
    people = {}

    def person(user):
        return people.setdefault(
            user["login"], {"login": user["login"], "avatar": user.get("avatar_url", ""), "prs": 0, "commits": 0}
        )

    for c in paged(f"/repos/{repo}/contributors?per_page=100"):
        if not is_bot(c):
            person(c)["commits"] = c.get("contributions", 0)

    for pr in paged(f"/repos/{repo}/pulls?state=closed&base={default_branch}&per_page=100"):
        if pr.get("merged_at") and not is_bot(pr.get("user")):
            person(pr["user"])["prs"] += 1

    rows = [p for p in people.values() if p["prs"] or p["commits"]]
    rows.sort(key=lambda p: (-p["prs"], -p["commits"], p["login"].lower()))
    return rows[:TOP], default_branch


def avatar_data_uri(url):
    """The avatar as a data URI, or None. No token is sent to the avatar host."""
    if not url:
        return None
    sized = url + ("&" if "?" in url else "?") + "s=80"
    try:
        req = urllib.request.Request(sized, headers={"User-Agent": "mulearn-app-leaderboard"})
        with urllib.request.urlopen(req, timeout=20) as r:
            kind = r.headers.get_content_type()
            if not kind.startswith("image/"):
                return None
            return f"data:{kind};base64,{base64.b64encode(r.read()).decode('ascii')}"
    except (urllib.error.URLError, TimeoutError, OSError):
        return None


def short(login):
    return login if len(login) <= MAX_NAME else login[: MAX_NAME - 1] + "…"


def render(rows, avatars, theme, branch, updated):
    t = THEMES[theme]
    body_h = max(len(rows), 1) * ROW_H
    height = HEAD_H + body_h + FOOT_H
    x_rank, x_avatar, x_name, x_prs, x_commits = 34, 78, 108, 430, 528
    out = [
        f'<svg xmlns="http://www.w3.org/2000/svg" width="{WIDTH}" height="{height}" '
        f'viewBox="0 0 {WIDTH} {height}" role="img" aria-label="Contributor leaderboard">',
        f"<style>text{{font-family:{FONT};font-variant-numeric:tabular-nums}}"
        f".h{{font-size:12px;font-weight:600;fill:{t['muted']}}}"
        f".n{{font-size:15px;font-weight:600;fill:{t['ink']}}}"
        f".v{{font-size:15px;fill:{t['muted']}}}"
        f".p{{font-size:15px;font-weight:700;fill:{t['accent']}}}"
        f".r{{font-size:13px;font-weight:700;fill:{t['muted']}}}"
        f".m{{font-size:13px;font-weight:700;fill:#ffffff}}"
        f".f{{font-size:11px;fill:{t['muted']}}}</style>",
        f'<rect x="0.5" y="0.5" width="{WIDTH - 1}" height="{height - 1}" rx="12" '
        f'fill="{t["bg"]}" stroke="{t["border"]}"/>',
        f'<text class="h" x="{x_rank}" y="27" text-anchor="middle">#</text>',
        f'<text class="h" x="{x_avatar - 16}" y="27">Contributor</text>',
        f'<text class="h" x="{x_prs}" y="27" text-anchor="end">Merged PRs</text>',
        f'<text class="h" x="{x_commits}" y="27" text-anchor="end">Commits</text>',
        f'<line x1="16" y1="{HEAD_H}" x2="{WIDTH - 16}" y2="{HEAD_H}" stroke="{t["rule"]}"/>',
    ]
    if not rows:
        out.append(
            f'<text class="v" x="{WIDTH / 2}" y="{HEAD_H + ROW_H / 2 + 5}" text-anchor="middle">No contributions yet</text>'
        )
    for i, row in enumerate(rows):
        rank = i + 1
        top = HEAD_H + i * ROW_H
        cy = top + ROW_H / 2
        base = cy + 5  # text baseline for 15px type centred on the row
        if rank in MEDALS:
            out.append(f'<circle cx="{x_rank}" cy="{cy}" r="12" fill="{MEDALS[rank]}"/>')
            out.append(f'<text class="m" x="{x_rank}" y="{cy + 4.5}" text-anchor="middle">{rank}</text>')
        else:
            out.append(f'<text class="r" x="{x_rank}" y="{cy + 4.5}" text-anchor="middle">{rank}</text>')
        clip = f"a{i}"
        out.append(f'<clipPath id="{clip}"><circle cx="{x_avatar}" cy="{cy}" r="16"/></clipPath>')
        data = avatars.get(row["login"])
        if data:
            out.append(
                f'<image href="{data}" x="{x_avatar - 16}" y="{cy - 16}" width="32" height="32" '
                f'clip-path="url(#{clip})" preserveAspectRatio="xMidYMid slice"/>'
            )
        else:
            out.append(f'<circle cx="{x_avatar}" cy="{cy}" r="16" fill="{t["avatar_bg"]}"/>')
            out.append(
                f'<text class="r" x="{x_avatar}" y="{cy + 4.5}" text-anchor="middle">'
                f"{escape(row['login'][:1].upper())}</text>"
            )
        out.append(f'<circle cx="{x_avatar}" cy="{cy}" r="16" fill="none" stroke="{t["ring"]}"/>')
        out.append(f'<text class="n" x="{x_name}" y="{base}">{escape(short(row["login"]))}</text>')
        out.append(f'<text class="p" x="{x_prs}" y="{base}" text-anchor="end">{row["prs"]}</text>')
        out.append(f'<text class="v" x="{x_commits}" y="{base}" text-anchor="end">{row["commits"]}</text>')
        if i < len(rows) - 1:
            out.append(
                f'<line x1="16" y1="{top + ROW_H}" x2="{WIDTH - 16}" y2="{top + ROW_H}" stroke="{t["rule"]}"/>'
            )
    foot = HEAD_H + body_h
    out.append(f'<line x1="16" y1="{foot}" x2="{WIDTH - 16}" y2="{foot}" stroke="{t["rule"]}"/>')
    out.append(
        f'<text class="f" x="20" y="{foot + 25}">Ranked by pull requests merged into {escape(branch)}, '
        f"then commits · updated {escape(updated)}</text>"
    )
    out.append("</svg>")
    return "\n".join(out) + "\n"


def main():
    if len(sys.argv) != 3:
        sys.exit("usage: leaderboard.py <owner/repo> <out-dir>")
    repo, out_dir = sys.argv[1], sys.argv[2]
    try:
        rows, branch = collect(repo)
    except urllib.error.HTTPError as e:
        sys.exit(f"::error::GitHub API {e.code} for {e.url}: {e.read()[:300].decode('utf-8', 'replace')}")
    avatars = {row["login"]: avatar_data_uri(row["avatar"]) for row in rows}
    updated = datetime.datetime.now(datetime.timezone.utc).strftime("%d %b %Y")
    os.makedirs(out_dir, exist_ok=True)
    for theme in THEMES:
        with open(os.path.join(out_dir, f"leaderboard-{theme}.svg"), "w", encoding="utf-8", newline="\n") as f:
            f.write(render(rows, avatars, theme, branch, updated))
    with open(os.path.join(out_dir, "README.md"), "w", encoding="utf-8", newline="\n") as f:
        f.write(
            "# Contributor leaderboard\n\n"
            "Generated by `.github/workflows/leaderboard.yml` and force-pushed here; "
            "don't edit. The main README embeds these SVGs.\n"
        )
    for row in rows:
        print(f"{row['prs']:>4} PRs {row['commits']:>5} commits  {row['login']}")
    print(f"{len(rows)} contributors -> {out_dir}")


if __name__ == "__main__":
    main()
