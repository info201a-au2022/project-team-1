library(dplyr)
library(plotly)

# source() all the data sets that will be displayed
source("source/scatter_plot/tt_and_spotify_19.R")
source("source/scatter_plot/tt_and_spotify_20.R")
source("source/scatter_plot/tt_and_spotify_21.R")
source("source/scatter_plot/tt_and_spotify_22.R")

# Define the server
scatter_server <- function(input, output) {
# Render a plotly object that returns scatter plot
# key from the plotlyOutput was `graph`
  output$graph <- renderPlotly({
    plot_ly(data = get(input$year),
            x = ~track_pop, # x axis
            y = ~peak_rank, # y axis
            type = "scatter", # type of graph that will appear
            color = get(input$year), # keeping this in case I figure out how to merge graphs with check boxes
            mode = "markers",
              hoverinfo = "text",
            # "</br>" signals a break in paragraph for the labels
              text = ~paste("</br>", song_title, "by", artist,
                            "</br> Spotify Chart Rank: ", peak_rank,
                            "</br> Popularity on TikTok: ", track_pop)) %>%
      layout(
        xaxis = list(
          title = "Popularity on TikTok", # renames x-axis
          range = list(0,100) # keeps x-axis's max and min consistent
        ),
        yaxis = list(
          title = "Ranking on Spotify", # renames y-axis
          range = list(200,0) # reverses y-axis + consistent maximum and minimum
      ))
 })
}
