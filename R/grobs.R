.engrob_hex <- function(coords, fill_col) {
  grid::polygonGrob(
    coords[["x"]],
    coords[["y"]],
    gp = grid::gpar(fill = fill_col)
  )
}

.engrob_text <- function(
    text_string,
    text_x,
    text_y,
    text_col,
    text_size,
    text_font
) {
  grid::textGrob(
    text_string,
    x = grid::unit(text_x, "npc"),
    y = grid::unit(text_y, "npc"),
    gp = grid::gpar(
      col = text_col,
      fontsize = text_size,
      fontfamily = text_font,
      lineheight = 0.75
    )
  )
}

.engrob_img <- function(
    img_object,
    img_x,
    img_y,
    img_width,
    img_height
) {
  grid::rasterGrob(
    img_object,
    x = grid::unit(img_x, "npc"),
    y = grid::unit(img_y, "npc"),
    width = grid::unit(img_width, "npc"),
    height = grid::unit(img_height, "npc")
  )
}
