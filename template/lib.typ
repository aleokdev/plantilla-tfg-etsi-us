#let etsi_color = rgb(83, 16, 12)

#let thesis_metadata(
  // El título del TFG
  title,
  // El grado de la titulación, e.g. Ingeniería Industrial
  degree,
  // Nombre y apellidos del autor
  author,
  // Nombre y apellidos del tutor (o tutores)
  tutor,
  // Nombre del departamento asociado
  department,
  // Año del TFG (Por defecto el año de compilación del archivo)
  year: datetime.today().year()
) = (title: title, degree: degree, author: author, tutor: tutor, department: department, year: year)

#let cover(
  metadata
) = {
  set page(
    margin: 0pt,
    paper: "a4",
    background: {
      place(top + left, rect(fill: etsi_color, width: 35mm, height: 100%))
      place(top + left, dy: 205mm, rect(fill: etsi_color, height: 261mm-205mm, width: 100%))
    },
    foreground: {
      place(top + left, dx:0mm, dy: 205mm, image("figures/edificio01.png", width: 35mm, height: 5.6cm))
      place(top + left, dx: 175mm, dy: 215mm, image("figures/Logo.svg", width: 2.5cm))
      place(top + left, dx: 141mm, dy: 265mm, [/* department logo */])

      set par(leading: 0.4em)
      place(top + left, dx: 42mm, dy: 25mm, text(size: 21pt, [
        Trabajo Fin de Grado\
        en #metadata.degree
      ]))
      place(bottom + left, dx: 4.2cm, dy: -16.6cm, text(size: 21pt, box(width: 16cm, [#metadata.title])))

      place(top + left, dx: 4.2cm, dy: 165mm, text(size: 15pt, [
        Autor: #metadata.author\
        Tutor: #metadata.tutor
      ]) )

      place(top + center, dy: 215mm, box(width: 13cm, text(size: 14pt, fill: white, weight: "bold", [
        #metadata.department\
        Escuela Técnica Superior de Ingeniería\
        Universidad de Sevilla
        #v(0.5cm)
        #text(size: 13pt, weight: "regular", [Sevilla, #metadata.year])
        ])))

      place(top + center, dy: 267mm, image(width: 2.5cm, "figures/US-marca-principal.png"))

  })
}

#let title_page(
  metadata
) = {

}

#let tfg_etsi_us_template(
  // El título del TFG
  title,
  // El grado de la titulación, e.g. Ingeniería Industrial
  degree,
  // Nombre y apellidos del autor
  author,
  // Nombre y apellidos del tutor (o tutores)
  tutor,
  // Nombre del departamento asociado
  department,
  // Año del TFG (Por defecto el año de compilación del archivo)
  year: datetime.today().year(),

  body) = {
  let metadata = thesis_metadata(title, degree, author, tutor, department, year: year)

  cover(metadata)
  pagebreak()
  title_page(metadata)
}