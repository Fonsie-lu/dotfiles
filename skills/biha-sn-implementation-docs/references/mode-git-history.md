---
description: Steps for the git-history input mode of biha-sn-implementation-docs.
---

# Input Mode 2 — Git History

Use this mode when the user wants to document recent changes tracked in a git
repository.

## Trigger signals

- "document recent changes", "what we committed", "document the last N commits"
- "git history" as source, no specific file or update set mentioned

---

## Pre-check: Confirm git repository

Before any other step, run:

```bash
git rev-parse --is-inside-work-tree 2>&1
```

If the command fails or returns an error, stop and inform the user:

> "The current directory is not a git repository. Please switch to the correct
> directory or use a different input mode: Base File, sn-scriptsync Scope, or
> Update Set."

Do not proceed further in git mode.

---

## Steps

### Step 1 — Determine scope of changes

Run these read-only commands:

```bash
git status --short
git log --oneline -20
```

Ask the user via `AskUserQuestion` to confirm the commit range if unclear:
> "Should I document the last N commits, or a different range (e.g., `HEAD~5..HEAD`)?"

### Step 2 — Get the diff

For the confirmed range:

```bash
git diff <range> --stat
git diff <range> -- <file>
```

For uncommitted changes:

```bash
git diff HEAD --stat
git diff HEAD -- <file>
```

Read each changed file using `Read`.

### Step 3 — Group changes by scope and table

The sn-scriptsync path pattern is `<instance>/<scope>/<table>/<ArtifactName>.<ext>`.

Group all changed files by `<scope>/<table>` prefix. For each group, record:
- Artefact names added, modified, or removed
- File content from Step 2

If the repository does not follow the sn-scriptsync layout, ask the user:
> "The file paths do not follow a recognised sn-scriptsync structure. Can you
> describe which ServiceNow components these changes relate to?"

### Step 4 — Gather business context

If not derivable from commit messages or file content, ask via `AskUserQuestion`:
- Business purpose of the changes
- Related work items (full identifiers, no abbreviations)
- Author

### Step 5 — Hand off to universal workflow (§4 in SKILL.md)

Pass the grouped change summary as the gathered input.

---

## Pitfalls

- Do not run `git add`, `git commit`, `git push`, or any write git commands.
- Merge commits show many files but often represent no real functional change;
  focus on feature and fix commits.
- Commit messages may contain work item references — extract them, but spell them
  out fully.
