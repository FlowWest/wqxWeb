#' @title WQX Monitoring Locations Endpoint
#' @param org_id organization ID as designated by the WQX (required)
#' @param location_id a monitoring location ID as designation by organization (optional)
#' @param location_name a monitoring location name as designated by organization (optional)
#' @param location_type a monitoring location type (optional)
#' @param config path to configuration file (see details for more information)
#' @export
wqx_locations <- function(org_id, config = NULL, pk = NULL, username = NULL) {
  if (is.null(config)) {
    if (any(is.null(pk), is.null(username))) stop("No config file provided, please provide private key and username")
  }

  user_creds <- tryCatch(config::get(file = config),
                         error = function(e) stop("Could not find a config file", call. = FALSE))

  org_id = paste(org_id, collapse = ",")
  resp <- wqx$wqxtools$monitoring_locations(org_id,
                                            user_creds$private_key,
                                            user_creds$user_id)

  if (resp$status_code != 200) {
    stop("an error occures communicating with the WQX Web Serivce", call. = FALSE)
  }


  data <- resp$content %>%
    purrr::map_df(~tibble::tibble(
      OrganizationIdentifier = .$OrganizationIdentifier,
      MonitoringLocationIdentifier = .$MonitoringLocationIdentifier,
      MonitoringLocationName = .$MonitoringLocationName,
      StateCode = .$StateCode,
      TribalLandName = .$TribalLandName,
      MonitoringLocationTypeName = .$MonitoringLocationTypeName,
      LatitudeMeasure = .$LatitudeMeasure,
      LongitudeMeasure = .$LongitudeMeasure
    ))

  list(
    status_code = resp$status_code,
    data = data
  )

}
