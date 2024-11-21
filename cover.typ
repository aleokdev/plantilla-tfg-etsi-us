#let etsi_color = rgb(83, 16, 12)

#set page(margin: 0pt,
paper: "a4",
background: {
  place(top + left, rect(fill: etsi_color, width: 35mm, height: 100%))
  place(top + left, dy: 205mm, rect(fill: etsi_color, height: 261mm-205mm, width: 100%))
},
foreground: {
  place(top + left, dx:0mm, dy: 205mm, image("figures/edificio01.png", width: 35mm, height: 5.6cm))
  place(top + left, dx: 175mm, dy: 215mm, image("figures/Logo.svg", width: 2.5cm))
  place(top + left, dx: 141mm, dy: 265mm, [/* department logo */])


})