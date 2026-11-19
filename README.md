# BO1 Living Zombies V1.0.1

Physics-driven zombies for Call of Duty: Black Ops (2010) Zombies on Plutonium T5. This is a free, non-commercial fan mod. It ships only its own plugin, script, and trained policy files. No game files are included or changed.

You need your own copy of Black Ops and Plutonium T5.

**Single-player only.** V1 is tested solo. Multiplayer and co-op have not been tested.

This repository holds the installer, documentation, and third-party licenses. The plugin, policies, and script are in the release zip, not in this git tree.

**Download:** [Releases](https://github.com/Ross2K/bo1-zombies-active-ragdoll/releases) — current package is [BO1 Living Zombies V1.0.1](https://github.com/Ross2K/bo1-zombies-active-ragdoll/releases/tag/v1.0.1).

## Install

1. Close the game.
2. Download `bo1-living-v1.0.1.zip` from [Releases](https://github.com/Ross2K/bo1-zombies-active-ragdoll/releases/latest) and unzip the whole folder.
3. Double-click `install.bat`. It copies files into `%LOCALAPPDATA%\Plutonium` and keeps a `.bak_pre_v1` copy of any file it replaces.
4. Start the game and load a Zombies map.

**Off switch:** open the console and type `living_enable 0`.

**Uninstall:** delete `plugins\ragdoll-m5.dll`, `plugins\bo1_living\`, and `storage\t5\scripts\sp\zom\ragdoll_m5_living.gsc` under `%LOCALAPPDATA%\Plutonium` (or rename the `.bak_pre_v1` files back).

## What it does

Zombies are driven by trained physics policies instead of canned animation:

- Walker policy: walk, run, sprint, and free turning.
- Getup policy: knocked-down zombies get back up on their own.
- Hits push zombies; a hard hit can knock one down.
- Zombie and player bumps, wall sliding, and a teleporter-pad floor fix.
- Chase the closest living player and use stock melee when close — only once the zombie is standing.
- No attacks while a zombie is down or getting up.
- Tighter braking turns (on by default).
- A stutter meter is built in but off by default.

Full details and known limits are in [RELEASE_NOTES.md](RELEASE_NOTES.md).

## Console dvars

| dvar | what it does |
|---|---|
| `living_enable 0/1` | master switch |
| `living_turn_slow 0/1` | brake into hard turns (default 1) |
| `living_melee_dist <m>` | melee range (default 1.8) |
| `living_max_zombies <n>` | cap on living zombies at once (default 0 = no cap) |
| `living_out_status` | read-only: body state of the zombie just ticked (1 = standing/may attack, 2 fell, 4 falling, 5 getting up) |
| `living_meter 0/1` | stutter meter log every 2 s (default 0 = off) |
| `living_max_turn <deg>` | turn limit per step (default 180 = uncapped) |
| `living_player_floor 0/1` | stand on player-only collision (teleporter pad fix) |
| `living_chase_any 0/1` | chase the closest player (0 = player 1 only) |
| `living_allow_attack 0/1` | let living zombies melee when close (only while standing) |
| `living_turn_slow_half_deg <deg>` | heading error where speed hits the floor (default 60) |
| `living_turn_slow_min <0-1>` | lowest speed fraction while turning (default 0.25) |
| `living_meter_csv 0/1` | also write the meter CSV (default 0) |
| `living_bump`, `living_bump_radius`, `living_bump_scale` | zombie/player bumps |
| `living_bump_players 0/1` | include players in bumps |
| `living_getup`, `living_getup_timeout_s`, `living_getup_stall_s` | getup and stuck fail-safe |
| `living_hit_scale` (+ `_melee`, `_explosive`) | hit push strength |
| `living_budget_ms` | per-frame CPU budget |
| `living_debug 1` | debug output |

## Credits / licenses

Physics: MuJoCo (Apache-2.0) and its bundled libraries (qhull, libccd, tinyxml2, tinyobjloader, lodepng, miniz, MarchingCubeCpp). Notices are in `licenses/`.

Black Ops and its assets belong to their owners. This mod is not affiliated with or endorsed by them.
