test_that("file is png", {

  file_png <- tempfile(fileext = ".png")
  file_jpeg <- tempfile(fileext = ".jpeg")

  expect_no_error(make_hex(file_png))
  expect_error(make_hex(file_jpeg))

})

test_that("dir exists", {

  real_path <- tempfile(fileext = ".png")
  fake_path <- "x/y/z/hex.png"

  expect_no_error(make_hex(real_path))
  expect_error(make_hex(fake_path))

})

test_that("border width is 0 to 1", {

  file_png <- tempfile(fileext = ".png")

  expect_no_error(make_hex(file_png, border_width = 0))
  expect_no_error(make_hex(file_png, border_width = 1))
  expect_no_error(make_hex(file_png, border_width = 0.5))

  expect_error(make_hex(file_png, border_width = -1))
  expect_error(make_hex(file_png, border_width = 2))

})

test_that("numeric", {

  f <- tempfile(fileext = ".png")

  expect_no_error(make_hex(f, border_width = 0.9))
  expect_error(make_hex(f, border_width = TRUE))
  expect_error(make_hex(f, border_width = "a"))
  expect_error(make_hex(f, border_width = list()))
  expect_error(make_hex(f, border_width = data.frame()))
  expect_error(make_hex(f, border_width = matrix()))

  expect_no_error(make_hex(f, text_x = 0.2))
  expect_error(make_hex(f, text_x = TRUE))
  expect_error(make_hex(f, text_x = "a"))
  expect_error(make_hex(f, text_x = list()))
  expect_error(make_hex(f, text_x = data.frame()))
  expect_error(make_hex(f, text_x = matrix()))

  expect_no_error(make_hex(f, text_y = 0.2))
  expect_error(make_hex(f, text_y = TRUE))
  expect_error(make_hex(f, text_y = "a"))
  expect_error(make_hex(f, text_y = list()))
  expect_error(make_hex(f, text_y = data.frame()))
  expect_error(make_hex(f, text_y = matrix()))

  expect_no_error(make_hex(f, text_size = 1.5))
  expect_error(make_hex(f, text_size = TRUE))
  expect_error(make_hex(f, text_size = "a"))
  expect_error(make_hex(f, text_size = list()))
  expect_error(make_hex(f, text_size = data.frame()))
  expect_error(make_hex(f, text_size = matrix()))

  expect_no_error(make_hex(f, text_y = 45))
  expect_error(make_hex(f, text_rotate = TRUE))
  expect_error(make_hex(f, text_rotate = "a"))
  expect_error(make_hex(f, text_rotate = list()))
  expect_error(make_hex(f, text_rotate = data.frame()))
  expect_error(make_hex(f, text_rotate = matrix()))

})

test_that("character", {

  f <- tempfile(fileext = ".png")

  expect_no_error(make_hex(f, border_col = "red"))
  expect_error(make_hex(f, border_col = TRUE))
  expect_error(make_hex(f, border_col = 1))
  expect_error(make_hex(f, border_col = list()))
  expect_error(make_hex(f, border_col = data.frame()))
  expect_error(make_hex(f, border_col = matrix()))

  expect_no_error(make_hex(f, bg_col = "red"))
  expect_error(make_hex(f, bg_col = TRUE))
  expect_error(make_hex(f, bg_col = 1))
  expect_error(make_hex(f, bg_col = list()))
  expect_error(make_hex(f, bg_col = data.frame()))
  expect_error(make_hex(f, bg_col = matrix()))

  expect_no_error(make_hex(f, text_string = "hexbase"))
  expect_error(make_hex(f, text_string = TRUE))
  expect_error(make_hex(f, text_string = 1))
  expect_error(make_hex(f, text_string = list()))
  expect_error(make_hex(f, text_string = data.frame()))
  expect_error(make_hex(f, text_string = matrix()))

  expect_no_error(make_hex(f, text_font= "serif"))
  expect_error(make_hex(f, text_font = TRUE))
  expect_error(make_hex(f, text_font = 1))
  expect_error(make_hex(f, text_font = list()))
  expect_error(make_hex(f, text_font = data.frame()))
  expect_error(make_hex(f, text_font = matrix()))

  expect_no_error(make_hex(f, text_col = "red"))
  expect_error(make_hex(f, text_col = TRUE))
  expect_error(make_hex(f, text_col = 1))
  expect_error(make_hex(f, text_col = list()))
  expect_error(make_hex(f, text_col = data.frame()))
  expect_error(make_hex(f, text_col = matrix()))

})

test_that("colour", {

  f <- tempfile(fileext = ".png")

  expect_no_error(make_hex(f, bg_col = "red"))
  expect_no_error(make_hex(f, bg_col = "#F00"))
  expect_no_error(make_hex(f, bg_col = "#FF0000"))
  expect_no_error(make_hex(f, bg_col = "#FF0000FF"))
  expect_no_error(make_hex(f, bg_col = "#f00"))
  expect_no_error(make_hex(f, bg_col = "#ff0000"))
  expect_no_error(make_hex(f, bg_col = "#ff0000ff"))
  expect_error(make_hex(f, bg_col = "#F001"))
  expect_error(make_hex(f, bg_col = "#FF00001"))
  expect_error(make_hex(f, bg_col = "#FF0000FF1"))
  expect_error(make_hex(f, bg_col = "a"))
  expect_error(make_hex(f, bg_col = TRUE))
  expect_error(make_hex(f, bg_col = 1))
  expect_error(make_hex(f, bg_col = list()))
  expect_error(make_hex(f, bg_col = data.frame()))
  expect_error(make_hex(f, bg_col = matrix()))

  expect_no_error(make_hex(f, border_col = "red"))
  expect_no_error(make_hex(f, border_col = "#F00"))
  expect_no_error(make_hex(f, border_col = "#FF0000"))
  expect_no_error(make_hex(f, border_col = "#FF0000FF"))
  expect_no_error(make_hex(f, border_col = "#f00"))
  expect_no_error(make_hex(f, border_col = "#ff0000"))
  expect_no_error(make_hex(f, border_col = "#ff0000ff"))
  expect_error(make_hex(f, border_col = "#F001"))
  expect_error(make_hex(f, border_col = "#FF00001"))
  expect_error(make_hex(f, border_col = "#FF0000FF1"))
  expect_error(make_hex(f, border_col = "a"))
  expect_error(make_hex(f, border_col = TRUE))
  expect_error(make_hex(f, border_col = 1))
  expect_error(make_hex(f, border_col = list()))
  expect_error(make_hex(f, border_col = data.frame()))
  expect_error(make_hex(f, border_col = matrix()))

})
