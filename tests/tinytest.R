# Throttle magick CPU threads if R CMD check (for CRAN)
# See https://github.com/vincentarelbundock/tinysnapshot?tab=readme-ov-file#cran-multithreading-warning
if (any(grepl("_R_CHECK", names(Sys.getenv()), fixed = TRUE))) {
  if (requireNamespace("magick", quietly = TRUE)) {
    library(magick)
    magick:::magick_threads(1)
  }
}

if (requireNamespace("tinytest", quietly = TRUE)) {
  tinytest::test_package("gex")
}
