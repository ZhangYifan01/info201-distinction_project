library(shiny)
library(ggplot2)
library(dplyr)
library(spotifyr)
library(shinyWidgets)

# make sure to run the sys.setenv to set the spotify client keys. These can be obtained by creating a developer spotify account

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
  
  output$song_info <- renderText({
    # get info about top 50 most dancable songs for an artist
    artist_songs <- get_artist_audio_features(input$artist)
    artist_songs <- artist_songs %>% 
      group_by(track_name) %>% 
      filter(row_number() == 1)
    artist_songs$track_name <- factor(artist_songs$track_name, levels = artist_songs$track_name[order(artist_songs$track_popularity)])
    artist_songs <- head(artist_songs, 50)
    
    # find point closest to curser
    point <- nearPoints(artist_songs, input$plot_hover, threshold = 5, maxpoints = 1)
    if (nrow(point) == 0) return(NULL)
    
    if (is.null(point)) {
      text <- "Song:"
    } else {
      text <- paste("Song:", point$track_name)
    }
    return(text)
    
    
    # calculate point position INSIDE the image as percent of total dimensions
    # from left (horizontal) and from top (vertical)
    #left_pct <- (hover$x - hover$domain$left) / (hover$domain$right - hover$domain$left)
    #top_pct <- (hover$domain$top - hover$y) / (hover$domain$top - hover$domain$bottom)
    
    # calculate distance from left and bottom side of the picture in pixels
    #left_px <- hover$range$left + left_pct * (hover$range$right - hover$range$left)
    #top_px <- hover$range$top + top_pct * (hover$range$bottom - hover$range$top)
    
    # create style property fot tooltip
    # background color is set so tooltip is a bit transparent
    # z-index is set so we are sure are tooltip will be on top
    #style <- paste0("position:absolute; z-index:100; background-color: rgba(245, 245, 245, 0.85); ",
    #                "left:", left_px + 2, "px; top:", top_px + 2, "px;")
    
    #wellPanel(
    #  style = style,
    #  p(HTML(paste0("<b> Song: </b>", point$track_name, "<br/>")))
    #                #"<b> Distance from left: </b>", left_px, "<b>, from top: </b>", top_px)))
    #)
    
  })
}

shinyServer(my_server)