#server for pie app
library(shiny)
library(plotly)
#sourcing data
source("./pie_tt_spotify_19.r")
source("./pie_tt_spotify_20.r")
source("./pie_tt_spotify_21.r")
source("./pie_tt_spotify_21.r")

server <- function(input, output) {
 
  output$pie <- renderPlotly({
    plot_ly(data = get(input$pievar), labels = ~artist, values = ~popular, type = 'pie')
  })

}