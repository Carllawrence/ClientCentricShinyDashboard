library(shiny)
library(leaflet)
require(rCharts)
library(shinydashboard)
#options(RCHART_LIB = 'dimple')

dashboardPage(skin = "blue",
  
  
  dashboardHeader(title = "ABC Company -- Client Centric Dashboard Example",titleWidth = 600),
  
  dashboardSidebar(sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Database", tabName = "data", icon = icon("database"))
  )),
  dashboardBody(
    tabItems(
tabItem("dashboard",
  fluidRow(
    box(  DT::dataTableOutput('x1', height = 250)),
    
    box(chartOutput('Chart1',"dimple"))
       

),
fluidRow(
  column(6,
  
  infoBoxOutput("progressBox",width = 6),
  infoBoxOutput("approvalBox", width = 6),
    infoBoxOutput("progressBox2",width = 6),
  infoBoxOutput("approvalBox2",width = 6)),
  
  column(6, 
  leafletOutput("mymap",  height = 270)
  )
  )
 

  
),


  tabItem("data",
          fluidPage(
          h2("Raw data"),
          DT::dataTableOutput('x3')
  ))))
  
)