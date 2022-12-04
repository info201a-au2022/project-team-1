library(plotly)
library(stringr)

source("source/stacked_bar_chart/trending_artists.R")

build_bar_chart <- function(artistvar) {
  data <- final_dataframe %>%
    filter(artist == artistvar)
  
  p <- plot_ly(data, x = ~year, y = ~pop_on_tiktok, name = 'Popular songs on TikTok', type = 'bar') %>%
    add_trace(y = ~pop_on_spotify, name = 'Popular songs on Spotify') %>% 
    add_trace(y = ~pop_on_both, name = 'Popular songs on both') %>% 
    layout(yaxis = list(title = 'Count'), barmode = 'stack')
  return(p)
}

