# This is summary_table organization


library(dplyr)
library(tidyr)

#--------------------------------------------------------

# READING DATA

#reading the tiktok popular songs file
tiktok_popular_2021 <- read.csv(file = "data/TikTok_songs_2021.csv")

#reading top 2022 tiktok songs
tiktok_popular_2022 <- read.csv(file = "data/TikTok_songs_2022.csv")

#reading spotify top 2021
spotify_2021 <- read.csv(file = "data/spotify_charts_2021.csv")

#reading spotify top 2022
spotify_2022 <- read.csv(file = "data/spotify_charts_2022.csv")

#reading charts 
charts <- read.csv(file = "data/charts.csv")



#----------------------------------------------------------

#combining all popular tiktok songs

tiktok_popular_both <- full_join(tiktok_popular_2021, tiktok_popular_2022)


#combining all popular spotify songs

spotify_popular_both <- full_join(spotify_2021, spotify_2022)


#cleaning up both tables to relevant info

tiktok_popular_both <- tiktok_popular_both %>% 
  select(
    track_name,
    artist_name,
    album
  )

spotify_popular_both <- spotify_popular_both %>% 
  select(
    track_name,
    artist_names,
    peak_rank, 
    weeks_on_chart
  )

tiktok_and_spotify_popular <- left_join(
  spotify_popular_both,
  tiktok_popular_both,
  by = c("track_name",
         "artist_names" = "artist_name"
         )
  )

# tiktok_and_spotify_popular <- tiktok_and_spotify_popular %>% distinct()


write.csv(tiktok_and_spotify_popular, file = 'tiktok_and_spotify_popular.csv', na = '0') 
