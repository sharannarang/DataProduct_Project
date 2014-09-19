
read_football_data <- function(season = "epl_12_13.csv") {
    ## Read the CSV
    football.data <- read.csv(season)
    
    ## Convert Team Names to factor variables
    football.data$HomeTeam <- as.factor(football.data$HomeTeam)
    football.data$AwayTeam <- as.factor(football.data$AwayTeam)
    
    ## Remove odds columns
    football.data <- football.data[,1:23]
    
    ## Remove division and date of game played
    football.data <- football.data[,3:23]
    
    ## Get referee data
    referee <- football.data[,9]
    
    ## Get points data from HTR/FTR columns
    football.data$HTFTP <- ifelse(football.data$FTR == 'H', 3, ifelse(football.data$FTR == 'D', 1, 0))
    football.data$ATFTP <- ifelse(football.data$FTR == 'A', 3, ifelse(football.data$FTR == 'D', 1, 0))
    football.data$HTHTP <- ifelse(football.data$HTR == 'H', 3, ifelse(football.data$HTR == 'D', 1, 0))
    football.data$ATHTP <- ifelse(football.data$HTR == 'A', 3, ifelse(football.data$HTR == 'D', 1, 0))
    
    ## Remove referee, result information from the main data frame
    football.data <- football.data[,-c(5,8,9)]
    
    ## Give meaningful column names
    colnames(football.data) <- c("HomeTeam", "AwayTeam", "Home.Goals", "Away.Goals", "Half.Time.Home.Goals", "Half.Time.Away.Goals", "Home.Team.Shots", "Away.Team.Shots", "Home.Team.Shots.On.Target", "Away.Team.Shots.On.Target", "Home.Team.Fouls", "Away.Team.Fouls", "Home.Team.Corners", "Away.Team.Corners", "Home.Team.Yellow.Cards", "Away.Team.Yellow.Cards", "Home.Team.Red.Cards", "Away.Team.Red.Cards", "Home.Team.Points", "Away.Team.Points", "Home.Team.Half.Time.Points", "Away.Team.Half.Time.Points")
    
    football.data
    
}

fetch_stats <- function(season = "epl_12_13.csv", stat = "total") {
    football.data <- read_football_data(season)
    
    ## Melt the data frame
    football.data.melt <- melt(football.data, id.vars = c("HomeTeam", "AwayTeam"))
    
    ## Create Home/Away casts
    football.data.away.cast <- dcast(football.data.melt, AwayTeam ~ variable, sum)
    football.data.home.cast <- dcast(football.data.melt, HomeTeam ~ variable, sum)
    
    ## Create tables for total statistics
    football.data.stats <- as.data.frame(football.data.home.cast$HomeTeam)
    colnames(football.data.stats) <- "Team"
    
    football.data.stats$Goals <- football.data.away.cast$Away.Goals + football.data.home.cast$Home.Goals
    football.data.stats$Points <- football.data.away.cast$Away.Team.Points + football.data.home.cast$Home.Team.Points
    football.data.stats$Goals.Against <- football.data.away.cast$Home.Goals + football.data.home.cast$Away.Goals
    football.data.stats$Shots <- football.data.away.cast$Away.Team.Shots + football.data.home.cast$Home.Team.Shots
    football.data.stats$Shots.On.Target <- football.data.away.cast$Away.Team.Shots.On.Target + football.data.home.cast$Home.Team.Shots.On.Target
    football.data.stats$Fouls <- football.data.away.cast$Away.Team.Fouls + football.data.home.cast$Home.Team.Fouls
    football.data.stats$Fouls.Against <- football.data.away.cast$Home.Team.Fouls + football.data.home.cast$Away.Team.Fouls
    football.data.stats$Corners <- football.data.away.cast$Away.Team.Corners + football.data.home.cast$Home.Team.Corners
    football.data.stats$Corners.Conceeded <- football.data.away.cast$Home.Team.Corners + football.data.home.cast$Away.Team.Corners
    football.data.stats$Yellow.Cards <- football.data.away.cast$Away.Team.Yellow.Cards + football.data.home.cast$Home.Team.Yellow.Cards
    football.data.stats$Red.Cards <- football.data.away.cast$Away.Team.Red.Cards + football.data.home.cast$Home.Team.Red.Cards

    if (stat == "home") {
        football.data.home.cast
    }
    else if (stat == "away") {
        football.data.away.cast
    }
    else {
        football.data.stats
    }
}


## Plot the statistics
generate_plot <- function(season = "epl_12_13.csv", type = "total", stat="Points") {
    f.data <- fetch_stats(season, type)
    if (type == "total"){
        d1 <- dPlot(y = "Team", x = stat, groups = "Team", data = f.data, type="bar")        
    }
    else if (type == "away") {
        d1 <- dPlot(y = "AwayTeam", x = stat, groups = "AwayTeam", data = f.data, type="bar")        
    }
    else {
        d1 <- dPlot(y = "HomeTeam", x = stat, groups = "HomeTeam", data = f.data, type="bar")                
    }
    d1$yAxis(type="addCategoryAxis", orderRule=stat)
    d1$xAxis(type="addMeasureAxis")
    d1
}
