#' Create Graphics Object: Hexagon
#' @param coords List. Coordinates to draw polygon. Elements named `x` and `y`.
#' @param fill_col Character. Named or hexadecimal colour.
#' @noRd
.engrob_hex <- function(coords, fill_col) {
  grid::polygonGrob(
    coords[["x"]],
    coords[["y"]],
    gp = grid::gpar(fill = fill_col)
  )
}

#' Create Graphics Object: Text
#' @param txt_string Character. Text to print on hex.
#' @param txt_col Character. Named or hexadecimal colour.
#' @param txt_size Numeric. Point size of text.
#' @param txt_font Character. Font family for text. Must exist on system.
#' @noRd
.engrob_text <- function(txt_string, txt_col, txt_size, txt_font) {
  grid::textGrob(
    txt_string,
    gp = grid::gpar(
      col = txt_col,
      fontsize = txt_size,
      fontfamily = txt_font,
      lineheight = 0.75
    )
  )
}
