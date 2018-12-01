library(shiny)
library(ggplot2)
library(dplyr)
library(spotifyr)
Sys.setenv(SPOTIFY_CLIENT_ID = "14c1d5db508741c2bd9e25a36f6d04ee")
Sys.setenv(SPOTIFY_CLIENT_SECRET = "066386b6f54743d5b8d9a6581e64f41c")
access_token <- get_spotify_access_token()

my_server <- function(input, output) {
  output$artist_plot <- renderPlot({
    # get info about top 50 most dancable songs for an artist
    artist <- get_artist_audio_features(input$artist)
    artist <- artist %>% 
      group_by(track_name) %>% 
      filter(row_number() == 1)
    artist$track_name <- factor(artist$track_name, levels = artist$track_name[order(artist$danceability)])
    artist <- head(artist, 50)
    
    # create and return bargraph of top 50 songs' danceability
    artist_plot <- ggplot(data = artist) +
      geom_bar(mapping = aes(x = track_name, y = danceability, fill = album_name), stat = "identity") +
      coord_flip() +
      labs(
        title = "Danceability of Songs",
        x = "Song Name",
        y = "Danceability",
        fill = "Albums:"
      ) +
      theme(legend.position = "top")
    return(artist_plot)
  })
}

shinyServer(my_server)