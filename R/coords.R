.get_hex_coords <- function(d = 1) {
  a <- d / 2
  b <- sqrt(3) * a
  list(
    x = c(-b,      0,  b, b,     0, -b),
    y = c(-a, -2 * a, -a, a, 2 * a,  a)
  )
}

.scale_outer_coords <- function(outer_coord_val) {
  num <- outer_coord_val - min(outer_coord_val)
  dem <- max(outer_coord_val) - min(outer_coord_val)
  num / dem
}

.get_inner_hex_coords_scaled <- function(coords_inner, coords_outer) {

  coords_inner_scaled <- vector("list", length = length(coords_inner))
  names(coords_inner_scaled) <- c("x", "y")

  for (i in seq_along(coords_inner)) {
    coords_inner_scaled[[i]] <- .scale_inner_coords(
      coords_inner[[i]],
      min(coords_outer[[i]]),
      max(coords_outer[[i]])
    )
  }

  coords_inner_scaled

}

.scale_inner_coords <- function(inner_val, outer_val_min, outer_val_max) {
  num <- inner_val - pmin(min(inner_val), outer_val_min)
  dem <- pmax(max(inner_val), outer_val_max) - pmin(min(inner_val), outer_val_min)
  num / dem
}
