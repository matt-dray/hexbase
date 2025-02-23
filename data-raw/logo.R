# image via:
#   https://pixabay.com/vectors/dragon-lizard-line-art-line-drawing-5660771/
img_tmp <- tempfile(fileext = ".png")
magick::image_read("inst/images/lizard.png") |>
  magick::image_fill("olivedrab1", fuzz = 100, refcolor = "black") |>
  magick::image_write(img_tmp)
img <- png::readPNG(img_tmp)
write_path <- "man/figures/logo.png"
font <- "IBM Plex Serif"
gex::open_device(file_path = write_path)
gex::add_hex(col = "olivedrab4")
for (x in seq(-0.04, 1, 0.2)) {
  for (y in seq(0, 1, 0.16)) {
    gex::add_image(img, x, y, width = 0.3, angle = -30)
  }
}
unlink(img_tmp)
x <- 0.52
y <- 0.56
gex::add_text(
  string = "gex",
  x = x + 0.01,
  y = y - 0.01,
  size = 60,
  col = "olivedrab4",
  family = font,
  face = "italic"
)
gex::add_text(
  string = "gex",
  x = x,
  y = y,
  size = 60,
  col = "olivedrab1",
  family = font,
  face = "italic"
)
gex::add_border(width = 0.05, col = "olivedrab1")
gex::close_device()
system(paste("open", write_path))
