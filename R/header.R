# prep a header to be used by all api calls

#' Prepare Header
#' @description Create the required headers for all API calls
#' @param method the method used for the call "GET", "POST", ...
#' @param uri uri for the API call
#' @param config config file where userID and private key are set. See details section
#' for more information
#' @return string vector of headers
#' @export
wqx_header <- function(method, uri, config, verbose=FALSE) {
  b64 <- reticulate::import("base64")
  user_creds <- tryCatch(config::get(file = config),
                         error = function(e) stop("Could not find a config file", call. = FALSE))

  time_stamp <- format(lubridate::now("UTC"), "%m/%d/%Y %I:%M:%S %p")

  data <- sprintf(
    "%s%s%s%s",
    user_creds$user_id,
    time_stamp,
    uri,
    toupper(method))

  signature_hash <- RCurl::base64Encode(
    digest::hmac(
      key = user_creds$private_key,
      object = data,
      algo = "sha256",
      raw = TRUE))

  c(
    "X-UserID" = user_creds$user_id,
    "X-Stamp" = time_stamp,
    "X-Signature" = signature_hash
  )
}




