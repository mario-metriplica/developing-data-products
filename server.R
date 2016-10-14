#Load libraries

require(shiny) 
require(shinyjs) 
library(devtools) 
library(leaflet)
library(ggplot2)
  
airports <- read("airports.txt")
colnames(airports) <- c("AirportID", "Name", "City", "Country", "IATA_FAA", "ICAO", "Latitude", "Longitude", "Altitude", "TimeZone", "DST", "TimeZone.Names")

shinyServer(function(input, output){
  values <- reactiveValues()
  observeEvent(input$update, {
    if(input$update>0){
      values$nclust <- input$slider1
      values$airports <- airports
      values$plotcountry <- input$country
      values$cluster <- kmeans(values$airports[,c(7,8)], values$nclust)
      values$textcluster <- paste("K-means clustering with",values$nclust, "clusters", sep=" ")
      values$cluster$cluster <- as.factor(values$cluster$cluster)
      values$plot <- ggplot(values$airports, aes(Longitude,Latitude, color = values$cluster$cluster)) + geom_point() + theme_classic()
      values$map <- leaflet() %>% addTiles() %>% addMarkers(lat=values$airports[values$airports$Country==values$plotcountry,7], lng=values$airports[values$airports$Country==values$plotcountry,8], popup=values$airports[values$airports$Country==values$plotcountry,2])
      return(list(values$airports, values$plot, values$nclust,values$textcluster,values$map))
    } 
  })
  output$table <- renderDataTable({values$airports})
  output$text <- renderText(values$textcluster)
  output$intro <- renderText("The OpenFlights Airports Database contains 7908 airports spanning the globe, as shown in the current app. Each entry contains the following information: Airport ID, Name of airport, City	(city served by airport), Country or territory where airport is located, IATA/FAA, ICAO, Latitude, Longitude, Altitude, Time Zone, DST (Daylight savings time) and Tz database time zone.")
  output$intro2 <- renderText("This App makes cluster analysis to group the OpenFlights Airports by area (maximum allowed perform five groups, corresponding to the five continents).")
  output$intro3 <- renderText("Finally, it allows user to select a country to view in a map the OpenFlights Airports.")
  output$plotcluster <- renderPlot({values$plot})
  output$mymap <- renderLeaflet({values$map})
})  
