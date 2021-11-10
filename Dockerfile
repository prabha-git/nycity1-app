FROM rocker/shiny-verse:latest

COPY . ./app
EXPOSE 3838

RUN R -e "install.packages('bigrquery')"
RUN R -e "install.packages('DBI')"

CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 3838)"]