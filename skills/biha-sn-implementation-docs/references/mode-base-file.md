---
description: Steps for the base-file input mode of biha-sn-implementation-docs.
---

# Input Mode 1 — Base File

Use this mode when the user references one or more specific files as the source
for documentation.

## Trigger signals

- User provides a file path directly
- "document this file", "create docs for this script", "based on this artefact"
- User names a specific Script Include, Business Rule, or widget by name

---

## Steps

### Step 1 — Identify the file(s)

If the user did not provide an explicit path, ask via `AskUserQuestion`:
> "Which file or files should I use as the basis for the documentation?"

### Step 2 — Read the file(s)

Use `Read` to load the full content of each provided file.

### Step 3 — Extract structure from the path

The sn-scriptsync path pattern is:
`<instance>/<scope>/<table>/<ArtifactName>.<ext>`

From the path, derive:
- **Instance**: first path segment (e.g., `bithawkagdemo15`)
- **Scope**: second segment (e.g., `global`, `x_bits2_siamsync`)
- **Table**: third segment (e.g., `sys_script_include`, `sys_script`)
- **Artefact name**: filename without extension (e.g., `BiHaIncidentAjax`)

If the path does not follow this pattern, make no assumptions — ask the user for
scope and table via `AskUserQuestion`.

### Step 4 — Scan siblings for context

Use `Glob` on `<instance>/<scope>/<table>/` to list sibling artefacts in the same
table folder. Read files that appear related by name prefix or naming convention to build broader context.

### Step 5 — Gather business context

If the following are not derivable from the file or its path, ask via
`AskUserQuestion`:
- Business purpose: what process or use case does this artefact support?
- Related work items: full story/task/ticket identifiers (spell them out completely; do not abbreviate)
- Author name

### Step 6 — Build artefact summary

Produce a brief internal summary before handing off:

```
Artefact: <name>
Table:     <table>
Scope:     <scope>
Instance:  <instance>
Purpose:   <derived or user-supplied>
Key logic: <1–3 bullet points from reading the code>
```

### Step 7 — Hand off to universal workflow (§4 in SKILL.md)

Pass the artefact summary as the gathered input. Continue from Step 2 of the
universal workflow.

---

## Pitfalls

- Do not infer the customer name from the instance folder name — use only what the user states or what is in the project config.
- Do not document every line of code — document what the code does in terms of
  business logic and integration points.
- Do not read `_map.json`, `_settings.json`, or `scopes.json` for documentation
  content — these are sn-scriptsync metadata files.
