#let etsi_color = rgb(83, 16, 12)


#let cover(
  metadata
) = {
  set page(
    paper: "a4",
    background: {
      place(top + left, rect(fill: etsi_color, width: 35mm, height: 100%))
      place(top + left, dy: 205mm, rect(fill: etsi_color, height: 261mm-205mm, width: 100%))
    },
    foreground: {
      if metadata.dev_mode {
        let today = datetime.today()
        set text(size: 6mm)
        place(top + right, dx: -5mm, dy: 5mm, box(fill: white, outset: 2mm, raw("VERSIÓN DEL " + str(today.day()) + "/" + str(today.month()) + "/" + str(today.year()))))
      }
      place(top + left, dx:0mm, dy: 205mm, image("figures/edificio01.png", width: 35mm, height: 5.6cm))
      place(top + left, dx: 175mm, dy: 215mm, image("figures/Logo.svg", width: 2.5cm))
      place(top + left, dx: 141mm, dy: 265mm, [/* department logo */])

      set par(leading: 0.4em)
      place(top + left, dx: 42mm, dy: 25mm, box(width: 155mm, text(size: 21pt, [
        Trabajo Fin de Grado\
        #metadata.degree
      ])))
      place(bottom + left, dx: 4.2cm, dy: -16.6cm, text(size: 21pt, box(width: 16cm, [#metadata.title])))

      place(top + left, dx: 4.2cm, dy: 165mm, text(size: 14pt, [
        Autor: #metadata.author

        Tutor: #metadata.tutor
      ]) )

      place(top + center, dy: 217mm, box(width: 13cm, text(size: 14pt, fill: white, weight: "bold", [
        #metadata.department\
        Escuela Técnica Superior de Ingeniería\
        Universidad de Sevilla
        #v(0.5cm)
        #text(size: 10pt, weight: "regular", [Sevilla, #metadata.year])
        ])))

      place(top + center, dy: 267mm, image(width: 2.5cm, "figures/US-marca-principal.png"))

  })
}

#let title_page(
  metadata  
) = {
  set align(center)
  set par(spacing: 0pt, leading: 0.5em)
  text(size: 16pt, [
    Trabajo Fin de Grado\
    #metadata.degree
  ])
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
  text(size: 14pt, [
    #metadata.department\
    Escuela Técnica Superior de Ingeniería\
    Universidad de Sevilla
  ])
  v(0.5cm)
  text(size: 10pt, [Sevilla, #metadata.year])
}

#let main_heading(x) = {
  pagebreak(weak: true)

  set text(font: "TeX Gyre Heros", size: 20pt, stretch: 85%)
  set block(spacing: 0pt)
  v(75pt)
  align(end, x.body)
  v(13pt)
  line(length: 100%, stroke: (paint: gray, thickness: 3.5pt))
  v(15pt)
}

#let main-content_heading(x) = {
  pagebreak(weak: true)

  set text(font: "TeX Gyre Heros", size: 20pt, stretch: 85%)
  set block(spacing: 0pt)
  v(75pt)
  align(left, x)
  v(13pt)
  line(length: 100%, stroke: (paint: gray, thickness: 3.5pt))
  v(15pt)
}

#let court_info(
  metadata
) = {
  pagebreak(weak: true)

  set text(font: "TeX Gyre Heros", size: 10pt, stretch: 85%)
  set block(spacing: 0pt)
  
  grid.with(columns: (90pt, auto), gutter: 10pt)(
    text([Trabajo Fin de Grado: ]),
    text( metadata.title)
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
    v(1.5cm)
  )

  text([Acuerdan otorgarle la calificación de: ])
  v(4.5cm)
  grid.with(columns: (7.5cm,7cm), gutter: 10pt)(
    v(3.5cm),
    text([El Secretario del Tribunal:]),
    v(1.5cm),
    text([Fecha:]),
    
  )
}

#let index(target) = context {
  if target == "" or target == "normal" or target == "reduced"{ 

    if target ==  "" or target == "normal" {[= Índice]}
    else {[= Índice Reducido]}

    set text(font: "TeX Gyre Heros", size: 12pt, stretch: 85%)
    let chapters = query(heading)
    for chapter in chapters {
      let loc = chapter.location()

      let body = if chapter.numbering == none {
        if chapter.body == [Índice] {
        } else {
          emph(chapter.body)
        }

      } else {
        chapter.body
      }

      let page_numbering = loc.page-numbering()
      let page_number = if page_numbering != none {
        numbering(
          page_numbering,
          ..counter(page).at(loc),
        )
      } else {
        []
      }

      let level_numbering = if chapter.numbering == none {
          none
        } else {
          context numbering(chapter.numbering, ..counter(heading).at(loc))
        }

      let entry = [#grid(columns: (30pt * (chapter.level - 1), 30pt + 6pt * (chapter.level - 1), 1fr, auto), [], level_numbering, body, page_number)]

      let entry_spacing = if chapter.numbering != none and chapter.level == 1 { 25pt } else { 5pt }

      show grid: set block(above: entry_spacing)

      if (target == "" or target == "normal") or (target == "reduced" and chapter.level <= 2){
        if chapter.numbering != none {

            if chapter.level == 1{
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
      }
    }
  } else if target == "figures"{


  } else if target == "tables"{

  } else if target == "codes"{}
}

#let pre-content(body) = {
  show heading.where(level: 1): main_heading
  set page(numbering: "I")
  set heading(numbering: none)

  body
  
}

#let main-content(body) = {
 
  show heading.where(level: 1): main-content_heading
  index("reduced")
  set heading(numbering: "1.1")
  // Start counting from 1, since the pre-content section was counted in roman
  // numerals.
  set page(numbering: "1")
  counter(page).update(1)



  body
}

#let post-content(body) = {
  show heading.where(level: 1): main_heading
  set page(numbering: "1")
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

  body) = {
  set text(lang: "es")
  set par(justify: true)

  set page(
    margin: (
      top: 1in - 23pt + 12pt + 25pt,
      inside: 1in + 13pt,
      // TODO Grab rest from https://www.overleaf.com/learn/latex/Page_size_and_margins
    ),
    numbering: none // Will get overriden by xxx-content functions
  )

  let metadata = (title: title, degree: degree, author: author, tutor: tutor, tutor_title: tutor_title, department: department, year: year, dev_mode: true)

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


  

  body
}
