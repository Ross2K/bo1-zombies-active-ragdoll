# BO1 Living Zombies — V1

**Version:** V1.0.1 · **Date:** October 31, 2026 · **Game:** Call of Duty: Black Ops (2010) Zombies on Plutonium T5 — **single-player only** (multiplayer/co-op not tested)

**Download:** [bo1-living-v1.0.1.zip](https://github.com/Ross2K/bo1-zombies-active-ragdoll/releases/download/v1.0.1/bo1-living-v1.0.1.zip)

**SHA-256:** `20022cb43e9df6c88e3698eeac62d27fd9f3d7779c43e15e5b45c4e8d840f301`

Free, non-commercial fan mod. It ships only its own plugin, script and trained policy files. No game files are included or changed — you need your own copy of Black Ops and Plutonium.

## New in V1.0.1
- **No attack while down:** a living zombie that is on the ground or getting up can't swing until it is fully standing and walking again.
- **Tighter turns (turn-slow):** zombies brake into hard heading changes instead of looping wide into walls at full speed. Dvars `living_turn_slow` (default 1; 0 = old full-speed turning), `living_turn_slow_half_deg` (default 60), `living_turn_slow_min` (default 0.25).
- **Stutter meter (off by default):** built-in frame/hitch meter for troubleshooting. `living_meter 1` logs one `living meter:` line every 2 s; `living_meter_csv 1` also writes `plugins\bo1_living\logs\living_meter.csv`. No gameplay change.

## What's in V1
Zombies are driven by trained physics policies instead of canned animation.
- **Walker policy** (`walk_sprint_turn`): walks, runs, sprints and turns freely (no turn cap; `living_max_turn` defaults to 180°). Speed follows the zombie's move type: walk 1.0 / run 2.7 / sprint 3.5 m/s.
- **Getup policy:** knocked-down zombies get back up on their own.
- **Hits:** bullets, melee and explosives push zombies; a hard hit (e.g. headshot) can knock one down for a couple of seconds.
- **Bumps:** zombies shove each other and players. Stuck fail-safe releases a zombie that has been pinned for 2 s with almost no movement.
- **World:** zombies slide along walls and stand on player-only collision (e.g. the lobby teleporter pad) instead of sinking into it.
- **Chase + attack:** zombies chase the closest living player (not only player 1) and use stock melee when close (~1.8 m) — only once standing.
- **Death:** killed zombies go to ragdoll with a death shove (intentionally strong).

## Install
1. Close the game.
2. Unzip the whole folder anywhere.
3. Double-click **`install.bat`**. It copies the files into `%LOCALAPPDATA%\Plutonium\plugins` and `%LOCALAPPDATA%\Plutonium\storage\t5\scripts\sp\zom`, and keeps a `.bak_pre_v1` copy of any file it replaces. (That's your Windows user LocalAppData, even if the game itself is on another drive.)
4. Start the game and load any Zombies map.

**Uninstall:** delete `plugins\ragdoll-m5.dll`, `plugins\bo1_living\` and `storage\t5\scripts\sp\zom\ragdoll_m5_living.gsc` under `%LOCALAPPDATA%\Plutonium` (or rename the `.bak_pre_v1` files back to restore an older build).

## Console dvars
| dvar | what it does |
|---|---|
| `living_enable 0/1` | master switch |
| `living_max_turn <deg>` | turn limit per step (default 180 = uncapped) |
| `living_player_floor 0/1` | stand on player-only collision (teleporter pad fix) |
| `living_chase_any 0/1` | chase the closest player (0 = player 1 only) |
| `living_allow_attack 0/1` | let living zombies melee when close (only while standing, see `living_out_status`) |
| `living_melee_dist <m>` | melee range (default 1.8) |
| `living_max_zombies <n>` | cap on living zombies at once (default 0 = no cap; lower it on slower PCs) |
| `living_out_status` | read-only: body state of the zombie just ticked (1 = standing/may attack, 2 fell, 4 falling, 5 getting up) |
| `living_turn_slow 0/1` | brake into hard turns (default 1) |
| `living_turn_slow_half_deg <deg>` | heading error where speed hits the floor (default 60) |
| `living_turn_slow_min <0-1>` | lowest speed fraction while turning (default 0.25) |
| `living_meter 0/1` | stutter meter log every 2 s (default 0 = off) |
| `living_meter_csv 0/1` | also write the meter CSV (default 0) |
| `living_bump`, `living_bump_radius`, `living_bump_scale` | zombie/player bumps |
| `living_bump_players 0/1` | include players in bumps |
| `living_getup`, `living_getup_timeout_s`, `living_getup_stall_s` | getup and stuck fail-safe |
| `living_hit_scale` (+ `_melee`, `_explosive`) | hit push strength |
| `living_budget_ms` | per-frame CPU budget |
| `living_debug 1` | debug output |

## Known limits
- One walker policy (walk/run/sprint) + one getup policy. No attack or crawl policy yet.
- Zombies follow the game's navigation, so tight turns at walls can still look clumsy.
- The death shove is strong on purpose: bodies can fly, and there can be a brief hitch with many living zombies.
- Roughly 8–9 ms/frame CPU at ~10 living zombies; slower PCs may hitch (`living_budget_ms` lowers the load).
- Single-player only. Multiplayer/co-op has not been tested.
- The teleporter-pad floor uses a player-collision trace; zombie bodies standing on the pad can occasionally confuse it (`living_player_floor 0` turns it off).

## Credits / licenses
Physics: MuJoCo (Apache-2.0) and its bundled libraries (qhull, libccd, tinyxml2, tinyobjloader, lodepng, miniz, MarchingCubeCpp). Notices in `licenses\`. Black Ops and its assets belong to their owners; this mod is not affiliated with or endorsed by them.
