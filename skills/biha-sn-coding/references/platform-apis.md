# Platform APIs

---

## Scoped App Rules

- **No `gs.now()` / `gs.nowDateTime()`** in scoped apps. Use
  `new GlideDateTime()` plus `getDayOfMonthLocalTime()`,
  `getMonthLocalTime()`, `getYearLocalTime()`.
- Use **ES12 mode features** — scoped apps enable ES12 mode by default.
- Build a `<scope>.logging.verbosity` System Property to control log
  level; drive `gs.debug/info/warn/error` calls from it.
- Logs go to `sys_log_appscope` (not `syslog`).
- Add menu entries: Properties (with category filter) and the
  `sys_log_appscope` view.

---

## Outbound REST

Never hardcode URLs or credentials — use Connection & Credential aliases.

`sn_cc` and `sn_ws` are **scoped app namespaces**. In global scope, use
`RESTMessageV2` directly (without the `sn_ws.` prefix) and use the global
`ConnectionInfoProvider` or pass credentials via the REST Message record.

```javascript
const provider = new sn_cc.ConnectionInfoProvider();
const connInfo = provider.getConnectionInfo('my_credential', 'my_connection');
const restMessage = new sn_ws.RESTMessageV2();
restMessage.setEndpoint(connInfo.getAttribute('url') + '/api/endpoint');
restMessage.setHttpMethod('GET');
restMessage.setBasicAuth(
    connInfo.getAttribute('username'),
    connInfo.getAttribute('password')
);
if (debugMode) { restMessage.setLogLevel('all'); }
const response = restMessage.execute();
```

---

## System Properties

```javascript
const batchSize = gs.getProperty('x_myapp.import.batch_size', '100'); // ✔ default
gs.getProperty('x_myapp.import.batch_size');                          // ✘ no default
```

- **Always supply a default value.**
- **Don't store dynamically changing data** in System Properties — every
  change flushes the instance cache (unless "Ignore cache" is set).
- Big JSON config? Split across multiple properties; do not stuff
  everything into one.
- Hardcoded values, sys_ids, user IDs → System Properties or Groups.
- For justified hardcoded sys_ids, suppress with a comment:
  `// eslint-disable-next-line servicenow/no-hardcoded-sysids`.
