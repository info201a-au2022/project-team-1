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
    choices = c("2019", "2020", "2021", "2022")
    # looks like there's no place for choices?
  )
)
