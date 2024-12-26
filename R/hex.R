#' Create a Hex
#'
#' @param filename Character. Full file path to a .png where the output PNG will
#'     be saved. The containing directory must already exist.
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
    filename,
    border_width = 0.95,
    border_col = "black",
    bg_col = "grey",
    text_string = "hexbase",
    text_col = "black",
    text_font = "mono",
    text_x = 0,
    text_y = 0,
    text_size = 2,
    text_rotate = 0
) {

  if (tools::file_ext(filename) != "png") {
    stop(
      "Argument 'filename' must end with '.png'.",
      call. = FALSE
    )
  }

  if (!dir.exists(dirname(filename))) {
    stop(
      "Argument 'filename' must resolve to an existing directory.",
      call. = FALSE
    )
  }

  if (!check_is_col(border_col) | !check_is_col(bg_col) | !check_is_col(text_col)) {
    stop(
      "Arguments 'border_col', 'bg_col', 'text_col' must be named or hexadecimal colours.",
      call. = FALSE
    )
  }

  if (
    !inherits(border_col, "character") |
    !inherits(bg_col, "character") |
    !inherits(text_string, "character") |
    !inherits(text_font, "character") |
    !inherits(text_col, "character")
  ) {
    stop(
      "Arguments 'border_col', 'bg_col', 'text_string', 'text_font' an 'text_col' must be character strings.",
      call. = FALSE
    )
  }

  if (!check_is_col(bg_col) | !check_is_col(border_col) | !check_is_col(text_col)) {
    stop(
      "Arguments 'bg_col', 'border_col', 'text_col' must be named or hexadecimal colours.",
      call. = FALSE
    )
  }

  if (
    !is.numeric(border_width) |
    !is.numeric(text_x) |
    !is.numeric(text_y) |
    !is.numeric(text_size) |
    !is.numeric(text_rotate)
  ) {
    stop(
      "Arguments 'border_width', 'text_x', 'text_y', 'text_size' and 'text_rotate' must be numeric.",
      call. = FALSE
    )
  }

  if (!(border_width >= 0 & border_width <= 1)) {
    stop(
      "Argument 'border_width' must be between 0 and 1.",
      call. = FALSE
    )
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

  .add_text(
    text_string,
    text_col,
    text_font,
    text_x,
    text_y,
    text_size,
    text_rotate
  )

  grDevices::dev.off()

}

.draw_hex_base <- function(border_col) {

  d <- 1
  a <- d / 4
  b <- sqrt(3) * a

  coords <- data.frame(
    x = c(-b,      0,  b, b,     0, -b),
    y = c(-a, -2 * a, -a, a, 2 * a,  a)
  )

  graphics::par(mar = rep(0, 4))  # no plot margin, resets with dev.o

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

  a <- border_width / 4  # i.e. diameter / 4
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

.add_text <- function(
    text_string,
    text_col,
    text_font,
    text_x,
    text_y,
    text_size,
    text_rotate
) {

  graphics::text(
    x = text_x,
    y = text_y,
    labels = text_string,
    cex = text_size,
    col = text_col,
    family = text_font,
    srt = text_rotate
  )

}

check_is_col <- function(col) {
  is_col <- col %in% grDevices::colors() |
    grepl("^#[0-9A-Fa-f]{6}$", col) |
    grepl("^#[0-9A-Fa-f]{8}$", col)
}
