library(dplyr)
library(ggplot2)

# Charts for 2020 Spotify and TikTok
# Please change the wd() to /docs later, but for now we are going to be 
# working with /source
# working from /docs would be "data/CSV FILE.csv"
spotify_21 <- read.csv("data/spotify_charts_2021.csv") %>%
  select(artist_names, track_name, peak_rank, weeks_on_chart) %>%
  rename(artist = artist_names, song_title = track_name)

tiktok_21 <- read.csv("data/TikTok_songs_2021.csv") %>%
  select(track_name, artist_name, track_pop) %>%
  rename(song_title = track_name, artist = artist_name)

# Join both charts together by song title and artist in order to make a pie chart
chart_21 <- left_join(spotify_21, tiktok_21, by = c("song_title", "artist")) %>%
  arrange(-peak_rank) 

# Converting all NAs in the `track_pop` column into 0s
chart_21[is.na(chart_21)] = "0"

# Adding another column `on_both` to see whether a song was popular on both charts
chart_21 <- chart_21 %>%
  mutate(on_both = track_pop > 0)

#summary of artists
summary_21 <- chart_21 %>% 
  filter(on_both == TRUE) %>% 
  group_by(artist) %>% 
  summarize(
    popular = length(on_both)
  )
