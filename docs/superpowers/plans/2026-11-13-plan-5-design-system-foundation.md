# Plan 5 — Design system foundation

Source of truth: the μLearn Mobile design system artifact (https://claude.ai/artifact/7K3eV2dVDNYdkBcc5iyXFj). Its `tokens.json` is copied to `design/tokens.json`; its "Flutter architecture" section is the spec for this plan.

Goal: land the new design system's foundation in `lib/core/design_system/` without changing any screen yet. Screens migrate in later plans, one at a time, and the old `core/theme` + `core/widgets` go away when their last use goes.

Branch: `feat/design-system` (from `feat/app-parity`). One commit per task, no push.

## Tasks

- [x] **1. Tokens.** `tool/gen_tokens.dart` reads `design/tokens.json` and writes `lib/core/design_system/tokens/mu_tokens.g.dart` (palette light/dark, type scale, spacing, radii, sizes, shadows, springs, opacity). A test regenerates in memory and fails if the committed file is stale. `no_color_literals_test` exempts `lib/core/design_system/tokens/`.
- [x] **2. Theme.** `MuTheme` (`ThemeExtension`) carrying palette + text styles + shadows; `MuThemeData.light()/dark()` building `ThemeData`; `context.mu` accessor. Contrast test over the documented text/ground pairs in both palettes. The app installs `MuTheme` as an extension on its current theme so unmigrated screens keep their look; `MuThemeData` replaces it when the last screen moves over.
- [x] **3. Motion.** `muSpring(damping, response)`, `project(velocity)`, `rubberband(...)`, and `MuPressable` (scale on pointer-down, spring back, reduced-motion aware). Unit and widget tests.
- [x] **4. Button.** `MuButton` (ink + knob, cobalt, ink, outline, ghost, volt; regular/small; block; loading; disabled) built on `MuPressable`. Widget tests: semantics label, loading blocks taps, disabled, 360dp no overflow.
- [x] **5. Barrel + docs.** `lib/core/design_system/design_system.dart` exports; rules.md §8 updated to the new tokens and location.

Out of scope here: bundling font files offline (needs the font files downloaded: ask first), the map package (needs approval, rules.md §9), any screen changes.
