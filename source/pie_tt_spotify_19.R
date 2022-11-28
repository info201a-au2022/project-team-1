library(dplyr)
library(ggplot2)
library(plotly)

# Charts for 2019 Spotify and TikTok chart
# Please change the wd() to /docs later, but for now we are going to be 
# working with /source
# working from /docs would be "data/CSV FILE.csv"
spotify_19 <- read.csv("../data/spotify_top_charts_19.csv") %>%
  select(artist_names, track_name, peak_rank, weeks_on_chart) %>%
  rename(artist = artist_names, song_title = track_name)

tiktok_19 <- read.csv("../data/TikTok_songs_2019.csv") %>%
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

# New variable summarizes how many FALSEs and TRUEs there are
summary_19 <- chart_19 %>%
  group_by(on_both) %>%
  summarize(length(on_both)) %>% #makes two values with numbers
  rename(value = "length(on_both)")

# How to make a pie chart https://www.displayr.com/how-to-make-a-pie-chart-in-r/
# Make a bar chart first before we make a pie chart
pie_19 <- ggplot(summary_19, aes(x="Song", y = value, fill = on_both)) +
  geom_bar(stat = "identity")

# Make a pie chart
pie_19 <- pie_19 +
  coord_polar("y", start = 0) +
  geom_text(aes
            (label = paste0(round((value/nrow(chart_19)*100)), "%")), 
            position = position_stack(vjust = 0.5))