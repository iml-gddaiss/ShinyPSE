library(shiny)
library(bslib)
library(odbc)
library(DBI)
library(DT)
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


inspect_source_info_list <- function(data, selected_rows, select_type) {
  cod_source_info <- data$COD_SOURCE_INFO[selected_rows]
  return(PSEtoDataframe::no_releve_list(cod_source_info))
  }

server <- function(input, output, session) {
  conn <- make_db_connection()
  select_type <- "single"

  table_data <- reactiveValues()
  table_data$name  <- "source_info_list"
  table_data$data  <- PSEtoDataframe::source_info_list()

  observeEvent(input$source_info_list, {
    table_data$data <- PSEtoDataframe::source_info_list()
    table_data$name  <- "source_info_list"
    select_type <- "single"

  })

  observeEvent(input$no_releve_list, {
    if (is.null(input$data_rows_selected)) {
      session$sendCustomMessage(
        "alert",
        message = "Veullez selectioner un projet dans la table."
        )
    } else {
      table_data$data <- inspect_source_info_list(table_data$data, input$data_rows_selected, select_type)
      table_data$name <- "no_releve_list"
      select_type <- "single"
    }
})

  # # Observe selected rows
  # observe({
  #   selected_rows <- input$data_rows_selected
  #   if (!is.null(selected_rows)) {
  #     print(paste("Selected row index:", selected_rows))
  #   }
  # })


  output$data <- DT::renderDT(table_data$data, selection = select_type
)
}
