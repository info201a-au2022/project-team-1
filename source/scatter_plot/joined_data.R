source("source/scatter_plot/tt_and_spotify_19.R")
source("source/scatter_plot/tt_and_spotify_20.R")
source("source/scatter_plot/tt_and_spotify_21.R")
source("source/scatter_plot/tt_and_spotify_22.R")

s_chart_20 <- s_chart_20 %>%
  mutate(Year = "2020")

s_chart_21 <- s_chart_21 %>%
  mutate(Year = "2021")

joined_data_s <- rbind(s_chart_19, s_chart_20) %>%
  rbind(s_chart_21) %>%
  rbind(s_chart_22)
