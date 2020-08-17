#' Upload a file to the WQX servers
#' @description upload a file to the wqx server, this file is not pushed to staging yet.
#' @param file file to be uploaded
#' @param config config file with private key and username
#' @param pk private key if not supplied via a config file, ignored if config file supplied
#' @param username username, ignored if config file supplied
#' @return returns a list with status code and if succesful a file-id or if not
#' successful an error message.
#' @export
wqx_upload <- function(file, config=NULL, pk=NULL, username=NULL) {
  if (is.null(config)) {
    if (any(is.null(pk), is.null(username))) {
      stop("No config file provided, please provide private key and username")
    }
    else {
      user_creds <- list(
        "private_key" = pk,
        "username" = username
      )
    }
  } else {
    user_creds <- tryCatch(read.csv(config, stringsAsFactors = FALSE),
                           error = function(e) stop("Could not find a config file", call. = FALSE))

  }


  file_name <- basename(file)
  resp <- wqx$wqxtools$upload(filename = file_name,
                      filepath = file,
                      pk = user_creds$private_key,
                      username = user_creds$username)

  if (resp$status_code == 200) {
    message("file upload was succesfull, note the file id and call wqx_start_import() to start importing into staging phase")
  }

  list(
    status_code = resp$status_code,
    file_id = resp$content
  )
}


#' Start importing into the staging database
#' @description import an uploaded dataset into a staging phase. This function is
#' called once you have uploaded data using the \code{wqx_upload} function.
#' @param file_id file_id for uploaded file, this is returned by wqx_upload()
#' @param import_config config id for the destination of file. This can be
#' found in the CDX web portal.
#' @param file_type file type of dataset "CSV"
#' @param new_or_existing is this data 'new' data, 'existing' data (replaces old data) or 'both'
#' @param headers is the first line of the file a header?
#' @param config config file with username and private key
#' @param pk private key if not supplied via a config file
#' @param username username if not uspplied via a config file
#' @export
wqx_start_import <- function(file_id, import_config, file_type, new_or_existing,
                             headers, config=NULL, pk=NULL, username=NULL) {

  if (is.null(config)) {
    if (any(is.null(pk), is.null(username))) {
      stop("No config file provided, please provide private key and username")
    }
    else {
      user_creds <- list()
      user_creds$private_key = pk
      user_creds$user_id = username
    }
  } else {
    user_creds <- tryCatch(config::get(file = config),
                           error = function(e) stop("Could not find a config file", call. = FALSE))

  }


  resp <- wqx$wqxtools$start_import(
    pk = user_creds$private_key,
    username = user_creds$user_id,
    import_config = import_config,
    file_id = file_id,
    file_type = file_type,
    new_or_existing = new_or_existing,
    headers = headers
  )

  list(
    status_code = resp$status_code,
    dataset_id = resp$content
  )

}

#' Get status
#' @description returns a status code for the given dataset id
#' @param dataset_id id corresponding to dataset
#' @param config config file with username and private key
#' @param pk private key string, ignored if config file supplied
#' @param username username string, ignored if config file supplied
#' @export
wqx_get_status <- function(dataset_id, config=NULL, pk=NULL, username=NULL) {

  if (is.null(config)) {
    if (any(is.null(pk), is.null(username))) {
      stop("No config file provided, please provide private key and username")
    }
    else {
      user_creds <- list()
      user_creds$private_key = pk
      user_creds$user_id = username
    }
  } else {
    user_creds <- tryCatch(config::get(file = config),
                           error = function(e) stop("Could not find a config file", call. = FALSE))

  }

  resp <- wqx$wqxtools$get_status(dataset_id=dataset_id, pk=user_creds$private_key,
                                  username=user_creds$user_id)

  list(
    status_code=resp$status_code,
    content=resp$content
  )
}
