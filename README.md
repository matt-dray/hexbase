
# {hexbase}

<!-- badges: start -->
[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![R-CMD-check](https://github.com/matt-dray/hexbase/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/matt-dray/hexbase/actions/workflows/R-CMD-check.yaml)
[![test-coverage](https://github.com/matt-dray/hexbase/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/matt-dray/hexbase/actions/workflows/test-coverage.yaml)
<!-- badges: end -->

## What

A dependency-free R package to help create simple hexagon-shaped sticker logos.

The package's only function, `make_hex()`, is intentionally limited and opinionated. You can only:

* adjust the width and colour of the border
* colour the background
* add text and adjust its location, rotation, size, colour and font family
* provide an image from file and adjust its location, size and rotation
* save to PNG with the dimensions of [the Stickers Standard](https://sticker.how/#type-hexagon)

For more established hex-making tools, try:

* [{hexSticker}](https://github.com/GuangchuangYu/hexSticker) by Guangchuang Yu
* [{bunny}](https://github.com/dmi3kno/bunny) by Dmytro Perepolkin
* the [hexmake](https://connect.thinkr.fr/hexmake/) Shiny app by Colin Fay

## Install

You can install {hexbase} from GitHub like:

``` r
install.packages("remotes")  # if not yet installed
remotes::install_github("matt-dray/hexbase")
```

## Example

Here's the hex logo for {hexbase}, which was made using {hexbase} (so meta).
It's composed of two main elements: an image (a grey-bordered white hexagon) with some text ('hexbase') overlaid.

<img src="man/figures/hexbase-logo.png" width=200>

Images can't be added directly onto a hex logo. You must read in an image file.
As such, the inner grey-bordered hexagon is itself an image made with {hexbase}.
To create it, you call the `make_hex()` function with minimal inputs. 
It's saved to a `file` location as PNG.

``` r
image_temp <- tempfile("image", fileext = ".png")

hexbase::make_hex(
  file = image_temp,
  open = FALSE,  # don't open a preview
  border_width = 0.8,
  border_col = "grey",
  bg_col = "white",
  text_string = "",  # no text
  img_object = NULL  # no image
)
```

To create the actual hex logo, you supply several more arguments `make_hex()` to help colour and place the various elements.
You can use [the {png} package](https://cran.r-project.org/package=png) to read in the PNG we just created, passing the resulting object to the `img_object` argument.
I've installed [Routed Gothic](https://webonastick.com/fonts/routed-gothic/) on my computer, so I can name it as the `text_font`.

``` r
hex_temp <- tempfile("hex", fileext = ".png")
image_png <- png::readPNG(image_temp)

hexbase::make_hex(
  file = hex_temp,
  open = FALSE,
  border_col = "grey",
  bg_col = "darkblue",
  text_string = "hex\nbase",
  text_x = 0.5,
  text_y = 0.5,
  text_angle = 30,
  text_size = 18,
  text_col = "darkblue",
  text_font = "Routed Gothic Wide",
  img_object = image_png,
  img_x = 0.5,
  img_y = 0.5,
  img_width = 0.7,
  img_height = 0.7,
  img_angle = 30
)
```

The output is saved to PNG with [standard dimensions](https://sticker.how/#type-hexagon)).
Set `open = TRUE` to automatically open the file after it's written.
