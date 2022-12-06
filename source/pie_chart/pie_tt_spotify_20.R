library(dplyr)
library(ggplot2)

# Charts for 2020 Spotify and TikTok chart
# Don't forget to change the wd() to /docs later
# Currently working from /source
spotify_20 <- read.csv("data/spotify_top_charts_20.csv") %>%
  select(artist_names, track_name, peak_rank, weeks_on_chart) %>%
  rename(artist = artist_names, song_title = track_name)

tiktok_20 <- read.csv("data/TikTok_songs_2020.csv") %>%
  select(track_name, artist_name, track_pop) %>%
  rename(song_title = track_name, artist = artist_name)

# Join both charts together by song title and artist
# will be using Spotify chart as we want to see how many TikTok songs managed to 
# break into the real music charts
chart_20 <- left_join(spotify_20, tiktok_20, by = c("song_title", "artist")) %>%
  arrange(-peak_rank) # negative because the lower score you have on Spotify, the 
                      # higher value you have

# Converting all NAs in `track_pop` into 0
chart_20[is.na(chart_20)] = "0"

# Adding another column `on_both` to see whether a song was popular on both Tiktok
# and Spotify. Returns a boolean
chart_20 <- chart_20 %>%
  mutate(on_both = track_pop > 0)

#summary of artists
summary_20 <- chart_20 %>% 
  filter(on_both == TRUE) %>% 
  group_by(artist) %>% 
  summarize(
    popular = length(on_both)
  )

