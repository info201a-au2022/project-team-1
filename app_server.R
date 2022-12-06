library(dplyr)
library(plotly)
library(shiny)

# Sources; don't forget to check wd()
# Scatter Plot Panel (Kim) -----------------------------------------------------
source("source/scatter_plot/tt_and_spotify_19.R")
source("source/scatter_plot/tt_and_spotify_20.R")
source("source/scatter_plot/tt_and_spotify_21.R")
source("source/scatter_plot/tt_and_spotify_22.R")
# ------------------------------------------------------------------------------
# Stacked Bar Chart Panel (Mie) ------------------------------------------------
source("source/stacked_bar_chart/build_barchart.R")
# ------------------------------------------------------------------------------
# Pie Chart Panel (Xenia) ------------------------------------------------------
source("source/pie_chart/pie_tt_spotify_19.R")
source("source/pie_chart/pie_tt_spotify_20.R")
source("source/pie_chart/pie_tt_spotify_21.R")
source("source/pie_chart/pie_tt_spotify_22.R")
# ------------------------------------------------------------------------------

# Define the server
server <- function(input, output) {
# Scatter Plot Panel (Kim) -----------------------------------------------------
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
# ------------------------------------------------------------------------------
# Stacked Bar Chart Panel (Mie) ------------------------------------------------
  output$plot <- renderPlotly({
    return(build_bar_chart(input$artistvar))
  })

# ------------------------------------------------------------------------------
# Pie Chart Panel (Xenia) ------------------------------------------------------
  output$pie <- renderPlotly({
    plot_ly(data = get(input$pievar), labels = ~artist, values = ~popular, type = 'pie')
  })
# ------------------------------------------------------------------------------
# Report Panel (Mie)
    output$table <- renderTable(data_df)
}
