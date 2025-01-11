
# {hexbase} <a href="https://github.com/matt-dray/hexbase"><img src="man/figures/logo.png" align="right" height="139" alt='A hexagon sticker logo for the package hexbase. It has a darkblue hexagon with a grey border. There is an a white hexagon with a thick grey border inside. In the centre is darkblue text saying hexbase.'/></a>

<!-- badges: start -->
[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![R-CMD-check](https://github.com/matt-dray/hexbase/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/matt-dray/hexbase/actions/workflows/R-CMD-check.yaml)
[![test-coverage](https://github.com/matt-dray/hexbase/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/matt-dray/hexbase/actions/workflows/test-coverage.yaml)
<!-- badges: end -->

## What

A dependency-free R package to help create simple hexagon-shaped sticker logos.

The package's only function, `make_hex()`, is intentionally limited and opinionated. For now, you can only:

* adjust the width and colour of the border
* colour the background
* add text and adjust its location, rotation, size, colour and font family
* provide an image from file and adjust its location, size and rotation
* save to PNG with the dimensions of [the Stickers Standard](https://sticker.how/#type-hexagon)

## Install

You can install {hexbase} [from GitHub](https://github.com/matt-dray/hexbase) like:

``` r
install.packages("remotes")  # if not yet installed
remotes::install_github("matt-dray/hexbase")
```

## Example

The hex logo for {hexbase} was made using {hexbase} (so meta).
You can see it at the top of this README.
It's composed of two main elements: an image (a grey-bordered white hexagon) read from a PNG file overlaid with some text ('hexbase').

You can make this hex using the `make_hex()` function.
The output is saved to a PNG at the `file_path` location.

``` r
# Create temporary PNG file where hex will be written
temp_path <- tempfile(fileext = ".png")

# Read an image file to use as an element in the hex
image_path <- system.file("images", "hexagon.png", package = "hexbase")
image_png <- png::readPNG(image_path)

# Generate the hex with border, background, text and image elements
hexbase::make_hex(
  file_path = temp_path,
  file_open = TRUE,  # open the file after being written
  border_col = "grey",  # named colour or hexadecimal
  bg_col = "darkblue",
  txt_string = "hex\nbase",  # includes linebreak
  txt_x = 0.5,
  txt_y = 0.5,
  txt_angle = 30,
  txt_size = 18,
  txt_col = "darkblue",
  txt_font = "Routed Gothic Wide",  # downloaded via webonastick.com/fonts/routed-gothic/
  img_object = image_png,
  img_x = 0.5,
  img_y = 0.5,
  img_width = 0.7,
  img_height = 0.7,
  img_angle = 30
)
```

## Related

For more established hex-making tools with R, try:

* [{hexSticker}](https://github.com/GuangchuangYu/hexSticker) by Guangchuang Yu
* [{bunny}](https://github.com/dmi3kno/bunny) by Dmytro Perepolkin
* the [hexmake](https://connect.thinkr.fr/hexmake/) Shiny app by Colin Fay
