library(dplyr)
library(ggplot2)

# selected only columns "track_name" (renamed to "title") and "artist_name" (renamed
# "artist") for easy reading
tiktok_22 <- read.csv("./data/TikTok_songs_2022.csv") %>%
  select(track_name, artist_name) %>%
  rename(title = track_name) %>%
  rename(artist = artist_name)

# selected only columns "title", "artist", and "duration" for merging and to 
# see where the spotify and tiktok datasets don't match
spotify_22 <- read.csv("Top_Songs_2022_BEST_HITS_2022.csv") %>%
  select(title, artist, duration)

# merged spotify into tiktok data because the tiktok data had more rows (263 vs. 220)
# made another column through "duration" results to see whether a song had appeared on 
# both the Spotify and TikTok data set. Returns either TRUE or NA
a <- left_join(tiktok_22, spotify_22) %>%
  mutate(tiktok_and_spotify = (duration >= 0))

# made a stacked bar chart through "tiktok_and_spotify" column. Compares the amount 
# of trues and na's
ggplot(a) +
  geom_col(mapping = aes(x = "artist", y = "title", fill = tiktok_and_spotify)
) 
