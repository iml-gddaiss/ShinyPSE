


source("global.R")
source("ui.R")
source("server.R")

# js files are properly sourced this way
runApp()

# js files are not sourced this way
shinyApp(ui = ui, server = server)
