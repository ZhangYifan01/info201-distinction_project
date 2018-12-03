library(shiny)
library(shinyWidgets)

my_ui <- fluidPage(
  titlePanel("Spotify Artist Information"),
  # layout the page in two columns
  sidebarLayout( 
    # specify content for the "sidebar" column
    sidebarPanel(   
      searchInput("artist", label = "What artist do you want to know about?"),
      p("Type in the name of an artist to see his/her most popular songs' dancebility distribution and the 
          relationship between valence and dancebility. Some artists' data may not be shown because of 
          privacy issues. This app only applies to artists who give Spotify full accesss to their data. Try 
          these if you have no idea whose name to type in:"),
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
      plotOutput("artist_danceability", height = "800px"),
      plotOutput("valence_dance", hover = hoverOpts("plot_hover", delay = 100, delayType = "debounce")),
      textOutput("song_info")
    )
  )
)

shinyUI(my_ui)