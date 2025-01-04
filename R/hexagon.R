#' Create a Hex Sticker
#'
#' Generate a simple hexagon-shaped sticker design with a border, image and
#' text.
#'
#' @param file Character. Full file path to a .png where the output PNG will be
#'     saved. The containing directory must already exist.
#' @param open Logical. Open the PNG file once written?
#' @param border_width Numeric. Thickness of the border, expressed as a ratio
#'     of the 'inner' hexagon to 'outer' hexagon (must be less than 1).
#' @param border_col Character. Named R colour or hexadecimal code for the
#'     border around the hex. See details.
#' @param bg_col Character. Named R colour or hexadecimal code for the interior
#'     background. See details.
#' @param text_string Character. Text to display. Use an empty character string
#'     if you don't want to place text.
#' @param text_x Numeric. The x-axis position where the text will be placed. See
#'     details.
#' @param text_y Numeric. The y-axis position where the text will be placed. See
#'     details.
#' @param text_angle Numeric. Rotation of text string in degrees.
#' @param text_size Numeric. Size of the text in pixels.
#' @param text_col Character. Named R colour or hexadecimal code for the text
#'     string. See details.
#' @param text_font Character. Name of font family available on your system.
#' @param img_object Array. A PNG file read in by the user. Use `NULL` if you
#'     don't want to place an image.
#' @param img_x Numeric. The x-axis position where the image will be placed. See
#'     details.
#' @param img_y Numeric. The y-axis position where the image will be placed. See
#'     details.
#' @param img_width Numeric. The width of the image.
#' @param img_height Numeric. The height of the image.
#' @param img_angle Numeric. Rotation of text string in degrees.
#'
#' @details
#'
#' ## Dimensions
#'
#' Writes a hexagon to the dimensions of
#' [the Stickers Standard](https://sticker.how/#type-hexagon): 4.39 cm wide by
#' 5.08 cm high (2 by 1.73 inches).
#'
#' Any elements falling outside of the hexagon will be clipped out.
#'
#' ## Coordinates
#'
#' Coordinates should be provided as native units ('Normalised Parent
#' Coordinates'), which means that the x- and y-axes range from 0 to 1. This
#' applies to arguments `text_x`, `text_y`, `img_x`, `img_y`, `img_width` and
#' `img_height`.
#'
#' ## Colours
#'
#' Named colour values must be listed in [grDevices::colours()]. Hexadecimal
#' colour values must be provided with length 6 or 8 and must begin with an
#' octothorpe (`#`). This applies to arguments `border_col`, `bg_col` and
#' `text_col`.
#'
#' ## Write order
#'
#' The order of action when building the sticker is:
#'
#' 1. Add outer hexagon.
#' 2. Add inner hexagon.
#' 3. Add image.
#' 4. Add text.
#' 5. Clip to outer hexagon.
#'
#' @return None.
#'
#' @export
#'
#' @examples
#' tmp <- tempfile(fileext = ".png")
#' make_hex(file = tmp, open = FALSE)
make_hex <- function(
    file,
    open = FALSE,
    border_width = 0.95,
    border_col = "black",
    bg_col = "grey",
    text_string = "example",
    text_x = 0.5,
    text_y = 0.35,
    text_angle = 0,
    text_size = 20,
    text_col = "red",
    text_font = "mono",
    img_object = png::readPNG(system.file("img", "Rlogo.png", package = "png")),
    img_x = 0.5,
    img_y = 0.6,
    img_width = 0.45,
    img_height = 0.35,
    img_angle = 0
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

  if (!is.null(img_object)) {
    grob_img <- .engrob_img(
      img_object,
      img_x,
      img_y,
      img_width,
      img_height
    )
  }

  viewport_clip <- grid::viewport(clip = grob_outer)
  grid::pushViewport(viewport_clip)

  for (grob in list(grob_outer, grob_inner)) {
    viewport_hex <- grid::viewport(gp = grid::gpar(lwd = 0))
    grid::pushViewport(viewport_hex)
    grid::grid.draw(grob)
  }

  if (!is.null(img_object)) {
    viewport_img <- grid::viewport(angle = img_angle)
    grid::pushViewport(viewport_img)
    grid::grid.draw(grob_img)
    grid::popViewport()
  }

  viewport_text <- grid::viewport(angle = text_angle)
  grid::pushViewport(viewport_text)
  grid::grid.draw(grob_text)
  grid::popViewport()

  grid::popViewport()  # clip

  dev.off()

  if (open) system(paste("open", file))

}
