---
description: Steps for the update-set input mode of biha-sn-implementation-docs.
---

# Input Mode 4 — Update Set

Use this mode when the user provides one or more update set names or an exported
XML file as the source for documentation.

## Trigger signals

- User mentions an update set name (e.g., "BiHa - STRY0012345 - V01 - Feature")
- User provides an XML file exported from ServiceNow
- "document what's in the update set", "documentation for the update set"

---

## Step 1 — Parse update set names

Extract update set name(s) from the user's message. If multiple names are given,
ask: are these related through a parent–child relationship in ServiceNow? If
uncertain, proceed and resolve the batch structure in Step 3.

---

## Step 2 — Check ServiceNow MCP availability

Read the project config (`.biha-sn-implementation-docs.config.json`) and check the `servicenow_mcp_available` key:

- **`true`** → proceed to Step 3a (MCP path).
- **`false`** → proceed to Step 3b (XML path).
- **`null` or key absent** → ask the user **once** via `AskUserQuestion`:
  > "Is a ServiceNow MCP configured for this project?"

  Then persist the answer back to the project config using `Edit` (update the key) or `Write` (create a minimal config if the file does not yet exist):
  ```json
  { "servicenow_mcp_available": true }
  ```
  Proceed to the matching branch.

---

## Step 3a — MCP path

Query using the available ServiceNow MCP tools.

**Single update set**: query `sys_update_set` by name to get the sys_id and state, then inspect child records in `sys_update_xml`.

**Batched update sets**: query `sys_update_set` using the `parent` field
(`parent=<parent_sys_id>`) to retrieve all child update sets. Aggregate artefacts
across the entire batch.

For each artefact:
- Extract: `type` (artefact type), `name`, `payload` (if script content is present)
- Group by artefact type (Business Rules, Script Includes, Client Scripts, etc.)
- Deduplicate by name across the batch; note the source update set for each. If multiple `sys_update_xml` matching same `name` only take the one with latest `sys_updated_on`.

---

## Step 3b — XML path

If no MCP is available, instruct the user:

> "Please export the update set as XML from ServiceNow
> (System Update Sets → Local Update Sets → *Open desired update set* → Export to XML) and provide me with the file path of the exported file."

For batched update sets, use `Export Update Set Batch to XML` related link on desired update set.

Once the file path(s) are provided:

1. Read each XML file using `Read`.
2. Locate `<sys_remote_update_set>` elements for update set metadata.
3. Locate child `<sys_update_xml>` elements for individual artefacts.
4. For batches, follow the `<parent>` field on update set records to identify the
   parent–child hierarchy.
5. Extract per artefact:
   - `<type>`: the ServiceNow artefact type
   - `<name>`: the artefact name
   - `<payload>`: script or configuration content (if present)
6. Group by artefact type; deduplicate by name; note source update set.If multiple matching only use the one with latest `sys_updated_on`.

---

## Step 4 — Gather business context

Ask via `AskUserQuestion` if not derivable from the update set names or payloads:
- Business purpose of the update set(s)
- Related work items (full identifiers — spell them out completely; do not
  abbreviate)
- Author

---

## Step 5 — Hand off to universal workflow (§4 in SKILL.md)

Pass the grouped artefact summary as the gathered input. Continue from Step 2 of
the universal workflow.
