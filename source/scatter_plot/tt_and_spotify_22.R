library(dplyr)
library(ggplot2)

# 2022 version.  
# later changed it to `project-team-1` so look into markdown

# reduced columns of spotify_charts_2022.csv to just 4 columns
# renamed columns for merging later
s_spotify_22 <- read.csv("data/spotify_charts_2022.csv") %>%
  select(artist_names, track_name, peak_rank, weeks_on_chart) %>%
  rename(artist = artist_names, song_title = track_name)

# reduced columns of TikTok_songs_2022.csv to 4 columns
# renamed columns for merging
s_tiktok_22 <- read.csv("data/TikTok_songs_2022.csv") %>%
  select(track_name, artist_name, album, track_pop) %>%
  rename(song_title = track_name, artist = artist_name)

# merged both charts together
s_chart_22 <- left_join(s_spotify_22, s_tiktok_22, by = c("song_title", "artist")) %>%
  arrange(-peak_rank)

# making plot for chart$peak_rank
s_chart_22$song_title <- as.vector(s_chart_22$song_title) #gets rid of alphabetical order
unique_2022 <- unique(s_chart_22$song_title)
s_chart_22$song_title = factor(s_chart_22$song_title, levels = unique_2022, ordered = TRUE) #adds ordering from arrange()

# JUST ADDED THIS
# -----------------------------------------------------
# add another column for "year" just to say 2022
s_chart_22 <- s_chart_22 %>%
  mutate(Year = "2022")
# --------------------------------------------------------

point_peak_rank_22 <- ggplot(
  data = s_chart_22, 
  aes(track_pop, -peak_rank, col = "2022")) + geom_point()

# Adding labels to the axis
point_peak_rank_22 <- point_peak_rank_22 + labs(
  title = "Peak Rankings of 2022 Songs on \nof Spotify and TikTok",
  y = "Ranking on Spotify",
  x = "Popularity on TikTok"
)


# OG CODING AFTER POINT_PEAK_RANK_22 LINE 28
# ------------------------------------------------------------------------
# Adding labels to the axis
#print(point_peak_rank_22 + labs(
  #title = "Peak Rankings of 2022 Songs on \nof Spotify and TikTok",
  #y = "Ranking on Spotify",
  #x = "Popularity on TikTok"
#))