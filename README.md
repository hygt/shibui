# shibui

A clean, single-column resume template for [Typst](https://typst.app). Understated
and matter-of-fact — practical, to the point, quietly refined (渋い).

A4, one column, no sidebar, no colour blocks: a name and contact grid at the top,
then ruled sections with tight, aligned entry headers. Every gutter, inset, and
vertical gap is derived from one 4 pt scale, so the rhythm stays consistent no
matter how much content you add.

## Requirements

A recent Typst installation (tested with 0.15.1). Nothing else is required; the
example uses the `fontawesome` package for contact icons.

```sh
typst compile cv.typ        # one-shot build
typst watch cv.typ          # rebuild on save
```

## Files

| File | Purpose |
| --- | --- |
| [shibui.typ](shibui.typ) | The template: styles, theme values, and components |
| [elliot.typ](elliot.typ) | Example resume (Elliot Alderson, *Mr. Robot*) |
| [elliot.pdf](elliot.pdf) | Build output |

## Quick start

```typ
#import "shibui.typ": *
#import "@preview/fontawesome:0.6.2": fa-icon

#let contact-icon(name, solid: false) = fa-icon(
  name,
  solid: solid,
  size: 10pt,
  top-edge: "baseline",
)

#resume(
  name: "Your Name",
  role: "Staff Software Engineer",
  contacts: (
    (icon: contact-icon("envelope"), text: "you@example.com", link: "mailto:you@example.com"),
    (icon: contact-icon("github"), text: "github.com/you", link: "https://github.com/you"),
    (icon: contact-icon("home"), text: "Zürich area"),
  ),
)[
  #summary[
    One or two sentences on what you do, at what scale, and for how long.
  ]

  #section("Employment")

  #job(
    "Staff Software Engineer",
    company: "Acme",
    location: "Zürich, Switzerland",
    team: "Platform",
    dates: "2020 – Present",
    body: [
      One-paragraph description of the role and its scope.

      - A result, with a number in it.
      - Another result, kept to one line if possible.
    ],
  )

  #section("Open Source")

  #project(
    "some-tool",
    url: "https://github.com/you/some-tool",
    description: [What you contributed and why it mattered.],
  )

  #section("Education")

  #education(
    "MSc – Computer Science",
    "EPFL",
    location: "Lausanne, Switzerland",
    dates: "2008 – 2010",
  )

  #section("Skills")
  #skills-table(
    ("Languages", "Data", "Infrastructure"),
    (
      ("Scala", "Spark", "Kubernetes"),
      ("Rust", "Kafka", "AWS"),
    ),
  )
]
```

## Components

All components are exported, so `#import "shibui.typ": *` is enough.

### `resume(name: "", role: none, contacts: (), body)`

Wraps the whole document. Sets A4 paper, 1.2 cm margins, 11 pt text without
hyphenation, `-` list markers, and underlined links.

- `name` — displayed at 25 pt bold.
- `role` — optional subtitle under the name, in muted grey.
- `contacts` — array of `(icon: content, text: string, link: string)`; `link` is
  optional. Rendered as an aligned two-column (icon, label) grid on the right.
- `body` — everything else: summary and sections.

### `section(title)`

A 14 pt accent-coloured heading followed by a full-width rule, with
`gap-section` above and `gap-block` below. Use it for *Employment*, *Education*,
*Skills*, and so on.

### `summary(body)`

Muted introductory paragraph directly beneath the header. Optional.

### `job(title, company: none, location: none, team: none, dates: none, body: none)`

One entry in the employment history.

- Row 1: `title` (bold, 28% column), `company` (bold, centred), `dates` (right).
- Row 2: `team` (small, muted, under the title), `location` (small, muted, right).
- `body` — free-form content, indented under the entry. Lists work as usual.

### `company(name, location: none, dates: none, body: none)` and `role(title, team: none, dates: none, body: none)`

For several roles at the same employer: use `company` for the employer heading,
then nest `role` entries under it (each `role` keeps its own dates).

### `education(degree, institution, location: none, dates: none)`

One degree. Same two-row header layout as `job`, without a body.

### `project(name, url: none, description: none)`

Two-column row: project name (bold, optionally linked) and description. Handy for
open source, side projects, or talks.

### `skill(category, items)`

A single `category → items` row, for short skill lists used outside a table.

### `skills-table(headers, rows, widths: none)`

A borderless table of skills where each column is a group.

- `headers` — array of column names, rendered bold in a repeated table header.
- `rows` — array of row arrays; a cell may be `none` to leave a gap.
- `widths` — optional column widths (e.g. `(1.2fr, 1fr, 1fr)`); defaults to equal
  `1fr` columns.

### `entry-header(...)`

The shared two-row header used by `job`, `company`, `role`, and `education`. Only
needed if you build a custom entry type.

## Contacts and icons

`icon` is ordinary Typst content, so it can be anything: a Font Awesome glyph, a
unicode character, or empty content `[]`. Icons are vertically centred against
their label, and all labels start at the same x position regardless of icon width.

```typ
#let contact-icon(name) = fa-icon(name, size: 10pt, top-edge: "baseline")
```

## Theming

Theme values are plain `let` bindings at the top of `shibui.typ`. Edit them there —
shadowing them in `cv.typ` after the import will *not* change the output, because
the components resolve the names inside the template's own scope.

```typ
#let accent = rgb("#339595")   // section headings and rules
#let ink = rgb("#000000")      // body text
#let muted = rgb("#4b5563")    // role, team, location, summary

#let main-font = ("SF Pro Text")
#let accent-font = ("SF Pro Text")

#let spacing-unit = 4pt
#let space = (
  xs: 1 * spacing-unit, // 4pt
  sm: 2 * spacing-unit, // 8pt
  md: 3 * spacing-unit, // 12pt
  lg: 4 * spacing-unit, // 16pt
  xl: 6 * spacing-unit, // 24pt
)
```

Spacing roles map onto that scale: `gutter` (between columns), `inset` (table cell
padding), `gap-inline` (header → body), `gap-block` (between entries),
`gap-section` (before a section), `gap-header` (after the name block). Page margin
is `page-margin = 1.2cm`. Change `spacing-unit` alone to retune the whole document
proportionally.

Fonts are referenced by name, so any font installed on the system works; swap in a
font stack such as `("Helvetica Neue", "Arial", "Liberation Sans")` for
portability.

## Tips

- Keep it to two pages. `#pagebreak(weak: true)` (as in the example) starts a new
  page only when there is content to fill it, which avoids blank pages.
- The layout has no built-in page numbers. Add `#set page(numbering: "1 / 1")`
  *above* `#resume(...)` in your document — the template's own `set page` only
  overrides paper, margin, and fill, so numbering survives. Put it inside the
  body instead and the setter forces a page break at that point.
- `justify` is off and hyphenation is disabled by design — write lines that fit
  rather than letting the engine stretch them.
