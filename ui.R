library(shiny)
library(bslib)
library(DT)

ui <- page_sidebar(
  singleton(
    tags$head(tags$script(src = "message-handler.js"))
  ),
  title = "Tables de base de données PSE (Oracle) ",
  sidebar = sidebar("Navigation",
    card(
      actionButton("source_info_list", "Liste Projets"),
      actionButton("no_releve_list", "Liste Relevés"),
    ),
  ),
  card(
    renderText("Fetch data"),
    DT::DTOutput("data")
  )
)
