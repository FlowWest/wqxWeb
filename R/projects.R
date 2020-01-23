#' @title Upload to Server
#' @description upload a file to wqx server. This does not import the file, rather
#' keeps it in a staging state.
#' @param file_path path to file, filename cannot have spaces
#' @param private_key private key associated with application or user, provided by WQX
#' @param user_id user id associated with user or application
#' @export
wqx_projects <- function(org_id, config) {
  user_creds <- tryCatch(config::get(file = config),
                         error = function(e) stop("Could not find a config file", call. = FALSE))

  resp <- wqx$wqxtools$projects(org_id,
                                user_creds$private_key,
                                user_creds$user_id)

  if (resp$status_code != 200) {
    stop("an error occures communicating with the WQX Web Serivce", call. = FALSE)
  }

  data <- resp$content %>%
    purrr::map_df(~tibble::tibble(
      ProjectIdentifier = .$ProjectIdentifier,
      OrganizationIdentifier = .$OrganizationIdentifier,
      ProjectName = .$ProjectName,
      Description = .$Description,
      LastChangeDate = .$LastChangeDate
    ))

  list(
    status_code = resp$status_code,
    data = data
  )

}
