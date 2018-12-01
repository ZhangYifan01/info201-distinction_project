library(shiny)
library(ggplot2)
library(dplyr)
library(spotifyr)
Sys.setenv(SPOTIFY_CLIENT_ID = "14c1d5db508741c2bd9e25a36f6d04ee")
Sys.setenv(SPOTIFY_CLIENT_SECRET = "066386b6f54743d5b8d9a6581e64f41c")
access_token <- get_spotify_access_token()

my_server <- function(input, output) {
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

shinyServer(my_server)