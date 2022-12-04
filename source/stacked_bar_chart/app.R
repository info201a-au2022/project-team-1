library("shiny")

source("source/stacked_bar_chart/app_server.R")
source("source/stacked_bar_chart/app_ui.R")

shinyApp(ui = ui, server = server)