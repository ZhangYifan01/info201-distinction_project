library(shiny)
library(shinyWidgets)

my_ui <- fluidPage(
  titlePanel("Spotify Artist Information"),
  # layout the page in two columns
  sidebarLayout( 
    # specify content for the "sidebar" column
    sidebarPanel(   
      searchInput("artist", label = "What artist do you want to know about?")
    ),
    # specify content for the "main" column
    mainPanel(   
      plotOutput("artist_danceability", height = "800px"),
      plotOutput("valence_dance")
    )
  )
)

shinyUI(my_ui)