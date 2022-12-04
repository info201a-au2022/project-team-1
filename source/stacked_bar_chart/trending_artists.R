library(dplyr)
library(ggplot2)

# set working directory to source file (project-team-1/source)
# Joined table for 2022
tiktok_22 <- read.csv("data/TikTok_songs_2022.csv") %>%
  select(artist_name, track_name) %>%
  mutate(year = 2022) %>%
  rename(artist = artist_name, song_title = track_name)

spotify_22 <- read.csv("data/spotify_charts_2022.csv") %>%
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

# Joined table for 2021

tiktok_21 <- read.csv("data/TikTok_songs_2021.csv") %>%
  select(artist_name, track_name) %>%
  mutate(year = 2021) %>%
  rename(artist = artist_name, song_title = track_name)

spotify_21 <- read.csv("data/spotify_charts_2021.csv") %>%
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

# Joined table for 2020

tiktok_20 <- read.csv("data/TikTok_songs_2020.csv") %>%
  select(artist_name, track_name) %>%
  mutate(year = 2020) %>%
  rename(artist = artist_name, song_title = track_name)

spotify_20 <- read.csv("data/spotify_top_charts_20.csv") %>%
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

# Joined table for 2019

tiktok_19 <- read.csv("data/TikTok_songs_2019.csv") %>%
  select(artist_name, track_name) %>%
  mutate(year = 2019) %>%
  rename(artist = artist_name, song_title = track_name)

spotify_19 <- read.csv("data/spotify_top_charts_19.csv") %>%
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

# Building master dataframe for app purposes
master_dataframe <- full_join(joined_songs_19, joined_songs_20)

master_dataframe <- full_join(master_dataframe, joined_songs_21)

master_dataframe <- full_join(master_dataframe, joined_songs_22)
master_dataframe <- master_dataframe[order(master_dataframe$artist), ]

year <-rep(c(2019,2020,2021,2022),times=106)

artist <- unique(master_dataframe$artist)
artist <- rep(artist, each = 4)

ref_df <- data.frame(artist, year)

songs_tiktok_19_table <- table(tiktok_19$artist)
songs_tiktok_19 <- data.frame(songs_tiktok_19_table) %>%
  rename(artist = Var1) %>%
  mutate(year = 2019)

ref_df <- ref_df %>% left_join(songs_tiktok_19, by =c('artist', 'year')) 
ref_df[is.na(ref_df)] = 0
ref_df <- ref_df %>% rename(pop_on_tiktok = Freq)

#########################################################################################################

songs_spotify_19_table <- table(spotify_19$artist)
songs_spotify_19 <- data.frame(songs_spotify_19_table) %>%
  rename(artist = Var1) %>%
  mutate(year = 2019)

ref_df <- ref_df %>% left_join(songs_spotify_19, by = c('artist', 'year'))
ref_df[is.na(ref_df)] = 0
ref_df <- ref_df %>% rename(pop_on_spotify = Freq)

#########################################################################################################

songs_both_19 <- master_dataframe %>% 
  filter(year == 2019)

songs_both_19 <- subset(songs_both_19, select = c(-song_title))
songs_both_19_table <- table(songs_both_19)
songs_both_19 <- data.frame(songs_both_19_table)
songs_both_19 <- songs_both_19[, c(1, 3, 2)]
songs_both_19 <- songs_both_19 %>% mutate(year = as.character(year))

ref_df <- ref_df %>% mutate(year = as.character(year))
ref_df <- ref_df %>% left_join(songs_both_19, by = c('artist', 'year'))
ref_df[is.na(ref_df)] = 0
ref_df <- ref_df %>% rename(pop_on_both = Freq)

#########################################################################################################

year <-rep(c(2019,2020,2021,2022),times=106)

artist <- unique(master_dataframe$artist)
artist <- rep(artist, each = 4)

ref_2_df <- data.frame(artist, year)

songs_tiktok_20_table <- table(tiktok_20$artist)
songs_tiktok_20 <- data.frame(songs_tiktok_20_table) %>%
  rename(artist = Var1) %>%
  mutate(year = 2020) %>%
  mutate(year = as.character(year))

ref_2_df <- ref_2_df %>% mutate(year = as.character(year))
ref_2_df <- ref_2_df %>% left_join(songs_tiktok_20, by =c('artist', 'year')) 
ref_2_df[is.na(ref_2_df)] = 0
ref_2_df <- ref_2_df %>% rename(pop_on_tiktok = Freq)

#########################################################################################################

songs_spotify_20_table <- table(spotify_20$artist)
songs_spotify_20 <- data.frame(songs_spotify_20_table) %>%
  rename(artist = Var1) %>%
  mutate(year = 2020) %>%
  mutate(year = as.character(year))

ref_2_df <- ref_2_df %>% mutate(year = as.character(year))
ref_2_df <- ref_2_df %>% left_join(songs_spotify_20, by = c('artist', 'year'))
ref_2_df[is.na(ref_2_df)] = 0
ref_2_df <- ref_2_df %>% rename(pop_on_spotify = Freq)

#########################################################################################################

songs_both_20 <- master_dataframe %>% 
  filter(year == 2020)

songs_both_20 <- subset(songs_both_20, select = c(-song_title))
songs_both_20_table <- table(songs_both_20)
songs_both_20 <- data.frame(songs_both_20_table)
songs_both_20 <- songs_both_20[, c(1, 3, 2)]
songs_both_20 <- songs_both_20 %>% mutate(year = as.character(year))

ref_2_df <- ref_2_df %>% mutate(year = as.character(year))
ref_2_df <- ref_2_df %>% left_join(songs_both_20, by = c('artist', 'year'))
ref_2_df[is.na(ref_2_df)] = 0
ref_2_df <- ref_2_df %>% rename(pop_on_both = Freq)
#########################################################################################################

new_df <- ref_2_df %>% left_join(ref_df, by = c('artist', 'year'))

#########################################################################################################
year <-rep(c(2019,2020,2021,2022),times=106)

artist <- unique(master_dataframe$artist)
artist <- rep(artist, each = 4)

ref_3_df <- data.frame(artist, year)

songs_tiktok_21_table <- table(tiktok_21$artist)
songs_tiktok_21 <- data.frame(songs_tiktok_21_table) %>%
  rename(artist = Var1) %>%
  mutate(year = 2021) %>%
  mutate(year = as.character(year))

ref_3_df <- ref_3_df %>% mutate(year = as.character(year))
ref_3_df <- ref_3_df %>% left_join(songs_tiktok_21, by =c('artist', 'year')) 
ref_3_df[is.na(ref_3_df)] = 0
ref_3_df <- ref_3_df %>% rename(pop_on_tiktok = Freq)

#########################################################################################################

songs_spotify_21_table <- table(spotify_21$artist)
songs_spotify_21 <- data.frame(songs_spotify_21_table) %>%
  rename(artist = Var1) %>%
  mutate(year = 2021) %>%
  mutate(year = as.character(year))

ref_3_df <- ref_3_df %>% mutate(year = as.character(year))
ref_3_df <- ref_3_df %>% left_join(songs_spotify_21, by = c('artist', 'year'))
ref_3_df[is.na(ref_3_df)] = 0
ref_3_df <- ref_3_df %>% rename(pop_on_spotify = Freq)

#########################################################################################################

songs_both_21 <- master_dataframe %>% 
  filter(year == 2021)

songs_both_21 <- subset(songs_both_21, select = c(-song_title))
songs_both_21_table <- table(songs_both_21)
songs_both_21 <- data.frame(songs_both_21_table)
songs_both_21 <- songs_both_21[, c(1, 3, 2)]
songs_both_21 <- songs_both_21 %>% mutate(year = as.character(year))

ref_3_df <- ref_3_df %>% mutate(year = as.character(year))
ref_3_df <- ref_3_df %>% left_join(songs_both_21, by = c('artist', 'year'))
ref_3_df[is.na(ref_3_df)] = 0
ref_3_df <- ref_3_df %>% rename(pop_on_both = Freq)

#########################################################################################################

new_df_2 <- ref_3_df %>% left_join(new_df, by = c('artist', 'year'))

#########################################################################################################
year <-rep(c(2019,2020,2021,2022),times=106)

artist <- unique(master_dataframe$artist)
artist <- rep(artist, each = 4)

ref_4_df <- data.frame(artist, year)

songs_tiktok_22_table <- table(tiktok_22$artist)
songs_tiktok_22 <- data.frame(songs_tiktok_22_table) %>%
  rename(artist = Var1) %>%
  mutate(year = 2022) %>%
  mutate(year = as.character(year))

ref_4_df <- ref_4_df %>% mutate(year = as.character(year))
ref_4_df <- ref_4_df %>% left_join(songs_tiktok_22, by =c('artist', 'year')) 
ref_4_df[is.na(ref_4_df)] = 0
ref_4_df <- ref_4_df %>% rename(pop_on_tiktok = Freq)

#########################################################################################################

songs_spotify_22_table <- table(spotify_22$artist)
songs_spotify_22 <- data.frame(songs_spotify_22_table) %>%
  rename(artist = Var1) %>%
  mutate(year = 2022) %>%
  mutate(year = as.character(year))

ref_4_df <- ref_4_df %>% mutate(year = as.character(year))
ref_4_df <- ref_4_df %>% left_join(songs_spotify_22, by = c('artist', 'year'))
ref_4_df[is.na(ref_4_df)] = 0
ref_4_df <- ref_4_df %>% rename(pop_on_spotify = Freq)

#########################################################################################################

songs_both_22 <- master_dataframe %>% 
  filter(year == 2022)

songs_both_22 <- subset(songs_both_22, select = c(-song_title))
songs_both_22_table <- table(songs_both_22)
songs_both_22 <- data.frame(songs_both_22_table)
songs_both_22 <- songs_both_22[, c(1, 3, 2)]
songs_both_22 <- songs_both_22 %>% mutate(year = as.character(year))

ref_4_df <- ref_4_df %>% mutate(year = as.character(year))
ref_4_df <- ref_4_df %>% left_join(songs_both_22, by = c('artist', 'year'))
ref_4_df[is.na(ref_4_df)] = 0
ref_4_df <- ref_4_df %>% rename(pop_on_both = Freq)

#########################################################################################################

new_df_3 <- ref_4_df %>% left_join(new_df_2, by = c('artist', 'year'))

#########################################################################################################

new_df_3$pop_on_tiktok=rowSums(cbind(new_df_3$pop_on_tiktok.x.x,new_df_3$pop_on_tiktok.y, 
                                   new_df_3$pop_on_tiktok.x, new_df_3$pop_on_tiktok.y.y))
new_df_3 <- new_df_3[, -c(3, 6, 9, 12)]

new_df_3$pop_on_spotify=rowSums(cbind(new_df_3$pop_on_spotify.x,new_df_3$pop_on_spotify.x.x, 
                                     new_df_3$pop_on_spotify.y, new_df_3$pop_on_spotify.y.y))
new_df_3 <- new_df_3[, -c(3, 5, 7, 9)]

new_df_3$pop_on_both=rowSums(cbind(new_df_3$pop_on_both.x,new_df_3$pop_on_both.x.x, 
                                     new_df_3$pop_on_both.y, new_df_3$pop_on_both.y.y))

new_df_3 <- new_df_3[, -c(3, 4, 5, 6)]

final_dataframe <- new_df_3
