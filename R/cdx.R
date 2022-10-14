#' @title Create CDX Session
#' @description creates a CDX session object that provides methods for uploding and
#' querying data from the CDX.
#' @export
cdx <- function(user, key, filepath, filename) {
  wqx$wqxtools$cdx$CDX(
    user_id = user,
    cdx_key = key,
    file_path = filepath,
    file_name = filename
  )
}


# create a CDX session object
my_username <- "user"
my_key <- "l3uhB9o3IWHqpbbYlUz59hPiqgPI7cWxXGj9B0fuX5lDKvFZl5dVy5uGsyCcqpdz"
my_filepath <- "some/path"
my_file <- "test.xlsx"

session <- cdx(
  user = my_username,
  key = my_key,
  filepath = my_filepath,
  filename = my_file
)


# basically they would all take "session" as the first param and just
# call methods from it with arguments passed into the functions

# this takes no params so it looks weird
cdx_upload <- function(session) {
  file_id <- session$upload()

  return(file_id)
}

cdx_import <- function(session, file_id, config_id, params) {
  res <- session$start_import(
    file_id = file_id,
    config_id = config_id,
    params = params
  )

  return(res)
}






