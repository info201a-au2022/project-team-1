library(shiny)

source("source/scatter_plot/scatter_ui.R")
source("source/scatter_plot/scatter_server.R")

shinyApp(ui = scatter_ui, server = scatter_server)
