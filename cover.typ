#let etsi_color = rgb(83, 16, 12)

#let cover(
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

      place(bottom + left, dx: 4.2cm, dy: -27cm, text(size: 21pt, [
        Trabajo Fin de Grado\
        en #degree
      ]))
      place(bottom + left, dx: 4.2cm, dy: -16.6cm, text(size: 21pt, [Título del proyecto]))

      place(top + left, dx: 4.2cm, dy: 165mm, text(size: 15pt, [
        Autor: #author\
        Tutor: #tutor
      ]) )

      place(top + center, dy: 215mm, text(size: 14pt, fill: white, weight: "bold", [
        Departamento\
        Escuela Técnica Superior de Ingeniería\
        Universidad de Sevilla
        #v(0.5cm)
        #text(size: 13pt, [Sevilla, #year])
        ]))

      place(top + center, dy: 267mm, image(width: 2.5cm, "figures/US-marca-principal.png"))

  })
}

#cover("Ingeniería Robótica, Electrónica y Mecatrónica",
"Nombre Apellidos",
"Nombre Apellidos",
"Departamento")