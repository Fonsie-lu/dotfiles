# Script Include Pattern

> Examples use `const`/`let` inside methods, which requires **ES12 mode**.
> For ES5 targets, replace with `var`.

```javascript
var MyUtils = Class.create();

MyUtils.FIELD_NAME = 'u_my_field';
MyUtils.TABLES = { ALLOWED: ['cmdb_ci_service_technical'] };

MyUtils.fetchSomeIds = function () {
    const ids = [];
    const grRecord = new GlideRecord('some_table');
    grRecord.query();
    while (grRecord.next()) {
        ids.push(grRecord.getUniqueValue());
    }
    return ids;
};

MyUtils.prototype = {
    initialize: function (grRecord) {
        this.grRecord = grRecord;
    },

    publicMethod: function () {
        return this._privateMethod();
    },

    _privateMethod: function () {
        if (gs.nil(this.grRecord)) { return null; }
        return this.grRecord.getValue(MyUtils.FIELD_NAME);
    },

    type: 'MyUtils'
};
```

For pure-static utility classes, leave `initialize` empty.

---

## Ajax (Client-Callable) Script Include

Catch exceptions at this boundary layer — lower-level helpers let
exceptions propagate (see Error Handling in `references/logging-error-br.md`).

```javascript
var MyAjax = Class.create();
MyAjax.prototype = Object.extendsObject(AbstractAjaxProcessor, {

    sampleRequest: function () {
        try {
            var sysId = this.getParameter('sysparm_sys_id');
            var helper = new MyUtils(/* ... */);
            return JSON.stringify({ status: 'success', data: helper.publicMethod() });
        } catch (e) {
            gs.error('MyAjax.sampleRequest: ' + e.message);
            return JSON.stringify({ status: 'failed', message: e.message, data: [] });
        }
    },

    type: 'MyAjax'
});
```

- **Always create an ACL** for Client-Callable Script Includes — they are
  effectively API endpoints.
- **No business logic in the Ajax class.** Delegate to a non-client-callable
  Script Include (MVC pattern).

---

## Result Object Pattern

```javascript
const result = { status: 'failed', message: '', data: [] };
// ...
result.status = errorOccurred ? 'failed' : 'success';
return result;
```

Callers check `result.status === 'success'` before reading `result.data`.

---

## Client Scripts & GlideAjax

Server-data sources, in order of preference:

1. **`g_scratchpad`** — best performance; populated by a display Business
   Rule on form load.
2. **GlideAjax** — preferred for dynamic data.
3. **`g_form.getReference()` callback** — avoid (poor performance).

### GlideAjax call template

```javascript
var ga = new GlideAjax('MyToolAjax');
ga.addParam('sysparm_name', 'getToolData');
ga.addParam('sysparm_sys_id', g_form.getUniqueValue());
ga.getXMLAnswer(function (answer) {
    var result = JSON.parse(answer);
    g_form.setLabelOf('short_description', result.shortDescriptionLabel);
});
```

- Use `getXMLAnswer` (not `getXML`) — simpler, no XML traversal.
- Variable name **`ga`** for GlideAjax in Client Scripts (client-side
  context only; does not conflict with server-side GlideAggregate `ga` prefix).
- `g_form.setValue('field', sysId, displayValue)` — pass the third arg
  to avoid a synchronous Ajax call.
- **Avoid global Client Scripts** (table = "global") — they load on every
  page.
