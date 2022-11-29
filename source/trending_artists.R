library(dplyr)
library(ggplot2)

# set working directory to source file (project-team-1/source)
# Joined table for 2022
tiktok_22 <- read.csv("../data/TikTok_songs_2022.csv") %>%
  select(artist_name, track_name) %>%
  mutate(year = 2022) %>%
  rename(artist = artist_name, song_title = track_name)

spotify_22 <- read.csv("../data/spotify_charts_2022.csv") %>%
  select(artist_names, track_name) %>%
  mutate(year = 2022) %>%
  rename(artist = artist_names, song_title = track_name)

joined_songs_22 <- left_join(spotify_22, tiktok_22, by = c("song_title", "artist")) %>%
  arrange(song_title)

joined_songs_22 <- na.omit(joined_songs_22)
joined_songs_22 <- joined_songs_22[!duplicated(joined_songs_22$song_title), ]
joined_songs_22 <- joined_songs_22 %>%
  select(-year.y) %>%
  rename(year = year.x)
View(joined_songs_22)

# Joined table for 2021

tiktok_21 <- read.csv("../data/TikTok_songs_2021.csv") %>%
  select(artist_name, track_name) %>%
  mutate(year = 2021) %>%
  rename(artist = artist_name, song_title = track_name)

spotify_21 <- read.csv("../data/spotify_charts_2021.csv") %>%
  select(artist_names, track_name) %>%
  mutate(year = 2021) %>%
  rename(artist = artist_names, song_title = track_name)

joined_songs_21 <- left_join(spotify_21, tiktok_21, by = c("song_title", "artist")) %>%
  arrange(song_title)

joined_songs_21 <- na.omit(joined_songs_21)
joined_songs_21 <- joined_songs_21[!duplicated(joined_songs_21$song_title), ]
joined_songs_21 <- joined_songs_21 %>%
  select(-year.y) %>%
  rename(year = year.x)
View(joined_songs_21)

# Joined table for 2020

tiktok_20 <- read.csv("../data/TikTok_songs_2020.csv") %>%
  select(artist_name, track_name) %>%
  mutate(year = 2020) %>%
  rename(artist = artist_name, song_title = track_name)

spotify_20 <- read.csv("../data/spotify_top_charts_20.csv") %>%
  select(artist_names, track_name) %>%
  mutate(year = 2020) %>%
  rename(artist = artist_names, song_title = track_name)

joined_songs_20 <- left_join(spotify_20, tiktok_20, by = c("song_title", "artist")) %>%
  arrange(song_title)

joined_songs_20 <- na.omit(joined_songs_20)
joined_songs_20 <- joined_songs_20[!duplicated(joined_songs_20$song_title), ]
joined_songs_20 <- joined_songs_20 %>%
  select(-year.y) %>%
  rename(year = year.x)
View(joined_songs_20)

# Joined table for 2019

tiktok_19 <- read.csv("../data/TikTok_songs_2019.csv") %>%
  select(artist_name, track_name) %>%
  mutate(year = 2019) %>%
  rename(artist = artist_name, song_title = track_name)

spotify_19 <- read.csv("../data/spotify_top_charts_19.csv") %>%
  select(artist_names, track_name) %>%
  mutate(year = 2019) %>%
  rename(artist = artist_names, song_title = track_name)

joined_songs_19 <- left_join(spotify_19, tiktok_19, by = c("song_title", "artist")) %>%
  arrange(song_title)

joined_songs_19 <- na.omit(joined_songs_19)
joined_songs_19 <- joined_songs_19[!duplicated(joined_songs_19$song_title), ]
joined_songs_19 <- joined_songs_19 %>%
  select(-year.y) %>%
  rename(year = year.x)
View(joined_songs_19)

# Building master dataframe for app purposes
master_dataframe <- full_join(joined_songs_19, joined_songs_20, joined_songs_21, joined_songs_22, by = c("year")) %>%
  arrange(year)

View(master_dataframe)
