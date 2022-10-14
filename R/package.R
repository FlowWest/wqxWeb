#' @import httr
#' @importFrom magrittr %>%
NULL

base_url <- httr::parse_url("https://cdx.epa.gov")

# wqx tools implementation in python
wqx <- NULL

.onLoad <- function(libname, pkgname) {
  python_path <- system.file("python", package = "wqxWeb")
  wqx <<- reticulate::import_from_path("wqxtools", path = python_path)
}
