library(dplyr)
library(ggplot2)

# set working directory to root (project-team-1) so markdown would work

# reduced columns of spotify_charts_2021.csv to just 4 columns
# renamed columns for merging later
spotify_21 <- read.csv("data/spotify_charts_2021.csv") %>%
  select(artist_names, track_name, peak_rank, weeks_on_chart) %>%
  rename(artist = artist_names, song_title = track_name)

# reduced columns of TikTok_songs_2021.csv to 4 columns
# renamed columns for merging
tiktok_21 <- read.csv("data/TikTok_songs_2021.csv") %>%
  select(track_name, artist_name, album, track_pop) %>%
  rename(song_title = track_name, artist = artist_name)

# merged both charts together 
chart <- left_join(spotify_21, tiktok_21) %>%
  arrange(-peak_rank)

# making a plot for chart$peak_rank
chart$song_title <- as.vector(chart$song_title) #gets rid of alphabetical order
chart$song_title = factor(chart$song_title, chart$song_title) #adds ordering from arrange()

point_peak_rank <- ggplot(
  data = chart, 
aes(track_pop, -peak_rank, col= "2021")) + geom_point()

print(point_peak_rank + labs(
  title = "Peak Rankings of 2021 Songs on \nof Spotify and TikTok",
  y = "Ranking on Spotify",
  x = "Popularity on TikTok"
))
# RAHHHHHHH
# made it negative because the higher rank, the lower value you have
# removed all missing values, just seeing relations between TikTok and Spotify