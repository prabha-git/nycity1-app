library(shiny)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Hello Shiny!"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      

      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      textOutput("trip_count")
      
    )
  )
)