library(shiny)
require(rCharts)
library(reshape2)
library('rjson')
source('helper.R')

options(RCHART_WIDTH = 900)

shinyServer(function(input, output) {
    output$oid1 <- renderPrint({paste("epl_", sub("-","_",input$epl_season), ".csv", sep="")})
    output$eplchart <- renderChart({
        epl_stat_list <- get_stat_type(input$epl_stat)
        epl_season_txt <- paste("epl_", sub("-","_",input$epl_season), ".csv", sep="")
        epl_d1 <- generate_plot(epl_season_txt, as.character(epl_stat_list[1]), as.character(epl_stat_list[2]))
        epl_d1$set(dom="eplchart")
        return(epl_d1)
    })
    output$oid2 <- renderPrint({paste("sp_", sub("-","_",input$sp_season), ".csv", sep="")})
    output$spchart <- renderChart({
        sp_season_txt <- paste("sp_", sub("-","_",input$sp_season), ".csv", sep="")
        sp_stat_list <- get_stat_type(input$sp_stat)
        sp_d2 <- generate_plot(sp_season_txt, as.character(sp_stat_list[1]), as.character(sp_stat_list[2]))
        sp_d2$set(dom="spchart")
        return(sp_d2)        
   })
   output$oid3 <- renderPrint({paste("bl_", sub("-","_",input$bl_season), ".csv", sep="")})
   output$blchart <- renderChart({
       bl_season_txt <- paste("bl_", sub("-","_",input$bl_season), ".csv", sep="")
       bl_stat_list <- get_stat_type(input$bl_stat)
       bl_d2 <- generate_plot(bl_season_txt, as.character(bl_stat_list[1]), as.character(bl_stat_list[2]))
       bl_d2$set(dom="blchart")
       return(bl_d2)        
   })
})
