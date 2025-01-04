# if (tools::file_ext(filename) != "png") {
#   stop(
#     "Argument 'filename' must end with '.png'.",
#     call. = FALSE
#   )
# }
#
# if (!dir.exists(dirname(filename))) {
#   stop(
#     "Argument 'filename' must resolve to an existing directory.",
#     call. = FALSE
#   )
# }
#
# if (!check_is_col(border_col) | !check_is_col(bg_col) | !check_is_col(text_col)) {
#   stop(
#     "Arguments 'border_col', 'bg_col', 'text_col' must be named or hexadecimal colours.",
#     call. = FALSE
#   )
# }
#
# if (
#   !inherits(border_col, "character") |
#   !inherits(bg_col, "character") |
#   !inherits(text_string, "character") |
#   !inherits(text_font, "character") |
#   !inherits(text_col, "character")
# ) {
#   stop(
#     "Arguments 'border_col', 'bg_col', 'text_string', 'text_font' an 'text_col' must be character strings.",
#     call. = FALSE
#   )
# }
#
# if (!check_is_col(bg_col) | !check_is_col(border_col) | !check_is_col(text_col)) {
#   stop(
#     "Arguments 'bg_col', 'border_col', 'text_col' must be named or hexadecimal colours.",
#     call. = FALSE
#   )
# }
#
# if (
#   !is.numeric(border_width) |
#   !is.numeric(text_x) |
#   !is.numeric(text_y) |
#   !is.numeric(text_size) |
#   !is.numeric(text_rotate)
# ) {
#   stop(
#     "Arguments 'border_width', 'text_x', 'text_y', 'text_size' and 'text_rotate' must be numeric.",
#     call. = FALSE
#   )
# }
#
# if (!(border_width >= 0 & border_width <= 1)) {
#   stop(
#     "Argument 'border_width' must be between 0 and 1.",
#     call. = FALSE
#   )
# }
#
# check_is_col <- function(col) {
#   is_col <- col %in% grDevices::colors() |
#     grepl("^#[0-9A-Fa-f]{6}$", col) |
#     grepl("^#[0-9A-Fa-f]{8}$", col)
# }
