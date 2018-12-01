library(shiny)

my_ui <- fluidPage(
  titlePanel("Spotify Artist Information"),
  # layout the page in two columns
  sidebarLayout( 
    # specify content for the "sidebar" column
    sidebarPanel(   
      textInput("artist", label = "What artist do you want to know about?")
    ),
    # specify content for the "main" column
    mainPanel(   
      plotOutput("artist_plot"),
      textOutput("num_states")
    )
  )
)

shinyUI(my_ui)