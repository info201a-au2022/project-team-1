# This is code for organizing the main data frame

library(dplyr)
library(tidyr)

#----------------------------------------------------------

# READING DATA

#reading the tiktok popular songs file
tiktok_popular_2021 <- read.csv(file = "data/TikTok_songs_2021.csv")

#reading the billboard 100
billboard_100 <- read.csv(file = "data/charts.csv")

#notes on how data is organized
# the chart is organized as top 100 for every **WEEK** 

#reading top 2022 tiktok songs
tiktok_popular_2022 <- read.csv(file = "data/TikTok_songs_2022.csv")

#reading spotify top 2022
spotify_2022 <- read.csv(file = "data/Top Songs 2022  BEST HITS 2022.csv")

#reading charts
#Note: Charts is the same as billboard, just with some more columns
charts <- read.csv(file = "data/charts.csv")

#-------------------------------------------------------------

# Organizational work

# ----------------------------------------------
# Organizing 2022 artists

# Creating a data frame of just artists and the number of popular songs
# they had on tiktok in 2022
in2022_num_of_songs_of_popular_artists_tiktok <- tiktok_popular_2022 %>% 
  group_by(artist_name) %>% 
  summarize(
    num_of_pop_songs = length(unique(track_name))
  )

# Creating a data frame of all the artists on spotify in 2022
spotify_artists_2022 <- spotify_2022 %>% 
  summarize(
    artist_name = unique(artist)
  )

# Combining ALL artists of spotify 2022 and adding how many songs they had
# popular on tiktok. If they didn't have any, it will just say N/A. This is made
# so we can analyze how many were popular vs. how many were not.
in2022_spotify_and_popular_tiktok_artists <- left_join(
  spotify_artists_2022, 
  in2022_num_of_songs_of_popular_artists_tiktok, 
  by = "artist_name"
)

# ----------------------------------------------
# Organizing 2021 artists
# Basically, same organization as 2022, but just because billboard data
# is organized a bit different, it was a slightly different approach

# Creating a data frame of all the artists on billboard in 2022
billboard_artists_2021 <- billboard_100 %>% 
  filter(date >= "2021-01-01")  %>% 
  summarize(
    artist_name = unique(artist)
  )



# Creating a data frame of just artists and the number of popular songs
# they had on tiktok in 2021
num_of_songs_of_popular_artists_tiktok <- tiktok_popular_2021 %>% 
  group_by(artist_name) %>% 
  summarize(
    num_of_pop_songs = length(unique(track_name))
  )

# Combining ALL artists of billboard 2021 and adding how many songs they had
# popular on tiktok. If they didn't have any, it will just say N/A. This is made
# so we can analyze how many were popular vs. how many were not.
billboard_and_popular_tiktok_artists <- left_join(
  billboard_artists_2021, 
  num_of_songs_of_popular_artists_tiktok, 
  by = "artist_name"
)

all_popular_tiktok_songs <- full_join(tiktok_popular_2021, tiktok_popular_2022)

# ---------------------------------------------------------
# Organizing the main data frame
# While the previous organization was used to pick out very specific parts of
# the data, I am making this data frame from which all those conclusions can be
# analyzed and drawn upon, but this is just to keep all this info together.

# Because I made that first organizational work while just exploring that data,
# it is not how it should have been organized in the first place. It might still
# be helpful, but if you're working on analysis and charts, THIS IS THE DATA 
# FRAME YOU SHOULD BE USING.

# I will also write in a separate csv for it that would probably be better used
# for analysis and charts that are going to be on the report
# but if you wanted to trace down how that data was organized, it's all in here.

# In this data frame, I'm combining the main metrics that I think would be 
# useful for the analysis. Feel free to change it as you see.

main_data_frame <- full_join(
  in2022_num_of_songs_of_popular_artists_tiktok, 
  billboard_and_popular_tiktok_artists, by = "artist_name", "num_of_pop_songs"
)

main_data_frame <- main_data_frame %>% 
  mutate(
    num_of_pop_songs = num_of_pop_songs.x + num_of_pop_songs.y
  )


refined_charts <- billboard_100 %>% 
  filter(date >= "2021-01-01")  %>% 
  group_by(song) %>% 
  summarize(
    song = unique(song),
    artist_name = unique(artist),
    weeks_on_board = max(weeks.on.board)
  )

refined_spotify <- spotify_2022 %>% 
  group_by(title) %>% 
  summarise(
    title = unique(title),
    artist_name = unique(artist)
  )

main_data_frame <- full_join(refined_charts, main_data_frame)



#renaming columns for readability
#once ran once, can't be ran again??

main_data_frame <- main_data_frame %>% 
  rename(
    "Weeks on Billboard Charts" = "weeks_on_board",
    "# of Songs Trending on Tiktok by Artist in 2021" = "num_of_pop_songs.x",
    "# of Songs Trending on Tiktok by Artist in 2022" = "num_of_pop_songs.y",
    "Total # of Songs Trending on Tiktok by Artist" = "num_of_pop_songs"
  )

# for some reason, there are two song columns. won't delete them for now, but 
# they should be removed eventually