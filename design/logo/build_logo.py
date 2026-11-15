"""Render every app logo asset from the fitted model, straight into the app.

usage (from anywhere):  python design/logo/build_logo.py [--check]
then:                   dart run flutter_launcher_icons
Needs numpy + opencv-python. --check also writes design/logo/out/ previews
(check_ref_scale.png is the render at reference size, to diff against
reference.png).
"""
import json
import os
import sys

import cv2
import numpy as np

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from logo_model import (S, Canvas, apply, compose, load_paths, mu_features, shape_masks, star_features,
                   tile_bg_features)

ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..'))
OUT = ROOT
paths = load_paths()
prm = json.load(open(S + "/params.json"))
coefs = dict(np.load(S + "/coefs.npz"))
x0, y0 = paths['tile'].min(0)
x1, y1 = paths['tile'].max(0)
CX, CY = (x0 + x1) / 2, (y0 + y1) / 2
FRAME = 516.0  # the tile's (square) frame in reference units: 510 x 515.7 tile inside


def canvas(px, units):
    """Square canvas `px` pixels wide showing `units` reference units around the tile centre."""
    c = Canvas(paths, px / units, origin=(CX - units / 2, CY - units / 2), size=(units, units))
    c.clamp_box = (x0 + 2, y0 + 2, x1 - 2, y1 - 2)
    return c


def extended_tile(c, m, effects=True):
    """Tile colour on a full-bleed canvas: each region's gradient is continued past
    the tile from inside that region only, then blended by the (smooth, already
    extended) wave boundaries, so the waves stay clean curves to the canvas edge."""
    feats = tile_bg_features(c, m, prm)
    k = max(1, int(round(4 * c.s)))
    ker = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (2 * k + 1,) * 2)
    tile_in = cv2.erode((m['tile'] > 0.99).astype(np.uint8), ker) > 0
    out = 0
    for r in ('body', 'tl', 'br'):
        f = apply(feats, coefs['tile'], only=(f'{r}_p',))
        f = f / np.maximum(m[r], 1e-6)[..., None]  # undo the region weight
        valid = tile_in & (cv2.erode((m[r] > 0.99).astype(np.uint8), ker) > 0)
        out = out + c.extend_from(f, valid) * m[r][..., None]
    if effects:
        out = out + apply(feats, coefs['tile'], exclude=('body_p', 'tl_p', 'br_p', 'tilerim'))
    else:
        out = out + apply(feats, coefs['tile'], only=('tlrim', 'brrim'))
    return out


def parts(c, rim=True):
    m = shape_masks(c)
    if rim:
        tile = apply(tile_bg_features(c, m, prm), coefs['tile'])
    else:
        tile = extended_tile(c, m)
    mu = apply(mu_features(c, m, prm), coefs['mu'])
    star = apply(star_features(c, m, prm), coefs['star'])
    return m, tile, mu, star


def over(base, col, cov):
    cov = cov[..., None]
    return base * (1 - cov) + col * cov


def save(name, rgb, alpha=None):
    os.makedirs(os.path.dirname(os.path.join(OUT, name)), exist_ok=True)
    rgb = np.clip(np.round(rgb), 0, 255).astype(np.uint8)[:, :, ::-1]
    if alpha is not None:
        a = np.clip(np.round(alpha * 255), 0, 255).astype(np.uint8)
        rgb = np.dstack([rgb, a])
    cv2.imwrite(os.path.join(OUT, name), rgb)
    print('wrote', name, rgb.shape)


def full_bleed(px):
    c = canvas(px, FRAME)
    m, tile, mu, star = parts(c, rim=False)
    return over(over(tile, mu, m['mu']), star, m['star'])


def rounded(px, units=FRAME):
    c = canvas(px, units)
    m, tile, mu, star = parts(c, rim=True)
    rgb = over(over(tile, mu, m['mu']), star, m['star'])
    return rgb, m['tile']


def adaptive(px):
    # adaptive icons: 108dp canvas, the 72dp viewport is the tile frame
    units = FRAME * 108 / 72
    c = canvas(px, units)
    m, tile, mu, star = parts(c, rim=False)
    a = np.clip(m['mu'] + m['star'], 0, 1)
    # under the glyphs the shadow terms are meaningless: fade to the plain field
    clean = extended_tile(c, m, effects=False)
    under = c.blur(np.clip(m['mu'] + m['star'], 0, 1), 3)[..., None]
    tile = tile * (1 - under) + clean * under
    fg = (mu * m['mu'][..., None] + star * m['star'][..., None]) / np.maximum(a, 1e-6)[..., None]
    return tile, fg, a


if __name__ == '__main__':
    which = ['icons', 'splash', 'native'] + (['check'] if '--check' in sys.argv else [])
    if 'check' in which:
        c = Canvas(paths, 1.0)
        img, _ = compose(c, prm, coefs)
        save('design/logo/out/check_ref_scale.png', img)
        c2 = Canvas(paths, 2.0)
        img2, _ = compose(c2, prm, coefs)
        save('design/logo/out/preview_2x.png', img2)
    if 'icons' in which:
        save('assets/icon/app_icon.png', full_bleed(1024))
        rgb, a = rounded(1024, FRAME / 0.92)
        save('assets/icon/app_icon_android.png', rgb, a)
        bg, fg, a = adaptive(1024)
        save('assets/icon/app_icon_background.png', bg)
        save('assets/icon/app_icon_foreground.png', fg, a)
        save('assets/icon/app_icon_monochrome.png', np.full_like(fg, 255), a)
    if 'splash' in which:
        rgb, a = rounded(512)
        save('assets/images/app_logo.png', rgb, a)
    if 'native' in which:
        # every launch surface shows the tile frame at MARK_DP (SplashScreen.markSize)
        MARK_DP = 120
        SPLASH_CANVAS_DP = float(os.environ.get('SPLASH_CANVAS_DP', 288))
        for d, f in dict(mdpi=1, hdpi=1.5, xhdpi=2, xxhdpi=3, xxxhdpi=4).items():
            px = int(round(MARK_DP * f))
            rgb, a = rounded(px)
            save(f'android/app/src/main/res/drawable-{d}/launch_mark.png', rgb, a)
            cpx = int(round(SPLASH_CANVAS_DP * f))
            rgb, a = rounded(cpx, FRAME * SPLASH_CANVAS_DP / MARK_DP)
            save(f'android/app/src/main/res/drawable-{d}/splash_icon.png', rgb, a)
        for sfx, f in (('', 1), ('@2x', 2), ('@3x', 3)):
            rgb, a = rounded(MARK_DP * f)
            save(f'ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage{sfx}.png', rgb, a)
