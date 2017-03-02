library(leaflet)
library(shiny)
require(rCharts)
library(DT)
library(reshape)
library(plyr)
library(rjson)

#sample data

sampleData <- read.csv("data/SalesJan2009.csv")


sampleDataFilter <- sampleData[1:20,]
clientData <- sampleDataFilter[c(1,2,3,4,5,7,8,9,12,13)]

shinyServer( function(input, output, session) {
  
  clientIcon <- makeIcon(
    iconUrl= "image/client.png",
    iconWidth = 30, iconHeight = 30,
    iconAnchorX = 2, iconAnchorY = 4
  )
    output$mymap <- renderLeaflet({
      
      clientDetail = clientData
      s=input$x1_rows_selected
      if (length(s)){
        clientDetail=clientData[s, , drop = FALSE]
      }
    leaflet(clientDetail) %>%
      addProviderTiles("Stamen.TonerLite",
                       options = providerTileOptions(noWrap = TRUE)
      ) %>%
addMarkers(~Longitude, ~Latitude, label= ~Name, icon=clientIcon,popup=(~Product))
      
      
      
  })
  
output$x1 = DT::renderDataTable(clientData[c(5,2,8)], server = FALSE, selection="single", options = list(pageLength = 4, dom="ftp"))
  
output$x3 = DT::renderDataTable(clientData, server = FALSE,selection="none")

  output$Chart1 <- renderChart2({
    
    clientDetail = clientData
    s=input$x1_rows_selected
    if (length(s)){
      clientDetail=clientData[s, , drop = FALSE]
    }
    d1<- dPlot(y="Name",x=c("Product","Payment_Type"),z="Complaints", groups ="Payment_Type",data=clientDetail, type="bubble",
               
               height = 260,
               width = 500
                         )
    d1$xAxis(type="addCategoryAxis")
    d1$yAxis(type="addCategoryAxis")
    d1$zAxis(type="addMeasureAxis")
    
    d1$legend(
      x = 1,
      y = 0,
      width = 400,
      height = 20,
      horizontalAlign = "right"
    )
    
    
    return(d1)
    
  })
  
  
   output$progressBox <- renderInfoBox({
     clientDetail = sampleDataFilter
     s=input$x1_rows_selected
     if (length(s)){
       clientDetail=sampleDataFilter[s, , drop = FALSE]
     }
     
     
    infoBox(
      "Account Created", clientDetail$Account_Created, icon = icon("user-plus"),
      color = "blue"
    )
  })
  output$approvalBox <- renderInfoBox({
    clientDetail = sampleDataFilter
    s=input$x1_rows_selected
    if (length(s)){
      clientDetail=sampleDataFilter[s, , drop = FALSE]
    }
    infoBox(
      "Last Login", clientDetail$Last_Login, icon = icon("user-secret"),
      color = "black"
    )
  })
  
  # Same as above, but with fill=TRUE
  output$progressBox2 <- renderInfoBox({
    clientDetail = sampleDataFilter
    s=input$x1_rows_selected
    if (length(s)){
      clientDetail=sampleDataFilter[s, , drop = FALSE]
    }
    infoBox(
      "City",clientDetail$City, icon = icon("building"),
      color = "green"
    )
  })
  output$approvalBox2 <- renderInfoBox({
    clientDetail = sampleDataFilter
    s=input$x1_rows_selected
    if (length(s)){
      clientDetail=sampleDataFilter[s, , drop = FALSE]
    }
    infoBox(
      "Complaints", clientDetail$Complaints, icon = icon("phone"),
      color = "yellow"
    )
  })
  
  
  
})
