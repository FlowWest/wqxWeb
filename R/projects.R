#' @title Upload to Server
#' @description upload a file to wqx server. This does not import the file, rather
#' keeps it in a staging state.
#' @param file_path path to file, filename cannot have spaces
#' @param private_key private key associated with application or user, provided by WQX
#' @param user_id user id associated with user or application
#' @export
wqx_projects <- function(org_id=NULL, project_id=NULL, transaction_id=NULL,
                         last_change_min=NULL, last_change_max=NULL, ...) {

  url <- "https://cdx.epa.gov/WQXWeb/api/Projects/"
  req_headers <- wqx_header("GET", uri = url, ...)

  httr::GET(
    url = url,
    query = list(OrganizationIdentifiersCsv = org_id,
                 ProjectIdentifiersCsv = project_id,
                 TransactionIdentifier = transaction_id,
                 LastChangeDateMin = last_change_min,
                 LastChangeDateMax = last_change_max),
    httr::add_headers(.headers = req_headers)
  )

}


# Projects: returns projects for an organization
# Action
# GET
# Parameters
# OrganizationIdentifiersCsv
# Comma delimited (e.g. "id1,id2,id3")
# NOTE: No spaces
# ProjectIdentifiersCsv
# Comma delimited (e.g. "id1,id2,id3")
# NOTE: No spaces
# TransactionIdentifier
# (e.g. "_23090c89-c6a6-4dd1-b16f-73f8ac36fac1"
#   LastChangeDateMin
#   Format: (mm/dd/yyyy or mm-dd-yyyy)
#   LastChangeDateMax
#   Format: (mm/dd/yyyy or mm-dd-yyyy)
