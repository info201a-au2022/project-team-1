library(dplyr)
library(ggplot2)
library(plotly)

# Charts for 2019 Spotify and TikTok chart
# Please change the wd() to /docs later, but for now we are going to be 
# working with /source
# working from /docs would be "data/CSV FILE.csv"
spotify_19 <- read.csv("../../data/spotify_top_charts_19.csv") %>%
  select(artist_names, track_name, peak_rank, weeks_on_chart) %>%
  rename(artist = artist_names, song_title = track_name)

tiktok_19 <- read.csv("../../data/TikTok_songs_2019.csv") %>%
  select(track_name, artist_name, track_pop) %>%
  rename(song_title = track_name, artist = artist_name)

# Join both charts together by song title and artist in order to make a pie chart
chart_19 <- left_join(spotify_19, tiktok_19, by = c("song_title", "artist")) %>%
  arrange(-peak_rank) 

# Converting all NA = 0
chart_19[is.na(chart_19)] = "0" 

# Adding another column "on_both" to see whether a song was popular on both TikTok
# and spotify
chart_19 <- chart_19 %>%
  mutate(on_both = track_pop > 0)

# summary of how many songs trending each artist had
summary_19 <- chart_19 %>% 
  filter(on_both == TRUE) %>% 
  group_by(artist) %>% 
  summarize(
    popular = length(on_both)
  )

# Making interactive pie chart

#pie_19 <- plot_ly(summary_19, labels = ~artist, values = ~popular, type = 'pie')

#print(pie_19)
#print(fig)
