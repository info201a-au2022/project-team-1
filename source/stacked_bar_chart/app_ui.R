library(shiny)
library(plotly)

barchart_side_content <- sidebarPanel(
  selectInput(
    "artistvar",
    label = "Select artist",
    choices = unique(data$artist)
  )
)

barchart_main_content <- mainPanel(
  plotlyOutput("barchart")
)
  