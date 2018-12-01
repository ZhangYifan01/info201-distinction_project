# getting spotify song information from the spotify api
library(httr)
library(jsonlite)
library(dplyr)
library(spotifyr)

#Sys.setenv(SPOTIFY_CLIENT_ID = "14c1d5db508741c2bd9e25a36f6d04ee")
#Sys.setenv(SPOTIFY_CLIENT_SECRET = "066386b6f54743d5b8d9a6581e64f41c")
access_token <- get_spotify_access_token()

Khalid <- get_artist_audio_features('Khalid')
#Khalid <- get_artists("Khalid") %>% 
#  filter(Khalid, artist_name == "Khalid")
#Khalidalbums <- get_albums("Khalid")

#authorize_base <- "https://accounts.spotify.com"
#authorize_endpoint <- "authorize"
#authorize_uri <- paste(authorize_base, authorize_endpoint, sep = "/")
#authorize_params <- list(client_id = client_id, response_type = "token", redirect_uri = "")
#authorize_result <- GET(authorize_uri)
#authorize_data <- content(authorize_result, "text") %>% fromJSON()

