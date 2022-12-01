library(shiny)
library(plotly)

# Intro Panel 1 (Kim) ----------------------------------------------------------

# ------------------------------------------------------------------------------
# Scatter Plot Panel (Kim) -----------------------------------------------------

# SIDEBAR panel `sidebarPanel()` to have a radioButton of multiple years, each
# year being a different data set
radio_sidebar_content <- sidebarPanel(
  radioButtons(
    inputId = "year",
    label = "Choose a year",
    choiceNames = c("2019", "2020", "2021", "2022"),
    choiceValues = c("s_chart_19", "chart_20", "chart_21", "chart_22"), # reminder
    # that when doing input$year, it's NOT "2019" but rather the chart 
    selected = NULL
  )
)
# Main panel to have the graphs show up after selecting year(s); reactive/output
radio_main_content <- mainPanel(
  plotlyOutput("graph")
)
# The full scatter plot PANEL all laid out
radio_panel <- tabPanel(
  "Scatter Plot", # this is the title of the TAB
  titlePanel("Chart Ranking v.s. TikTok Popularity"), # The actual title on the panel
  sidebarLayout(
    radio_sidebar_content,
    radio_main_content
  )
)
# ------------------------------------------------------------------------------
# Stacked Bar Chart Panel (Mie) ------------------------------------------------

# ------------------------------------------------------------------------------
# Pie Chart Panel (Xenia) ------------------------------------------------------
pie_panel <- tabPanel(
  "Pie Chart", # title of tab
  titlePanel("idk what title Xenia has"), # the title on the panel itself
  sidebarLayout(
    selectInput(
      "pievar",
      label = "Select year",
      choices = c("2019" = "summary_19",
                  "2020" = "summary_20",
                  "2021" = "summary_21",
                  "2022" = "summary_22")),
  mainPanel(plotlyOutput("pie"))
  )
)

# ------------------------------------------------------------------------------
# Summary Takeaways (Xenia) ----------------------------------------------------

# ------------------------------------------------------------------------------
# Report (Mie) -----------------------------------------------------------------

# ------------------------------------------------------------------------------

# Define the UI
ui <- navbarPage(
  "Bawling vs. Ballin", # application title, can be changed to something else
  # The report panels, most likely intro and other discussions
  
  # Scatter plot panel (Kim)
  radio_panel, 
  # Stacked bar chart panel (Mie)
  
  # Pie chart panel (Xenia)
  pie_panel
)
