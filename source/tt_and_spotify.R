library(dplyr)
library(ggplot2)

# reduced columns of spotify_charts_2021.csv to just 4 columns
# renamed columns for merging later
spotify_21 <- read.csv("../data/spotify_charts_2021.csv") %>%
  select(artist_names, track_name, peak_rank, weeks_on_chart) %>%
  rename(artist = artist_names, song_title = track_name)

# reduced columns of TikTok_songs_2021.csv to 4 columns
# renamed columns for merging
tiktok_21 <- read.csv("../data/TikTok_songs_2021.csv") %>%
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
#<<<<<<< HEAD
  aes(song_title, -peak_rank)) + geom_point()

# RAHHHHHH
# made it negative because the higher rank, the lower value you have
#=======
  aes(song_title, -peak_rank, col= "2021") + geom_point()
# RAHHHHHHH
# made it negative because the higher rank, the lower value you have
#>>>>>>> 39ec92ba464284e1436343022ee8e29b1b347d2e
