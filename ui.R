library(shiny)
require(rCharts)
source('helper.R')

options(RCHART_LIB = 'dimple')

## Define the UI for the application
shinyUI(pageWithSidebar(
    headerPanel("Football Statistics"),
    sidebarPanel(
        selectInput('season', label = h4("Select a season"), choices = list("2013-2014" , "2012-2013" , "2011-2012")),
        selectInput('stat', label = h4("Select a stat"), choices = list("Total Points", "Total Goals", "Home Goals", "Away Goals"))
    ),
    mainPanel(
        h4('You entered'), 
        textOutput("oid2"),
        showOutput("mychart", "dimple")
    )
))