wqx_read_config <- function(cfg) {
  x <- xml2::as_list(xml2::read_xml(cfg))
  reg_cols <- x$Configuration$RegularColumns
  reg_cols %>%
    purrr::map_df(
      ~tibble::tibble(
        column_name = .$ColumnElements$ColumnElement$ElementName[[1]],
        column_number = .$ColumnNumber[[1]],
        column_type_UID = .$ColumnTypeUid[[1]]
      ))
}

wqx_read_config("data-raw/Import Configuration.cfg")
