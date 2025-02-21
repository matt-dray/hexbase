
# {hexbase}

<!-- badges: start -->
[![Project Status: Concept – Minimal or no implementation has been done yet, or the repository is only intended to be a limited example, demo, or proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)
[![R-CMD-check](https://github.com/matt-dray/hexbase/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/matt-dray/hexbase/actions/workflows/R-CMD-check.yaml)
[![test-coverage](https://github.com/matt-dray/hexbase/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/matt-dray/hexbase/actions/workflows/test-coverage.yaml)
<!-- badges: end -->

## What

A dependency-light R package to help create simple hexagon-shaped sticker logos with the dimensions of [the Stickers Standard](https://sticker.how/#type-hexagon).

This a concept package that may be unstable.
It has little testing across systems.
[Please contribute](https://github.com/matt-dray/hexbase/issues) if you have ideas or want to fix my code.

## Install

You can install {hexbase} [from GitHub](https://github.com/matt-dray/hexbase) like:

``` r
install.packages("remotes")  # if not yet installed
remotes::install_github("matt-dray/hexbase")
```

The package uses the inbuilt {grid} graphics system and the sister package [{gridGeometry}](https://cran.r-project.org/package=gridGeometry).
The package may include more 'gridverse' packages in future.
Otherwise it's BYOIAF ('bring your own images and fonts').

## Example

Build a sticker additively with a series of function calls:

1. `open_device()` to set up a PNG graphics device with the dimensions of [the Stickers Standard](https://sticker.how/#type-hexagon).
1. `add_hex()` to add the underlying hexagon 'canvas'.
1. `add_image()` to place an image (run multiple times for more images).
1. `add_text()` to place and style text (run multiple times for more text).
1. `add_border()` to put a border around the edge of the hex (add this after images and text to draw over the top of them).
1. `close_device()` to close the PNG graphics device and save to file.

You can set various text and image properties like position, size, colour and angle.
Text and images will be clipped if they exceed the boundary of the hexagon.

Below is an extremely basic example.
Note how you call each function independently (i.e. no pipes), much like writing base plots.

``` r
# Bring your own image
image_path <- system.file("img", "Rlogo.png", package = "png")
image_png <- png::readPNG(image_path)

# Somewhere to save it
temp_path <- tempfile(fileext = ".png")

# Build up and write the sticker
hexbase::open_device(file_path = temp_path)
hexbase::add_hex(col = "#BEBEBE")
hexbase::add_image(
  img = image_png,
  y = 0.6,
  angle = 20,
  width = 0.5
)
hexbase::add_text(
  string = "example",
  y = 0.35,
  col = "red",
  family = "mono",
  face = "bold.italic"
)
hexbase::add_text(
  string = "visit https://rstats.lol/ ftw",
  x = 0.73, 
  y = 0.17,
  angle = 30, 
  size = 6, 
  col = "blue", 
  family = "serif"
)
hexbase::add_border(col = "grey20")
hexbase::close_device()

# Optionally, open the image for inspection
system(paste("open", temp_path))
```

That creates this absolutely stunning sticker, written to the specified `file_path`:

<img src='man/figures/readme-hex.png' width='300' alt="A grey hexagon with a dark grey border. An R logo is shown just above centre and angled at 30 degrees. Just below centre is the text 'example' in monospace red and bold font. On the lower right edge is the URL 'htps://rstats.lol' in smaller, blue italic serif font.">

Note that you can't rely on plot-window previews when you're developing your sticker (they lie).
You must inspect the generated PNG file instead.

## Related

For more established hex-making tools with R, try:

* [{hexSticker}](https://github.com/GuangchuangYu/hexSticker) by Guangchuang Yu
* [{bunny}](https://github.com/dmi3kno/bunny) by Dmytro Perepolkin
* the [hexmake](https://connect.thinkr.fr/hexmake/) Shiny app by Colin Fay
