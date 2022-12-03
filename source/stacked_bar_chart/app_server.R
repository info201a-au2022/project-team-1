library(dplyr)

source("build_bar_chart.R")

server <- function(input, output) {
  output$plot <- renderPlotly({
    return(build_bar_chart(input$artistvar))
  })
  
}
