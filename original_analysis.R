# This is practice analysis for Info 201 Project Group 1
# This is not the final analysis, but simply an exploration

library(dplyr)
library(tidyr)

#----------------------------------------------------------

# READING DATA

#reading the tiktok popular songs file
tiktok_popular_2021 <- read.csv(file = "TikTok_songs_2021.csv")

#notes on how data is organized


#reading the billboard 100
billboard_100 <- read.csv(file = "charts.csv")

#notes on how data is organized
# the chart is organized as top 100 for every **WEEK** 

#reading top 2022 tiktok songs
tiktok_popular_2022 <- read.csv(file = "TikTok_songs_2022.csv")

#reading spotify top 2022
spotify_2022 <- read.csv(file = "Top Songs 2022  BEST HITS 2022.csv")

#-------------------------------------------------------------

# ANALYSIS

#Summary Questions

# 1: Artists

# 1a: What percent of all artists on in top 100 in 2021 were also in the popular songs on tiktok?
# NOTE: This is only for YEAR 2021 and only based on BILLBOARD
billboard100_2021 <- billboard_100 %>% 
  filter(date >= "2021-01-01") 

billboard_artists_2021 <- billboard100_2021 %>% 
  summarize(
    artist_name = unique(artist)
  )

#IMPORTANT NOTE: 
# Some artists repeat because they are in collab with someone. How to fix?

#match num of artists with num of artists in popular tiktok songs??

#unique the artists together in a summary?
#number of trending songs per artist
num_of_songs_of_popular_artists_tiktok <- tiktok_popular_2021 %>% 
  group_by(artist_name) %>% 
  summarize(
    num_of_pop_songs = length(unique(track_name))
  )

#data frame of both top billboard artists and num of tiktok songs they had
billboard_and_popular_tiktok_artists <- left_join(
    billboard_artists_2021, 
    num_of_songs_of_popular_artists_tiktok, 
    by = "artist_name"
    )

#calculating percentage
over_zero_songs <- billboard_and_popular_tiktok_artists %>% 
  filter(num_of_pop_songs >= 1)
  
percentage <- (nrow(over_zero_songs)/nrow(billboard_artists_2021)) * 100
# result: 6.4876957944072

#1b: What percent of artists trending on Spotify also had songs trending on Tiktok in 2022?

spotify_artists_2022 <- spotify_2022 %>% 
  summarize(
    artist_name = unique(artist)
  )

in2022_num_of_songs_of_popular_artists_tiktok <- tiktok_popular_2022 %>% 
  group_by(artist_name) %>% 
  summarize(
    num_of_pop_songs = length(unique(track_name))
  )

#data frame of both top spotify artists and num of tiktok songs they had
in2022_spotify_and_popular_tiktok_artists <- left_join(
  spotify_artists_2022, 
  in2022_num_of_songs_of_popular_artists_tiktok, 
  by = "artist_name"
)

#calculating percentage for 2022
in2022_over_zero_songs <- in2022_spotify_and_popular_tiktok_artists %>% 
  filter(num_of_pop_songs >= 1)

percentage_2022 <- (nrow(in2022_over_zero_songs)/nrow(spotify_artists_2022)) * 100
percentage_2022 <- round(percentage_2022, digits = 2)
#result: 20.77