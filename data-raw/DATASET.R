## code to prepare `DATASET` dataset goes here
monitoring_table_headers <-
  wqxWeb::wqx_read_config("data-raw/Import Configuration.cfg")

usethis::use_data(monitoring_table_headers, overwrite = TRUE)
