---
description: Language profiles and prose style rules for implementation documentation. Default profile is Swiss German (de).
---

# Prose Style Guide

This file defines language profiles for implementation documentation. The active
profile is selected by the `language` key in the project config. New profiles can
be added as H2 sections without renaming this file.

---

## Universal Rules (all profiles)

These rules apply regardless of language.

**1. Technical identifiers are always English, always in inline code.**

Table names, field names, script names, scope names, property names, and role names are rendered in inline code format:

- `` `cmdb_ci_business_app` ``, `` `u_mycustomfield` ``, `` `BiHaIncidentAjax` ``

Never translate or paraphrase a technical name. Never write it as plain text.

**2. No filler phrases.**

Do not write:
- "Im Folgenden wird erläutert, wie..." / "In the following section, we describe..."
- Rule-of-three padding
- "Es ist wichtig zu beachten, dass..." / "It is important to note that..."
- Closing summaries that restate the section ("Zusammenfassend lässt sich sagen...")
- Transition phrases with no content ("Das gesagte vorausgesetzt...", "Building on the above...")

**3. Active voice.**

"Das System sendet eine E-Mail" — not "Eine E-Mail wird vom System gesendet."
"The system validates the request" — not "The request is validated by the system."

**4. One idea per sentence. Maximum ~25 words.**

Long sentences almost always contain hidden ambiguity. Split them.

**5. Prose for connected thoughts; bullets for genuinely list-shaped data.**

If three items have a narrative connection, write them as a paragraph. Use bulleted lists only when the items are parallel and independently meaningful.

**6. Headings as noun phrases, not full sentences.**

- Good: "Architekturübersicht", "Authentication Flow", "Fehlerbehandlung"
- Avoid: "Wie die Architektur aufgebaut ist", "How Authentication Works"

**7. Present tense for system behaviour.**

"Das System prüft den Wert" — not "Das System hat den Wert geprüft."
Use past tense only for one-time events or historical migrations.

---

## Profile: Swiss German (de)

Active when `language: "de"` in the project config.

### Spelling

- Correct umlauts: `ä`, `ö`, `ü`. Never `ae`, `oe`, `ue`.
- Always `ss`. Never `ß`. (Swiss convention)
- Standard German compound nouns: "Architekturentscheidung",
  "Prozessübersicht", "Einschränkung".

### Headings

Use German noun phrases:
- "Übersicht" (not "Überblick schaffen")
- "Einschränkungen und Grenzen" (not "Was nicht unterstützt wird")
- "Technische Implementierung" (not "Wie es technisch umgesetzt wurde")

### Worked example

**Bad — AI-style, passive, filler:**

> Im Folgenden wird beschrieben, wie die Implementierung des Update Sets
> `BiHa - STRY0012345 - V01 - Demo` aufgebaut ist. Es ist wichtig zu beachten,
> dass die Lösung in drei Schritte unterteilt wurde. Zunächst wird der Datensatz
> geprüft, danach wird er verarbeitet und schliesslich wird das Ergebnis
> zurückgegeben.

**Good — active, concise, no filler:**

> Die Lösung liest eingehende Anfragen über die REST-Ressource
> `x_bits2_api/getServices`, prüft die Berechtigung anhand der Rolle
> `x_bits2_consumer` und persistiert das Ergebnis in `x_bits2_request`.

---

## Profile: English (en)

Active when `language: "en"` in the project config.

### Headings

Use English noun phrases:
- "Overview", "Technical Implementation", "Architecture Overview"
- "Constraints and Decisions" (not "What Is Not Supported")

### Worked example

**Bad — AI-style, passive, filler:**

> In the following section, we will describe how the implementation is structured.
> It is important to note that the solution was divided into three steps. First,
> the record is validated, then it is processed, and finally the result is returned.

**Good — active, concise, no filler:**

> The solution reads incoming requests from the `x_bits2_api/getServices` REST
> resource, validates the caller's `x_bits2_consumer` role, and stores the result
> in `x_bits2_request`.
