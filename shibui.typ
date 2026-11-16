// shibui.typ — a clean, single-column resume template
// Understated and matter-of-fact: practical, to the point, quietly refined.
// Inspired by the layout of pragmaticengineer.com/resume
//
// Usage:
//   #import "shibui.typ": *
//   #resume(name: [Your Name], role: [Your Title], contacts: (...))[
//     #section("Experience")
//     #job(
//       "Staff Engineer",
//       company: "Acme",
//       dates: "2020 – Present",
//       body: [ ... ],
//     )
//   ]

// #let accent = rgb("#1a2cf7")
#let accent = rgb("#339595")
#let ink = rgb("#000000")
#let muted = rgb("#4b5563")

#let main-font = ("SF Pro Text")
#let accent-font = ("SF Pro Text")

// Spacing
// -------
// Every gutter, inset, and vertical gap is derived from this scale so the
// layout keeps a consistent rhythm. The base unit is 4pt; all values below
// are multiples of it.
#let spacing-unit = 4pt
#let space = (
  xs: 1 * spacing-unit, // 4pt
  sm: 2 * spacing-unit, // 8pt
  md: 3 * spacing-unit, // 12pt
  lg: 4 * spacing-unit, // 16pt
  xl: 6 * spacing-unit, // 24pt
)

// Reusable spacing roles.
#let gutter = space.sm       // space between columns
#let inset = space.xs        // padding within a cell
#let gap-inline = space.xs   // tightly coupled lines (header -> body)
#let gap-block = space.lg    // between entries
#let gap-section = space.xl  // before a section
#let gap-header = space.md   // after the name and contact details
#let page-margin = 1.2cm

// Contact entries: (icon: [icon content], text: "...", link: "mailto:...")
// A single grid keeps every icon column and label column aligned across rows:
// icons are centred in their column and labels start at the same x position.
#let contact-grid(contacts) = {
  let cells = contacts.map(c => {
    let label = if c.at("link", default: none) == none {
      c.text
    } else {
      link(c.at("link"))[#c.text]
    }
    (c.icon, label)
  }).flatten()

  grid(
    columns: (auto, auto, auto, auto),
    column-gutter: gutter,
    row-gutter: gutter,
    align: (center + bottom, left + horizon, center + bottom, left + horizon),
    ..cells,
  )
}

#let resume(
  name: "",
  role: none,
  contacts: (),
  body,
) = {
  set page(
    paper: "a4",
    margin: (x: page-margin, y: page-margin),
    fill: white,
  )
  set text(
    font: main-font,
    size: 11pt,
    fill: ink,
    lang: "en",
    hyphenate: false,
  )
  set par(
    justify: false,
  )
  set list(
    marker: [-],
  )

  // Links stay in the text colour; the underline distinguishes them.
  show link: it => {
    set text(fill: ink)
    underline(stroke: 0.5pt + luma(170), offset: 2pt, it)
  }

  // Name and contact details
  block(width: 100%, below: gap-header)[
    #grid(
      columns: (1fr, auto),
      column-gutter: space.lg,
      align: (left + top, right + top),
      [
        #text(font: accent-font, size: 25pt, weight: "bold")[#name]
        #if role != none [
          #v(space.xs)
          #text(size: 11pt, fill: muted, weight: "bold")[#role]
        ]
      ],
      contact-grid(contacts),
    )
  ]

  body
}

#let section(title) = {
  block(above: gap-section, below: gap-block, width: 100%)[
    #grid(
      columns: (auto, 1fr),
      column-gutter: gutter,
      align: (left + bottom, right + bottom),
      text(fill: accent, weight: "bold", size: 14pt)[#title],
      move(dy: -0.2em, line(length: 100%, stroke: 1pt + accent)),
    )
  ]
}

#let summary(body) = {
  block(
    width: 100%,
    above: gap-header,
    below: 0pt,
    text(fill: muted, body),
  )
}

#let entry-header(
  title,
  company: none,
  location: none,
  team: none,
  dates: none,
) = {
  grid(
    columns: (28%, 1fr, auto),
    gutter: gutter,
    align: (left + top, center + top, right + top),
    text(weight: "bold")[#title],
    text(weight: "bold")[#company],
    text[#dates],
    text(size: 10pt, fill: muted)[#team],
    [],
    text(size: 10pt, fill: muted)[#location]
  )
}

#let job(
  title,
  company: none,
  location: none,
  team: none,
  dates: none,
  body: none,
) = {
  block(width: 100%, above: gap-block, below: 0pt)[
    #entry-header(
      title,
      company: company,
      team: team,
      dates: dates,
      location: location,
    )
    #if body != none [
      #v(gap-inline)
      #body
    ]
  ]
}

// A company with several roles underneath it.
#let company(name, location: none, dates: none, body: none) = {
  block(width: 100%, above: gap-block, below: 0pt)[
    #entry-header(
      name,
      dates: dates,
      location: location,
    )
    #v(gap-inline)
    #body
  ]
}

#let role(title, team: none, dates: none, body: none) = {
  block(width: 100%, above: space.md, below: 0pt)[
    #entry-header(
      title,
      team: team,
      dates: dates,
    )
    #if body != none [
      #v(gap-inline)
      #body
    ]
  ]
}

#let education(degree, institution, location: none, dates: none) = {
  block(width: 100%, above: gap-block, below: 0pt)[
    #entry-header(
      degree,
      company: institution,
      dates: dates,
      location: location,
    )
  ]
}

#let skill(category, items) = {
  grid(
    columns: (28%, 1fr),
    column-gutter: gutter,
    align: (left + top, left + top),
    text(weight: "bold")[#category],
    text[#items],
  )
  v(gap-inline)
}

#let skills-table(
  headers,
  rows,
  widths: none,
) = {
  let columns = if widths == none {
    range(headers.len()).map(_ => 1fr)
  } else {
    widths
  }

  let body = rows.flatten().map(cell => {
    if cell == none { [] } else { text(size: 11pt)[#cell] }
  })

  table(
    columns: columns,
    inset: (left: 0pt, right: gutter, top: inset, bottom: inset),
    stroke: none,
    align: left + top,
    table.header(..headers.map(header => text(weight: "bold")[#header])),
    ..body,
  )
}

#let project(name, url: none, description: none) = {
  block(width: 100%, above: gap-block, below: 0pt)[
    #grid(
      columns: (28%, 1fr),
      column-gutter: gutter,
      align: (left + top, left + top),
      if url == none {
        text(weight: "bold")[#name]
      } else {
        link(url)[#text(weight: "bold")[#name]]
      },
      description,
    )
  ]
}
