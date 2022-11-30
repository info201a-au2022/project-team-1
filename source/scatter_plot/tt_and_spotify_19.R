library(dplyr)
library(ggplot2)
library(plotly)

# set working source file location (project-team-1/source) so markdown would work

# reduced columns of spotify_top_charts_19.csv to just 4 columns
# renamed columns for merging later
spotify_19 <- read.csv("../data/spotify_top_charts_19.csv") %>%
  select(artist_names, track_name, peak_rank, weeks_on_chart) %>%
  rename(artist = artist_names, song_title = track_name)

# reduced columns of TikTok_songs_2019.csv to 4 columns
# renamed columns for merging
tiktok_19 <- read.csv("../data/TikTok_songs_2019.csv") %>%
  select(track_name, artist_name, album, track_pop) %>%
  rename(song_title = track_name, artist = artist_name)

# merged both charts together 
chart_19 <- left_join(spotify_19, tiktok_19) %>%
  arrange(-peak_rank)

# making a plot for chart$peak_rank
chart_19$song_title <- as.vector(chart$song_title) #gets rid of alphabetical order
chart_19$song_title = factor(chart$song_title, chart$song_title) #adds ordering from arrange()
chart_19 <- chart_19[-766, ] # delete any duplicates

point_peak_rank_19 <- ggplot(
  data = chart_19, 
  aes(track_pop, -peak_rank, col= "2019")) + geom_point() 

print(point_peak_rank_19 + labs(
  title = "Peak Rankings of 2019 Songs on \nof Spotify and TikTok",
  y = "Ranking on Spotify",
  x = "Popularity on TikTok"
))



# testing how to combine stuff
sample <- ggplot(
  NULL, 
  aes(track_pop, -peak_rank)) +
  geom_point(data = chart_19,
             col = "#1b98e0") +
  geom_point(data = chart_20,
             col = "green") +
  geom_point(data = chart_21,
             col = "red")

print(sample + labs(
  title = "Peak Rankings 2019 - 2021",
  y = "Ranking on Spotify",
  x = "Popularity on TikTok"
))
