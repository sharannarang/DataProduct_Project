library(shiny)
require(rCharts)
library(reshape2)
library('rjson')
source('helper.R')

options(RCHART_WIDTH = 900)

shinyServer(function(input, output) {
    output$oid2 <- renderPrint({paste("epl_", sub("-","_",input$season), ".csv", sep="")})
    output$mychart <- renderChart({
        switch(input$stat, 
            "Total Points" = {
                type = "total"
                stat = "Points"
            },
            "Total Goals" = {
                type = "total"
                stat = "Goals"
            },
            "Home Goals"   = {
                type = "home"
                stat = "Home.Goals"
            },
            "Away Goals"   = {
                type = "away"
                stat = "Away.Goals"
            },            
            )
        season_txt <- paste("epl_", sub("-","_",input$season), ".csv", sep="")
        f.data <- fetch_stats(season_txt, type)
        d1 <- generate_plot(season_txt, type, stat)
        d1$set(dom="mychart")
        return(d1)
#         if (type == "total"){
#             d1 <- dPlot(y = "Team", x = stat, groups = "Team", data = f.data, type="bar")        
#         }
#         else if (type == "away") {
#             d1 <- dPlot(y = "AwayTeam", x = stat, groups = "AwayTeam", data = f.data, type="bar")        
#         }
#         else {
#             d1 <- dPlot(y = "HomeTeam", x = stat, groups = "HomeTeam", data = f.data, type="bar")                
#         }
#         d1$yAxis(type="addCategoryAxis", orderRule=stat)
#         d1$xAxis(type="addMeasureAxis")        
        
   })
})
