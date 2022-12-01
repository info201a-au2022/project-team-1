library(shiny)
library(plotly)
library(dplyr)
library(ggplot2)

# Make a sidebar panel `sidebarPanel()` to have a checkbox
# of multiple years, each year being a different data set
checkbox_sidebar_content <- sidebarPanel(
  checkboxGroupInput(
    inputId = "year",
    label = "Year for Graph",
    choiceNames = c("2019", "2022"),
    choiceValues = c("chart_19", "chart_22"),
    selected = NULL
  )
)

# Make a main panel to have the graphs show up after
# selecting year(s); interactive
checkbox_main_content <- mainPanel(
  plotlyOutput("graph")
)

checkbox_panel <- tabPanel(
  "Scatter Plot", # this is the title of the TAB
  titlePanel("Graph lol"), # i think this is the actual title on the page
  sidebarLayout(
    checkbox_sidebar_content,
    checkbox_main_content
  )
)

scatter_ui <- navbarPage(
  "Unique Title", # application title
  checkbox_panel
)
