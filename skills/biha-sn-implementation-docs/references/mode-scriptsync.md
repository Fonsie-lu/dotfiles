---
description: Steps for the sn-scriptsync scope input mode of biha-sn-implementation-docs.
---

# Input Mode 3 — sn-scriptsync Scope

Use this mode when the user references a scope folder that has been synced from
ServiceNow using the sn-scriptsync VS Code extension.

## Trigger signals

- User names a scope (e.g., `x_bits2_siamsync`, `x_bh_cmdb`)
- "scoped app", "scope folder", "sn-scriptsync artefacts", "synced artefacts"
- User provides a path like `customerinstanceA/x_bits2_siamsync/`

---

## Pre-check: Confirm sn-scriptsync folder structure

The sn-scriptsync layout requires:
```
<instance>/<scope>/<table>/_map.json
```

Use `Glob` to check for `_map.json` files under the named scope. If none are found, inform the user:

> "No sn-scriptsync artefacts found in the `<scope>` folder (`_map.json` missing).
> Please run the VS Code command **sn-scriptsync: Load/Refresh artefacts from scope** and try again."

Do not proceed until the user confirms artefacts have been synced.

---

## Steps

### Step 1 — Determine instance and scope

If the user only named a scope (e.g., `x_bits2_siamsync`), use `Glob` to find
which instance folder contains it:

```
*/<scope>/
```

If multiple instances contain the same scope, ask the user to confirm which one via `AskUserQuestion`.

### Step 2 — Discover artefacts

Glob all script and markup files under `<instance>/<scope>/`:

```
<instance>/<scope>/**/*.script.js
<instance>/<scope>/**/*.client_script.js
<instance>/<scope>/**/*.client_script_v2.js
<instance>/<scope>/**/*.calculation.js
<instance>/<scope>/**/*.template.html
<instance>/<scope>/**/*.css.scss
<instance>/<scope>/**/script.js
<instance>/<scope>/**/client_script.js
```

Group files by `<table>` segment of their path.

### Step 3 — Read artefacts

Read each discovered file. For large scopes (more than 20 files), read only the
files in tables most relevant to the documentation topic. If unsure which tables
are most relevant, ask the user via `AskUserQuestion`.

### Step 4 — Confirm presence via `_map.json`

For each `<table>` folder, read `_map.json` to confirm which artefact names have
been successfully synced (have a sys_id entry). Note: sys_ids must **never** appear in the generated documentation.

### Step 5 — Handle global / non-scoped artefacts

If the scoped code references global artefacts (e.g., cross-scope `GlideRecord`
queries, global `sys_script_include` calls), inform the user:

> "The implementation may also reference global artefacts under `global/<table>/`.
> If these are relevant for the documentation, please sync them manually via sn-scriptsync and let me know their names."

List any referenced global types identified from the scoped code.

### Step 6 — Gather business context

If not derivable from artefact names or code, ask via `AskUserQuestion`:
- Business purpose of the scope
- Related work items (full identifiers, no abbreviations)
- Author

### Step 7 — Hand off to universal workflow (§4 in SKILL.md)

Pass the grouped artefact summary as the gathered input.

---

## Pitfalls

- sys_ids from `_map.json` are internal identifiers — never include them in the
  documentation.
- `_settings.json` and `scopes.json` contain credentials and are gitignored — never read them.
- Do not create or modify any `_map.json` files — they are managed exclusively by sn-scriptsync.
