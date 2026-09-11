---
name: biha-sn-implementation-docs
version: 1.0.0
description: >
  Generate or update ServiceNow implementation documentation in the project's
  docs/ folder. Trigger when a user asks to document an implementation, create
  or update implementation docs, or references a ServiceNow update set, scoped
  app, sn-scriptsync artefact folder, recent git commits, or a single base file
  as the source of truth and wants prose plus mermaid diagrams as output.
  Customer-agnostic; reads a per-project config
  (.biha-sn-implementation-docs.config.json) for language, output folder,
  filename suffix, audience, mermaid rendering and ServiceNow MCP availability.
---

# BitHawk ServiceNow — Implementation Documentation

**Owner:** Marco Moro, Stephan Kreilos | **Review:** quarterly | **As of:** 2026-Q2 | **Version:** 1.0

---

## 1. Purpose & Scope

This skill generates or updates a Markdown implementation document for a ServiceNow
delivery. It is customer-agnostic — all project-specific settings live in
`.biha-sn-implementation-docs.config.json` at the project root (optional; skill
defaults apply when absent).

The skill is deployed globally to `~/.claude/skills/` and applies to all ServiceNow projects. Customer-specific documentation skills supersede this one when present.

**Never overwrite an existing document without explicit user confirmation via
`AskUserQuestion`.**

Output: `<output_folder>/<base-name><filename_suffix>.md`
Defaults: `docs/<base-name>-implementation.md`

---

## 2. Input Mode Dispatcher

Identify the input mode from the user's message before doing anything else. Then
read the corresponding reference file for detailed steps.

| Mode | Signal phrases | Reference |
|------|---------------|-----------|
| **1 — Base file** | "document this file", "based on this script", user provides a file path | `references/mode-base-file.md` |
| **2 — Git history** | "recent changes", "what we committed", "git history", "last N commits" | `references/mode-git-history.md` |
| **3 — sn-scriptsync** | "scoped app", "scope folder", "sn-scriptsync", scope name like `x_bits2_` | `references/mode-scriptsync.md` |
| **4 — Update set** | "update set", "Update Set Name", "BiHa - STRY...", XML file provided | `references/mode-update-set.md` |

If the mode is ambiguous or the user's message could match multiple modes, ask via
`AskUserQuestion` before proceeding.

---

## 3. Resolve Project Config

Always resolve the effective configuration before gathering input. Read
`references/config-resolution.md` for the full schema and override order.

**Core keys** (defaults; inline message overrides take highest priority):

| Key | Default | Purpose |
|-----|---------|---------|
| `language` | `de` | Prose language profile; see `references/prose-style.md` |
| `output_folder` | `docs` | Folder where the doc is written |
| `filename_suffix` | `-implementation` | Appended to the base name |
| `audience` | `["process-owners","technicians"]` | Influences depth and terminology |

---

## 4. Universal Workflow

Every mode feeds into this pipeline after gathering input:

1. **Gather** — run the mode-specific reference file; collect artefact list and
   metadata.
2. **Resolve config** — apply §3; record effective settings.
3. **Detect existing doc** — see §7; ask user if a match is found.
4. **Ask for missing context** — if business purpose or related work items are
   unknown, ask via `AskUserQuestion`. **Author name is always required** — if
   not provided, ask via `AskUserQuestion`; never use a placeholder. When making
   an assumption, state it explicitly and ask for confirmation.
5. **Build outline** — produce a three-section skeleton:
   - Section 1: Overview (`en`) / Übersicht (`de`) — metadata table + process steps
   - Section 2: Constraints and Decisions (`en`) / Einschränkungen, Grenzen und Entscheidungen (`de`)
     — ADR placeholders if none derivable
   - Section 3: Technical Implementation (`en`) / Technische Implementierung (`de`)
     — diagram list + planned subsections
6. **Enter plan mode** — call `EnterPlanMode` with: target filename, section
   outlines, diagram list, audience, language profile, open assumptions.
7. **Incorporate feedback** — adjust outline per user response.
8. **Exit plan mode** — call `ExitPlanMode`.
9. **Write content** — section by section; apply `references/prose-style.md` and
   `references/mermaid-guidelines.md`.
10. **Optional mermaid render** — only if `mermaid.render: "image"` or user
    requests it; follow `references/mermaid-ink-integration.md`.
11. **Write file** — `Write` for new documents, `Edit` for existing. Show final
    summary: filename, sections written, diagrams, image paths, outstanding TODOs.

---

## 5. Mandatory Document Structure

Every generated document contains **at minimum** these three top-level sections in
this order. When updating an existing document, **preserve any sections the user
has added** beyond the three mandatory ones.

Section titles must match the active language profile (`language` config key). Read
`references/document-structure.md` for full specification, templates, and examples.

1. **Overview** (`en`) / **Übersicht** (`de`) — metadata table, affected work
   items, 3–5 step process overview in plain business language (no ServiceNow
   terminology).
2. **Constraints, Limits and Decisions** (`en`) / **Einschränkungen, Grenzen und
   Entscheidungen** (`de`) — technical constraints, design limits, and ADR entries.
   Emit `**TODO:**` placeholders for any entry that cannot be derived from the
   input; flag these in the final summary.
3. **Technical Implementation** (`en`) / **Technische Implementierung** (`de`) —
   focused description; first diagram is audience-dependent (see §6), then detail
   sections for components that drive non-obvious behaviour.

---

## 6. Diagram Policy

Generate mermaid diagrams for all technical flows.

The **first diagram** in Section 3 depends on the audience:
- `process-owners` in audience → **process overview** first (business flow, no
  technical component or API detail)
- `technicians` / `developers` only → **architecture overview** first

If `mermaid.render: "image"` is set or the user requests it, follow
`references/mermaid-ink-integration.md` — always keep the mermaid code block
in the document as well.

For templates, direction rules, and anti-patterns, read
`references/mermaid-guidelines.md`.

---

## 7. Existing-Doc Detection

Before writing, check whether a document already exists for this topic:

1. Derive the candidate filename: `<base-name><filename_suffix>.md` (base name from
   update-set name, scope name, base file stem, or user-supplied topic).
2. Glob `<output_folder>/**/*<filename_suffix>.md` for existing implementation docs.
3. Resolution:
   - **Exact filename match** → ask via `AskUserQuestion`: propose updating the
     existing file.
   - **Fuzzy match** (case-insensitive substring) → list up to 3 candidates; ask
     user to pick one or confirm "create new".
   - **No match** → confirm the proposed filename via `AskUserQuestion` before
     writing.

Never write or edit a file without passing this confirmation gate.

---

## 8. Language & Style

Apply the language profile selected by the `language` config key. Read
`references/prose-style.md` for the full rules, checklist, and worked examples.

**Always**: ServiceNow technical identifiers (table names, field names, script
names, scope names) are English in inline code, regardless of the prose language.
Example: `` `cmdb_ci_business_app` ``, `` `u_mycustomfield` ``.

---

## 9. Tool Usage Rules

- `EnterPlanMode` / `ExitPlanMode` — mandatory around the document outline; never
  write before the user approves the plan.
- `Write` — for new documents only.
- `Edit` — for updates to existing documents only.
- `AskUserQuestion` — for any ambiguity, assumption, missing context, or
  confirmation gate (existing doc detection, MCP availability).
- `Glob` / `Read` — for discovering existing docs and reading input artefacts.
- `Bash` — for read-only git commands (Mode 2) and mermaid encoding. Never use
  Bash to create or modify files — use `Write` or `Edit` instead.

---

## 10. Runtime Checklist

Tick every item before calling `Write` or `Edit`:

- [ ] Identified one of the four input modes; loaded the matching
  `references/mode-*.md`
- [ ] If git mode: confirmed the working directory is a git repository before
  proceeding
- [ ] If update-set mode and `servicenow_mcp_available` is unset: asked the user
  once and persisted the answer to the config file
- [ ] If existing doc found: asked user via `AskUserQuestion` before any
  modification
- [ ] Asked user via `AskUserQuestion` whenever an assumption was made or input was
  ambiguous
- [ ] Process overview in Section 1 uses business language only (no `BR`, `Script
  Include`, table names)
- [ ] Architecture overview diagram is the FIRST diagram in Section 3
- [ ] Detail diagrams follow, each with consistent direction
- [ ] All ServiceNow technical names are inline-coded and English
- [ ] Prose passes the active language profile's rules (no AI fluff, correct
  spelling)
- [ ] Constraints/Decisions section: real entries OR `**TODO:**` placeholders
  flagged in final summary
- [ ] If mermaid images requested: sanitization checklist in
  `references/mermaid-ink-integration.md` passed before encoding
- [ ] Mermaid code block kept in document alongside any image reference

---

## 11. Out of Scope

This skill does not:
- Write stories, acceptance criteria, or test cases → use
  `biha-sn-requirement-engineering`
- Generate ServiceNow code → use `biha-sn-coding`
- Automatically push or upload files to ServiceNow or any remote system
- Replace customer-specific documentation skills — a more specific skill supersedes
  this one when present in the same project
