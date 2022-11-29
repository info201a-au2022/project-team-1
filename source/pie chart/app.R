# Load libraries so they are available
library("shiny")

#loading ui and server source
source("app_ui.R")
source("app_server.R")


shinyApp(ui = ui, server = server)