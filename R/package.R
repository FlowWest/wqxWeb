#' @import httr
#' @importFrom magrittr %>%
NULL

base_url <- httr::parse_url("https://cdx.epa.gov")

check_python_deps <- function() {
  if (!reticulate::py_module_available("numpy")) {
    message("installing dependency 'numpy'")
    reticulate::py_install("numpy")

  }
  if (!reticulate::py_module_available("requests")) {
    message("installing dependency 'requests'")
    reticulate::py_install("requests")

  }

}

# wqx tools implementation in python
wqx <- NULL

.onLoad <- function(libname, pkgname) {
  python_path <- system.file("python", package = "wqxWeb")
  wqx <<- reticulate::import_from_path(
    "wqxtools",
    path = python_path,
    delay_load = list(
      on_load = check_python_deps()
    )
  )
}
