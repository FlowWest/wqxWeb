#' @title Create CDX Session
#' @description creates a CDX session object that provides methods for uploading and
#' querying data from the CDX.
#'
#' @param user CDX account username.
#' @param key CDX private encryption key. Found in My User Account Details under
#' Setup on CDX website.
#' @param filepath Full file path of the file that is being uploaded to CDX.
#' @param filename Name of the file that is being uploaded to CDX.
#'
#' @export

cdx <- function(user, key, filepath, filename) {
  wqx$cdx$CDX(
    user_id = user,
    cdx_key = key,
    file_path = filepath,
    file_name = filename
  )
}


#' @title Upload file
#' @description Using created CDX session object to upload the file.
#'
#' @param session CDX session object
#'
#' @return file_ID
#' @export

cdx_upload <- function(session) {
  file_id <- session$upload()

  return(file_id)
}


#' @title Import file
#' @description Use the file ID from the upload function to import the file
#' to the staging area in the CDX session.
#'
#' @param session CDX session object
#' @param file_id file_id from cdx_upload
#' @param config_id WQX template configuration ID. Found in Import Configurations
#' under Setup CDX website.
#' @param params Configuration parameters for import. Example: ("newOrExistingData", "0")
#' Do we want to list all of the available import params?
#'
#' @return dataset_id
#' @export

cdx_import <- function(session, file_id, config_id, params = NULL) {
  param_keys <- c(params[seq(1, length(params), 2)])
  param_values <- c(params[seq(2, length(params), 2)])
  params <- reticulate::py_dict(keys = param_keys, values = param_values)
  dataset_id <- session$start_import(
    file_id = file_id,
    config_id = config_id,
    params = params
  )

  return(dataset_id)
}

#' @title Get Status
#'
#' @description Check the dataset import or submission status on CDX session.
#'
#' @param session CDX session object
#' @param dataset_id Dataset ID from cdx_import
#'
#' @return Status
#' @export

cdx_get_status <- function(session, dataset_id) {
  status <- session$get_status(
    dataset_id = dataset_id
  )

  return(status)
}

#' @title Submit to CDX
#'
#' @description Submit the imported dataset to CDX.
#'
#' @param session CDX session object
#' @param dataset_id Dataset ID from cdx_import
#'
#' @export

cdx_submit_to_cdx <- function(session, dataset_id) {
  sub <- session$submit_to_cdx(
    dataset_id = dataset_id
  )

  return(sub)
}





