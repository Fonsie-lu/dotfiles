# ECMAScript Compatibility (Rhino + ES12)

ServiceNow runs server-side scripts in **Mozilla Rhino 1.7.14** (Xanadu+).
An optional **ES12 transpiler** (Babel-like) is available per script.
Scoped apps default to ES12 mode; global scope defaults to ES5. ES12 mode
can be enabled per-script in global scope since Xanadu.

> The ES12 toggle lives in `sys_es_latest_script` and does **not** export
> in XML update sets — it always imports as `false`. Verify ES12 mode is
> on after deployment.

---

## NEVER use — unsupported in any mode

`async` / `await`, `Promise`, ES `import` / `export`, `Proxy`, `Atomics`,
`SharedArrayBuffer`, typed arrays (`Int8Array`, `Uint8Array`, …),
`WeakRef` / `FinalizationRegistry`, generators (`function*` / `yield`),
`WeakMap` / `WeakSet`, `Packages.*` / `java.*`.

ServiceNow is **synchronous**. Use callbacks or direct return values.

---

## Always safe (no ES12 mode required)

- Arrow functions, method shorthand, template literals
- Optional chaining `?.`, nullish coalescing `??`
- `Array.from/of/isArray`, `.find/.findIndex/.includes/.fill`
- `Object.assign/is`
- `String.includes/startsWith/endsWith/repeat/padStart/padEnd`
- `Number.is*`, `Number.parse*`, full `Math.*` extensions

---

## ES12-mode features (verify mode is on)

`const`/`let`, destructuring, default params, rest/spread (`...args`,
`[...arr]`, `{ ...obj }`), `class` / `extends` / `super`, `Map` / `Set`,
`Symbol`, `for...of`, exponentiation `**`, logical assignment `&&=` /
`||=` / `??=`, `Array.flat/flatMap`, `Object.fromEntries`,
`String.replaceAll`, regex lookbehinds.

> **Note**: Does not work in background scripts.
---

## Class-level declarations

Use `var` at the top level (e.g. `var MyClass = Class.create()`). Use
`const` / `let` inside method bodies. Do **not** use `const` for a loop
counter that gets reassigned — Rhino throws.

---

## ES5 Fallback (when user reports "it doesn't work")

If code fails on the target instance, ES12 mode is likely off. Ask the
user, then rewrite in ES5.

Note: **arrow function syntax alone** is natively supported in Rhino 1.7.14
(Xanadu+) and does not need a fallback. The entry below covers **rest
parameter syntax** (`...args`), which is an ES12 feature.

| ES12 / Modern               | ES5 fallback                              |
| --------------------------- | ----------------------------------------- |
| `const` / `let`             | `var`                                     |
| `class Foo { ... }`         | `Class.create()` + `.prototype = { ... }` |
| `({a, b} = obj)`            | `var a = obj.a; var b = obj.b;`           |
| `function(...args) { ... }` | `function() { var args = arguments; }`    |
| `for (const x of arr)`      | classic `for` loop or `arr.forEach(...)`  |
| `{ ...obj }`                | `Object.assign({}, obj)`                  |
| `` `hello ${name}` ``       | `'hello ' + name`                         |
| `Array.flat()`              | manual concat / loop                      |
| `Object.fromEntries(...)`   | manual loop building object               |

`?.` and `??` stay safe — keep them.
