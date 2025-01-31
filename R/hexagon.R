#' Open a Device
#'
#' Begin a PNG plot device with dimensions matching
#' [the Stickers Standard](https://sticker.how/#type-hexagon): 4.39 cm wide by
#' 5.08 cm high (2 by 1.73 inches).
#'
#' @param file_path Character. Full file path to a .png where the output file
#'     will be saved. The containing directory must already exist.
#'
#' @returns Nothing. A graphics device is opened.
#'
#' @export
#'
#' @examples
#' temp_path <- tempfile(fileext = ".png")
#' open_device(temp_path)
#' add_hex()
#' image_path <- system.file("img", "Rlogo.png", package = "png")
#' image_png <- png::readPNG(image_path)
#' add_image(image_png)
#' add_text()
#' close_device()
open_device <- function(file_path) {

  if (grepl(file_path, "\\.png$")) {
    stop("Argument 'file_path' must end with '.png'.")
  }

  if (!dir.exists(dirname(file_path))) {
    stop("Argument 'file_path' must resolve to an existing directory.")
  }

  grDevices::png(
    filename = file_path,
    width =  4.39,
    height = 5.08,
    units = "cm",
    res = 1200,
    bg = "transparent"
  )

}

#' Add a Hexagon with a Border
#'
#' Add two hexagons, where the exposed region between the two creates a border.
#'
#' @param border_width Numeric. Thickness of the border, expressed as the
#'     inverse ratio of the 'inner' hexagon to 'outer' hexagon (must be between
#'     `0` and `1`).
#' @param border_col Character. Named R colour or hexadecimal code for the
#'     border around the hex.
#' @param bg_col Character. Named R colour or hexadecimal code for the interior
#'     background.
#'
#' @details
#'
#' ## Colours
#'
#' Named colour values must be listed in [grDevices::colours()]. Hexadecimal
#' colour values must be provided with length 6 or 8 and must begin with an
#' octothorpe (`#`).
#'
#' @returns `NULL`. Adds to an existing graphics device.
#'
#' @export
#'
#' @examples
#' temp_path <- tempfile(fileext = ".png")
#' open_device(temp_path)
#' add_hex()
#' image_path <- system.file("img", "Rlogo.png", package = "png")
#' image_png <- png::readPNG(image_path)
#' add_image(image_png)
#' add_text()
#' close_device()
add_hex <- function(
    border_width = 0.05,
    border_col = "black",
    bg_col = "grey"
) {

  if (!inherits(border_width, "numeric") || border_width >= 1) {
    stop("Argument 'border_width' must be a numeric value below 1.")
  }

  if (!(border_col %in% grDevices::colours() | grepl("^#[0-9A-Fa-f]{6}$", border_col))) {
    stop("Argument 'border_col' must a named R colour or a hex code.")
  }

  if (!(bg_col %in% grDevices::colours() | grepl("^#[0-9A-Fa-f]{6}$", bg_col))) {
    stop("Argument 'bg_col' must a named R colour or a hex code.")
  }

  hex_diameter_inner <- 1 - border_width

  hex_coords_outer <- .get_hex_coords(diameter = 1)
  hex_coords_inner <- .get_hex_coords(diameter = hex_diameter_inner)

  x_scale <- c(min(hex_coords_outer[["x"]]), max(hex_coords_outer[["x"]]))
  y_scale <- c(min(hex_coords_outer[["y"]]), max(hex_coords_outer[["y"]]))

  grid::pushViewport(grid::viewport(xscale = x_scale, yscale = y_scale))

  hex_grob_outer <- grid::polygonGrob(
    hex_coords_outer[["x"]],
    hex_coords_outer[["y"]],
    gp = grid::gpar(lwd = 0, fill = border_col),
    default.units = "native"
  )
  grid::pushViewport(
    grid::viewport(
      xscale = x_scale,
      yscale = y_scale,
      clip = hex_grob_outer
    )
  )

  grid::grid.draw(hex_grob_outer)

  grid::grid.polygon(
    x = hex_coords_inner[["x"]],
    y = hex_coords_inner[["y"]],
    default.units = "native",
    gp = grid::gpar(lwd = 0, fill = bg_col)
  )

}

#' Get Coordinates of Hexagon Vertices
#' @param diameter Numeric.
#' @returns A list of two numeric vectors that represent points of a hexagon.
#'     The elements are named 'x' and 'y'.
#' @noRd
.get_hex_coords <- function(diameter = 1) {

  radius <- diameter / 2
  centre <- 0.5
  angles <- seq(0, 2 * pi, length.out = 7)

  list(
    x = centre + radius * cos(angles - pi / 6),
    y = centre + radius * sin(angles - pi / 6)
  )

}

#' Add Text
#'
#' Overlay text on the hexagon. Text outside the hexagon will be clipped. Should
#' be called after [open_device] and [add_hex], in that order. Call this function
#' separately for each text item that you want to add.
#'
#' @param text_string Character. Text to display. `NULL` (or an empty string) if
#'    you don't want to place text.
#' @param text_x Numeric. Text location x-axis.
#' @param text_y Numeric. Text location y-axis.
#' @param text_angle Numeric. Rotation of text string in degrees. Positive
#'     values will rotate anticlockwise by the given angle.
#' @param text_size Numeric. Text point-size.
#' @param text_col Character. Text colour. A named R colour or hexadecimal code.
#' @param text_family Character. Name of a font family available on your system.
#' @param text_face Character. Font face for the text.
#'
#' @details
#'
#' ## Coordinates
#'
#' Coordinates should be provided within the x- and y-axis ranges, which are
#' both from 0 to 1, giving the centre as x = 0.5 and y = 0.5.
#'
#' ## Colours
#'
#' Named colour values must be listed in [grDevices::colours()]. Hexadecimal
#' colour values must be provided with length 6 or 8 and must begin with an
#' octothorpe (`#`).
#'
#' @returns `NULL`. Adds to an existing graphics device.
#'
#' @export
#'
#' @examples
#' temp_path <- tempfile(fileext = ".png")
#' open_device(temp_path)
#' add_hex()
#' image_path <- system.file("img", "Rlogo.png", package = "png")
#' image_png <- png::readPNG(image_path)
#' add_image(image_png)
#' add_text()
#' close_device()
add_text <- function(
    text_string = "example",
    text_x = 0.5,
    text_y = 0.3,
    text_angle = 0,
    text_size = 20,
    text_col = "black",
    text_family = "sans",
    text_face = c("plain", "bold", "italic", "bold.italic")
) {

  if (!inherits(text_string, "character")) {
    stop("Argument 'text_string' must be a character string.")
  }

  if (!inherits(text_x, "numeric") | !inherits(text_y, "numeric")) {
    stop("Arguments 'text_x' and 'text_y' must be numeric values.")
  }

  if (!inherits(text_size, "numeric")) {
    stop("Argument 'text_size' must be a numeric value.")
  }

  if (!inherits(text_size, "numeric")) {
    stop("Argument 'text_size' must be a numeric value.")
  }

  if (!(text_col %in% grDevices::colours() | grepl("^#[0-9A-Fa-f]{6}$", text_col))) {
    stop("Argument 'text_col' must a named R colour or a hex code.")
  }

  if (!inherits(text_family, "character")) {
    stop(
      "Argument 'text_family' must be a character string
      representing an available font family."
    )
  }

  if (!inherits(text_face, "character")) {
    stop(
      "Argument 'text_face' must be one of the following character strings:
      'plain', 'bold', 'italic', 'bold-italic'."
    )
  }

  text_face <- match.arg(text_face)

  grid::pushViewport(grid::viewport(x = text_x, y = text_y))
  grid::grid.text(
    text_string,
    gp = grid::gpar(
      col = text_col,
      fontsize = text_size,
      fontfamily = text_family,
      fontface = text_face
    ),
    vp = grid::viewport(angle = text_angle)
  )
  grid::popViewport()


}

#' Add an Image
#'
#' Overlay an image on the hexagon. Image content outside the hexagon will be
#' clipped. Should be called after [open_device] and [add_hex], in that order.
#' Call this function separately for each image you want to add.
#'
#' @param image_object Array. A PNG file read in by the user. `NULL` for no
#'     image.
#' @param image_x Numeric. Image location x-axis.
#' @param image_y Numeric. Image location y-axis.
#' @param image_angle Numeric. Text rotation in degrees.
#' @param image_width Numeric. Image width.
#'
#' @details
#'
#' ## Coordinates
#'
#' Coordinates should be provided within the x- and y-axis ranges, which are
#' both from 0 to 1, giving the centre as x = 0.5 and y = 0.5.
#'
#' @returns `NULL`. Adds to an existing graphics device.
#'
#' @export
#'
#' @examples
#' temp_path <- tempfile(fileext = ".png")
#' open_device(temp_path)
#' add_hex()
#' image_path <- system.file("img", "Rlogo.png", package = "png")
#' image_png <- png::readPNG(image_path)
#' add_image(image_png)
#' add_text()
#' close_device()
add_image <- function(
    image_object,
    image_x = 0.5,
    image_y = 0.7,
    image_angle = 0,
    image_width = 0.4
) {

  if (!inherits(image_x, "numeric") | !inherits(image_y, "numeric")) {
    stop("Arguments 'image_x' and 'image_y' must be numeric values.")
  }

  if (!inherits(image_angle, "numeric")) {
    stop("Argument 'image_angle' must be a numeric value.")
  }

  if (!inherits(image_width, "numeric")) {
    stop("Argument 'image_width' must be a numeric value.")
  }

  grid::pushViewport(
    grid::viewport(
      x = image_x,
      y = image_y,
      width = image_width
    )
  )
  grid::grid.raster(
    image_object,
    vp = grid::viewport(angle = image_angle)
  )
  grid::popViewport()

}

#' Close the Device
#'
#' Clip to the area of the outer hexagon and close the PNG plot device, which
#' writes to the `file_path` specified in [open_device].
#'
#' @returns `NULL`. Adds to an existing graphics device.
#'
#' @export
#'
#' @examples
#' temp_path <- tempfile(fileext = ".png")
#' open_device(temp_path)
#' add_hex()
#' image_path <- system.file("img", "Rlogo.png", package = "png")
#' image_png <- png::readPNG(image_path)
#' add_image(image_png)
#' add_text()
#' close_device()
close_device <- function() {
  grid::popViewport(0)  # clip to outer hexagon
  grDevices::dev.off()
}
