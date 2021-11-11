library(shiny)
library(shinydashboard)

# Define UI for app that draws a histogram ----
ui <- dashboardPage(
  
  # App title ----
  dashboardHeader(title="Simulated Taxi Rides"),
  dashboardSidebar(),
  

  dashboardBody(fluidRow(valueBoxOutput("trip_count"),
                         plotOutput("last_24_hour_trend")))
      
  
)