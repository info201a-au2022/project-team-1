# This is code for making the summary

library(dplyr)
library(tidyr)

#----------------------------------------------------------

# READING DATA

#reading the tiktok popular songs file
tiktok_popular_2021 <- read.csv(file = "data/TikTok_songs_2021.csv")

#notes on how data is organized


#reading the billboard 100
billboard_100 <- read.csv(file = "data/charts.csv")

#notes on how data is organized
# the chart is organized as top 100 for every **WEEK** 

#reading top 2022 tiktok songs
tiktok_popular_2022 <- read.csv(file = "data/TikTok_songs_2022.csv")

#reading spotify top 2022
spotify_2022 <- read.csv(file = "data/Top Songs 2022  BEST HITS 2022.csv")

#reading charts
charts <- read.csv(file = "data/charts.csv")

#-------------------------------------------------------------

# Summarizing 