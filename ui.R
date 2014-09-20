library(shiny)
require(rCharts)
source('helper.R')

options(RCHART_LIB = 'dimple')

## Define the UI for the application
shinyUI(navbarPage("Football Statistics",
                   tabPanel(" English Premier League ",
                                sidebarLayout(
                                    sidebarPanel(
                                        selectInput('epl_season', label = h4("Select a season"), choices = seasons),
                                        selectInput('epl_stat', label = h4("Select a stat"), choices = stat_list)
                                    ),
                                    mainPanel(
                                        h4('You entered'), 
                                        textOutput("oid1"),
                                        showOutput("eplchart", "dimple")
                                    )
                            )
                   ),
                   tabPanel(" Spanish La Liga ",
                            sidebarLayout(
                                sidebarPanel(
                                    selectInput('sp_season', label = h4("Select a season"), choices = seasons),
                                    selectInput('sp_stat', label = h4("Select a stat"), choices = stat_list)
                                ),
                                mainPanel(
                                    h4('You entered'), 
                                    textOutput("oid2"),
                                    showOutput("spchart", "dimple")
                                )
                            )
                   ),
                   tabPanel(" Bundesliga",
                            sidebarLayout(
                                sidebarPanel(
                                    selectInput('bl_season', label = h4("Select a season"), choices = seasons),
                                    selectInput('bl_stat', label = h4("Select a stat"), choices = stat_list)
                                ),
                                mainPanel(
                                    h4('You entered'), 
                                    textOutput("oid3"),
                                    showOutput("blchart", "dimple")
                                )
                            )
                   )
                   
))