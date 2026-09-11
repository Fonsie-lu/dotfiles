# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal [Waybar](https://github.com/Alexays/Waybar) configuration for a River (wlroots) Wayland session on Arch Linux, on an AMD desktop (k10temp CPU sensor, amdgpu, Gigabyte motherboard — not a laptop, despite the `battery`/`backlight` modules defined but unused in `modules-*`). Not a software project with a build system — it's declarative config (JSONC + GTK CSS) that Waybar reads directly at runtime. There is no build, lint, or test tooling for this directory.

## Files

- `config.jsonc` — module layout and per-module config (JSON with comments, Waybar's format).
- `style.css` — main stylesheet; imports one theme file for the `@define-color` palette.
- `tokyo.css` / `mocha.css` — interchangeable Catppuccin-style color palettes (Tokyo Night and Catppuccin Mocha). Only one is `@import`ed from `style.css` at a time (currently `tokyo.css`). Both define the same set of color variable names (`@base`, `@text`, `@surface0`, `@red`, `@teal`, etc.), so switching themes is just changing the `@import` target in `style.css` — no other file needs to change.
- `wttrbar` — a prebuilt third-party binary ([wttrbar](https://github.com/bjesus/wttrbar), a weather module for Waybar). It is not currently wired into `config.jsonc`'s `custom/*` modules; treat it as available-but-unused rather than dead code to remove.

## Applying changes

Waybar must be restarted (or sent `SIGUSR2`/reloaded via the compositor) to pick up config/style changes — there's no separate reload command bundled here. Modules using `"signal"` (e.g. `custom/updates` uses signal 8) can be refreshed live with `pkill -SIGRTMIN+8 waybar` instead of a full restart.

## Editing conventions

- Keep module color rules keyed by GTK CSS node id (`#moduleName`, e.g. `#temperature`, `#cpu.warning`) rather than classes, matching Waybar's own `#name.state` selector convention — this is how the existing rules in `style.css` are structured.
- State-based coloring (`warning`/`critical`) is driven by each module's `"states"` thresholds in `config.jsonc` and styled via matching `.warning`/`.critical` CSS classes in `style.css` — when adding thresholds to a module, add the corresponding CSS rule (and vice versa).
- Icons are Nerd Font glyphs embedded directly in `format` strings; font size is frequently overridden inline per-icon via `<span font='N'>` rather than in CSS.
- Colors are referenced in `style.css` via the `@name` variables defined in the imported theme file, never as literal hex codes.

## Hardware-specific values

A few module settings are pinned to this specific machine's hardware and need re-checking if the config is ever moved to different hardware:

- `temperature.hwmon-path-abs` (`config.jsonc`) points at the k10temp sensor's hwmon directory (`/sys/devices/pci0000:00/0000:00:18.3/hwmon`, `temp1_input` = `Tctl`). Find the right one with `for d in /sys/class/hwmon/hwmon*; do cat "$d/name"; done` (look for `k10temp` on AMD or `coretemp` on Intel), then resolve its real path with `readlink -f /sys/class/hwmon/hwmonN`.
- `custom/updates.exec` shells out to `pacman -Qu` (official repos) and `paru -Qua` (AUR) — both Arch/paru-specific and assume `paru` is installed for AUR support.
- `battery.bat` is hardcoded to `BAT0`; irrelevant while `battery`/`backlight` aren't in `modules-*` (desktop, no battery/backlight hardware).
