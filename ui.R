library(shiny)
library(shinyWidgets)
library(plotly)

title <- "Spotify Artist Information Project"
by <- "By Cole Van Pelt, Joseph Wu & Yifan Zhang"
API_info <- "Our project utilizes the data provided by the Spotify API Project to create graphs showing 
  different Spotify artists' top songs' danceability distribution and relationship between danceability 
  and valence. We access the data stored in the API using a package called SpotifyR which wraps API calls 
  into methods. In order to access the data, you need a developer Spotify account as well as the Spotify ID 
  and secret ID linked to that developer account."
Audience <- "Our target audience for this project is people who stream music and care about the danceability 
  and valence of their music. This will tend to be people in their late teens and early twenties, because 
  they are the primary group that uses streaming services, and they care the most about how easy a song is 
  to dance to and how it makes them feel. Even though our data is acquired from Spotify, it can be used to 
  find trends in all streaming services, so our audience is not restricted to just Spotify users."
Plot_info <- "The first plot is a bar graph showing the danceability of up to the top 50 most popular songs 
  by the artist searched. If the artist has less than 50 songs, only the number of songs they have will be 
  shown. Our second plot is a scatter plot showing the correlation between danceability and valence. On this
  plot there is also a trend line of the correlation with an indicator for how much variation there is from it."
Measurment_info <- "The three measurements that we used to extract information about songs were popularity, 
  danceability and valence. Popularity is calculated and given a score from 0 to 100 using the number of plays
  a song has, with more recent plays being counted more highly. Danceability describes how suitable a track 
  is for dancing based on a combination of musical elements including tempo, rhythm stability, beat strength,
  and overall regularity. A value of 0.0 is least danceable and 1.0 is most danceable. Valence is a measure 
  from 0.0 to 1.0 describing the musical positiveness conveyed by a track. Tracks with high valence sound more
  positive (e.g. happy, cheerful, euphoric), while tracks with low valence sound more negative (e.g. sad, 
  depressed, angry)."
Disclaimer <- "Some artist don't allow Spotify to expose their data to the public, so their data cannot be 
  fetched."

my_ui <- fluidPage(
  titlePanel("Spotify Artist Information"),
  # layout the page in two columns
  sidebarLayout( 
    # specify content for the "sidebar" column
    sidebarPanel(   
      searchInput("artist", label = "What artist do you want to know about?"),
      p("Type in the name of an artist to see information about his/her most popular songs.
        If you have no idea whose name to type in try these:"),
      p("-----------"),
      p("Coldplay"),
      p("David Guetta"),
      p("Ariana Grande"),
      p("Drake"),
      p("Justin Bieber"),
      p("Rihanna"),
      p("Bruno Mars")
    ),
    # specify content for the "main" column
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Danceability and Popularity", 
                           plotOutput("plot1", height = "800px")),
                  tabPanel("Danceability and Valence", 
                           plotlyOutput("plot2", height = "600px")),
                  tabPanel("About", 
                           h1(title),
                           h3(by),
                           p(API_info),
                           p(Measurment_info),
                           p(Plot_info),
                           p(Audience),
                           p(Disclaimer))
      )
    )
  )
)

shinyUI(my_ui)