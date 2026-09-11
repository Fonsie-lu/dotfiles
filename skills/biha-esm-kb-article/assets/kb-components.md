# BitHawk KB — Komponentenbibliothek

Wähle nur was der Inhalt braucht. Weniger ist mehr.

---

## Pflicht

### Header
```html
<div class="bh-header">
  <div class="bh-header-accent"></div>
  <div>
    <div class="bh-header-meta">[Kategorie] &nbsp;&middot;&nbsp; [Team] &nbsp;&middot;&nbsp; Stand: YYYY-MM</div>
    <h1>[Titel]</h1>
    <div class="bh-header-sub">[Ein Satz: was der Leser hier bekommt]</div>
  </div>
</div>
```

### Kontakt — immer am Ende
```html
<div class="bh-contact">
  Fragen oder Probleme? Melde dich bei <strong>[Name]</strong>.
</div>
```

### Card — Wrapper für jeden Abschnitt
Titel handlungsorientiert: "So gehst du vor", "Das brauchst du" — nicht "Informationen".
```html
<div class="bh-card">
  <h2>[Abschnittstitel]</h2>
  <!-- Inhalt -->
</div>
```

---

## Nach Bedarf

### Schritte — wenn Reihenfolge eingehalten werden muss
```html
<div class="bh-steps">
  <div class="bh-step">
    <div class="bh-step-num">1</div>
    <div class="bh-step-body">
      <div class="bh-step-title">[Was tun]</div>
      <p>[Wie, wo, womit — konkret]</p>
    </div>
  </div>
</div>
```

### Tabelle — bei Vergleich, Übersicht oder Referenz
Standard (navy Header) / Update-Verlauf: `<table class="bh-update-table">`
```html
<table>
  <thead><tr><th>Spalte</th><th>Spalte</th></tr></thead>
  <tbody><tr><td>Wert</td><td>Wert</td></tr></tbody>
</table>
```

### Callouts — bei Ausnahmen, Fallen, Tipps
```html
<div class="bh-hint"><strong>Hinweis:</strong> Text</div>
<div class="bh-hint bh-tip"><strong>Tipp:</strong> Text</div>
<div class="bh-hint bh-warn"><strong>Achtung:</strong> Text</div>
<div class="bh-hint bh-danger"><strong>Stopp:</strong> Text</div>
<div class="bh-hint bh-success"><strong>Erledigt:</strong> Text</div>
```

### Nutzen-Karten — nur wenn Nutzen nicht selbstverständlich ist
Verwenden wenn der Leser sich fragt "Warum soll ich das tun?".
```html
<div class="bh-benefit-grid">
  <div class="bh-benefit-card">
    <div class="bh-benefit-title">[Was entfällt / besser wird]</div>
    <div class="bh-benefit-text">[Konkret, kein Marketingsprech]</div>
  </div>
  <div class="bh-benefit-card bh-accent">...</div>
</div>
```

### Option-Block — nur bei echter Entweder-Oder-Entscheidung
```html
<div class="bh-option-header">
  <span class="bh-tag">Option A</span> [Bezeichnung]
  <span class="bh-option-header-sub">([Kontext])</span>
</div>
<div class="bh-option-body"><!-- Schritte, Hinweise --></div>

<div class="bh-option-header">
  <span class="bh-tag bh-orange">Option B</span> [Bezeichnung]
</div>
<div class="bh-option-body"><!-- Schritte, Hinweise --></div>
```

### FAQ — wenn Folgefragen realistisch sind
Proaktiv einbauen: "Wie merke ich dass es funktioniert?" / "Was wenn es nicht klappt?"
```html
<div class="bh-faq-wrap">
  <div class="bh-faq-item">
    <div class="bh-faq-q">[Frage?]</div>
    <div class="bh-faq-a">[Antwort]</div>
  </div>
</div>
```

### Try-it — wenn direkte Aktion folgen soll (Tooling/Anleitungen)
```html
<div class="bh-try">
  <div class="bh-try-label">Jetzt ausprobieren</div>
  <div class="bh-try-title">[Aufforderung]</div>
  <div class="bh-try-prompt">&ldquo;[Konkreter Beispiel-Prompt]&rdquo;</div>
  <div class="bh-try-sub">[Was passiert]</div>
</div>
```

### Status-Banner — bei artikelweitem Status
Über dem Header platzieren. Varianten: `.bh-new` / `.bh-wip` / `.bh-deprecated`
```html
<div class="bh-banner bh-new">
  <div class="bh-banner-icon">i</div>
  <div class="bh-banner-body"><strong>Neu:</strong> Text</div>
</div>
```

### Applies-to — Voraussetzungen am Artikelanfang
Direkt nach Header. Nur wenn Plattform, Version oder Zielgruppe relevant.
```html
<div class="bh-applies">
  <div class="bh-applies-label">Gilt f&uuml;r</div>
  <div class="bh-applies-grid">
    <div><div class="bh-applies-key">Plattform</div><div class="bh-applies-val">ServiceNow Washington+</div></div>
    <div><div class="bh-applies-key">Zielgruppe</div><div class="bh-applies-val">IT-Administratoren</div></div>
  </div>
</div>
```

### Inhaltsverzeichnis — bei 4+ Cards
Direkt nach Header. Cards brauchen `id`-Attribute.
```html
<div class="bh-toc">
  <div class="bh-toc-label">Inhalt</div>
  <ul class="bh-toc-list">
    <li><a href="#abschnitt1">[Abschnittstitel]</a></li>
    <li><a href="#abschnitt2">[Abschnittstitel]</a></li>
  </ul>
</div>
```

### Changelog — Versionshistorie am Artikelende
```html
<div class="bh-changelog">
  <div class="bh-changelog-item">
    <div class="bh-changelog-head">
      <span class="bh-changelog-version">v2.0</span>
      <span class="bh-changelog-date">2026-05</span>
      <span class="bh-changelog-author">M. Muster</span>
    </div>
    <div class="bh-changelog-body"><ul><li>[Was ge&auml;ndert wurde]</li></ul></div>
  </div>
</div>
```

### Tags — Status-Labels inline
In `h2`, `bh-header-meta` oder Fliesstext.
```html
<span class="bh-tag">NEU</span>
<span class="bh-tag bh-orange">BETA</span>
<span class="bh-tag bh-ghost">GEPLANT</span>
```

### Tastenkürzel
```html
<kbd>Cmd</kbd> + <kbd>K</kbd>
```

### Key-Value-Liste — für Parameter, Steckbriefe
```html
<dl class="bh-kv">
  <dt>Schl&uuml;ssel</dt><dd>Wert</dd>
</dl>
```

### Verwandte Artikel
```html
<ul class="bh-related">
  <li><a href="#">[Artikeltitel]</a> <span class="bh-related-meta">KB-Kategorie</span></li>
</ul>
```

---

## Inhaltliche Regeln

- Wichtigstes zuerst — nicht nach einer Einleitung
- Keine leeren Versprechen: nicht "spart Zeit", sondern was konkret entfällt
- Sprache: Deutsch, direkte Ansprache "du", kein Marketingsprech
- Kein Markdown im HTML: kein `**fett**`, stattdessen `<strong>`
- Umlaute als HTML-Entities: `&auml;` `&ouml;` `&uuml;` `&Auml;` `&Ouml;` `&Uuml;` `&szlig;` `&ndash;`
