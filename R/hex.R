#' Create a Hex
#'
#' @param filename Character. Full file path to a .png where the output PNG will
#'     be saved. The containing directory must exist.
#' @param bg_col Character. Named R colour or hex code for the interior
#'     background.
#' @param border_col Character. Named R colour or hex code for the border around
#'     the hex.x
#' @param border_width Numeric. Thickness of the border, expressed as a ratio
#'     of the 'inner' hexagon to 'outer' hexagon (must always be less than 1).
#' @param text Character. Text to add to the hex.
#' @param text_x Numeric. The x-axis position where the text will be placed.
#'     Defaults to 0 (centre).
#' @param text_y Numeric. The y-axis position where the text will be placed.
#'     Defaults to 0 (centre).
#' @param text_size Numeric. Size of the text in pixels.
#'
#' @details
#' Plots a hexagon to the dimensions of the sticker standard given by
#' <github.com/terinjokes/StickersStandard>: 4.39 cm wide by 5.08 cm high.
#'
#' @return A new plot.
#'
#' @export
#'
#' @examples \dontrun{make_hex()}
make_hex <- function(
    filename,
    bg_col = "white",
    border_col = "#000000",
    border_width = 0.95,
    text = "hexbase",
    text_x = 0,
    text_y = 0,
    text_size = 2
) {

  if (grepl(filename, ".png$")) {
    stop("Argument 'filename' must end with '.png'.")
  }

  if (!dir.exists(dirname(filename))) {
    stop("Argument 'filename' must resolve to an existing directory.")
  }

  grDevices::png(
    filename = filename,
    width = 4.39,
    height = 5.08,
    units = "cm",
    res = 1200,
    bg = "transparent"
  )

  .draw_hex_base(border_col)
  .draw_hex_overlay(border_width, bg_col)
  .add_text(text, text_x, text_y, text_size)

  grDevices::dev.off()

}

.draw_hex_base <- function(border_col) {

  if (
    !(border_col %in% grDevices::colours() | grepl("#\\d{3,6}", border_col))
  ) {
    stop("Argument 'border_col' must a named R colour or a hex code.")
  }

  d <- 1
  a <- d / 4
  b <- sqrt(3) * a

  coords <- data.frame(
    x = c(-b,      0,  b, b,     0, -b),
    y = c(-a, -2 * a, -a, a, 2 * a,  a)
  )

  # grDevices::dev.new(width = 4.39, height = 5.08, unit = "cm")

  graphics::par(mar = rep(0, 4))

  graphics::plot(
    coords[["x"]],
    coords[["y"]],
    xaxs = "i",    # edge-edge on x-axis
    yaxs = "i",    # edge-edge on y-axis
    axes = FALSE,  # no axes
    ann = FALSE,   # no annotations
    pch = NA,      # no points
    asp = 1        # lock 1:1 aspect ratio
  )

  graphics::polygon(
    coords[["x"]],
    coords[["y"]],
    col = border_col,
    border = border_col
  )

}

.draw_hex_overlay <- function(border_width, bg_col) {

  if (!inherits(border_width, "numeric") || border_width >= 1) {
    stop("Argument 'border_width' must be a numeric value below 1.")
  }

  if (!(bg_col %in% grDevices::colours() | grepl("#\\d{3,6}", bg_col))) {
    stop("Argument 'border_col' must a named R colour or a hex code.")
  }

  a <- border_width / 4  # diameter / 4
  b <- sqrt(3) * a

  coords <- list(
    x = c(-b,      0,  b, b,     0, -b),
    y = c(-a, -2 * a, -a, a, 2 * a,  a)
  )

  graphics::polygon(
    coords[["x"]],
    coords[["y"]],
    col = bg_col,
    border = bg_col
  )

}

.add_text <- function(text = "hexbase", text_x, text_y, text_size) {

  if (!inherits(text, "character")) {
    stop("Argument 'text' must be a character string.")
  }

  if (!inherits(text_x, "numeric") | !inherits(text_y, "numeric")) {
    stop("Arguments 'x_pos' and 'y_pos' must be numeric values")
  }

  if (!inherits(text_size, "numeric")) {
    stop("Argument 'size' must be a numeric value.")
  }

  graphics::text(
    x = text_x,
    y = text_y,
    labels = text,
    cex = text_size
  )

}
