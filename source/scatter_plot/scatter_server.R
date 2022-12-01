library(dplyr)
library(plotly)

# source() all the data sets that will be displayed
source("source/scatter_plot/tt_and_spotify_19.R")
source("source/scatter_plot/tt_and_spotify_22.R")

# Define the server
scatter_server <- function(input, output) {
  # Render a plotly object that returns scatter plot
  # key from the plotlyOutput was `graph`
  output$graph <- renderPlotly({
    plot_ly(data = get(input$year),
            x = ~track_pop,
            y = ~peak_rank,
            type = "scatter",
            color = get(input$year)) %>%
      layout(yaxis = list(
        autorange = "reversed"
      ))
 })
}
# server <- function(input, output) {
#  output$pie <- renderPlotly({
#    plot_ly(data = get(input$pievar), 
#            labels = ~artist, 
#            values = ~popular, 
#            type = 'pie')
#  })
#}
