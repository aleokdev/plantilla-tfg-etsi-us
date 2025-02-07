#import "template/lib.typ": tfg_etsi_us_template, pre-content, main-content, post-content, index

#set text(font: ("Times New Roman", "Tinos"))

#show: tfg_etsi_us_template.with(
  // El título del TFG
  "Formato de Publicación de la Escuela Técnica Superior de Ingeniería",
  // El grado de la titulación, e.g. Ingeniería Industrial
  "Ingeniería de las Tecnologías de Telecomunicación",
  // Nombre y apellidos del autor
  "Nombre Apellidos",
  // Nombre y apellidos del tutor (o tutores)
  "Nombre Apellidos",
  // Título del tutor, p.ej. Profesor Asociado
  "Profesor Titular",
  // Nombre del departamento asociado
  "Dpto. Teoría de la Señal y Comunicaciones"
  // Año del TFG (Por defecto el año de compilación del archivo)
  // year: 2024
  )

#index() // TODO: change this for outline

#pre-content[
  // El contenido de aquí usa numeración romana de páginas y los títulos
  // definidos no están numerados. Usado para índice, agradecimientos,
  // introducción, abstracto/resumen, ...
  = Agradecimientos
  #lorem(100)

  = Resumen
  #lorem(100)

  = Abstract
  #lorem(100)
]
#main-content[
  // Las páginas de aquí junto a los títulos definidos usan numeración arábiga
  // comenzando desde 1. Usado para el contenido principal del TFG
  = Capítulo
  #lorem(30)

  == Subsección
  #lorem(50)
]
#post-content[
  // El contenido de aquí continúa con la numeración de páginas anterior, pero
  // los títulos definidos no están numerados. Usado para glosario,
  // bibliografía, índice de figuras...
  = Bibliografía
  // Recordar usar la función bibliography para la bibliografía.
  // Para mantener la lista de referencias se puede usar software como Mendeley.
  // #bibliography("referencias.bib")
]


