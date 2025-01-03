#' Create a Hex
#'
#' @param file Character. Full file path to a .png where the output PNG will be
#'     saved. The containing directory must already exist.
#' @param open Logical. Open the PNG file once written? Defaults to `TRUE`.
#' @param border_width Numeric. Thickness of the border, expressed as a ratio
#'     of the 'inner' hexagon to 'outer' hexagon (must be less than 1).
#' @param border_col Character. Named R colour or hexadecimal code (6- or
#'     8-digit versions) for the border around the hex.
#' @param bg_col Character. Named R colour or hexadecimal code (6- or
#'     8-digit versions) for the interior background.
#' @param text_string Character. Text to add to the hex. Use an empty character
#'     string if you don't want any text.
#' @param text_col Character. Named R colour or hexadecimal code (6- or
#'     8-digit versions) for the text string.
#' @param text_font Character. Name of font family available on your system.
#' @param text_x Numeric. The x-axis position where the text will be placed.
#'     Positive values will move the text to the right; negative to the left.
#'     Defaults to 0 (centre).
#' @param text_y Numeric. The y-axis position where the text will be placed.
#'     Positive values will move the text up; negative down.  Defaults to 0
#'     (centre).
#' @param text_size Numeric. Size of the text in pixels.
#' @param text_rotate Numeric. Rotation of text string in degrees.
#'
#' @details
#' Writes a hexagon to the dimensions of the sticker standard given by
#' [github.com](github.com/terinjokes/StickersStandard): 4.39 cm wide by 5.08 cm
#' high.
#'
#' @return Nothing.
#'
#' @export
#'
#' @examples
#' tmp <- tempfile(fileext = ".png")
#' make_hex(tmp)
make_hex <- function(
    file = "~/Desktop/test.png",
    open = TRUE,
    border_width = 0.95,
    border_col = "black",
    bg_col = "grey",
    text_string = "hexbase",
    text_x = 0.5,
    text_y = 0.4,
    text_col = "red",
    text_size = 20,
    text_font = "mono",
    img_object = png::readPNG(system.file("img", "Rlogo.png", package = "png")),
    img_x = 0.5,
    img_y = 0.6,
    img_width = 0.37,
    img_height = 0.3
) {

  grDevices::png(
    filename = file,
    width = 4.39,
    height = 5.08,
    units = "cm",
    res = 1200,
    bg = "transparent"
  )

  coords_outer <- .get_outer_hex_coords()
  coords_outer_scaled <- .get_outer_hex_coords_scaled(coords_outer)

  coords_inner <- .get_inner_hex_coords(border_width)
  coords_inner_scaled <- .get_inner_hex_coords_scaled(coords_inner, coords_outer)

  grob_outer <- .engrob_hex(coords_outer_scaled, border_col)
  grob_inner <- .engrob_hex(coords_inner_scaled, bg_col)
  grob_text  <- .engrob_text(
    text_string,
    text_x,
    text_y,
    text_col,
    text_size,
    text_font
  )
  grob_img <- .engrob_img(img_object, img_width, img_height)

  viewport_clip <- grid::viewport(clip = grob_outer)
  viewport_img <- grid::viewport(x = img_x, y = img_y)

  grid::pushViewport(viewport_clip)
  grobs <- list(grob_outer, grob_inner, grob_text)
  for (grob in grobs) grid::grid.draw(grob)

  grid::pushViewport(viewport_img)
  grid::grid.draw(grob_img)

  grid::popViewport()  # img
  grid::popViewport()  # clip

  dev.off()

  if (open) system(paste("open", file))

}
