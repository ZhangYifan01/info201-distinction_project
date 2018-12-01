library(httr)
library(jsonlite)
library(dplyr)
library(spotifyr)
library(ggplot2)

Sys.setenv(SPOTIFY_CLIENT_ID = "14c1d5db508741c2bd9e25a36f6d04ee")
Sys.setenv(SPOTIFY_CLIENT_SECRET = "066386b6f54743d5b8d9a6581e64f41c")
access_token <- get_spotify_access_token()

Khalid <- get_artist_audio_features("Khalid")

