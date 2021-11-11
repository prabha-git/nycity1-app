library(bigrquery)
library(DBI)
library(tidyverse)
library(shinydashboard)

projectid = 'nycity1'
datasetid = 'taxi'

sql = "select count(*) from nycity1.taxi.ride"

server <- function(input, output) {
  autoInvalidate <- reactiveTimer(20000)
  
  bq_conn <-  dbConnect(
    bigquery(),
    project = projectid,
    dataset = datasetid,
    use_legacy_sql = FALSE
  )
  
  bq_auth(path = "nycity1-db939ecf3844.json")
  sql_ride_count = "select count(*) ride_cnt from nycity1.taxi.ride"
  data = reactive({
    autoInvalidate()
    dbGetQuery(bq_conn, sql_ride_count)
  })
  

  
  output$trip_count = renderValueBox({
    valueBox(
      tags$p(prettyNum(data()$ride_cnt[1]), style = "text-align:center"),
      subtitle = tags$p("Total Trips", style = 'text-align:center')
    )})
    
    
    sql_trend = "select TIMESTAMP_TRUNC(TIMESTAMP_SUB(event_timestamp,INTERVAL MOD(EXTRACT (MINUTE from event_timestamp),5) MINUTE),MINUTE) ts,count(*) pkup_cnt
from nycity1.taxi.ride where event_timestamp >= TIMESTAMP_SUB(current_timestamp(), INTERVAL 24 HOUR) and event_type='pickup'
group by 1"
    
    
    
  trend_data = reactive({
    autoInvalidate()
    dbGetQuery(bq_conn,sql_trend)})


    
  output$last_24_hour_trend = renderPlot({
    ggplot(trend_data(),aes(x=ts,y=pkup_cnt))+geom_line()
  })
  
  }
    

  
