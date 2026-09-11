# Templates & Output Format

## Templates

### Story

Stories are managed in the **BitHawk ServiceNow instance** and consist of three fields:

| Field | Type | Purpose |
|---|---|---|
| **Short Description** | Text (single line) | Story title |
| **Description** | HTML (Rich Text) | What, why, context – understandable for all stakeholders |
| **Implementation Docs** | HTML (Rich Text) | Technical implementation steps – for the developer |

**Acceptance Criteria** are maintained separately in **Scrum Tasks** – they do NOT belong in the story fields.

#### Short Description

```
[Concise title: WHAT is being implemented]
```

#### Description

```
Als [Rolle]
möchte ich [Ziel]
damit [Nutzen].

[Kontextabsatz: Hintergrund und wer betroffen ist – 2 bis 4 Sätze]

### Open Questions

1. [Question]
2. [Question]
```

- Open Questions block only when needed; remove resolved questions; delete block when all resolved
- No TBD placeholders anywhere – if a value is unknown, capture it as an Open Question and reference it inline as `(→ Open Question #N)`. This applies to every field, value, or decision in the story.

#### Implementation Docs

Structure: `**Block Title**` (bold) + `-` bullet points with `  - Key: Value` sub-points (max. 2 levels). Minimal prose; short explanatory sentences only where necessary. NO markdown tables.

Required sections: `### Scope`, `### Changes`
Optional sections: `### Migration`, `### Dependencies`, `### Open Questions`
Separate each section with `---`.

```
### Scope

- Application Scope: x_[scope_name] ([Scope Label])
- Table: x_[scope_name]_[table_name]

---

### Changes

#### [Block Title]

- Main point
  - Label: English Label / German Label
  - Field name: field_name
  - Type: [Type]

---

### Migration

#### Migrate `table_name.old_field` → `new_field`

- Basis: Background Script
- Default: `default_value`
- `old_field` = `value` → `new_value`

---

### Dependencies

- STRY0000000: [Short description of dependency]

---

### Open Questions

1. [Question]
```

---

### New Table

**Implementation Docs blocks:**

```
#### Create Table

- Name: x_[scope]_[table_name]
- Label: English Label / German Label
- Extends: [task / sys_metadata / none]

#### Form Layout

- Section: Default
  - [field_name] ([Type])
  - [field_name] ([Type])

#### Create Application Menu (if needed)

- Name: [Menu Name]
- Role: [access_role]

#### Create Module

- Name: [Module Name]
- Table: x_[scope]_[table_name]
- Role: [access_role]

#### ACL – x_[scope]_[table_name]

- read: [role]
- write: [role]
- delete: [role]
```

---

### Acceptance Criteria

```
AC-[N]: [Title]
Details: [Description of the desired state]
```

---

### Test Cases

```
TC-[N]: [Title]
Precondition: [Starting situation]
Steps: [What is executed?]
Expected result: [What must happen?]
```

---

## Output Format

After completing Level 1, always output the following copy-paste block:

```
SHORT DESCRIPTION
─────────────────
[Title]

DESCRIPTION (HTML field)
─────────────────
[Prose text]

ACCEPTANCE CRITERIA
─────────────────
[AC list]

TEST CASES
─────────────────
[TC list]
```

Then ask: **"Should I also work out the Technical Design (Implementation Docs)?"**

After completing Level 2, append:

```
IMPLEMENTATION DOCS (HTML field)
─────────────────
[Technical list]
```
