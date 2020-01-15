#' @export
wqx_locations <- function(org_id, location_id = NULL, location_name = NULL,
                          location_type = NULL, transaction_id = NULL, config = NULL, ...) {

  url <- httr::modify_url(base_url, path = "WQXWeb/api/MonitoringLocations",
                          query = list("OrganizationIdentifiersCsv" = org_id,
                                       "MonitoringLocationIdentifiersCsv" = location_id,
                                       "MonitoringLocationName" = location_name,
                                       "MonitoringLocationType" = location_type))


  request_headers <- wqx_header("GET", url, config)

  httr::GET(url, httr::add_headers(.headers = request_headers))
}
