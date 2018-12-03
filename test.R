library(httr)
library(jsonlite)
library(dplyr)
library(spotifyr)
library(ggplot2)

Sys.setenv(SPOTIFY_CLIENT_ID = "14c1d5db508741c2bd9e25a36f6d04ee")
Sys.setenv(SPOTIFY_CLIENT_SECRET = "066386b6f54743d5b8d9a6581e64f41c")
access_token <- get_spotify_access_token()



library(shiny)
library(ggplot2)
library(dplyr)
library(spotifyr)
Sys.setenv(SPOTIFY_CLIENT_ID = "14c1d5db508741c2bd9e25a36f6d04ee")
Sys.setenv(SPOTIFY_CLIENT_SECRET = "066386b6f54743d5b8d9a6581e64f41c")
access_token <- get_spotify_access_token()

server <- function(input, output) {
  output$artist_danceability <- renderPlot({
    # get info about top 50 most dancable songs for an artist
    artist_songs <- get_artist_audio_features(input$artist)
    artist_songs <- artist_songs %>% 
      group_by(track_name) %>% 
      filter(row_number() == 1)
    artist_songs$track_name <- factor(artist_songs$track_name, levels = artist_songs$track_name[order(artist_songs$track_popularity)])
    artist_songs <- head(artist_songs, 50)
    
    # create and return bargraph of top 50 songs' danceability
    artist_danceability <- ggplot(data = artist_songs) +
      geom_bar(mapping = aes(x = track_name, y = danceability, fill = album_name), stat = "identity") +
      coord_flip() +
      labs(
        title = "Danceability of Popular Songs",
        x = "Songs (sorted by popularity top to bottom)",
        y = "Danceability",
        fill = "Albums:"
      ) +
      theme(legend.position = "top")
    return(artist_danceability)
  })
  output$text <- renderText({
    "Type in the name of the Artist you like to see his/her most popular songs' dancebility distribution and the relationship between valence and dancebility.
                 Some artists' data may not be shown because of privacy issue. This app only applies to artists who give Spotify full accesss to their data. Try these if you
                 have no idea whose name to type in: "
  })
  
  output$name1 <- renderText({
    "Coldplay"
  })
  
  output$name2 <- renderText({
    "David Guetta"
  })
  
  output$name3 <- renderText({
    "Ariana Grande"
  })
  
  output$name4 <- renderText({
    "Drake"
  })
  
  output$name5 <- renderText({
    "Justin Bieber"
  })
  
  output$name6 <- renderText({
    "Rihanna"
  })
  
  output$name7 <- renderText({
    "Bruno Mars"
  })

output$space <- renderText({
  "-----------"
})

output$valence_dance <- renderPlot({
  # get info about top 50 most dancable songs for an artist
  artist_songs <- get_artist_audio_features(input$artist)
  artist_songs <- artist_songs %>% 
    group_by(track_name) %>% 
    filter(row_number() == 1)
  artist_songs$track_name <- factor(artist_songs$track_name, levels = artist_songs$track_name[order(artist_songs$track_popularity)])
  artist_songs <- head(artist_songs, 50)
  
  valence_dance <- ggplot(data = artist_songs) +
    geom_point(mapping = aes(x = danceability, y = valence)) +
    geom_smooth(mapping = aes(x = danceability, y = valence))
  return(valence_dance)
})
}



library(shiny)
library(shinyWidgets)
dplyr::bind_rows()
ui <- fluidPage(
  titlePanel("Spotify Artist Information"),
  # layout the page in two columns
  sidebarLayout( 
    # specify content for the "sidebar" column
    sidebarPanel(   
      searchInput("artist", label = "What artist do you want to know about?"),
      textOutput("text"),
      textOutput("space"),
      textOutput("name1"),
      textOutput("name2"),
      textOutput("name3"),
      textOutput("name4"),
      textOutput("name5"),
      textOutput("name6"),
      textOutput("name7")
    ),
    
    # specify content for the "main" column
    mainPanel(   
      plotOutput("artist_danceability", height = "800px"),
      plotOutput("valence_dance")
    )
  )
)
