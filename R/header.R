# prep a header to be used by all api calls

wqx_header <- function(method, uri, user_id=NULL, private_key=NULL, ...) {
  if (is.null(user_id)) {
    user_id <- get_user_id(...)
  }

  if (is.null(private_key)) {
    private_key <- get_private_key(...)
  }

  time_stamp <- format(lubridate::now("UTC"), "%m/%d/%Y %I:%M:%S %p")
  signature_str <- paste0(user_id, time_stamp, uri, toupper(method))
  signature <- digest::hmac(key = private_key, object = signature, algo = "sha256")

  c(
    "X-UserID" = user_id,
    "X-Stamp" = time_stamp,
    "X-Signature" = signature
  )
}

get_user_id <- function(config_file) {
  tryCatch(config::get("user_id", file = config_file),
           error = function(e) stop("Could not find a config file", call. = FALSE))
}

get_private_key <- function(config_file) {
  tryCatch(config::get("private_key", file = config_file),
           error = function(e) stop("Could not find a config file", call. = FALSE))
}

