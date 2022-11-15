library(dplyr)
library(ggplot2)

# 2022 version.  
spotify_22 <- read.csv("../data/spotify_charts_2022.csv") %>%
  select(artist_names, track_name, peak_rank, weeks_on_chart) %>%
  rename(artist = artist_names, song_title = track_name)

tiktok_22 <- read.csv("../data/TikTok_songs_2022.csv") %>%
  select(track_name, artist_name, track_pop) %>%
  rename(song_title = track_name, artist = artist_name)

chart_22 <- left_join(spotify_22, tiktok_22, by = c("song_title", "artist")) %>%
  arrange(-peak_rank)

chart_22$song_title <- as.vector(chart_22$song_title) #gets rid of alphabetical order
unique_2022 <- unique(chart_22$song_title)
chart_22$song_title = factor(chart_22$song_title, levels = unique_2022, ordered = TRUE) #adds ordering from arrange()

point_peak_rank_22 <- ggplot(
  data = chart_22, 
  aes(song_title, -peak_rank, col = "2022")) + geom_point()