# GlideRecord Patterns

> Examples use `let`/`const`, which requires **ES12 mode**. For ES5 targets,
> replace with `var` (see `references/es-compatibility.md`).

```javascript
let grService = new GlideRecord('cmdb_ci_service');
if (grService.get(sysId)) {
    let className = grService.getValue('sys_class_name');
    grService.setValue('u_bcm_class', '2');
    grService.work_notes = 'Updated automatically.'; // journal field exception
    grService.update();
}
```

- **Read fields with `getValue('field')`** — never `grRecord.field` (type
  varies) and never the legacy `grRecord.field + ''` or `.toString()`.
- **Display values:** `grRecord.field.getDisplayValue()`.
- **Boolean fields** return `'0'` / `'1'` strings — compare explicitly:
  `grUser.getValue('vip') === '1'`.
- **Journal fields** (`work_notes`, `comments`) — `setValue` does **not**
  work. Use `grIncident.work_notes = 'foo'` or
  `grIncident.work_notes.setJournalEntry('bar')`. Read with
  `grIncident.work_notes.getJournalEntry(1)`.
- **Catalog variables:** `grRITM.variables.my_var.getValue()`,
  `grRITM.variables.my_var = 'foo'` to set.
- **sys_id:** always `grRecord.getUniqueValue()`, not `.sys_id`,
  `.sys_id.toString()`, or `getValue('sys_id')`.
- **Reference traversal:** `grChild.cmdb_ci.getRefRecord()` — then check
  `isValidRecord()` before use. Avoid dot-walking to `.sys_id` of a
  reference: use `current.getValue('caller_id')`.
- **Querying:** prefer `addQuery()` over `addEncodedQuery()` for
  readability. `addEncodedQuery()` is fine for relative dates and complex
  OR/AND chains.
- **Single record:** `grRecord.get('field', value)` — always wrap in `if`.
- **`setLimit(x)`** to bound performance. For existence checks, use
  `setLimit(1)` + `hasNext()` (no record load).
- **`GlideAggregate`** Always prefer for counting (don't iterate to count) rather `GlideRecord`.
- **`GlideRecordSecure` vs `GlideRecord`:** GlideRecord skips ACLs. Use
  `GlideRecordSecure` for any code that queries tables dynamically or on
  behalf of a user.

---

## Null / empty checks

```javascript
if (gs.nil(grRecord)) { return; }                       // GlideRecord / refs
if (!gs.nil(grCI.getValue('u_mycustomfield'))) { ... }  // field value
if (!currentKey) { return; }                            // plain string
```

`if (variable)` is fine for strings/numbers but unreliable for arrays /
objects in global scope. Use `gs.nil()` when in doubt.

---

## Guard clauses

Return early; do **not** nest deeply.

```javascript
function save(user) {
    if (!user) { return; }
    if (user.isBanned) { return; }
    if (!user.email.includes('@')) { return; }
    database.save(user);
}
```
