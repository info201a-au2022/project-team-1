#ui for pie app
library(shiny)


ui <- fluidPage(
  selectInput(
    "pievar",
    label = "Select year",
    choices = c("2019" = "summary_19",
                "2020" = "summary_20",
                "2021" = "summary_21",
                "2022" = "summary_22")
  ),
  
  plotlyOutput("pie")
)