library(bigrquery)
library(DBI)

projectid = 'nycity1'
datasetid='taxi'

sql="select count(*) from nycity1.taxi.ride"

server <- function(input, output) {
  autoInvalidate <- reactiveTimer(5000)
  
bq_conn <-  dbConnect(
    bigquery(),
    project = projectid,
    dataset = datasetid,
    use_legacy_sql = FALSE
  )

bq_auth(path = "nycity1-db939ecf3844.json")
sql="select count(*) from nycity1.taxi.ride"
data = reactive({
  autoInvalidate()
  dbGetQuery(bq_conn, sql, n = 10)
  })

output$trip_count = renderText({
  data()$f0_[1]
  
  })

  
}