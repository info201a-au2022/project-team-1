library(dplyr)
library(ggplot2)

tiktok_22 <- read.csv("../data/TikTok_songs_2022.csv") %>%
  select(artist_name, track_name, track_pop) %>%
  arrange(-track_pop) %>%
  mutate(year = 2022) %>%
  rename(artist = artist_name, song_title = track_name)

View(tiktok_22)

spotify_22 <- read.csv("../data/spotify_charts_2022.csv") %>%
  select(artist_names, track_name, peak_rank) %>%
  arrange(peak_rank) %>%
  mutate(year = 2022) %>%
  rename(artist = artist_names, song_title = track_name)

View(spotify_22)

joined_songs_22 <- left_join(spotify_22, tiktok_22, na.rm = TRUE) %>%
  arrange(song_title)

joined_songs_22 <- na.omit(joined_songs_22)
View(joined_songs_22)

