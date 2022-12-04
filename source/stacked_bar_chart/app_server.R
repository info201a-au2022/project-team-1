library(dplyr)

source("source/stacked_bar_chart/build_bar_chart.R")

server <- function(input, output) {
  output$plot <- renderPlotly({
    return(build_bar_chart(input$artistvar))
  })
  
}
