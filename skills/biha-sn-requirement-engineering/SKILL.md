---
name: biha-sn-requirement-engineering
version: 2.1.0
description: >
  BitHawk standard for writing, reviewing, and refining ServiceNow stories,
  acceptance criteria, test cases, and implementation docs. Covers two levels:
  Requirement Engineering and Technical Design. Trigger whenever someone wants
  to capture, formulate, document, or structure a requirement, feature, or change
  for a ServiceNow implementation – even if they don't use the word "story".
  Also trigger for: STRY, PROV, AC, ticket, backlog, refinement, Anforderung.
---

# Requirement Engineering & Technical Design – BitHawk ESM

**Owner:** Stephan Kreilos, Luiz Lehmann | **Review:** quarterly | **As of:** 2026-Q2 | **Version:** 2.1

---

## Overview

This skill covers two sequential levels:

**Level 1 – Requirement Engineering (RE)**
What is needed, for whom, why, and under what conditions it is considered fulfilled.
Output: Story (Short Description + Description) + Acceptance Criteria + Test Cases.

**Level 2 – Technical Design (TD)**
How the requirement is implemented in ServiceNow.
Output: Implementation Docs (Scope, Changes, Migration).

After completing Level 1, Claude always asks: **"Should I also work out the Technical Design (Implementation Docs)?"**
Level 2 is never started automatically.

---

## Level 1 – Requirement Engineering

### Story Creation

Work with the content provided. Assume the initial input covers most of the points below. Only ask upfront if critical information (role, goal, benefit) is completely missing. For everything else, capture gaps as Open Questions in the story and continue.

**File storage:**
- Save stories under `$BIHA_STORIES_PATH/STRY0000000_Short-Title.md` if set, otherwise `./Stories/STRY0000000_Short-Title.md` relative to the current project folder
- Create the `Stories/` directory if it does not exist
- If the resolved path does not exist and cannot be created, inform the user and offer to set up the env var: add `"BIHA_STORIES_PATH": "/absolute/path"` to the `"env"` block in `~/.claude/settings.local.json`, then restart the Claude Code session

**Story number:**
- Format: `STRY0000000` (7 digits)
- If not yet available: suggest provisional number `PROV0000001` (increment per session)
- Ask for the story number upfront; if the story does not exist yet, propose a provisional number and confirm with the user

**Use case:**
1. Who is the user or role affected?
2. What do they want to achieve?
3. What is the business value or benefit?
4. What triggered this requirement – what changed or what problem exists?

**Scope:**
5. What is explicitly in scope?
6. What is out of scope?
7. Are there related stories or dependencies?

**Technical:**
8. Which application scope / customer instance?
9. Are there known constraints (permissions, performance, existing data)?

Only block if role, goal, or benefit (questions 1–3) cannot be derived from the provided input at all.

Once the story is written, always generate Acceptance Criteria and Test Cases as part of the same flow – do not wait for a separate request.

---

### Story Review

When asked to review an existing story, check the following and report findings grouped by section:

**Description:**
- [ ] 🔴 Follows "Als / möchte ich / damit" format
- [ ] 🔴 Context paragraph present and understandable for all stakeholders
- [ ] 🟡 Swiss spelling (ä/ö/ü, ss instead of ß, no ae/oe/ue)
- [ ] 🟡 No AI-typical writing style
- [ ] 🟡 Open questions captured in block, not as TBD placeholders

**Acceptance Criteria:**
- [ ] 🔴 Every AC describes desired state, not implementation steps
- [ ] 🔴 Every AC is testable (yes/no)
- [ ] 🟡 Error scenarios and permission scenarios covered

**Test Cases:**
- [ ] 🔴 Every AC has at least one test case
- [ ] 🟡 Negative paths covered
- [ ] 🟡 ACs and Test Cases are consistent with the current story content (no outdated criteria after refinements)

**Implementation Docs (only if present):**
- [ ] 🔴 `### Scope` block present and complete
- [ ] 🔴 `### Changes` block structured correctly (bold block titles, bullet points, Key: Value)
- [ ] 🟡 No markdown tables
- [ ] 🟡 Migration section present if story includes data migration
- [ ] 🟡 Dependencies to other stories captured

---

### Story Refinement

When asked to refine or improve an existing story:

- Ask what specifically should be improved if not stated
- Preserve the structure and content intent – only improve clarity, language, or completeness
- Flag any structural changes that go beyond the request before applying them
- Apply Swiss spelling and writing style corrections silently without flagging each one
- After applying changes: always ask "Sollen Acceptance Criteria und Test Cases nachgeführt werden?"

---

## Standards

### Language and Writing Style

All content is written in German. Technical names (fields, flows, scripts, tables) are excluded – these remain in English.

- Swiss spelling: correct umlauts (ä, ö, ü), ss instead of ß, never ae/oe/ue
- No AI-typical writing style: no inflated phrasing, no rule-of-three, no marketing language
- No bullet overload: connected thoughts belong in prose, not bullets
- Active voice over passive constructions

Users with the `/humanizer` skill installed can use it for a full writing style pass on the Description.

### Field Standards

Apply to all blocks in Implementation Docs:

- Label: `English Label / German Label`
- If the input does not provide an English label:
  - Derive the English label from the provided label (translate if unambiguous)
  - If translation is uncertain, use `[EN: TBD]` as placeholder
  - Collect all fields with missing English labels in the Open Questions block under Implementation Docs: "English labels missing for: field_a, field_b, ..."
- Field name: `snake_case` (no `u_` prefix in custom scopes; `u_` prefix in Global scope only)
- Type: `String` / `Integer` / `Boolean` / `Choice` / `Reference` / `HTML` / `Date` / etc.
- Choice values: text-based preferred over numeric

### Acceptance Criteria Standards

An acceptance criterion is well-written when:

- It describes the **desired state** – what must be true, not how it is achieved
- It is **testable** – the question "Met?" can be answered with yes or no
- It contains **no implementation details** (no "deploy", "migrate", "configure")
- Edge cases are covered: error cases, permissions, boundary values

Pre-approval checklist:

- [ ] Every AC is testable (yes/no answer possible)
- [ ] No AC contains deployment steps or technical implementation details
- [ ] Error scenarios are covered (invalid input, missing permissions)
- [ ] Permission scenarios considered (who can do what?)
- [ ] Performance requirements explicit, if relevant

### Test Case Standards

- 1 AC → at least 1 test case (positive path)
- Error scenarios as a separate negative path
- Permission scenarios: one test per relevant role
- Order: happy path first, then edge cases

### Resolving Open Questions

Before deleting a resolved question, document the resolution inline:
`~~1. [Question]~~ → Resolved: [Answer]`
Delete the block once all questions are resolved.

### ServiceNow Naming

- **Custom scopes** (e.g. `x_[scope]_*`): NO `u_` prefix for new fields
- **Global scope**: `u_` prefix for custom fields
- Labels: English is mandatory, German as an additional language entry
- Technical names (flow, script, table, field): ALWAYS English

### Warning Signals

🔴 **Clarify before implementation:**
- AC describes implementation steps instead of desired state
- Implementation Docs missing `### Scope` block
- Field type, scope, or table unclear

🟡 **Flag gaps:**
- No error scenario in the ACs
- Test cases missing for individual ACs
- Open points in Implementation Docs not captured as `### Open Questions`
- Dependencies to other stories not documented

---

## Level 2 – Technical Design

> Only worked out after explicit confirmation at the end of Level 1.

Read `references/technical-design.md` before writing Implementation Docs (covers Dependencies and New Table clarifications).

---

## Templates & Output Format

Read `references/templates.md` before writing any output block. It contains the field structure, Story/AC/TC templates, Implementation Docs structure, and the final copy-paste output format.
