# Plan 7 — Design system content components

Spec: the μLearn Mobile design system artifact (AvatarStack, BentoBoard, IGSticker, Switchboard, EventTicket, LevelPath, Leaderboard, VoiceBubbles). These are what the pre-login experience (plan 8) and the migrated Home are built from. Branch `feat/design-system`, one commit per task, no push. Generated files are never run through `dart format`.

## Tasks

- [ ] **1. Tones, avatars.** `IgCategory` + `MuTones` (category → sticker fill, always `ink-print` text). `MuAvatar` (photo via cached_network_image, else initials on a category fill hashed from the name). `MuAvatarStack` replaces the old one with the same constructor (2 call sites change import); `MuPeerLine` names the first two people ("Arjun, Sneha & 9 others from CET").
- [ ] **2. Slab and bento.** `MuSlab` (hero slab with token-shape orbs, cobalt/volt/night) and `MuBento` + `MuTile` (tall, square, wide; coloured by IG category; corner arrow when it opens).
- [ ] **3. IG sticker.** `MuIgSticker` (category fill, one sharp corner, stable tilt by index, Join/Joined) and `MuIgChip`.
- [ ] **4. Switchboard.** `MuSwitchboard` (ruled 2×2 doors, icon wells in category colours) with the `MuPulseStrip` marquee (pauses on touch, static under reduced motion).
- [ ] **5. Event ticket.** `MuTicketBorder` (notches + perforation as one ShapeBorder) and `MuEventTicket` listing variant (poster or generated poster, capacity/type badges, meta pills, going row, stub action).
- [ ] **6. Level path and ranks.** `MuLevelPath` (stations: done / now / locked, hatched) and `MuPodium` + `MuRankRow` (karma bar scaled to #1, "you" row).
- [ ] **7. Voice bubble.** `MuVoiceBubble` (pill speech bubble with tail, tone).
