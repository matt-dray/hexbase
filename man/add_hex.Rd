% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hexagon.R
\name{add_hex}
\alias{add_hex}
\title{Add a Hexagon with a Border}
\usage{
add_hex(border_width = 0.05, border_col = "black", bg_col = "grey")
}
\arguments{
\item{border_width}{Numeric. Thickness of the border, expressed as the
inverse ratio of the 'inner' hexagon to 'outer' hexagon (must be between
\code{0} and \code{1}).}

\item{border_col}{Character. Named R colour or hexadecimal code for the
border around the hex.}

\item{bg_col}{Character. Named R colour or hexadecimal code for the interior
background.}
}
\value{
\code{NULL}. Adds to an existing graphics device.
}
\description{
Add two hexagons, where the exposed region between the two creates a border.
}
\details{
\subsection{Colours}{

Named colour values must be listed in \code{\link[grDevices:colors]{grDevices::colours()}}. Hexadecimal
colour values must be provided with length 6 or 8 and must begin with an
octothorpe (\verb{#}).
}
}
\examples{
temp_path <- tempfile(fileext = ".png")
open_device(temp_path)
add_hex()
image_path <- system.file("img", "Rlogo.png", package = "png")
image_png <- png::readPNG(image_path)
add_image(image_png)
add_text()
close_device()
}
