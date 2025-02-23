library("tinytest")
using("tinysnapshot")
options("tinysnapshot_device" = "svglite")

# Open device -------------------------------------------------------------

temp_path <- tempfile(fileext = ".png")
dev_open <- open_device(temp_path)
expect_null(dev_open)
dev_close <- dev.off()
expect_true(is.numeric(dev_close))

err_arg <- 'argument "file_path" is missing, with no default'
expect_error(open_device(), err_arg)

err_png <- "Argument 'file_path' must end with '\\.png'\\."
expect_error(open_device("x"), err_png)
expect_error(open_device("x/y"), err_png)
expect_error(open_device("x/y.pdf"), err_png)

err_dir <- "Argument 'file_path' must resolve to an existing directory\\."
expect_error(open_device("x/y/z.png", err_dir))

err_res <- "Argument 'resolution' must be a numeric value\\."
expect_error(open_device(temp_path, resolution = "x"), err_res)

unlink(temp_path)

# Add hex -----------------------------------------------------------------

hex <- add_hex()
expect_null(hex)

tinysnapshot::expect_snapshot_plot(
  function() add_hex(),
  label = "add-hex"
)

tinysnapshot::expect_snapshot_plot(
  function() add_hex(col = "red"),
  label = "add-hex-args"
)

temp_path <- tempfile(fileext = ".png")
open_device(temp_path)
add_hex()
dev_close <- dev.off()
expect_true(is.numeric(dev_close))
unlink(temp_path)

err_col <- "Argument 'col' must a named R colour or a hex code\\."
expect_error(add_hex(1), err_col)
expect_error(add_hex("x"), err_col)
expect_error(add_hex("#0011"), err_col)
expect_error(add_hex("#0011223344"), err_col)
expect_error(add_hex("001122"), err_col)

# Add text ----------------------------------------------------------------

txt <- add_text()
expect_null(txt)

tinysnapshot::expect_snapshot_plot(
  function() add_text(),
  label = "add-text"
)

tinysnapshot::expect_snapshot_plot(
  function() {
    add_text(
      string = "test",
      x = 0.4,
      y = 0.6,
      angle = 30,
      size = 25,
      col = "red",
      family = "mono",
      face = "bold"
    )
  },
  label = "add-text-args"
)

temp_path <- tempfile(fileext = ".png")
open_device(temp_path)
add_hex()
add_text()
dev_close <- dev.off()
expect_true(is.numeric(dev_close))
unlink(temp_path)

err_str <- "Argument 'string' must be a character string\\."
expect_error(add_text(string = 1), err_str)

err_xy <- "Arguments 'x' and 'y' must be numeric values\\."
expect_error(add_text(x = "x"), err_xy)
expect_error(add_text(y = "y"), err_xy)

err_angle <- "Argument 'angle' must be a numeric value\\."
expect_error(add_text(angle = "x"), err_angle)

err_size <- "Argument 'size' must be a numeric value\\."
expect_error(add_text(size = "x"), err_size)

err_col <- "Argument 'col' must a named R colour or a hex code\\."
expect_error(add_text(col = 1), err_col)
expect_error(add_text(col = "x"), err_col)
expect_error(add_text(col = "#0011"), err_col)
expect_error(add_text(col = "#0011223344"), err_col)
expect_error(add_text(col = "001122"), err_col)

err_fam <- paste(
  "Argument 'family' must be a character string representing",
  "an available font family\\."
)
expect_error(add_text(family = 1), err_fam)
err_fam_2 <- "invalid font type"
expect_error(suppressWarnings(add_text(family = "x")), err_fam_2)

err_face <- paste(
  "Argument 'face' must be one of the following character strings:",
  "'plain', 'bold', 'italic', 'bold\\.italic'\\."
)
expect_error(add_text(face = 1), err_face)
err_face_2 <- '\'arg\' should be one of "plain", "bold", "italic", "bold\\.italic"'
expect_error(add_text(face = "x"), err_face_2)

# Add image ---------------------------------------------------------------

img_path <- system.file("img", "Rlogo.png", package = "png")
img_png <- png::readPNG(img_path)
img <- add_image(img_png)
expect_null(img)

tinysnapshot::expect_snapshot_plot(
  function() add_image(img_png),
  label = "add-image"
)

tinysnapshot::expect_snapshot_plot(
  function() {
    add_image(
      img = img_png,
      x = 0.6,
      y = 0.4,
      angle = 30,
      width = 0.5
    )
  },
  label = "add-image-args"
)

temp_path <- tempfile(fileext = ".png")
open_device(temp_path)
add_hex()
add_image(img_png)
dev_close <- dev.off()
expect_true(is.numeric(dev_close))
unlink(temp_path)

err_img <- "Argument 'img' must be an array \\(a png or jpeg file\\)\\."
expect_error(add_image(img = 1), err_img)
expect_error(add_image(img = "x"), err_img)

err_xy <- "Arguments 'x' and 'y' must be numeric values\\."
expect_error(add_image(img_png, x = "x"), err_xy)
expect_error(add_image(img_png, y = "y"), err_xy)

err_angle <- "Argument 'angle' must be a numeric value\\."
expect_error(add_image(img_png, angle = "x"), err_angle)

err_width <- "Argument 'width' must be a numeric value\\."
expect_error(add_image(img_png, width = "x"), err_width)

# Add border --------------------------------------------------------------

border <- add_border()
expect_null(border)

tinysnapshot::expect_snapshot_plot(
  function() add_border(),
  label = "add-border"
)

tinysnapshot::expect_snapshot_plot(
  function() add_border(width = 0.1, col = "red"),
  label = "add-border-args"
)

temp_path <- tempfile(fileext = ".png")
open_device(temp_path)
add_hex()
add_border()
dev_close <- dev.off()
expect_true(is.numeric(dev_close))
unlink(temp_path)

err_col <- "Argument 'col' must a named R colour or a hex code\\."
expect_error(add_border(col = 1), err_col)
expect_error(add_border(col = "x"), err_col)
expect_error(add_border(col = "#0011"), err_col)
expect_error(add_border(col = "#0011223344"), err_col)
expect_error(add_border(col = "001122"), err_col)

err_width <- "Argument 'width' must be a numeric value between 0 and 1\\."
expect_error(add_border(width = -1), err_width)
expect_error(add_border(width = 2), err_width)
expect_error(add_border(width = "x"), err_width)

# Close device ------------------------------------------------------------

expect_error(close_device("x"), 'unused argument \\("x"\\)')

temp_path <- tempfile(fileext = ".png")
open_device(temp_path)
add_hex()
dev_off <- close_device()
expect_true(is.numeric(dev_close))
unlink(temp_path)
