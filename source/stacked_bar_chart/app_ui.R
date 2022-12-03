library(shiny)
library(plotly)

barchart_side_content <- sidebarPanel(
  selectInput(
    "artistvar",
    label = "Select artist",
    choices = unique(final_dataframe$artist)
  )
)

barchart_main_content <- mainPanel(
  plotlyOutput("plot")
)

chart_panel <- tabPanel(
  "barchart",
  titlePanel("Artist Song Popularity on TikTok vs. Spotify"),
  # A `sidebarLayout()` that contains...
  sidebarLayout(
    barchart_side_content,
    barchart_main_content
  )
)

ui <- navbarPage(
  "Anything",
  chart_panel,
)  