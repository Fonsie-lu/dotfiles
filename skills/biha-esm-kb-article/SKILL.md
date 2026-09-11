---
name: biha-esm-kb-article
version: 5.0.0
description: |
  Erstellt und aktualisiert BitHawk KB-Artikel für ServiceNow.
  Nimmt ein Thema, einen Inhalt oder Rohentwurf entgegen und liefert einen
  fertigen scoped HTML-Block im BitHawk ESM Design — bereit zum Einfügen
  in den ServiceNow KB Body-Editor.
  Verwende diesen Skill wenn jemand sagt: "KB Artikel", "Knowledge Base",
  "KB erstellen", "KB schreiben", "KB überarbeiten", "KB aktualisieren",
  "ServiceNow Artikel", "Wissensdatenbank", "KB template".
allowed-tools:
  - Read
  - Write
  - Edit
---

# BitHawk ESM – KB Artikel

**Owner:** Luiz Lehmann, Stephan Kreilos | **Review:** quarterly | **As of:** 2026-Q2 | **Version:** 5.0

Du nimmst ein Thema oder einen Inhalt entgegen und lieferst direkt einen fertigen KB-Artikel als scoped HTML-Block für ServiceNow. Kein `<!DOCTYPE>`, kein `<html>`, kein `<body>`.

Frage nicht nach — ausser die Kontaktperson fehlt vollständig (dann einmalig kurz fragen). Kategorie, Team und Stand kannst du sinnvoll ableiten oder als Platzhalter setzen.

---

## Schritt 1 — Assets laden

Lies beide Dateien bevor du schreibst:

```
Read: assets/kb-style.html      → der vollständige <style>-Block
Read: assets/kb-components.md   → Komponentenbibliothek und Inhaltsregeln
```

Pfade relativ zum Skill-Verzeichnis (Base directory, wie oben angegeben).

---

## Schritt 2 — Inhalt verstehen

Beantworte intern bevor du schreibst:

- Was soll der Leser danach tun, wissen oder entscheiden können?
- Was ist die wichtigste Information — sie kommt zuerst.
- Wo scheitern Menschen bei diesem Thema? → Warnung oder FAQ-Eintrag.

---

## Schritt 3 — Artikel aufbauen

Struktur:

```
[Style-Block aus kb-style.html]

<div class="bh-kb">
  [Banner — optional, über Header]
  [Header — immer]
  [Applies-to — optional, nach Header]
  [TOC — optional, bei 4+ Cards]
  [Cards mit Inhalt]
  [Try-it — optional, bei Tooling]
  [Kontakt — immer]
</div>
```

Komponenten aus `kb-components.md` wählen — nur was der Inhalt braucht.

---

## Schritt 4 — Ausgabe

Vollständigen HTML-Block ausgeben: Style-Block + `<div class="bh-kb">` … `</div>`.
Kein erklärender Text davor oder danach.
