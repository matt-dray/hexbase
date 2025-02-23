#' Open a PNG Device with Sticker-Standard Dimensions
#'
#' Begin a PNG plot device with dimensions matching
#' [the Stickers Standard](https://sticker.how/#type-hexagon): 4.39 cm wide by
#' 5.08 cm high (2 by 1.73 inches).
#'
#' @param file_path Character. File path to a .png where the output file will be
#'     saved. The containing directory must already exist.
#' @param resolution Numeric. Resolution of the graphics device in pixels per
#'     inch (ppi). Higher values have better resolution but create larger file
#'     sizes.
#'
#' @details
#'
#' ## Order
#'
#' When building a hex, this function should be called first, followed by
#' [add_hex]. You can then use  [add_text], [add_image] and [add_border] (if
#' desired) and finally [close_device].
#'
#' @returns Nothing. A graphics device is opened.
#'
#' @family hex device handlers
#'
#' @export
#'
#' @examples
#' temp_path <- tempfile(fileext = ".png")
#' open_device(temp_path)
#' add_hex()
#' img_path <- system.file("img", "Rlogo.png", package = "png")
#' img_png <- png::readPNG(img_path)
#' add_image(img_png)
#' add_text()
#' add_border()
#' close_device()
open_device <- function(file_path, resolution = 300) {

  if (tools::file_ext(file_path) != "png") {
    stop("Argument 'file_path' must end with '.png'.", call. = FALSE)
  }

  if (!dir.exists(dirname(file_path))) {
    stop(
      "Argument 'file_path' must resolve to an existing directory.",
      call. = FALSE
    )
  }

  if (!inherits(resolution, "numeric")) {
    stop("Argument 'resolution' must be a numeric value.", call. = FALSE)
  }

  grDevices::png(
    filename = file_path,
    width =  4.39,
    height = 5.08,
    units = "cm",
    res = resolution,
    bg = "transparent"
  )

}

#' Add a Hexagon
#'
#' Add a hexagon 'canvas' to which elements can be added.
#'
#' @param col Character. Named R colour or hexadecimal code for the interior
#'     background.
#'
#' @details
#'
#' ## Order
#'
#' When building a hex, this function should be called after [open_device]. You can then use
#' [add_text], [add_image] and [add_border] (if desired) and finally
#' [close_device].
#'
#' ## Colours
#'
#' Named colour values must be listed in [grDevices::colours()]. Hexadecimal
#' colour values must be provided with length 6 or 8 and must begin with an
#' octothorpe (`#`).
#'
#' @returns `NULL`. Adds to an existing graphics device.
#'
#' @family hex elements
#'
#' @export
#'
#' @examples
#' temp_path <- tempfile(fileext = ".png")
#' open_device(temp_path)
#' add_hex()
#' img_path <- system.file("img", "Rlogo.png", package = "png")
#' img_png <- png::readPNG(img_path)
#' add_image(img_png)
#' add_text()
#' add_border()
#' close_device()
add_hex <- function(col = "grey") {

  if (!(col %in% grDevices::colours() | grepl("^#[0-9A-Fa-f]{6,8}$", col))) {
    stop("Argument 'col' must a named R colour or a hex code.", call. = FALSE)
  }

  hex_coords_outer <- .get_hex_coords(diameter = 1)

  x_scale <- c(min(hex_coords_outer[["x"]]), max(hex_coords_outer[["x"]]))
  y_scale <- c(min(hex_coords_outer[["y"]]), max(hex_coords_outer[["y"]]))

  grid::pushViewport(grid::viewport(xscale = x_scale, yscale = y_scale))

  hex_grob_outer <- grid::polygonGrob(
    hex_coords_outer[["x"]],
    hex_coords_outer[["y"]],
    gp = grid::gpar(lwd = 0, fill = col),
    default.units = "native"
  )

  # Remove anything outside the outer hex boundary when popped
  grid::pushViewport(
    grid::viewport(
      xscale = x_scale,
      yscale = y_scale,
      clip = hex_grob_outer
    )
  )

  grid::grid.draw(hex_grob_outer)

}

#' Add Text to the Hexagon
#'
#' Overlay text on the hexagon. Call this function separately for each string
#' you want to add.
#'
#' @param string Character. Text to display. `NULL` (or an empty string) if
#'    you don't want to place text.
#' @param x Numeric. Text location on the hexagon's x-axis.
#' @param y Numeric. Text location on the hexagon's y-axis.
#' @param angle Numeric. Rotation of text string in degrees. Positive
#'     values will rotate anticlockwise by the given angle.
#' @param size Numeric. Text point-size.
#' @param col Character. Text colour. A named R colour or hexadecimal code.
#' @param family Character. Name of a font family available on your system.
#' @param face Character. Font face for the text.
#'
#' @details
#'
#' ## Order
#'
#' When building a hex, this function should be called after [open_device] and
#' [add_hex]. You can then use further calls to [add_text], [add_image] and
#' [add_border] (if desired) and finally [close_device].
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
#' @family hex content adders
#'
#' @export
#'
#' @examples
#' temp_path <- tempfile(fileext = ".png")
#' open_device(temp_path)
#' add_hex()
#' img_path <- system.file("img", "Rlogo.png", package = "png")
#' img_png <- png::readPNG(img_path)
#' add_image(img_png)
#' add_text()
#' add_border()
#' close_device()
add_text <- function(
    string = "example",
    x = 0.5,
    y = 0.4,
    angle = 0,
    size = 20,
    col = "black",
    family = "sans",
    face = c("plain", "bold", "italic", "bold.italic")
) {

  if (!inherits(string, "character")) {
    stop("Argument 'string' must be a character string.", call. = FALSE)
  }

  if (!inherits(x, "numeric") | !inherits(y, "numeric")) {
    stop("Arguments 'x' and 'y' must be numeric values.", call. = FALSE)
  }

  if (!inherits(angle, "numeric")) {
    stop("Argument 'angle' must be a numeric value.", call. = FALSE)
  }

  if (!inherits(size, "numeric")) {
    stop("Argument 'size' must be a numeric value.", call. = FALSE)
  }

  if (!(col %in% grDevices::colours() | grepl("^#[0-9A-Fa-f]{6,8}$", col))) {
    stop("Argument 'col' must a named R colour or a hex code.", call. = FALSE)
  }

  if (!inherits(family, "character")) {
    stop(
      "Argument 'family' must be a character string representing ",
      "an available font family.",
      call. = FALSE
    )
  }

  if (!inherits(face, "character")) {
    stop(
      "Argument 'face' must be one of the following character strings: ",
      "'plain', 'bold', 'italic', 'bold.italic'.",
      call. = FALSE
    )
  }

  face <- match.arg(face)

  grid::pushViewport(grid::viewport(x = x, y = y))
  grid::grid.text(
    string,
    gp = grid::gpar(
      col = col,
      fontsize = size,
      fontfamily = family,
      fontface = face
    ),
    vp = grid::viewport(angle = angle)
  )
  grid::popViewport()


}

#' Add an Image to the Hexagon
#'
#' Overlay an image on the hexagon. Call this function separately for each image
#' you want to add.
#'
#' @param img Array. A PNG or JPEG file read in by the user, most likely
#'     using packages 'png' or 'jpeg'.
#' @param x Numeric. Image location on the hexagon's x-axis.
#' @param y Numeric. Image location on the hexagon's y-axis.
#' @param angle Numeric. Text rotation in degrees.
#' @param width Numeric. Image width.
#'
#' @details
#'
#'  ## Order
#'
#' When building a hex, this function should be called after [open_device] and
#' [add_hex]. You can then use further calls to [add_image], [add_text] and
#' [add_border] (if desired) and finally [close_device].
#'
#' ## Coordinates
#'
#' Coordinates should be provided within the x- and y-axis ranges, which are
#' both from 0 to 1, giving the centre as x = 0.5 and y = 0.5.
#'
#' @returns `NULL`. Adds to an existing graphics device.
#'
#' @family hex content adders
#'
#' @export
#'
#' @examples
#' temp_path <- tempfile(fileext = ".png")
#' open_device(temp_path)
#' add_hex()
#' img_path <- system.file("img", "Rlogo.png", package = "png")
#' img_png <- png::readPNG(img_path)
#' add_image(img_png)
#' add_text()
#' add_border()
#' close_device()
add_image <- function(
    img,
    x = 0.5,
    y = 0.7,
    angle = 0,
    width = 0.4
) {

  if (!inherits(img, "array")) {
    stop(
      "Argument 'img' must be an array (a png or jpeg file).",
      call. = FALSE)
  }

  if (!inherits(x, "numeric") | !inherits(y, "numeric")) {
    stop("Arguments 'x' and 'y' must be numeric values.", call. = FALSE)
  }

  if (!inherits(angle, "numeric")) {
    stop("Argument 'angle' must be a numeric value.", call. = FALSE)
  }

  if (!inherits(width, "numeric")) {
    stop("Argument 'width' must be a numeric value.", call. = FALSE)
  }

  grid::pushViewport(
    grid::viewport(
      x = x,
      y = y,
      width = width
    )
  )
  grid::grid.raster(
    img,
    vp = grid::viewport(angle = angle)
  )
  grid::popViewport()

}

#' Add a Border to the Edge of the Hexagon
#'
#' Add a border of given thickness and colour to the inner edges of hexagon.
#'
#' @param width Numeric. Thickness of the border, expressed as the
#'     inverse ratio of the interior of the hex to the full extent of the hex
#'     (must be between `0` and `1`).
#' @param col Character. Named R colour or hexadecimal code for the
#'     border around the hex.
#'
#' @details
#'
#' ## Order
#'
#' When building a hex, this function should be called after [open_device],
#' [add_hex] and any calls to [add_text] and [add_image] (in that order), and
#' before [close_device].
#'
#' ## Colours
#'
#' Named colour values must be listed in [grDevices::colours()]. Hexadecimal
#' colour values must be provided with length 6 or 8 and must begin with an
#' octothorpe (`#`).
#'
#' @returns `NULL`. Adds to an existing graphics device.
#'
#' @family hex elements
#'
#' @export
#'
#' @examples
#' temp_path <- tempfile(fileext = ".png")
#' open_device(temp_path)
#' add_hex()
#' img_path <- system.file("img", "Rlogo.png", package = "png")
#' img_png <- png::readPNG(img_path)
#' add_image(img_png)
#' add_text()
#' add_border()
#' close_device()
add_border <- function(
    width = 0.05,
    col = "black"
) {

  if (!inherits(width, "numeric") || (width < 0 | width > 1)) {
    stop(
      "Argument 'width' must be a numeric value between 0 and 1.",
      call. = FALSE
    )
  }

  if (!(col %in% grDevices::colours() | grepl("^#[0-9A-Fa-f]{6,8}$", col))) {
    stop("Argument 'col' must a named R colour or a hex code.", call. = FALSE)
  }

  hex_diameter_inner <- 1 - width

  hex_coords_outer <- .get_hex_coords(diameter = 1)
  hex_coords_inner <- .get_hex_coords(diameter = hex_diameter_inner)

  x_scale <- c(min(hex_coords_outer[["x"]]), max(hex_coords_outer[["x"]]))
  y_scale <- c(min(hex_coords_outer[["y"]]), max(hex_coords_outer[["y"]]))

  grid::pushViewport(grid::viewport(xscale = x_scale, yscale = y_scale))

  hex_grob_outer <- grid::polygonGrob(
    hex_coords_outer[["x"]],
    hex_coords_outer[["y"]],
    default.units = "native"
  )

  # Inner hexagon will be clipped from outer, leaving a border polygon
  hex_grob_inner <- grid::polygonGrob(
    hex_coords_inner[["x"]],
    hex_coords_inner[["y"]],
    default.units = "native"
  )

  border_grob <- gridGeometry::polyclipGrob(
    A = hex_grob_outer,
    B = hex_grob_inner,
    op = "minus",  # removes inner from outer
    gp = grid::gpar(lwd = 0, fill = col)
  )

  grid::grid.draw(border_grob)

}


#' Close the Device and Write to File
#'
#' Clip to the area of the outer hexagon and shut down the PNG plot device,
#' which writes to the `file_path` specified in [open_device].
#'
#' @details
#'
#' ## Order
#'
#' When building a hex, this function should be called at the end, after
#' [open_device], [add_hex] and any calls to [add_text], [add_image] and
#' [add_border].
#'
#' @returns Named numeric. The device name and number where the hex has been
#'     written.
#'
#' @family hex device handlers
#'
#' @export
#'
#' @examples
#' temp_path <- tempfile(fileext = ".png")
#' open_device(temp_path)
#' add_hex()
#' img_path <- system.file("img", "Rlogo.png", package = "png")
#' img_png <- png::readPNG(img_path)
#' add_image(img_png)
#' add_text()
#' add_border()
#' close_device()
close_device <- function() {
  grid::popViewport(0)  # close all open viewports, clip to outer hexagon
  grDevices::dev.off()
}

#' Get Coordinates of Hexagon Vertices
#' @param diameter Numeric.
#' @returns A list of two numeric vectors that represent vertex coordinates of a
#'     regular hexagon (point-side down) within a unit-1 square. The elements
#'     are named 'x' and 'y'.
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
