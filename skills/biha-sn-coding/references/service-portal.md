# Service Portal Widgets

## Widget Anatomy

| Part | Runs on | Responsible for |
|---|---|---|
| **Server Script** | server | Loading/saving data, ACL-safe queries, building `data` |
| **Client Controller** (`api.controller`) | client (Angular) | User interaction, `$scope` bindings, calling server via `c.server` |
| **Link Function** | client, DOM-ready | Direct DOM access, only when Angular bindings truly cannot do it |

```javascript
// Client Controller
function () {
    var c = this;
    c.doSomething = function () {
        c.server.get({ action: 'refresh' }).then(function (response) {
            c.data = response.data;
        });
    };
}
```

- **Server:** fetch/prepare data, never leave it to the client.
- **Client:** react to clicks, form input, `$watch`; delegate anything
  data-related back to the server.
- **Link function:** last resort (e.g. third-party JS libs needing a raw
  DOM node). Violates the "no DOM manipulation" core principle otherwise,
  see `SKILL.md` Core Principles.

---

## Widget Embedding

- **HTML template:** `<widget id="widget-cool-clock"></widget>`,
  optionally `options='{"zone":"…"}'` or `options='data.clockOptions'`.
- **Server script:**
  `data.clockWidget = $sp.getWidget('widget-cool-clock', { zone: '…' });`
  → render with `<sp-widget widget="data.clockWidget"></sp-widget>`.
- **Client script:**
  ```javascript
  function (spUtil) {
      var c = this;
      spUtil.get('widget-cool-clock').then(function (response) {
          c.myWidget = response;
      });
  }
  ```
- **Multiple instances:** push `$sp.getWidget(...)` results into an array
  on the server, then `ng-repeat` over them.

---

## Server-Client Contract

`data` must only ever hold **serializable values** (strings, numbers,
booleans, plain objects/arrays). It is JSON-serialized to the client:
GlideRecord objects, GlideElement wrappers, or GlideDateTime objects do
not survive that trip.

```javascript
// ✘ leaks a GlideRecord (server-only object, useless on client)
data.grIncident = grIncident;

// ✔ extract plain values explicitly
data.incident = {
    sysId: grIncident.getUniqueValue(),
    number: grIncident.getValue('number'),
    shortDescription: grIncident.getValue('short_description'),
    state: grIncident.getDisplayValue('state')
};
```

- Use `getValue()` for raw values, `getDisplayValue()` for labels, never
  assign the GlideElement itself.
- `input` carries data **client to server** for round trips triggered from
  the controller:

```javascript
// Client Controller
c.server.update().then(function (response) {
    c.data = response.data;
});

// or an ad-hoc call with a payload
c.server.get({ action: 'approve', sysId: c.data.incident.sysId })
    .then(function (response) {
        c.data = response.data;
    });
```

```javascript
// Server Script
(function () {
    if (input && input.action === 'approve') {
        var grIncident = new GlideRecordSecure('incident');
        if (grIncident.get(input.sysId)) {
            grIncident.setValue('approval', 'approved');
            grIncident.update();
        }
    }
    data.incident = { /* ... rebuild from current state ... */ };
})();
```

---

## spUtil

- **`spUtil.recordWatch($scope, table, filter, callback)`**: subscribes
  to live GlideRecord change events; use for widgets that must reflect
  changes made elsewhere (e.g. another widget, a Flow) without polling.
- **`spUtil.update($scope)`**: re-runs the server script and refreshes
  `data`; use after an action that changed server-side state but was
  handled outside `c.server.update()`.
- **`spUtil.addErrorMessage(message)` / `spUtil.addInfoMessage(message)`**:
  standard portal-wide notifications; prefer these over custom alert
  markup.
- **`$rootScope.$broadcast('biha.widget.event', payload)`**: use sparingly,
  only for cross-widget signals that `recordWatch` cannot cover. Namespace
  events like System Properties: `biha.<area>.<event>`.

---

## Employee Center / ESC

- Widgets must remain **Employee Center compatible** unless explicitly
  built as Service Portal-only: check the widget's "Roles"/host
  configuration before adding portal-specific APIs.
- **No direct DOM manipulation** (same rule as UI Pages, see `SKILL.md`
  Core Principles): use Angular bindings; reserve the link function for
  cases Angular genuinely cannot handle.
- **Theming:** use CSS variables (`var(--now-color--primary)`,
  `var(--sp-…)`) instead of hardcoded hex colors, so widgets follow the
  active ESC/Portal theme automatically.

---

## Performance

- **One server round trip per user action.** Batch everything the action
  needs into a single `c.server.get()` / `c.server.update()` call instead
  of chaining several.
- **No GlideRecord queries in loops** inside the server script: resolve
  in bulk (e.g. `GlideRecord` with `addQuery('sys_idIN', ids)`) instead of
  querying per iteration.
- **`setLimit()` on every query**, same as any other server script (see
  `references/gliderecord-patterns.md`).
- **Keep `$watch` expressions cheap.** Do not run expensive computation or
  filtering directly in a `$watch` expression/function; compute once on
  the relevant event and cache the result in `$scope`/`c.data`.
