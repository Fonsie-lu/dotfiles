---
name: biha-sn-coding
version: 1.1.0
description: >
  BitHawk + ServiceNow coding standards for writing server- and client-side
  ServiceNow JavaScript. Apply whenever writing, refactoring, or reviewing
  ServiceNow code: Script Includes, Business Rules, Client Scripts, Catalog
  Client Scripts, UI Actions, UI Policies, Scheduled Jobs, Fix Scripts, Flow
  scripts, Service Portal / ESC widgets, Transform Scripts, Inbound Email
  Actions, calculation scripts, ACL conditions, and REST/SOAP message scripts.
  Covers Rhino + ES12 compatibility, GlideRecord / GlideAggregate / GlideAjax
  patterns, naming and style conventions, scoped app rules, logging, error
  handling, and ES5 fallback guidance for instances where ES12 mode is off.
---

# BitHawk ServiceNow Coding Standards

**Owner:** Enea Krähenbühl, Marco Moro | **Review:** quarterly | **As of:** 2026-Q2 | **Version:** 1.1

The skill is deployed globally to `~/.claude/skills/` and applies to all ServiceNow projects. Customer-specific coding rule skills supersede this one when present.

---

## 1. Core Principles

- **Readability first.** Simple, boring code beats clever code. The next
  developer is not you.
- **Keep it small and modular.** Prefer many small, single-purpose Script
  Includes over one large `*Utils` class.
- **Use OOB whenever possible.** Customize OOB records in place, do **not**
  disable OOB and re-create with a `BiHa` prefix.
- **Don't repeat yourself.** Extract reusable helpers.
- **Find the root cause** instead of patching symptoms.
- **No DOM manipulation** outside UI Pages and Service Portal widgets, use
  the GlideForm API.
- **Never run/execute the generated code.** The user uploads and tests it
  on their instance. Do not run linters or formatters either.

---

## 2. Naming Conventions

- **English only** for technical/internal names. Translate UI later.
- **camelCase** for variables and functions; `snake_case` allowed in JSON
  attributes only.
- **UPPER_SNAKE_CASE** for constants: `MY_CONSTANT_VALUE`.
- **Booleans:** prefix with `is` / `has` / `can` (e.g. `isVip`, `hasKey`).
- **GlideRecord:** prefix `gr`, e.g. `grIncident`, `grSysUser`. Never use bare
  `gr`. Avoid cryptic names (`grEASF` ✘ → `grEccAgentFile` ✔).
- **GlideAggregate (server-side):** prefix `ga`, e.g. `gaIncidentCount`.
- **GlideAjax (client-side):** prefix `ga`, e.g. `ga.getXMLAnswer(...)`. Client
  context only; does not conflict with server-side GlideAggregate.
- **sys_id variables:** suffix with `SysId` (`catalogItemSysId`). Never
  call them `id`.
- **Arrays:** plural, e.g. `users`, `sysIds`.
- **Private methods:** `_underscorePrefix`.
- **Type hints (Hungarian)** only when type conversion is the point:
  `var strAge = "42"; var intAge = parseInt(strAge);`. Otherwise omit.
- **Single-letter names** only for tight `i` index loops.

### Record / artifact naming

- **Tables:** singular technical name (no trailing "s").
- **Column labels:** Sentence case ("Test label" ✔, "Test Label" ✘).
- **Business Rules / UI Policies / Client Scripts:** `BiHa <verb> <noun> <on/if/from/to> ...`
  → `BiHa Hide fields if user is missing role`.
- **Script Includes:** `BiHa<Module><Suffix>` → `BiHaIncidentAjax`.
- **Scoped apps:** customer prefix instead of `BiHa`. Keep customer name
  out of the technical scope name (it's permanent): scope
  `x_mycag_superapp`, app name "MyCompany Super App".
- **Update Sets:** `BiHa - <TaskNumber> - V01 - <Description>`.
- **Messages / Events / System Properties:** dot-separated keywords,
  e.g. `biha.welcome.message`.

---

## 3. Style Rules

- Single quotes `'…'`, not double.
- Always use curly braces after `if`, `else`, `while`, `for`, even for one-liners.
- Dot notation for property access (`inputs.state`, not `inputs['state']`).
- Empty line before `// comment`, space after `//`.
- Blank line after `}` blocks.
- Type-coerce at the start of a function, not mid-flow.
- Prefer **explicit** over implicit:
  `gs.info(array.join(','))` not `gs.info(array)`;
  implicit coercion via `.toString()` is forbidden, use
  `getValue()` / `getDisplayValue()` instead.

---

## 4. Reference Dispatcher

Load the relevant reference file before writing or reviewing code in that area.

| Task context | Reference |
|---|---|
| ES/Rhino version, `const`/`let`, ES5 fallback, unsupported features | `references/es-compatibility.md` |
| GlideRecord queries, `getValue`, null checks, dot-walking | `references/gliderecord-patterns.md` |
| Script Include, `Class.create`, GlideAjax, Client Scripts | `references/script-patterns.md` |
| Scoped apps, REST/SOAP, System Properties, Connection aliases | `references/platform-apis.md` |
| Logging, Business Rules, Error Handling | `references/logging-error-br.md` |
| Service Portal / ESC widgets, `$sp`, `spUtil` | `references/service-portal.md` |

---

## 5. Common Pitfalls

- ✘ `var id = current.caller_id.sys_id` → returns an object.
  ✔ `var id = current.getValue('caller_id')`.
- ✘ Hardcoded URLs / sys_ids / user names. ✔ System Properties / groups.
- ✘ `eval(...)`: eval is evil.
- ✘ Synchronous-looking code that depends on async patterns: there is no event loop.
- ✘ Disabling and copying OOB records. ✔ Customize in place so upgrades
  surface conflicts.
- ✘ Bare `gr` as a variable name (collides globally).
- ✘ Putting all Service Catalog logic into one `BiHaCatalogUtils`,
  break it into focused Script Includes.

---

## 6. Quick Checklist Before Handing Code Over

- [ ] Names follow BiHa + camelCase + `gr/ga/is/has/can` conventions
- [ ] All field reads use `getValue()` / `getDisplayValue()`
- [ ] All sys_ids come from `getUniqueValue()`
- [ ] Guard clauses, no deep nesting
- [ ] `setLimit()` set on every query
- [ ] No hardcoded URLs, sys_ids, credentials
- [ ] Logging uses scope-appropriate API with placeholders
- [ ] Ajax Script Include has a corresponding ACL noted for the user
- [ ] Code uses ES12 features only if target instance has ES12 mode on
      (otherwise rewrite per ES5 fallback table in `references/es-compatibility.md`)
