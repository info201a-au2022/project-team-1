library(shiny)
library(plotly)
source("source/stacked_bar_chart/trending_artists.R")

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

bar_chart_panel <- tabPanel(
  "Bar Chart",
  titlePanel("Artist Song Popularity on TikTok vs. Spotify"),
  # A `sidebarLayout()` that contains...
  sidebarLayout(
    barchart_side_content,
    barchart_main_content
  )
)

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
report_panel <- tabPanel(
  "Report", # title of tab
  titlePanel("Project Report"),
  mainPanel(
    h6("Code Name: Tiktok-music"),
    h6("Project Title: Knock, Knock It’s TikTok: Examining TikTok’s Role in Changing the Music Industry"),
    h6("Report by: Mie Dunbar (dunbar11@uw.edu), Xenia Capcan (capcax@uw.edu), Kim Ng (kimng@uw.edu)"),
    h6("Affiliation: INFO-201: Technical Foundations of Informatics- The Information School- University of Washington"),
    h6("Date: Autumn 2022"),
    h3(strong("Abstract")),
    p("Our main question is “How does TikTok influence music trends?” This question is important because social media is constantly changing the music industry. To address the question, we will evaluate numerous databases to compare music trends on TikTok vs. Spotify and by observing popular songs and artists."),
    h3(strong("Key Words:")),
    p("-Overlap"),
    p("-Popular"),
    p("-Ranking"),
    h3(strong("Introduction")),
    p("Now that we have gathered our datasets and brainstormed various research questions, we have compiled our findings into interactive graphs and charts. We mainly tried to focus on the overlap of popular songs/artists on TikTok and on the Spotify Charts. We utilized their rankings to compare their success on each platform. From doing this analysis, we have gotten a better idea on how the music industry influences music on TikTok and vice versa. We created three useful visualizations which utilize aggregated data from our datasets and used these visualizations to reach conclusions. The main focus of our visualizations was to show wwhat kindn of overlap there is for songs between the two apps generally and on a more specific scale."),
    h3(strong("Problem Domain")),
    p("As we do an in depth analysis of popular music on TikTok and Spotify it is important to question the meaning of this analysis. We may ask who is benefiting from our findings and when/if our data will ever be utilized. Besides the average person's curiosity, our work can be very beneficial to music artists who are just getting started/have a small following. They can use our data to determine if they should release their new single first on TikTok or on Spotify or the other way around. If they notice a correlation between songs that do well on TikTok vs on Spotify, they can examine what these songs are like and what made them blow up. The source playlist push confirms this idea and writes that \"Smaller Indie Artists are generating substantial streaming growth from TikTok. Proof that success from TikTok comes in different sizes and can work for artists of all types (and budgets).\" As for already established artists, they can observe which of their songs are blowing up on TikTok and why. They can try promoting their song to be streamed on Spotify by engaging with the different trends that are using their song  on TikTok."),
    h3(strong("Research Questions"))
  )
)
# ------------------------------------------------------------------------------

# Define the UI
ui <- navbarPage(
  "TikTok's Role in the Music Industry",
  # The report panels, most likely intro and other discussions

  # Scatter plot panel (Kim)
  radio_panel, 
  # Stacked bar chart panel (Mie)
  bar_chart_panel,
  # Pie chart panel (Xenia)
  pie_panel,
  # Report panel (Mie)
  report_panel
)

