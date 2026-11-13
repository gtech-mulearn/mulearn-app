# Plan 6 — Design system shell

Spec: the μLearn Mobile design system artifact (components NavCapsule, TopBar, IconButton, Toast, Sheet). Builds on plan 5. Branch `feat/design-system`, one commit per task, no push.

The app-wide chrome moves to the design system first, so every screen (migrated or not) gets the new nav, toasts and icon buttons. Where an old `core/widgets` component with the same name exists, the new one keeps its call shape, replaces it, and the old file is deleted.

## Tasks

- [ ] **1. Icon button.** `MuIconButton` in `core/design_system/input/` with variants (surface, sunk, night, cobalt, glass), 44dp circle in a 48dp hit area, badge dot or count (99+), tooltip required. Keeps the old constructor (`glass`, `badge`, `badgeCount`), so the 8 call sites only change their import. Old widget and its test move over.
- [ ] **2. Toast.** `MuToast.show(context, message:, type:, duration:, action:)` in `core/design_system/feedback/`: night capsule from the top safe area, tone disc, optional action, swipe up to dismiss, haptic on show, announced to screen readers. Same call shape as the old one (32 call sites change import only). `MuNudge` for inline nudges.
- [ ] **3. Nav capsule.** `MuNavCapsule` (night capsule, active item grows into a labelled pill with a spring, badge dot) replaces `MuBottomNav` in `MainShell`; old widget deleted.
- [ ] **4. Top bars.** `MuTopBar.greeting`, `MuTopBar.detail`, `MuGlassBar` (translucent, appears over scrolling content).
- [ ] **5. Sheets.** `showMuSheet` (grabber, drag to dismiss) and `showMuConfirm` (low dialog, destructive variant).
