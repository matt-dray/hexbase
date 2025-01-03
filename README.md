
# {hexbase}

<!-- badges: start -->
[![Project Status: Concept – Minimal or no implementation has been done yet, or the repository is only intended to be a limited example, demo, or proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)
[![R-CMD-check](https://github.com/matt-dray/hexbase/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/matt-dray/hexbase/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

A (limited (concept (base R only))) R package to create very simple hex logos.

If you want a more complete hex-making experience, you should try:

* [{bunny}](https://github.com/dmi3kno/bunny) by Dmytro Perepolkin
* [{hexSticker}](https://github.com/GuangchuangYu/hexSticker) by Guangchuang Yu
* [hexmake](https://connect.thinkr.fr/hexmake/) Shiny app by Colin Fay

You can install {hexbase} from GitHub like:

``` r
install.packages("remotes")  # if not yet installed
remotes::install_github("matt-dray/hexbase")
```

It doesn't do much yet. The function `make_hex()` will lay down a hexagon with another smaller one on top. The exposed region between the two creates a border. Some text can be overlaid. It saves out to PNG. The background is transparent.

``` r
hexbase::make_hex(
  filename = "~/Documents/hexbase.png",
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
)
```

<img src="man/figures/hexbase.png" width=200>
