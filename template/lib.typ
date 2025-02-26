#let etsi_color = rgb(83, 16, 12)
#import "@preview/droplet:0.3.1": dropcap


#let first-letter(text) = {
  dropcap(
    height: 2,
    gap: 4pt,
    hanging-indent: 0em,
    overhang: 0pt,
    font: ("Times New Roman", "Tinos"),
    text,
  )
}

#let cover(
  metadata,
) = {
  set page(
    paper: "a4",
    background: {
      place(top + left, rect(fill: etsi_color, width: 35mm, height: 100%))
      place(top + left, dy: 205mm, rect(fill: etsi_color, height: 261mm - 205mm, width: 100%))
    },
    foreground: {
      if metadata.dev_mode {
        let today = datetime.today()
        set text(size: 6mm)
        place(
          top + right,
          dx: -5mm,
          dy: 5mm,
          box(
            fill: white,
            outset: 2mm,
            raw("VERSIÓN DEL " + str(today.day()) + "/" + str(today.month()) + "/" + str(today.year())),
          ),
        )
      }
      place(top + left, dx: 0mm, dy: 205mm, image("figures/edificio01.png", width: 35mm, height: 5.6cm))
      place(top + left, dx: 175mm, dy: 215mm, image("figures/Logo.svg", width: 2.5cm))
      place(top + left, dx: 141mm, dy: 265mm, [/* department logo */])

      set par(leading: 0.4em)
      place(
        top + left,
        dx: 42mm,
        dy: 25mm,
        box(
          width: 155mm,
          text(
            size: 21pt,
            [
              Trabajo Fin de Grado\
              #metadata.degree
            ],
          ),
        ),
      )
      place(bottom + left, dx: 4.2cm, dy: -16.6cm, text(size: 21pt, box(width: 16cm, [#metadata.title])))

      place(
        top + left,
        dx: 4.2cm,
        dy: 165mm,
        text(
          size: 14pt,
          [
            Autor: #metadata.author

            Tutor: #metadata.tutor
          ],
        ),
      )

      place(
        top + center,
        dy: 217mm,
        box(
          width: 13cm,
          text(
            size: 14pt,
            fill: white,
            weight: "bold",
            [
              #metadata.department\
              Escuela Técnica Superior de Ingeniería\
              Universidad de Sevilla
              #v(0.5cm)
              #text(size: 10pt, weight: "regular", [Sevilla, #metadata.year])
            ],
          ),
        ),
      )

      place(top + center, dy: 267mm, image(width: 2.5cm, "figures/US-marca-principal.png"))
    },
  )
}

#let title_page(
  metadata,
) = {
  set align(center)
  set par(spacing: 0pt, leading: 0.5em)
  text(
    size: 16pt,
    [
      Trabajo Fin de Grado\
      #metadata.degree
    ],
  )
  v(2cm)
  text(size: 21pt, weight: "bold", metadata.title)
  v(2cm)
  text(size: 10pt, [Autor:])
  v(0.4cm)
  text(size: 14pt, metadata.author)
  v(1.5cm)
  text(size: 10pt, [Tutor:])
  v(0.4cm)
  text(size: 14pt, metadata.tutor)
  v(0.4cm)
  text(size: 10pt, metadata.tutor_title)
  v(3.5cm)
  text(
    size: 14pt,
    [
      #metadata.department\
      Escuela Técnica Superior de Ingeniería\
      Universidad de Sevilla
    ],
  )
  v(0.5cm)
  text(size: 10pt, [Sevilla, #metadata.year])
}

#let main_heading(x) = {
  pagebreak(weak: true)

  set text(font: "TeX Gyre Heros", size: 20pt, stretch: 85%)
  set block(spacing: 0pt)
  v(75pt)
  if x.numbering == none {
    align(end, x.body)
  } else {
    align(left, x)
  }
  v(13pt)
  line(length: 100%, stroke: (paint: gray, thickness: 3.5pt))
  v(50pt)
}

#let court_info(
  metadata,
) = {
  pagebreak(weak: true)

  set text(font: "TeX Gyre Heros", size: 10pt, stretch: 85%)
  set block(spacing: 0pt)

  grid.with(columns: (90pt, auto), gutter: 10pt)(
    text([Trabajo Fin de Grado: ]),
    text(metadata.title),
  )

  v(1cm)
  text([Autor: ])
  text(metadata.author)
  linebreak()
  text([Tutor: ])
  text(metadata.tutor)
  v(.5cm)

  text([El tribunal nombrado para juzgar el trabajo arriba indicado, compuesto por los siguientes profesores: ])
  v(1.25cm)

  grid.with(columns: (70pt, auto, 90pt), gutter: 0pt)(
    v(1.5cm),
    text([Presidente:]),
    v(1.5cm),
    v(3cm),
    text([Vocal/es:]),
    v(3cm),
    v(1.5cm),
    text([Secretario: ]),
    v(1.5cm),
  )

  text([Acuerdan otorgarle la calificación de: ])
  v(4.5cm)
  grid.with(columns: (7.5cm, 7cm), gutter: 10pt)(
    v(3.5cm),
    text([El Secretario del Tribunal:]),
    v(1.5cm),
    text([Fecha:]),
  )
}


#let index(title: [Índice], target: heading) = context {
  [= #title]

  set text(font: "TeX Gyre Heros", size: 12pt, stretch: 85%)

  let items = query(selector(target))

  for item in items {
    let loc = item.location()

    // Choose between normal and emph text
    let body = if item.numbering == none {
      emph(item.body)
    } else {
      item.body
    }

    // Page assignation
    let page_numbering = loc.page-numbering()
    let page_number = if page_numbering != none {
      numbering(
        page_numbering,
        ..counter(page).at(loc),
      )
    } else {
      []
    }

    // Section number assignation
    let item_numbering = if item.numbering == none {
      none
    } else {
      context numbering("1.", ..counter(heading).at(loc))
    }

    // Data representation

    // The first 'if' is for elements that have levels, i.e. headings
    if item.at("level", default: none) != none {
      let entry = [#grid(
          columns: (30pt * (item.level - 1), 30pt + 6pt * (item.level - 1), 1fr, auto),
          [], item_numbering, body, page_number,
        )]

      let entry_spacing = if item.numbering != none and item.level == 1 { 25pt } else { 5pt }

      show grid: set block(above: entry_spacing)


      if item.numbering != none {
        if item.level == 1 {
          v(-1em)
          strong(entry)
          v(1em)
        } else {
          v(-1em)
          entry
          v(1em)
        }
      } else {
        entry
      }


      // The second if is for elements with no levels, e.g. figures
    } else {
      let entry_f = [#grid(
          columns: (4em, 1fr, 1em, 1em),
          item_numbering, item.caption, h(1em), page_number,
        )]

      entry_f
    }
  }
}


#let page-header(numeration: "1", main: false) = {
  if (main) {
    context {
      // Header for the main content
      let titles = query(selector(heading.where(level: 1).or(heading.where(level: 2))))

      let title_left
      let title_right
      let chapter

      let page = counter(page).get().first()

      for title in titles {
        let loc = title.location()
        let title_numbering = if title.numbering == none {
          none
        } else {
          context numbering("1.", ..counter(heading).at(loc))
        }

        // Chapter numbering for the left headers
        if (title.level == 1) {
          chapter = [Capítulo ] + [#numbering("1", ..counter(heading).at(loc))] + [. ]
        } else {
          none
        }

        // Left headers for the main content
        if locate(loc).page() <= here().page() and title.level == 1 {
          title_left = strong([#numbering(numeration, page)] + h(1.4em) + chapter + title.body)
        }

        // Right headers for the main content
        if locate(loc).page() <= here().page() and title.level == 2 {
          title_right = strong([#title_numbering ] + title.body + h(1.4em) + [#numbering(numeration, page)])
        }

        // Skip the first header of a section
        if (title.level == 1 and locate(loc).page() == here().page()) {
          title_left = none
        }
      }

      // Header placement
      if title_left != none {
        if calc.odd(page) {
          place(top + right, dx: +2em, dy: 3.5em, [#title_right])
          line(length: 100%, stroke: (paint: gray, thickness: 1pt), start: (0pt, -10pt), end: (40em + 25pt, -10pt))
        } else {
          place(top + left, dx: -2em, dy: 3.5em, [#title_left])
          line(length: 100%, stroke: (paint: gray, thickness: 1pt), start: (-25pt, -10pt), end: (40em, -10pt))
        }
      } else {
        // If there is no header, place the page numbering in the middle
        place(top + center, dx: -.025em, dy: 72.028em, [#numbering(numeration, page)])
      }
    }
  } else {
    context {
      // Header for the others type of content
      let titles = query(selector(heading.where(level: 1)))

      let title_left
      let num_left
      let title_right
      let num_right

      let page = counter(page).get().first()

      for title in titles {
        let loc = title.location()
        let title_numbering = if title.numbering == none {
          none
        } else {
          context numbering("1.", ..counter(heading).at(loc))
        }

        // Prepare both left and right headers parts
        if locate(loc).page() <= here().page() {
          num_left = strong([#numbering(numeration, page)])
          title_left = strong(title.body)
          num_right = strong([#numbering(numeration, page)])
          title_right = strong(title.body)
        }

        // Skip the first header of a section
        if (locate(loc).page() == here().page()) {
          title_left = none
        }
      }

      // Header placement
      if title_left != none {
        if calc.odd(page) {
          place(top + right, dx: +2em, dy: 3.5em, [#num_right])
          place(top + center, dx: 0em, dy: 3.5em, [#title_right])
          line(length: 100%, stroke: (paint: gray, thickness: 1pt), start: (0pt, -10pt), end: (40em + 25pt, -10pt))
        } else {
          place(top + left, dx: -2em, dy: 3.5em, [#num_left])
          place(top + center, dx: +0em, dy: 3.5em, [#title_left])
          line(length: 100%, stroke: (paint: gray, thickness: 1pt), start: (-25pt, -10pt), end: (40em, -10pt))
        }
      } else {
        // If there is no header, place the page numbering in the middle
        place(top + center, dx: -.025em, dy: 72.028em, [#numbering(numeration, page)])
      }
    }
  }
}

#let pre-content(body) = {
  set page(numbering: "I", header: page-header(numeration: "I", main: false), footer: none)
  set heading(numbering: none)

  body
}

#let main-content(body) = {
  set heading(numbering: "1.1")
  set page(numbering: "1", header: page-header(numeration: "1", main: true), footer: none)
  counter(page).update(1)
  // Start counting from 1, since the pre-content section was counted in roman numerals.

  body
}

#let post-content(body) = {
  set page(numbering: "1", header: page-header(numeration: "1", main: false), footer: none)
  set heading(numbering: none)

  body
}

#let tfg_etsi_us_template(
  // El título del TFG
  title,
  // El grado de la titulación, p.ej. Ingeniería Industrial
  degree,
  // Nombre y apellidos del autor
  author,
  // Nombre y apellidos del tutor (o tutores)
  tutor,
  // Título del tutor, p.ej. Profesor Asociado
  tutor_title,
  // Nombre del departamento asociado
  department,
  // Año del TFG (Por defecto el año de compilación del archivo)
  year: datetime.today().year(),
  body,
) = {
  set text(lang: "es")
  set par(justify: true)

  set page(
    margin: (
      top: 1in - 23pt + 12pt + 25pt,
      inside: 1in + 13pt,
      // TODO Grab rest from https://www.overleaf.com/learn/latex/Page_size_and_margins
    ),
    numbering: none, // Will get overwritten by xxx-content functions
  )

  let metadata = (
    title: title,
    degree: degree,
    author: author,
    tutor: tutor,
    tutor_title: tutor_title,
    department: department,
    year: year,
    dev_mode: true,
  )

  cover(metadata)
  pagebreak()
  pagebreak()
  title_page(metadata)
  pagebreak()
  pagebreak()
  court_info(metadata)
  pagebreak()
  pagebreak()

  // Page numbering doesn't actually start until now, ignore cover and title
  // pages
  counter(page).update(1)

  show heading.where(level: 1): main_heading

  body
}
