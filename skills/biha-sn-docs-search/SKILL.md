---
name: biha-sn-docs-search
version: 2.1.0
description: |
  Search and fetch official ServiceNow documentation as clean Markdown.
  Use proactively whenever the user asks how something works in ServiceNow,
  what OOB behaviour is, how a table/module/API is supposed to work, or when
  an authoritative quote from the product docs is needed.
  Trigger on: "how does X work in ServiceNow", "what is the OOB behaviour of Y",
  "ServiceNow docs", "check the docs for", "GlideRecord API", "khub", etc.
  Accepts a search query OR a docs.servicenow.com URL.
  Pass --release <branch-name> to target a specific release.
argument-hint: "<search query or docs.servicenow.com URL> [--release <branch-name>]"
allowed-tools:
  - PowerShell
  - Glob
  - Grep
  - Read
---

# ServiceNow Docs Search

**Owner:** Jesse Szepieniec, Krähenbühl Enea | **Review:** quarterly | **As of:** 2026-Q2 | **Version:** 2.1

Passive reference skill — no code generation. Reads from a **local clone** of `ServiceNow/ServiceNowDocs` when available (fast, zero API cost). Falls back to the khub API only when no local clone is found.

Platform: **Windows / PowerShell**. No `curl | python3`.

---

## 1 — Strategy

```
Local clone found?
  YES → Glob to find file → Read → done          (2–3 tool calls)
  NO  → khub API search → fetch content → done   (3–4 tool calls)
```

Always try local clone first.

---

## 2 — Step 1: Find the Local Clone

Detect the clone dynamically via git remote — do **not** hardcode a path.

**Shortcut:** Check `$env:SN_DOCS_PATH` first, if set and valid, skip the search entirely:

```powershell
if ($env:SN_DOCS_PATH -and (Test-Path "$env:SN_DOCS_PATH\markdown")) {
    $repoPath = $env:SN_DOCS_PATH
}
```

Only run the candidate search below when `$repoPath` is still empty.

```powershell
$candidates = @(
    "$env:USERPROFILE\OneDrive - BitHawk AG\Development",
    "$env:USERPROFILE\Development",
    "$env:USERPROFILE\source"
)

$repoPath = $null
foreach ($base in $candidates) {
    if (-not (Test-Path $base)) { continue }
    $hits = Get-ChildItem $base -Recurse -Depth 3 -Directory -Filter "markdown" -ErrorAction SilentlyContinue |
        Where-Object { Test-Path (Join-Path $_.Parent.FullName ".git") }
    foreach ($hit in $hits) {
        $root = $hit.Parent.FullName
        $remote = git -C $root remote get-url origin 2>$null
        if ($remote -like "*ServiceNow/ServiceNowDocs*") {
            $repoPath = $root
            break
        }
    }
    if ($repoPath) { break }
}
```

- Found → **§ 3 Local Mode**
- Not found → **§ 4 API Mode**

> **One-time setup (optional, but recommended):**
> ```powershell
> git clone --single-branch --branch australia --depth 1 `
>   https://github.com/ServiceNow/ServiceNowDocs.git `
>   "$env:USERPROFILE\Development\Tools\ServiceNowDocs"
> ```
> After cloning, queries run in 2–3 tool calls instead of 8–12 and work offline.
>
> Set the clone path as `SN_DOCS_PATH` in the `"env"` block of `~/.claude/settings.local.json` so future searches hit the shortcut in § 2 immediately, for example:
> ```json
> "env": { "SN_DOCS_PATH": "C:\\Users\\<user>\\Development\\Tools\\ServiceNowDocs" }
> ```

---

## 3 — Local Mode (preferred)

### 3a — Detect release

```powershell
$release = git -C $repoPath branch --show-current   # e.g. "australia"
```

### 3b — URL Mode (if argument contains `docs.servicenow.com` or starts with `r/`)

Extract the subpath after `/docs/r/`, strip `.html`, map to `markdown\{subpath}.md`:

```powershell
$subpath = $arg -replace "https://www.servicenow.com/docs/r/","" -replace "\.html$",""
$file = Join-Path $repoPath "markdown\$subpath.md"
# Then: Read $file
```

If file not found → fall through to keyword search (§ 3c).

### 3c — Keyword Mode

**Never Grep the entire `markdown\` tree — it times out.**

Use two steps:

**Step 1 — Identify the publication folder** using the Glob tool:

```
Glob pattern: **
path: <repoPath>\markdown
→ lists all top-level publication folders
```

Match the query to a folder name. Examples:
- "Service Bridge", "Service Exchange" → `service-exchange`
- "GlideRecord", "Script Include", API → `api-reference`
- "Incident", "Change", "ITSM" → `it-service-management`
- "Flow Designer", "Workflow" → `build-workflows`
- "Service Portal", "ESC" → `platform-user-interface`

If unsure: read `<repoPath>\llms.txt` — it lists all publications with human-readable names.

**Step 2 — Find the file** within the publication folder:

```
Glob pattern: **/*.md
path: <repoPath>\markdown\<publication-folder>
```

Pick the best match:
- Conceptual questions → prefer `*overview*`, `*landing*`, `*exploring*`, `*-both-*`
- API questions → prefer `*api*`, `*reference*`
- Setup questions → prefer `*install*`, `*configure*`, `*register*`
- Unclear → read `index.md` in the publication folder first

### 3d — Read the file

Use the **Read tool** on the selected file. Output verbatim, preserving structure.

Extract from YAML frontmatter and always cite:
```yaml
canonical_url: https://www.servicenow.com/docs/...
last_updated: YYYY-MM-DD
```

---

## 4 — API Mode (fallback — no local clone)

### 4a — Detect release

```powershell
$repo    = Invoke-RestMethod "https://api.github.com/repos/ServiceNow/ServiceNowDocs"
$release = if ($repo.default_branch -and $repo.default_branch -ne "main") { $repo.default_branch } else { "australia" }
```

### 4b — URL Mode

Extract subpath from URL, try GitHub raw:

```powershell
$subpath = $arg -replace "https://www.servicenow.com/docs/r/","" -replace "\.html$",""
$subpath = $subpath -replace "^$release/",""
try {
    Invoke-RestMethod "https://raw.githubusercontent.com/ServiceNow/ServiceNowDocs/$release/markdown/$subpath.md"
} catch {
    # fall through to search
}
```

### 4c — Keyword Search via khub API

```powershell
$body = @{ query = "<QUERY>"; contentLocale = "en-US"; scope = "DEFAULT"; page = 1; perPage = 10 } | ConvertTo-Json
$resp = Invoke-RestMethod -Uri "https://www.servicenow.com/docs/api/khub/topics/search" `
    -Method POST -ContentType "application/json" -Body $body
```

Extract only what is needed — **never dump the full JSON**:

```powershell
$resp.results | Select-Object -First 5 | ForEach-Object {
    [PSCustomObject]@{
        title   = ($_.occurrences[0].breadcrumb | Select-Object -Last 1)
        url     = $_.occurrences[0].readerUrl
        mapId   = $_.mapId
        contId  = $_.contentId
    }
}
```

Prefer hits where breadcrumb or URL contains `$release`.

### 4d — Fetch content

```powershell
# 1. Try GitHub raw (cleaner markdown)
$subpath = $readerUrl -replace "https://www.servicenow.com/docs/r/","" -replace "\.html$","" -replace "^$release/",""
try {
    Invoke-RestMethod "https://raw.githubusercontent.com/ServiceNow/ServiceNowDocs/$release/markdown/$subpath.md"
} catch {
    # 2. Fallback: khub content API
    Invoke-RestMethod "https://www.servicenow.com/docs/api/khub/maps/$mapId/topics/$contentId/content?format=markdown"
}
```

---

## 5 — Output Rules

1. Always cite the `canonical_url` (from frontmatter) or `readerUrl` (API fallback).
2. State release and source: e.g. `Release: australia | Source: local clone`.
3. Quote verbatim — preserve bullets and tables.
4. Surface `last_updated` from frontmatter when available.
5. Never dump raw JSON or full metadata objects.

---

## 6 — Failure Modes

| Symptom | Cause | Fix |
|---|---|---|
| Local clone not found | Repo not cloned | See one-time setup in § 2 |
| Glob returns nothing useful | Wrong publication folder guessed | Read `llms.txt` to find correct folder name |
| GitHub raw 404 | Subpath mismatch | Use khub content API fallback |
| khub 403/405 | CDN auth issue | Retry once; use local clone if available |
| Grep timeout | Searched entire `markdown\` tree | Always search in specific publication subfolder |
| Clone search slow (OneDrive scan) | `SN_DOCS_PATH` not set | Set `SN_DOCS_PATH` env var (see § 2) |

---

## 7 — Update Local Clone

```powershell
git -C $repoPath pull --depth 1
```
