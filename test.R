# getting spotify song information from the spotify api
#library(httr)
#library(jsonlite)
#library(dplyr)
#library(spotifyr)

#Sys.setenv(SPOTIFY_CLIENT_ID = "14c1d5db508741c2bd9e25a36f6d04ee")
#Sys.setenv(SPOTIFY_CLIENT_SECRET = "066386b6f54743d5b8d9a6581e64f41c")
#access_token <- get_spotify_access_token()

#Khalid <- get_artist_audio_features('Khalid')
#Khalid <- get_artists("Khalid") %>% 
#  filter(Khalid, artist_name == "Khalid")
#Khalidalbums <- get_albums("Khalid")

#authorize_base <- "https://accounts.spotify.com"
#authorize_endpoint <- "authorize"
#authorize_uri <- paste(authorize_base, authorize_endpoint, sep = "/")
#authorize_params <- list(client_id = client_id, response_type = "token", redirect_uri = "")
#authorize_result <- GET(authorize_uri)
#authorize_data <- content(authorize_result, "text") %>% fromJSON()\


library(httr)
library(jsonlite)
library(dplyr)
library(spotifyr)
library(ggplot2)

Sys.setenv(SPOTIFY_CLIENT_ID = "14c1d5db508741c2bd9e25a36f6d04ee")
Sys.setenv(SPOTIFY_CLIENT_SECRET = "066386b6f54743d5b8d9a6581e64f41c")
access_token <- get_spotify_access_token()

#Khalid <- get_artist_audio_features('Khalid')
Khalid <- get_artists("David Bowie") %>% 
  filter(artist_name == "David Bowie")

Khalid_feature <- get_artist_audio_features("David Bowie",
                                            access_token = get_spotify_access_token())
David Bowie
Khalid_dance <- data.frame(song_name = Khalid_feature$track_name, dance = Khalid_feature$danceability, album = Khalid_feature$album_name)
Khalid_dance <- Khalid_dance %>% 
  group_by(song_name) %>% 
  filter(row_number() == 1)
Khalid_dance$song_name <- factor(Khalid_dance$song_name, levels = unique(Khalid_dance$song_name[order(Khalid_dance$dance)]))
Khalid_dance <- head(Khalid_dance, 50)
ggplot(Khalid_dance, aes(x = song_name, y = dance, fill = album))+geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

