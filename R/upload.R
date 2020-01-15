#' @title Upload to Server
#' @description upload a file to wqx server. This does not import the file, rather
#' keeps it in a staging state.
#' @param file_path path to file, filename cannot have spaces
#' @param private_key private key associated with application or user, provided by WQX
#' @param user_id user id associated with user or application
#' @export
wqx_upload <- function(file_path, private_key, user_id) {

  file_name <- basename(file_path)
  uri <- paste0("https://cdx.epa.gov/WQXWeb/api/Upload/", file_name)
  time_stamp <- as.character(lubridate::now(tzone = "UTC"))

  # build signature for upload
  signature = paste0(user_id, time_stamp, uri, "POST")
  hmac_obj <- digest::hmac(key = private_key, object = signature, algo = "sha256")
  httr::POST(
    url = endpoint
  )

}
