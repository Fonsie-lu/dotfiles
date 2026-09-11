# Logging, Business Rules, Error Handling

---

## Logging

### Server-side

- **Scoped:** `gs.debug() / gs.info() / gs.warn() / gs.error()` — control
  via `<scope>.logging.verbosity` System Property. Read at `sys_log_appscope`.
- **Global:** `GSLog` if you need property-driven log levels; otherwise
  `gs.*`.
- **`BiHaLog`:** when you need ordered multi-line entries collected into
  one record. Note: collected messages are lost if an exception occurs
  before the log is flushed.
- **Service Portal server scripts:** `$sp.log()` — output goes to the
  browser console.
- **Placeholders:** `gs.info('Incident {0}: {1}', number, shortDesc);`
- **Objects:** `JSON.stringify(obj, null, 2)`.

### Client-side

- `console.log/.warn/.error` — multiple args, expandable objects in dev
  tools. Don't `JSON.stringify` first.
- `jslog()` is **not** supported in Service Portal.
- The `debugger;` keyword halts execution in browser dev tools.

---

## Business Rules

- Know the BR phases (before / after / async / display) and pick the
  right one — wrong phase = wrong data state.
- **Never call `current.update()`** in a BR — it triggers the same
  table's BRs again and recurses.
- Wrap each BR in a self-executing function to avoid leaking globals:
  ```javascript
  (function executeRule(current, previous) {
      // ...
  })(current, previous);
  ```

---

## Error Handling

**Throw low, catch high.**

- **Lower layers** (Script Include helpers, data access methods): do not
  catch — let exceptions propagate. Only use early-return guard clauses
  for expected null/empty states, not for exception suppression.
- **Higher layers** (Ajax endpoints, Business Rule entry points, UI
  controllers): catch, decide what to do — log, return a Result Object,
  show a user-friendly message. See the Ajax pattern in
  `references/script-patterns.md` for a concrete example.
- Wrap fragile operations like `JSON.parse()` in `try/catch` at the
  boundary layer, not inside helpers.
- Return a Result Object (`status` / `message` / `data`) instead of
  raw nulls when callers need to know what failed.
