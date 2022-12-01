library(shiny)
library(plotly)
library(dplyr)
library(ggplot2)

# Make a sidebar panel `sidebarPanel()` to have a radioButton
# of multiple years, each year being a different data set
radio_sidebar_content <- sidebarPanel(
  radioButtons(
    inputId = "year",
    label = "Choose a year",
    choiceNames = c("2019", "2020", "2021", "2022"),
    choiceValues = c("chart_19", "chart_20", "chart_21", "chart_22"),
    selected = NULL
  )
)

# Make a main panel to have the graphs show up after
# selecting year(s); interactive
radio_main_content <- mainPanel(
  plotlyOutput("graph")
)

# Defining the contents of scatter panel
radio_panel <- tabPanel(
  "Scatter Plot", # this is the title of the TAB
  titlePanel("Chart Ranking v.s. TikTok Popularity"), # i think this is the actual title on the page
  sidebarLayout(
    radio_sidebar_content,
    radio_main_content
  )
)

# Define the UI
scatter_ui <- navbarPage(
  "Unique Title", # application title
  radio_panel
)
