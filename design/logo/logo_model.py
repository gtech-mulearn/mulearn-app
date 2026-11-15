"""Procedural model of the μLearn app icon (design/logo/reference.png).

Shapes are traced paths (reference units: the 658x652 reference canvas).
Colour = per-region polynomial fields + blurred-shape terms (shadows, glows,
rims, bevels) with linear weights fitted by least squares. Everything is
evaluated in reference units, so render(scale) gives the same picture at any
resolution.
"""
import json
import os

import cv2
import numpy as np

S = os.path.dirname(os.path.abspath(__file__))
H, W = 652, 658


def catmull(pts, closed=True, sub=4):
    """Densify with centripetal-ish uniform Catmull-Rom (smooth curve through points)."""
    p = np.asarray(pts, float)
    if closed:
        P = np.vstack([p[-1:], p, p[:2]])
    else:
        P = np.vstack([2 * p[0] - p[1], p, 2 * p[-1] - p[-2]])
    out = []
    t = np.linspace(0, 1, sub, endpoint=False)[:, None]
    for i in range(1, len(P) - 2):
        p0, p1, p2, p3 = P[i - 1], P[i], P[i + 1], P[i + 2]
        out.append(0.5 * ((2 * p1) + (-p0 + p2) * t + (2 * p0 - 5 * p1 + 4 * p2 - p3) * t ** 2 + (-p0 + 3 * p1 - 3 * p2 + p3) * t ** 3))
    return np.vstack(out)


def load_paths(path=S + "/paths.json"):
    return {k: np.array(v) for k, v in json.load(open(path)).items()}


class Canvas:
    def __init__(self, paths, scale=1.0, origin=(0.0, 0.0), size=(W, H), ss=4):
        """scale: output px per reference unit; origin: reference coord at output (0,0);
        size: output size in reference units."""
        self.p = paths
        self.s = scale
        self.ox, self.oy = origin
        self.w = int(round(size[0] * scale))
        self.h = int(round(size[1] * scale))
        self.ss = ss
        jj, ii = np.mgrid[0:self.h, 0:self.w]
        self.x = (ii + 0.5) / scale + self.ox
        self.y = (jj + 0.5) / scale + self.oy
        self._cache = {}

    def fill(self, pts, closed=True):
        key = ('fill', id(pts))
        if key in self._cache:
            return self._cache[key]
        k = self.ss
        dense = catmull(pts, closed=True)
        m = np.zeros((self.h * k, self.w * k), np.uint8)
        q = (dense - [self.ox, self.oy]) * self.s * k
        cv2.fillPoly(m, [np.round(q * 16).astype(np.int32)], 255, cv2.LINE_AA, shift=4)
        m = cv2.resize(m.astype(np.float32) / 255, (self.w, self.h), interpolation=cv2.INTER_AREA)
        self._cache[key] = m
        return m

    def inside_xy(self, inset=4.0):
        """Reference coords of the nearest point inside the tile (inset) for every pixel,
        so fields extend past the rounded tile as constants along its normals."""
        if 'inside' not in self._cache:
            t = self.fill(self.p['tile'])
            inside = cv2.erode((t > 0.99).astype(np.uint8), cv2.getStructuringElement(
                cv2.MORPH_ELLIPSE, (2 * int(inset * self.s) + 1,) * 2))
            src = (inside == 0).astype(np.uint8)
            _, lab = cv2.distanceTransformWithLabels(src, cv2.DIST_L2, 5, labelType=cv2.DIST_LABEL_PIXEL)
            zeros = np.argwhere(src == 0)  # row-major, labels 1..n
            idx = zeros[np.clip(lab - 1, 0, len(zeros) - 1)]
            x = np.where(src == 0, self.x, (idx[..., 1] + 0.5) / self.s + self.ox)
            y = np.where(src == 0, self.y, (idx[..., 0] + 0.5) / self.s + self.oy)
            self._cache['inside'] = (x, y)
            self._cache['inside_idx'] = (np.where(src == 0, np.arange(self.h)[:, None], idx[..., 0]),
                                         np.where(src == 0, np.arange(self.w)[None, :], idx[..., 1]))
        return self._cache['inside']

    def extend(self, img):
        """Continue a field past the tile: each outside pixel takes its nearest inside value."""
        self.inside_xy()
        r, c_ = self._cache['inside_idx']
        out = img[r, c_]
        # soften the seams that nearest-pixel copying leaves along the normals
        t = self.fill(self.p['tile'])
        w = np.clip((1 - t), 0, 1)[..., None]
        sm = cv2.GaussianBlur(out.astype(np.float32), (0, 0), 6 * self.s)
        far = np.clip(cv2.GaussianBlur((t < 0.5).astype(np.float32), (0, 0), 6 * self.s) * 2 - 0.5, 0, 1)[..., None]
        return out * (1 - far * w) + sm * far * w

    def extend_from(self, img, valid, soften=8.0):
        """Continue a smooth field past `valid` (bool mask): nearest valid value,
        then blurred outside so the copied rays leave no seams."""
        src = (~valid).astype(np.uint8)
        if not src.any():
            return img
        _, lab = cv2.distanceTransformWithLabels(src, cv2.DIST_L2, 5, labelType=cv2.DIST_LABEL_PIXEL)
        zeros = np.argwhere(src == 0)
        idx = zeros[np.clip(lab - 1, 0, len(zeros) - 1)]
        out = img[idx[..., 0], idx[..., 1]]
        sm = cv2.GaussianBlur(out.astype(np.float32), (0, 0), soften * self.s)
        k = cv2.GaussianBlur(valid.astype(np.float32), (0, 0), soften * self.s * 0.5)
        k = np.clip(k * 2, 0, 1)[..., None]  # 1 deep inside valid, 0 well outside
        return out * k + sm * (1 - k)

    def blur(self, m, sigma, dx=0.0, dy=0.0):
        key = ('blur', id(m), sigma, dx, dy)
        if key in self._cache:
            return self._cache[key]
        if dx or dy:
            M = np.float32([[1, 0, dx * self.s], [0, 1, dy * self.s]])
            m = cv2.warpAffine(m, M, (self.w, self.h), flags=cv2.INTER_LINEAR, borderMode=cv2.BORDER_CONSTANT)
        if sigma > 0:
            m = cv2.GaussianBlur(m, (0, 0), sigma * self.s, borderType=cv2.BORDER_CONSTANT)
        self._cache[key] = m
        return m

    clamp_box = None  # (x0, y0, x1, y1): hold fields constant past this box

    def poly_terms(self, deg, cx=330, cy=320, sc=260, clamp=False):
        """Lazy monomials [(fn)] of the field polynomial in reference units."""
        def xy():
            x, y = self.x, self.y

            return (x - cx) / sc, (y - cy) / sc
        terms = [(0, 0)]
        for i in range(1, deg + 1):
            for j in range(i + 1):
                terms.append((i - j, j))
        return [(lambda a=a, b=b: (lambda X, Y: X ** a * Y ** b)(*xy())) for a, b in terms]


def shape_masks(c):
    p = c.p
    tile = c.fill(p['tile'])
    # region weights are a partition of unity that extends past the tile, so
    # the fields can also fill a full-bleed square
    tl = c.fill(p['wave_tl_region'])
    br = c.fill(p['wave_br_region'])
    body = np.clip(1 - tl - br, 0, 1)
    return dict(tile=tile, tl=tl, br=br, body=body, mu=c.fill(p['mu']), star=c.fill(p['star']))


# ---- feature builders: lists of (name, fn) evaluated lazily ---------------
def tile_bg_features(c, m, prm):
    feats = []
    for r in ('body', 'tl', 'br'):
        for k, t in enumerate(c.poly_terms(prm['deg_tile'], clamp=True)):
            feats.append((f'{r}_p{k}', lambda t=t, r=r: t() * m[r]))
    for i, (dx, dy, sg) in enumerate(prm['mu_shadow']):
        feats.append((f'mushadow{i}', lambda dx=dx, dy=dy, sg=sg: c.blur(m['mu'], sg, dx, dy)))
    for i, sg in enumerate(prm.get('mu_ao', [])):
        # ambient occlusion: concave crevices of the mu collect more blur
        feats.append((f'muao{i}', lambda sg=sg: c.blur(m['mu'], sg)))
        feats.append((f'muao{i}sq', lambda sg=sg: c.blur(m['mu'], sg) ** 2))
    for i, (dx, dy, sg) in enumerate(prm['star_glow']):
        feats.append((f'starglow{i}', lambda dx=dx, dy=dy, sg=sg: c.blur(m['star'], sg, dx, dy)))
    for i, sg in enumerate(prm['tile_rim']):
        rim = lambda sg=sg: m['tile'] - np.minimum(c.blur(m['tile'], sg), m['tile'])
        feats.append((f'tilerim{i}', rim))
        # rim strength varies around the tile
        feats.append((f'tilerim{i}x', lambda rim=rim: rim() * (c.x - 326) / 255))
        feats.append((f'tilerim{i}y', lambda rim=rim: rim() * (c.y - 320) / 258))
    for r in ('tl', 'br'):
        for i, sg in enumerate(prm['wave_rim']):
            # highlight just inside the wave edge (wave side), fading out at the tile rim
            feats.append((f'{r}rim{i}', lambda r=r, sg=sg: np.clip(m[r] - c.blur(m[r], sg), 0, 1) * c.blur(m['tile'], 6) ** 4))
    return feats


def mu_features(c, m, prm):
    feats = [(f'mu_p{k}', t) for k, t in enumerate(c.poly_terms(prm['deg_mu'], cx=310, cy=350, sc=130))]
    for i, (dx, dy, sg) in enumerate(prm['mu_bevel']):
        feats.append((f'mubevel{i}', lambda dx=dx, dy=dy, sg=sg: 1 - c.blur(m['mu'], sg, dx, dy)))
    return feats


def star_features(c, m, prm):
    feats = [(f'star_p{k}', t) for k, t in enumerate(c.poly_terms(prm['deg_star'], cx=458, cy=200, sc=50))]
    for i, (dx, dy, sg) in enumerate(prm['star_bevel']):
        feats.append((f'starbevel{i}', lambda dx=dx, dy=dy, sg=sg: 1 - c.blur(m['star'], sg, dx, dy)))
    return feats


def page_features(c, m, prm):
    feats = [(f'page_p{k}', t) for k, t in enumerate(c.poly_terms(2))]
    for i, (dy, sg) in enumerate(prm['tile_shadow']):
        feats.append((f'tileshadow{i}', lambda dy=dy, sg=sg: c.blur(m['tile'], sg, 0, dy)))
    return feats


def solve(feats, ref, sel):
    A = np.stack([f()[sel] for _, f in feats], 1)
    coef = np.zeros((len(feats), 3))
    rms = []
    for ch in range(3):
        y = ref[..., ch][sel]
        cf, *_ = np.linalg.lstsq(A, y, rcond=None)
        coef[:, ch] = cf
        rms.append(np.sqrt(np.mean((A @ cf - y) ** 2)))
    return coef, np.array(rms)


def apply(feats, coef, exclude=(), only=None):
    out = 0
    for (name, f), cf in zip(feats, coef):
        if any(name.startswith(e) for e in exclude):
            continue
        if only is not None and not any(name.startswith(o) for o in only):
            continue
        out = out + f()[..., None].astype(np.float32) * cf.astype(np.float32)
    return out


def compose(c, prm, coefs, m=None):
    m = m or shape_masks(c)
    page = apply(page_features(c, m, prm), coefs['page'])
    tile = apply(tile_bg_features(c, m, prm), coefs['tile'])
    mu = apply(mu_features(c, m, prm), coefs['mu'])
    star = apply(star_features(c, m, prm), coefs['star'])
    tcov = m['tile'][..., None]
    img = page * (1 - tcov) + tile * tcov
    mc = m['mu'][..., None]
    img = img * (1 - mc) + mu * mc
    sc = m['star'][..., None]
    img = img * (1 - sc) + star * sc
    return np.clip(img, 0, 255), m
