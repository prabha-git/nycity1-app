library(shiny)
library(shinydashboard)

# Define UI for app that draws a histogram ----
ui <- dashboardPage(
  
  # App title ----
  dashboardHeader(title="Simulated Taxi Rides"),
  dashboardSidebar(collapsed=TRUE),
  

  dashboardBody(
    
    tags$head(tags$style(HTML('
                              .contant-wrapper{
                              background-color:#000;
                              }'))),
    
    fluidRow(valueBoxOutput("trip_count"),
                         plotOutput("last_24_hour_trend")))
      
  
)