---
description: Configuration schema, defaults, and override resolution for biha-sn-implementation-docs.
---

# Configuration Reference

The skill reads a per-project configuration file to adapt its behaviour to a
specific customer or project. The file is optional — skill defaults apply when
absent.

---

## Config file location

```
<project-root>/.biha-sn-implementation-docs.config.json
```

Place this file at the root of the project workspace (the folder open in IDE).
Commit it to the project repository if the settings are shared across the team, or
add it to `.gitignore` if they are personal.

A template is provided at:
```
skills/biha-sn-implementation-docs/.biha-sn-implementation-docs.config.example.json
```

Copy it to the project root and remove `.example` from the filename.

---

## Override resolution order

Highest priority wins:

1. Inline override in the user's message  
   (e.g., "use English this time", "save to `documentation/`")
2. `.biha-sn-implementation-docs.config.json` at the project root
3. Skill defaults (listed below)

---

## Schema and defaults

```json
{
  "language": "de",
  "output_folder": "docs",
  "images_folder": "docs/images",
  "filename_suffix": "-implementation",
  "audience": ["process-owners", "technicians"],
  "mermaid": {
    "render": "code-only"
  },
  "diagrams": {
    "default_direction": "LR"
  },
  "servicenow_mcp_available": null
}
```

---

## Key descriptions

| Key | Default | Description |
|-----|---------|-------------|
| `language` | `"de"` | Language profile for prose. `"de"` = Swiss German; `"en"` = English. Add profiles by extending `references/prose-style.md`. |
| `output_folder` | `"docs"` | Folder (relative to project root) where generated documentation is written. |
| `images_folder` | `"docs/images"` | Folder for mermaid-rendered PNG files. Create it manually or let `curl` create it. |
| `filename_suffix` | `"-implementation"` | Appended to the base name to form the output filename. |
| `audience` | `["process-owners","technicians"]` | Target readers. Influences depth and terminology in prose. Valid values: `"process-owners"`, `"technicians"`, `"developers"`. |
| `mermaid.render` | `"code-only"` | `"code-only"`: embed mermaid source only. `"image"`: also render and embed a PNG via mermaid.ink. |
| `diagrams.default_direction` | `"LR"` | Default flowchart direction: `"LR"` (left-to-right) or `"TB"` (top-to-bottom). |
| `servicenow_mcp_available` | `null` | Written automatically to `true` or `false` after the first update-set run that prompts the user. Prevents repeated prompting. |

---

## Merge semantics

- **Top-level keys** are shallow-merged: a config file with only `"language": "en"`
  overrides that key and leaves all others at their defaults.
- **`mermaid` and `diagrams` objects** are deep-merged: setting
  `"mermaid": { "render": "image" }` overrides only `render`; other mermaid keys
  remain at their defaults.

---

## Writing back to the config (`servicenow_mcp_available`)

When the key is `null` or absent and the update-set mode is run, the skill asks the
user once via `AskUserQuestion` and then persists the answer:

- **Config file exists** → use `Edit` to update the `servicenow_mcp_available` key.
- **Config file does not exist** → use `Write` to create a minimal config:
  ```json
  { "servicenow_mcp_available": true }
  ```

This ensures the user is not prompted again in subsequent runs within the same
project.
