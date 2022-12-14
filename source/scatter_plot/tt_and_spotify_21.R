library(dplyr)
library(ggplot2)

# set working source file location (project-team-1/source) so markdown would work
# later changed it to `project-team-1` so look into markdown

# reduced columns of spotify_charts_2021.csv to just 4 columns
# renamed columns for merging later
s_spotify_21 <- read.csv("data/spotify_charts_2021.csv") %>%
  select(artist_names, track_name, peak_rank, weeks_on_chart) %>%
  rename(artist = artist_names, song_title = track_name)

# reduced columns of TikTok_songs_2021.csv to 4 columns
# renamed columns for merging
s_tiktok_21 <- read.csv("data/TikTok_songs_2021.csv") %>%
  select(track_name, artist_name, album, track_pop) %>%
  rename(song_title = track_name, artist = artist_name)

# merged both charts together 
s_chart_21 <- left_join(s_spotify_21, s_tiktok_21) %>%
  arrange(-peak_rank)

# making a plot for s_chart_21$peak_rank
s_chart_21$song_title <- as.vector(s_chart_21$song_title) #gets rid of alphabetical order
s_chart_21$song_title = factor(s_chart_21$song_title, s_chart_21$song_title) #adds ordering from arrange()

point_peak_rank_21 <- ggplot(
  data = s_chart_21, 
aes(track_pop, -peak_rank, col= "2021")) + geom_point()

# Adding labels to the axis
point_peak_rank_21 <- point_peak_rank_21 + labs(
  title = "Peak Rankings of 2021 Songs on \nof Spotify and TikTok",
  y = "Ranking on Spotify",
  x = "Popularity on TikTok"
)
# RAHHHHHHH
# made it negative because the higher rank, the lower value you have
# removed all missing values, just seeing relations between TikTok and Spotify