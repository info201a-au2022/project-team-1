library(dplyr)
library(ggplot2)
library(plotly)

# set working source file location (project-team-1/source) so markdown would work
# later changed it to `project-team-1` so look into markdown

# reduced columns of spotify_top_charts_20.csv to just 4 columns
# renamed columns for merging later
spotify_20 <- read.csv("data/spotify_top_charts_20.csv") %>%
  select(artist_names, track_name, peak_rank, weeks_on_chart) %>%
  rename(artist = artist_names, song_title = track_name)

# reduced columns of TikTok_songs_2020.csv to 4 columns
# renamed columns for merging
tiktok_20 <- read.csv("data/TikTok_songs_2020.csv") %>%
  select(track_name, artist_name, album, track_pop) %>%
  rename(song_title = track_name, artist = artist_name)

# merged both charts together 
chart_20 <- left_join(spotify_20, tiktok_20) %>%
  arrange(-peak_rank)

# making a plot for chart$peak_rank
chart_20$song_title <- as.vector(chart_20$song_title) #gets rid of alphabetical order
chart_20$song_title = factor(chart_20$song_title, chart_20$song_title) #adds ordering from arrange()
chart_20 <- chart_20[-844, ] # delete any duplicates

point_peak_rank_20 <- ggplot(
  data = chart_20, 
  aes(track_pop, -peak_rank, col= "2020")) + geom_point() 

# Adding labels to the axis
print(point_peak_rank_20 + labs(
  title = "Peak Rankings of 2020 Songs on \nof Spotify and TikTok",
  y = "Ranking on Spotify",
  x = "Popularity on TikTok"
))
