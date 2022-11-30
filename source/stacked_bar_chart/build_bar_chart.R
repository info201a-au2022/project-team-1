library(plotly)
library(stringr)

source("./trending_artists.R")

build_bar_chart <- function(data, artistvar, xvar = "year", yvar = sum(data$year == "year")) {
  p <- plot_ly(x= data[, xvar],
               y = data[, yvar],
               color = ~artistvar,
               type = bar,
               ) %>%
    layout(barmode = "stack")
}
