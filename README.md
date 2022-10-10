
# {hexbase}

<!-- badges: start -->
[![Project Status: Concept – Minimal or no implementation has been done yet, or the repository is only intended to be a limited example, demo, or proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)
<!-- badges: end -->

A (limited (work in prgress (concept (base R only)))) R package to create very simple hex logos.

If you want actual hex-making functionality via R, you should try:

* [{bunny}](https://github.com/dmi3kno/bunny) by Dmytro Perepolkin
* [{hexSticker}](https://github.com/GuangchuangYu/hexSticker) by Guangchuang Yu
* [hexmake](https://connect.thinkr.fr/hexmake/) Shiny app by Colin Fay

You can install {hexbase} from GitHub like:

``` r
# install.packages("remotes")  # if not yet installed
remotes::install_github("matt-dray/hexbase")
library(hexbase)
```

It doesn't do much yet. The function `make_hex()` will lay down a hexagon with another smaller one on top. The exposed region between the two creates a border. Some text can be overlaid. It saves out to PNG. The background is transparent.

``` r
make_hex("~/Desktop/hexbase.png", bg_col = "grey90")
```

<img src="man/figures/hexbase.png" width=200>
