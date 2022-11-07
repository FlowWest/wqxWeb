#' @import httr
#' @importFrom magrittr %>%
NULL

base_url <- httr::parse_url("https://cdx.epa.gov")


check_python_deps <- function() {
  if (!reticulate::py_available()) {
    message("a version of python was not found on your system")
  }

  if (!reticulate::py_module_available("numpy")) {
    message("some python dependencies were not found, please run wqxWeb::py_install()")
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
      on_load = function() {
        check_python_deps()
      }
    ))
}
