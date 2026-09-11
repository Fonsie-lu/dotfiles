---
name: sn-refactor
description: Refactor a ServiceNow script (Script Include, Business Rule, Script Action, Scheduled Job, Fix Script, client script, UI Action) to be shorter, simpler, and more readable — modern ES12 syntax, config objects only to collapse if/switch chains, large objects built by a function at the bottom of the file, table/field names inline, JSDoc on top-level functions, getValue()/setValue() on GlideRecord, and a toggleable Logger on large scripts. Use when the user asks to refactor, clean up, modernize, optimize, or tidy a ServiceNow script.
---

# ServiceNow Script Refactoring

Refactor ServiceNow server-side and client-side scripts to a consistent, readable house style. Preserve behavior exactly — this is a refactor, not a rewrite.

**Guiding principle: readable, concise, simple.** Every change must make the script shorter or easier to follow. Abstraction is a cost — a constant, wrapper, or config object has to earn its place by removing branching or duplication. When a rule below and this principle disagree, the principle wins: prefer the plainer code and say why you left the pattern alone.

## Scope

**Refactor exactly one file: the one currently selected/open in the VS Code editor.** That single file is the entire edit scope — never modify, create, or rename any other file, even when the refactor makes a change elsewhere look obviously desirable. Other files may be *read* for context (callers, Script Includes being invoked, shared constants), but if something outside the target file needs to change, report it to the user instead of doing it.

### Resolving the target file — do this before anything else

The user's prompt usually does **not** name the file. The VS Code extension reports the editor state separately in the context, as `<ide_selection>` (highlighted code, with its file path in the header) or `<ide_opened_file>` (the file the user just opened). Resolve the target in this order:

1. A file path written in the prompt itself (`/sn-refactor path/to/file.js`) — always wins.
2. The **most recent** `<ide_selection>` block in the context.
3. The **most recent** `<ide_opened_file>` notice.

Non-obvious rules that decide the right answer:

- **Only the newest editor notice counts.** `<ide_selection>` and `<ide_opened_file>` blocks from earlier turns are stale — the user has since moved to another file. Scan for the last one in the context, not the first one you happen to see.
- **Conversation history is not editor state.** A file discussed, written or refactored earlier in this session is *not* the target unless the newest editor notice still points at it. This is the most common failure: re-refactoring the previous file while the user is looking at a new one.
- **A selection of lines still means the whole file.** The line range narrows nothing — see Workflow step 1.
- **Announce the target before the first edit:** open the reply with one line, `Refactoring <full path>`, so a mis-resolution is caught before anything is written.
- **No editor notice and no path in the prompt → stop and ask** which file to refactor. Never guess, and never fall back to the last file touched in this session.

## Workflow

1. **Read the whole selected file first.** Never refactor from a fragment. If the user selected lines within the file, still read the full file to understand callers, `initialize`/`prototype` structure, and shared state — then refactor the whole file, not just the selected lines.
2. **Refactor** applying every rule in "Rules" below.
3. **Verify** nothing changed semantically: same public methods -> do not change function name & arguments & return type of top level functions. Call out any behavior change you could not avoid.
4. **Report** briefly: what changed, anything suspicious you found but deliberately left alone (latent bugs, dead code), and any change that would be needed in *another* file — named but not made — so the user can decide.

## Rules

### Syntax and structure

- Modern **ES12**: `const` by default, `let` where reassigned, **never `var`**. Also use spread, destructuring, `Object.entries`/`values`, `??`, `Array.prototype.includes`
- Declare functions as **`function name() {}` declarations**, never `const name = () => {}`. Anonymous inline `function () {}` is acceptable only where a callback is genuinely unavoidable.
- Order the file **by execution**: constants/config objects → entry-point call (if any) → function declarations in the order they are called → config-building functions last. Hoisting makes this valid and it reads top-down.
- Keep it **concise**. Prefer early returns over nested `if`. Delete dead code, redundant temp variables, and comments that only restate the code.
- **Minimize the use of comments in the code.** Let names and structure carry the meaning; keep an inline comment only where it explains a non-obvious _why_ (platform quirk, business rule, workaround). This does not apply to the JSDoc blocks required below.

### Config objects to replace branching

A config object exists for **one** reason: to collapse an `if`/`else if` chain or a `switch` that maps a value to a value or behavior. That is the trigger. No other motive justifies one.

- Replace such a chain with a frozen lookup object, or a `Map` when keys are non-strings or insertion order matters. Declare it at the top as a named constant and look up with a fallback (`CONFIG[key] ?? CONFIG.DEFAULT`).
- Keep real conditional _logic_ as `if`. Only dispatch/mapping becomes a table. Two branches that already read clearly stay `if`/`else` — a two-entry lookup object is longer than the code it replaced.
- **Do not** introduce a config object to group unrelated values, to "centralize settings", or as a namespace. That is overhead, not structure.

```javascript
// Before — dispatch chain
function getRouting(category) {
  if (category === "network") return { group: "Network Support", priority: "2" };
  else if (category === "hardware") return { group: "Field Services", priority: "3" };
  else if (category === "software") return { group: "Application Support", priority: "3" };
  else return { group: "Service Desk", priority: "4" };
}

// After — lookup table
const CATEGORY_ROUTING = Object.freeze({
  network: { group: "Network Support", priority: "2" },
  hardware: { group: "Field Services", priority: "3" },
  software: { group: "Application Support", priority: "3" },
  DEFAULT: { group: "Service Desk", priority: "4" },
});

function routeIncident(gr) {
  const routing = CATEGORY_ROUTING[gr.getValue("category")] ?? CATEGORY_ROUTING.DEFAULT;
  gr.setValue("assignment_group", routing.group);
  gr.setValue("priority", routing.priority);
}
```

### Large objects come from a function

An object literal with **more than 5 attributes** does not sit inline in the middle of logic. Assign it from a function call, and put that function at the **bottom** of the file, after the working functions.

```javascript
function syncSupplierIncident(gr) {
  const payload = buildIncidentPayload(gr);
  postToSupplier(payload);
}

// ... other working functions ...

/**
 * Builds the supplier payload for an incident record.
 * @param {GlideRecord} gr - Incident record to serialize.
 * @returns {Object} Payload sent to the supplier endpoint.
 * @private
 */
function buildIncidentPayload(gr) {
  return {
    number: gr.getValue("number"),
    short_description: gr.getValue("short_description"),
    category: gr.getValue("category"),
    priority: gr.getValue("priority"),
    caller: gr.getDisplayValue("caller_id"),
    opened_at: gr.getValue("opened_at"),
    work_notes: gr.work_notes.getJournalEntry(1),
  };
}
```

This keeps the top of the file about what the script *does* and pushes bulk data assembly out of the reader's way.

### Table and field names stay inline

- Write table and field names **directly** as string literals: `new GlideRecord("incident")`, `gr.getValue("assignment_group")`. A `TABLE`/`FIELD` constants block adds a lookup hop for zero benefit and makes queries harder to read.
- Extract a literal into a named constant **only when it earns it**:
  - a **sys_id** — always (and mention that a system property or lookup would be more portable),
  - a **state/choice code** whose meaning is not obvious from context (`const STATE_RESOLVED = "6";`),
  - a **property name or endpoint** read in more than one place,
  - a value repeated **three or more times** where a typo would be silent.
- A field name used once, or twice in adjacent lines, stays a literal.
- Same test for numbers: extract a magic number when the name explains something the digits don't (`const RETRY_LIMIT = 3;`), not on principle.

### Avoid callbacks

- Prefer straight-line, synchronous code. Replace callback-passing helpers with functions that return a value the caller uses.
- Server-side: use `while (gr.next())` loops rather than callback-per-record helpers.
- Client-side: `getReference(field)` without a callback is synchronous and blocks — prefer `GlideAjax` with a Script Include, and if the platform forces asynchrony (`getXMLAnswer`, `g_form.getReference`), keep the callback as thin as possible and delegate to a named `function` declaration immediately.
- Array `map`/`filter`/`reduce` callbacks are fine — the rule targets control-flow callbacks, not functional array methods.

### GlideRecord access

- Read and write fields with **`getValue()` / `setValue()`**, not dot access, on GlideRecord.
- **Exception — journal fields:** `comments`, `work_notes`, `additional_comments`, and any other journal/journal_input field must use dot access (`gr.work_notes = …`, `gr.comments.getJournalEntry(1)`). `getValue()`/`setValue()` do not behave correctly on journal fields.
- `getDisplayValue()` stays as-is where a display value is intended. `getValue()` returns `null` for empty fields — handle with `??` rather than truthiness where an empty string matters.
- Write `addQuery` field names inline as literals, and prefer `gr.setLimit(1)` + `if (gr.next())` for single-record lookups.

### JSDoc

- Every **top-level** function gets a JSDoc block: one-line summary, `@param {Type} name` for each parameter, `@returns {Type}`. Add `@private` for internal helpers and `@throws` where it throws.
- For Script Includes, document each public prototype method the same way; `type: 'ClassName'` stays last in the prototype.
- Do **not** JSDoc trivial inline closures.

### Logger on large scripts

For scripts around **500+ lines** (or any script that already logs ad hoc), ensure a single Logger with an explicit on/off switch:

```javascript
const LOG_ENABLED = true;
const LOG_SOURCE = "BiHaSIAMSync";

/**
 * Writes a message to the system log when logging is enabled.
 * @param {string} message - Message to log.
 * @param {*} [detail] - Optional payload appended as JSON.
 * @returns {void}
 */
function logger(message, detail) {
  if (!LOG_ENABLED) return;
  const suffix = detail === undefined ? "" : ` | ${JSON.stringify(detail)}`;
  gs.info(`[${LOG_SOURCE}] ${message}${suffix}`);
}
```

- Route **all** existing `gs.log`/`gs.info`/`gs.print`/`jslog` calls through it.
- Client-side, the equivalent wraps `console.log`/`jslog` behind the same `LOG_ENABLED` flag.
- Add the log messages that are missing: entry/exit of each top-level function with key inputs, record counts, chosen config branch, every caught error (`gs.error` for those, always logged regardless of the flag), and skipped/no-op paths. Log identifiers and counts, never full record dumps or credentials.

## Anti-patterns to fix on sight

- `gs.nil()` chains where `??`/optional chaining is clearer (keep `gs.nil()` where GlideElement emptiness is what's meant).
- Queries built by string concatenation → chained `addQuery` calls.
- `new GlideRecord()` inside a loop → hoist or restructure the query.
- `getRowCount()` used just to test existence → `setLimit(1)` + `next()`.
- Repeated `gs.getProperty('x')` calls → read once into a constant.
- Hardcoded sys_ids → named constant, and mention to the user that a system property or lookup would be more portable.

## Over-abstraction to avoid

These make a script longer without making it clearer. Do not add them, and remove them when you find them:

- A `TABLE`/`FIELD` constants block wrapping names that were already readable.
- A config object holding unrelated values, or one with a single entry.
- A wrapper function called from exactly one place that adds no name-worthy meaning.
- A constant whose name just restates its value (`const INCIDENT = "incident";`).
- A `Map` where a plain object literal would do.

If a refactor step would add lines without removing a branch, a duplication, or a genuine ambiguity, skip it.
