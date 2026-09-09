library(PSEtoDataframe)

make_db_connection <- function() {
  ORACLE_HOST <- "NATP71.NAT.DFO-MPO.CA"
  ORACLE_PORT <- 1523
  ORACLE_SID <- "OKENP27"
  ORACLE_USER <- Sys.getenv("ORACLE_USER")
  ORACLE_PASSWORD <-  Sys.getenv("ORACLE_PASSWORD")
  ORACLE_DRIVER <- "Oracle in 12.2.0_Instant_x64"

  connection_string <- paste(
    "Driver=", ORACLE_DRIVER, ";",
    "DBQ=", ORACLE_HOST, ":", ORACLE_PORT, "/", ORACLE_SID, ";",
    "UID=", ORACLE_USER, ";",
    "PWD=", ORACLE_PASSWORD,
    sep = "")
  con <- DBI::dbConnect(odbc::odbc(),
            .connection_string = connection_string,
            timeout = 10)
  return(con)
}

conn <- make_db_connection()
source_info_df <- source_info_list()
str(source_info_df)
View(source_info_df)

# js files are properly sourced this way
runApp()


# js files are not sourced this way
source("ui.R")
source("server.R")
shinyApp(ui = ui, server = server)
