library(shiny)
library(ggplot2)
library(dplyr)
library(spotifyr)
library(shinyWidgets)
library(plotly)

# make sure to run the sys.setenv to set the spotify client keys. These can be obtained by creating a developer spotify account

my_server <- function(input, output) {
  output$plot1 <- renderPlot({
    # get info about top 50 most dancable songs for an artist
    artist_songs <- get_artist_audio_features(input$artist)
    artist_songs <- artist_songs %>%  
      group_by(track_name) %>% 
      filter(row_number() == 1)
    artist_songs$track_name <- factor(artist_songs$track_name, levels = artist_songs$track_name[order(artist_songs$track_popularity)])
    artist_songs <- head(artist_songs, 50)
    
    # create and return bargraph of top 50 songs' danceability
    plot1 <- ggplot(data = artist_songs) +
      geom_bar(mapping = aes(x = track_name, y = danceability, fill = album_name), stat = "identity") +
      coord_flip() +
      labs(
        title = "Danceability of Popular Songs",
        x = "Songs (sorted by popularity top to bottom)",
        y = "Danceability",
        fill = "Albums:"
      ) +
      theme(legend.position = "top")
    return(plot1)
  })
  
  output$plot2 <- renderPlotly({
    # get info about top 50 most dancable songs for an artist
    artist_songs <- get_artist_audio_features(input$artist)
    artist_songs <- artist_songs %>% 
      group_by(track_name) %>% 
      filter(row_number() == 1)
    artist_songs$track_name <- factor(artist_songs$track_name, levels = artist_songs$track_name[order(artist_songs$track_popularity)])
    artist_songs <- head(artist_songs, 50)
    
    # create plotly scatterplot of danceability versus valence with trendline
    plot2 <- ggplot(data = artist_songs) +
      geom_point(mapping = aes(x = danceability, y = valence, text = paste("Song:", track_name), color = track_popularity)) +
      geom_smooth(mapping = aes(x = danceability, y = valence))
    plot2 <- ggplotly(plot2, layerData = 2, tooltip = "text")
    return(plot2)
  })
}

shinyServer(my_server)