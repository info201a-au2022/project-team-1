library(dplyr)
library(ggplot2)

tiktok_22 <- read.csv("../data/TikTok_songs_2022.csv") %>%
  select(artist_name, track_name, track_pop) %>%
  arrange(-track_pop) %>%
  mutate(year = 2022) %>%
  rename(artist = artist_name, song_title = track_name)

spotify_22 <- read.csv("../data/spotify_charts_2022.csv") %>%
  select(artist_names, track_name, peak_rank) %>%
  arrange(peak_rank) %>%
  mutate(year = 2022) %>%
  rename(artist = artist_names, song_title = track_name)

joined_songs_22 <- left_join(spotify_22, tiktok_22, na.rm = TRUE) %>%
  arrange(song_title)

joined_songs_22 <- na.omit(joined_songs_22)

View(joined_songs_22)

pick_artist <- c("Doja Cat", "Olivia Rodrigo", "Ed Sheeran", "Lil Nas X")

number_of_songs <- c(3, 2, 1, 2)

artist_vs_song <- data.frame(pick_artist, number_of_songs)
View(artist_vs_song)

trending_artists <- ggplot(data = artist_vs_song) +
  geom_col(mapping = aes(x=pick_artist, y=number_of_songs)) +
  ggtitle("Number of Songs Artists Have Trending on TikTok and Spotify in 2022")

trending_artists
