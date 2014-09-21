library(shiny)
require(rCharts)
source('helper.R')

options(RCHART_LIB = 'dimple')

## Define the UI for the application
shinyUI(navbarPage("Football Statistics",
                   tabPanel(" How to use the website",
                            h2("Welcome to the Football Statistics Website!"),
                            br(),
                            p("This website displays statistics from several of the European Football Leagues. The data to develop statistics was obtained from http://www.football-data.co.uk. The football-data website records the result of each league game from various european leagues and makes the results available in csv format. 
                              Using the results, I've compiled a set of statistics. In order to use the website, please follow these steps:"),
                            br(),
                            tags$li("Select a league from the Navigation Tabs"),
                            tags$li("Select a season from the Season Input Box"),
                            tags$li("Select a statistic to display from the Stat Input Box"),
                            br(),
                            p("Using the inputs, a chart is displayed depicting the stat for each team from the desired league. The charts were developed using RCharts package, specifically using dplot function. Unfortunately, the labels on each of the bars don't display the team/stat data on the shiny app.
                              I couldn't really get it working despite trying several things."),
                            h4("Hope you enjoy using the website!")
                            
                   ),
                            
                   tabPanel(" English Premier League ",
                                sidebarLayout(
                                    sidebarPanel(
                                        selectInput('epl_season', label = h4("English Premier League season"), choices = seasons),
                                        selectInput('epl_stat', label = h4("Stat"), choices = stat_list)
                                    ),
                                    mainPanel(
                                        showOutput("eplchart", "dimple")
                                    )
                            )
                   ),
                   tabPanel(" Spanish La Liga ",
                            sidebarLayout(
                                sidebarPanel(
                                    selectInput('sp_season', label = h4("La Liga season"), choices = seasons),
                                    selectInput('sp_stat', label = h4("Stat"), choices = stat_list)
                                ),
                                mainPanel(
                                    showOutput("spchart", "dimple")
                                )
                            )
                   ),
                   tabPanel(" Bundesliga",
                            sidebarLayout(
                                sidebarPanel(
                                    selectInput('bl_season', label = h4("Budesliga season"), choices = seasons),
                                    selectInput('bl_stat', label = h4("Stat"), choices = stat_list)
                                ),
                                mainPanel(
                                    showOutput("blchart", "dimple")
                                )
                            )
                   ),
                   tabPanel(" Italian Serie A",
                            sidebarLayout(
                                sidebarPanel(
                                    selectInput('il_season', label = h4("Serie A season"), choices = seasons),
                                    selectInput('il_stat', label = h4("Stat"), choices = stat_list)
                                ),
                                mainPanel(
                                    showOutput("ilchart", "dimple")
                                )
                            )
                   )                   
))