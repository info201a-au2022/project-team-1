library(dplyr)
library(ggplot2)

# set working directory to project-team-1/source
spotify_22 <- read.csv("../../data/spotify_charts_2022.csv") %>%
  select(artist_names, track_name, peak_rank, weeks_on_chart) %>%
  rename(artist = artist_names, song_title = track_name)

tiktok_22 <- read.csv("../../data/TikTok_songs_2022.csv") %>%
  select(track_name, artist_name, track_pop) %>%
  rename(song_title = track_name, artist = artist_name)

chart_22 <- left_join(spotify_22, tiktok_22, by = c("song_title", "artist")) %>%
  arrange(-peak_rank) 

# attempting to make a pie chart

test_chart_22 <- chart_22

test_chart_22[is.na(test_chart_22)] = "0" 

test_chart_22 <- test_chart_22 %>%
  mutate(on_both = track_pop > 0)

#summary of artists
summary_22 <- test_chart_22 %>% 
  filter(on_both == TRUE) %>% 
  group_by(artist) %>% 
  summarize(
    popular = length(on_both)
  )


