library(shiny)
library(plotly)
source("source/stacked_bar_chart/trending_artists.R")

# Intro Panel 1 (Kim) ----------------------------------------------------------

intro_panel <- tabPanel(
  "Introduction",
  tags$head(
    tags$style(HTML("
    @import url('https://fonts.googleapis.com/css2?family=Rubik:wght@500&display=swap');
    h1 {
      font-family: 'Rubik', sans-serif;
      align-text: center;
      color: #3D388F;
    }
    
  "))),
  
  titlePanel(h1(strong("Examining TikTok's Effects On the Music Industry")))
)
# ------------------------------------------------------------------------------
# Scatter Plot Panel (Kim) -----------------------------------------------------

# SIDEBAR panel `sidebarPanel()` to have a radioButton of multiple years, each
# year being a different data set
radio_sidebar_content <- sidebarPanel(
  radioButtons(
    inputId = "year",
    label = "Choose a year",
    choiceNames = c("2019", "2020", "2021", "2022"),
    choiceValues = c("s_chart_19", "s_chart_20", "s_chart_21", "s_chart_22"), # reminder
    # that when doing input$year, it's NOT "2019" but rather the chart 
    selected = NULL
  )
)
# Main panel to have the graphs show up after selecting year(s); reactive/output
radio_main_content <- mainPanel(
  plotlyOutput("graph"),
  p("The purpose of this graph is to compare the popularity of a song on TikTok versus 
    it's peak performance on Spotify charts. While the scale for the x-axis 
    (popularity on TikTok) is self explanatory, it should be noted that the 
    y-axis (peak position on Spotify) is flipped, as the higher a song charts, the 
    lower the numerical value (being #1 on Spotify has more value than being #200).")
)
# The full scatter plot PANEL all laid out
radio_panel <- tabPanel(
  "Scatter Plot", # this is the title of the TAB
  titlePanel("Chart Ranking v.s. TikTok Popularity"), # The actual title on the panel
  sidebarLayout(
    radio_sidebar_content,
    radio_main_content
  )
)
# ------------------------------------------------------------------------------
# Stacked Bar Chart Panel (Mie) ------------------------------------------------
barchart_side_content <- sidebarPanel(
  selectInput(
    "artistvar",
    label = "Select artist",
    choices = unique(final_dataframe$artist)
  )
)

barchart_main_content <- mainPanel(
  plotlyOutput("plot"),
  p("The purpose of this chart is to show how many songs an artist has that are popular on TikTok, Spotify, and both for each year from 2019-2022. This information is useful because it provides a strong analysis of which artists and what songs can find success on both platforms and which of them can't. Then we can use this analysis to draw conclusions on how/why the do/don't find success.")
)

bar_chart_panel <- tabPanel(
  "Bar Chart",
  titlePanel("Artist Song Popularity on TikTok vs. Spotify"),
  # A `sidebarLayout()` that contains...
  sidebarLayout(
    barchart_side_content,
    barchart_main_content
  )
)

# ------------------------------------------------------------------------------
# Pie Chart Panel (Xenia) ------------------------------------------------------
pie_panel <- tabPanel(
  "Pie Chart", # title of tab
  titlePanel("idk what title Xenia has"), # the title on the panel itself
  sidebarLayout(
    selectInput(
      "pievar",
      label = "Select year",
      choices = c("2019" = "summary_19",
                  "2020" = "summary_20",
                  "2021" = "summary_21",
                  "2022" = "summary_22")),
  mainPanel(plotlyOutput("pie"))
  )
)

# ------------------------------------------------------------------------------
# Summary Takeaways (Xenia) ----------------------------------------------------

# ------------------------------------------------------------------------------
# Report (Mie) -----------------------------------------------------------------
report_panel <- tabPanel(
  "Report", # title of tab
  titlePanel(strong("Project Report")),
  mainPanel(
    h6("Code Name: Tiktok-music"),
    h6("Project Title: Knock, Knock It’s TikTok: Examining TikTok’s Role in Changing the Music Industry"),
    h6("Report by: Mie Dunbar (dunbar11@uw.edu), Xenia Capcan (capcax@uw.edu), Kim Nguyen (kimng@uw.edu)"),
    h6("Affiliation: INFO-201: Technical Foundations of Informatics- The Information School- University of Washington"),
    h6("Date: Autumn 2022"),
    h3(strong("Abstract")),
    p("Our main question is “How does TikTok influence music trends?” This question is important because social media is constantly changing the music industry. To address the question, we will evaluate numerous databases to compare music trends on TikTok vs. Spotify and by observing popular songs and artists."),
    h3(strong("Key Words:")),
    p("-Overlap"),
    p("-Popular"),
    p("-Ranking"),
    h3(strong("Introduction")),
    p("Now that we have gathered our datasets and brainstormed various research questions, we have compiled our findings into interactive graphs and charts. We mainly tried to focus on the overlap of popular songs/artists on TikTok and on the Spotify Charts. We utilized their rankings to compare their success on each platform. From doing this analysis, we have gotten a better idea on how the music industry influences music on TikTok and vice versa. We created three useful visualizations which utilize aggregated data from our datasets and used these visualizations to reach conclusions. The main focus of our visualizations was to show wwhat kindn of overlap there is for songs between the two apps generally and on a more specific scale."),
    h3(strong("Problem Domain")),
    p("As we do an in depth analysis of popular music on TikTok and Spotify it is important to question the meaning of this analysis. We may ask who is benefiting from our findings and when/if our data will ever be utilized. Besides the average person's curiosity, our work can be very beneficial to music artists who are just getting started/have a small following. They can use our data to determine if they should release their new single first on TikTok or on Spotify or the other way around. If they notice a correlation between songs that do well on TikTok vs on Spotify, they can examine what these songs are like and what made them blow up. The source playlist push confirms this idea and writes that \"Smaller Indie Artists are generating substantial streaming growth from TikTok. Proof that success from TikTok comes in different sizes and can work for artists of all types (and budgets).\" As for already established artists, they can observe which of their songs are blowing up on TikTok and why. They can try promoting their song to be streamed on Spotify by engaging with the different trends that are using their song  on TikTok."),
    h3(strong("Research Questions")),
    p(strong("- For songs that are popular on both TikTok and Spotify, how do they rank on each?")),
    p("This is an important question to ask because we may wonder if the #1 song on TikTok would also be the #1 song on Spotify. This question is motivated by trying to find a correlation between the success of songs and artists on TikTok and on Spotify."),
    p(strong("- Do certain artists do well on both TikTok and Spotify?")),
    p("This is an important question to ask because we can use the data to determine if artists mainly do better on one platform vs both. It is motivated by trying to see if the songs that do well on both are similar and what they have in common."),
    p(strong("- What kind of overlap is there between popular songs on TikTok and Spotify charts?")),
    p("This is an important question to ask because it can help us understand if there are a lot of songs that do well on both apps. It is motivated by determining if the success of songs on one app has any impact on the success of the same songs on the other app."),
    h3(strong("The Dataset")),
    p("Our problem domain considers how the popularity of songs on TikTok vs on the Spotify charts. In order to address this question, we have collected a dataset with a variety of databases."),
    p("For our first question we can use the TikTok and Spotify data sets from all years to examine their popularity. Specifically we can look at the columns peak_rank, artist_pop and track_pop to see their rankings for each app."),
    p("For our second research question, we should again utilize all the datasets to examine which artists are popular on both Spotify and TikTok. We can create a table to show which songs are popular on both apps and then filter this data to find artists who have multiple songs."),
    p("For our third research question we can use all of the datasets to discover what kind of overlap there is between popular songs on TikTok and on Spotify charts. We can do so by joining the tables based on the common song titles."),
    tableOutput("table"),
    p("This data was collected by Sveta 151 on GitHub in August of 2022 for a personal project that considers how TikTok is changing the music industry and how trends songs on TikTok social media influence global top charts.They used a collection method to gather popular songs in TikTok for 2019, 2020, 2021, and 2022 using Spotify API. They explain that Spotify does not provide all popular songs from previous years; it also updates weekly top week charts. So, to get this information, they had to look at other sources. To do so, they performed web scraping using BeautifulSoup. Overall, the data is credible and trustworthy. We obtained this data by doing some general research for datasets on Kaggle when we stumbled upon this user and their project that has a very similar research question to ours. We credit the source of the data."),
    p(strong("Full Citations:")),
    p("-Tiktok Popular Songs 20219. Kaggle. Retrieved November 15, 2022, fromhttps://www.kaggle.com/datasets/sveta151/tiktok-popular-songs-2019"),
    p("-Tiktok Popular Songs 2020. Kaggle. Retrieved November 15, 2022, fromhttps://www.kaggle.com/datasets/sveta151/tiktok-popular-songs-2020"),
    p("-Tiktok Popular Songs 2021. Kaggle. Retrieved November 15, 2022, fromhttps://www.kaggle.com/datasets/sveta151/tiktok-popular-songs-2021"),
    p("-Tiktok Popular Songs 2022. Kaggle. Retrieved November 15, 2022, from https://www.kaggle.com/datasets/sveta151/tiktok-popular-songs-2022"),
    p("-Sveta151. (2022, August 29). TikTok_impact_on_the_top_charts/spotify_top_charts_19.csv at main · sveta151/tiktok_impact_on_the_top_charts. GitHub. Retrieved November 15, 2022, from https://github.com/Sveta151/TikTok_impact_on_the_top_charts/blob/main/spotify_top_charts_19.csv"),
    p("-Sveta151. (2022, August 29). TikTok_impact_on_the_top_charts/spotify_top_charts_20.csv at main · sveta151/tiktok_impact_on_the_top_charts. GitHub. Retrieved November 15, 2022, from https://github.com/Sveta151/TikTok_impact_on_the_top_charts/blob/main/spotify_top_charts_20.csv"),
    p("-Sveta151. (2022, August 29). TikTok_impact_on_the_top_charts/spotify_top_charts_21.csv at main · sveta151/tiktok_impact_on_the_top_charts. GitHub. Retrieved November 15, 2022, from https://github.com/Sveta151/TikTok_impact_on_the_top_charts/blob/main/spotify_top_charts_21.csv"),
    p("-Sveta151. (2022, August 29). TikTok_impact_on_the_top_charts/spotify_top_charts_22.csv at main · sveta151/tiktok_impact_on_the_top_charts. GitHub. Retrieved November 15, 2022, from https://github.com/Sveta151/TikTok_impact_on_the_top_charts/blob/main/spotify_top_charts_22.csv "),
    h3(strong("Expected Implications")),
    p("The expected implications from our findings are that there is overlap between popular songs on TikTok and on Spotify and that we can use this data to pick out which artists and what songs are trending. Implications may also suggest that certain artists are more popular than others and that these artists are already famous and established. This is due to the fact that small artists may blow up on TikTok but their fame may take a while to translate onto the Spotify charts if it translates at all. This is a good starting point for us and we can continue to dive deeper into this data for a more meaningful analysis in the future. Our results can be utilized by and important for app designers as it may inspire them to consider what the effects of fame can be for small singers, dancers, and other types of social media influencers."),
    h3(strong("Limitations")),
    p("Some limitations we need to address is that TikTok is a relatively new app, so there isn't a lot of data over many years that we can utilize. Or perhaps, if there is a correlation between songs popularity on TikTok and Spotify charts, it may not be distinguished yet to our eyes in the visualiztions. Another limitation we have considered is the prevelance of other apps similar to TikTok such as Instagram Reels and Youtube shorts. Although it is doubtful, there is a possibility that small artists are finding more success by using their songs on alternative social media apps these days."),
    h3(strong("Findings")),
    p("Our first question asks: For songs that are popular on both TikTok and Spotify, how do they rank on each? To answer this question, we used data wrangling to create a dataset that we could use to make four different scatterplots. Each scatterplot plots songs’ popularities on TikTok (the higher being the more popular) vs. their rankings on Spotify for each year from 2019-2022. Based on these visualizations, we were able to distinguish if there was any correlation between these variables. Over the years a correlation became more recognizable. By 2022, there was a clear grouping of points in the top right of the graph meaning higher rankings on Spotify correlate to more popularity on TikTok. So, we can conclude that the popularity of songs on TikTok might mean they become successful on Spotify and vice versa."),
    p("Our second question asks: Do certain artists do well on both TikTok and Spotify? To answer this question, we created an interactive stacked bar chart that allows the user to choose a specific artist they want to study. For each artist, it displays how many popular songs they have on TikTok, how many popular songs they have on Spotify, and how many popular songs they have on both platforms so users can determine what the overlap is like between platforms. After toggling through the different select options, we found that more mainstream artists tend to have more popular songs on Spotfiy than TikTok. For others, their numbers show more popular songs on TikTok. Overall, song popularity on the two platforms really depends on who the artist is and what kind of music they make."),
    p("Our third question asks: What kind of overlap is there between popular songs on TikTok and Spotify charts? To answer this question, we used data wrangling to create a dataset that we could use to make an interactive pie chart that toggles between the years of 2019-2022. Artists that have more songs that are popular on both TikTok and Spotify take a larger percentage of the pie chart. What the different charts reveal is that over the years, a certain group of artists tend to remain popular on both platforms. It also revealed that a number of new artists also take a larger percentage meaning there is a correlation between finding success on TikTok and Spotify."),
    h3(strong("Discussion")),
    p("As stated in the findings, we concluded that the popularity of songs on TikTok correlate to the popularity of songs on Spotify and vice versa. Our conclusion is important because it answers the question we have on the popularity overlap between TikTok and Spotify. This information can be used to help artists profit off of their music. By understanding this conclusion, mainstream, popular artists should promote their new Spotify hits/album on TikTok. They can try to create a trend or pay other influencers to spread it on TikTok. They can increase their profit if their song is also being used on TikTok, and more listeners will search for their song on Spotfiy after hearing it on TikTok. For smaller artists who are struggling to make it big in the music industry, they can try to popularize their music on TikTok and hope to see an increase in streams on Spotfiy as a result."),
    p("We also concluded that song popularity on the two platforms simply depends on who the artist is and what kind of music they make. Based on the charts it seems like Doja Cat and Lil Nas X do really well on both platforms. Artists can study why this is so and try to implement similar elements in their music that they do. Also, our chart allows users to study the analytics of specific artists, so they can choose artists who inspire them or who are similar to them and analyze their numbers. For example, a smaller artist similar to Olivia Rodrigo can use our interactive charts and find that she tends to have more popular songs on Spotify than TikTok. We might interpret this to mean that her music isn’t as danceable or upbeat enough for TikTok so similar artists shouldn’t expect to blow up on TikTok."),
    p("Lastly, we concluded that certain artists remain popular on both Spotify and TikTok over the years, but also, smaller artists can find their break too. Some of the established artists who remained constant are Doja Cat, Lil Nas X, and Justin Bieber. Their popular, catchy songs always seem to do really well with the trends on TikTok. However, in the other case, Steve Lacy only really blew up on TikTok this year and can’t even be found on the pie chart from 2018-2022. It can definitely be concluded that his songs popularity on TikTok contributed to its success on Spotify. This information is important because it confirms that newer artists can try to use TikTok to blow up on Spotify because it has worked for many artists."),
    h3(strong("Conclusion")),
    p("Over the quarter, our group has worked really hard to choose a meaningful yet interesting topic, find accurate and useful datasets, write code for data wrangling, and use our newly created dataframes to create an interactive webpage that can be used to help educate real people in the world! We decided to study music- specifically the popularity of songs on TikTok and Spotify and whether or not there is a correlation because it is something we were all passionate about. And beyond this, we discussed our conclusions to define the importance of our analysis and the implications of our findings."),
    p("If there was one thing we’d like to leave our audience with, it would be to learn from others and to utilize every aspect of what you’re given. In our case, this theme applies to music and making it big in the music industry. Before examining our web app and data findings, smaller artists might be unsure of how much effort they should put into promoting their music. It costs a lot of money to get others to post about it on Instagram or put it on a billboard for all to see. It may not seem worthwhile to pay famous influencers on TikTok to create dances to their songs in an effort to popularize it on the app. They may wonder if their success on TikTok would even translate to their success on the Spotify charts. Would they even be taken seriously in the music industry if their song is only popular because people are using it on TikTok?"),
    p("Our web application can anwer these questions and bring hope and inspiration to many smaller artists. It shows them that they can learn from other artists who have been in their position which will help them feel less alone and definitely less hesitant in their decisions. It also reminds them to utilize what they have. If they think TikTok could benefit their success, why not try it?"),
    p("It was hard work, but we are very proud to have created something that is not only interesting but super meaningful to others from a business and even investment standpoint. This information can act as a great starting point for an even bigger, more in depth analysis in the future."),
    h3(strong("References")),
    p("- Acclaim. (2020, June 10). 6 viral TikTok songs that changed artists' lives. Acclaim Magazine. Retrieved November 15, 2022, from https://acclaimmag.com/music/6-viral-tiktok-songs-that-changed-artists-lives/#11 "),
    p("-Andry, C. S. (n.d.). Dear tiktokers, dancing to trends does not equal celebrity status. Three Penny Press. Retrieved November 15, 2022, from https://threepennypress.org/opinions/2021/11/05/dear-tiktokers-dancing-to-trends-does-not-equal-celebrity-status/#:~:text=Gaining%20a%20lot%20of%20followers,not%20make%20these%20influencers%20celebrities."),
    p("Mitchell-Hardt, A. (2022, October 23). Do tiktok views lead to Spotify streams? Six things every artist needs to know. Playlist Push. Retrieved November 15, 2022, from https://playlistpush.com/blog/do-tiktok-views-lead-to-spotify-streams-four-things-every-artist-needs-to-know/")
    )
)
# ------------------------------------------------------------------------------

# Define the UI
ui <- navbarPage(
  "TikTok's Role in the Music Industry",
  # The report panels, most likely intro and other discussions
  intro_panel,
  # Scatter plot panel (Kim)
  radio_panel, 
  # Stacked bar chart panel (Mie)
  bar_chart_panel,
  # Pie chart panel (Xenia)
  pie_panel,
  # Report panel (Mie)
  report_panel
)

