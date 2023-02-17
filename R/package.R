#' @import httr
#' @importFrom magrittr %>%
NULL

base_url <- httr::parse_url("https://cdx.epa.gov")


# create_virtual_env <- function(){
#   if(nchar(unname(Sys.which("python"))) == 0){
#     message("a version of python was not found on your system")
#   }else{
#     message("creating virtual environment")
#     reticulate::virtualenv_create("r-reticulate")
#     message("activating virtual environment")
#     reticulate::use_virtualenv("r-reticulate", required = TRUE)
#   }
# }

check_python_deps <- function() {
  # if (!reticulate::py_available()){
  #   message("A version of python was not found on your system, downloadign Python")
  #   install_python("3.10:latest")
  #   message("Python finished installing")
  if (!reticulate::py_module_available("numpy")) {
    message("some python dependencies were not found, installing missing packages")
    # reticulate::virtualenv_install("r-reticulate", "numpy")
    py_install("numpy")
    numpy <- import("numpy")
  }else {
    message("you have all of the dependencies, you are good to go")
    # message(Sys.which("python"))
  }

}

# wqx tools implementation in python
wqx <- NULL


.onLoad <- function(libname, pkgname) {
  # create_virtual_env()
  python_path <- system.file("python", package = "wqxWeb")
  wqx <<- reticulate::import_from_path(
    "wqxtools",
    path = python_path,
    delay_load = TRUE
  )
}
