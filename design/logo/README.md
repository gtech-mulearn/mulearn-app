# App logo

`reference.png` is the approved μLearn app icon (blue tile, white μ, gold
spark). Everything the app ships is rendered from a procedural rebuild of it,
so it stays sharp at any size:

- `paths.json`: the outlines (tile, μ, star, both waves), traced from the
  reference at sub-pixel precision, in reference pixels;
- `params.json` + `coefs.npz`: the colour model — a polynomial gradient per
  region (body, top-left wave, bottom-right wave, μ, star) plus blurred-shape
  terms for the shadows, ambient occlusion, star glow, rims and bevels, fitted
  to the reference by least squares;
- `logo_model.py`: the renderer; `build_logo.py`: writes every asset.

At reference size the render is within 1.3/255 of the reference on average
(edges within a fraction of a pixel).

## Regenerate

```sh
python design/logo/build_logo.py          # needs numpy + opencv-python
dart run flutter_launcher_icons           # platform icon sets
```

It writes:

| File | Use |
| --- | --- |
| `assets/icon/app_icon.png` | iOS icon, full-bleed (iOS rounds it) |
| `assets/icon/app_icon_android.png` | rounded tile, pre-Oreo Android |
| `assets/icon/app_icon_{background,foreground,monochrome}.png` | Android adaptive layers, 108dp canvas, tile = 72dp viewport (0% inset) |
| `assets/images/app_logo.png` | `MuLogo.appIcon`, the Flutter `SplashScreen` |
| `android/.../drawable-*/launch_mark.png`, `splash_icon.png` | native launch window, Android 12+ splash |
| `ios/.../LaunchImage*.png` | iOS launch screen |

Every launch surface shows the tile at 120dp (`SplashScreen.markSize`) on
launch navy, so opening the app is one still screen. `--check` also writes
`design/logo/out/` previews (gitignored) to diff against `reference.png`.
