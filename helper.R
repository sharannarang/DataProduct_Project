## Read the CSV
epl <- read.csv("epl_12_13.csv")

## Convert Team Names to factor variables
epl$HomeTeam <- as.factor(epl$HomeTeam)
epl$AwayTeam <- as.factor(epl$AwayTeam)

## Remove odds columns
epl <- epl[,1:23]

## Remove division and date of game played
epl <- epl[,3:23]

## Get referee data
referee <- epl[,9]

## Get points data from HTR/FTR columns
epl$HTFTP <- ifelse(epl$FTR == 'H', 3, ifelse(epl$FTR == 'D', 1, 0))
epl$ATFTP <- ifelse(epl$FTR == 'A', 3, ifelse(epl$FTR == 'D', 1, 0))
epl$HTHTP <- ifelse(epl$HTR == 'H', 3, ifelse(epl$HTR == 'D', 1, 0))
epl$ATHTP <- ifelse(epl$HTR == 'A', 3, ifelse(epl$HTR == 'D', 1, 0))

## Remove referee, result information from the main data frame
epl <- epl[,-c(5,8,9)]

## Give meaningful column names
colnames(epl) <- c("HomeTeam", "AwayTeam", "Home.Goals", "Away.Goals", "Half.Time.Home.Goals", "Half.Time.Away.Goals", "Home.Team.Shots", "Away.Team.Shots", "Home.Team.Shots.On.Target", "Away.Team.Shots.On.Target", "Home.Team.Fouls", "Away.Team.Fouls", "Home.Team.Corners", "Away.Team.Corners", "Home.Team.Yellow.Cards", "Away.Team.Yellow.Cards", "Home.Team.Red.Cards", "Away.Team.Red.Cards", "Home.Team.Points", "Away.Team.Points", "Home.Team.Half.Time.Points", "Away.Team.Half.Time.Points")

## Melt the data frame
epl.melt <- melt(epl, id.vars = c("HomeTeam", "AwayTeam"))

## Create Home/Away casts
epl.away.cast <- dcast(epl.melt, AwayTeam ~ variable, sum)
epl.home.cast <- dcast(epl.melt, HomeTeam ~ variable, sum)

## Create tables for total statistics
epl.stats <- as.data.frame(epl.home.cast$HomeTeam)
colnames(epl.stats) <- "Team"

epl.stats$Goals <- epl.away.cast$Away.Goals + epl.home.cast$Home.Goals
epl.stats$Points <- epl.away.cast$Away.Team.Points + epl.home.cast$Home.Team.Points
epl.stats$Goals.Against <- epl.away.cast$Home.Goals + epl.home.cast$Away.Goals
epl.stats$Shots <- epl.away.cast$Away.Team.Shots + epl.home.cast$Home.Team.Shots
epl.stats$Shots.On.Target <- epl.away.cast$Away.Team.Shots.On.Target + epl.home.cast$Home.Team.Shots.On.Target
epl.stats$Fouls <- epl.away.cast$Away.Team.Fouls + epl.home.cast$Home.Team.Fouls
epl.stats$Fouls.Against <- epl.away.cast$Home.Team.Fouls + epl.home.cast$Away.Team.Fouls
epl.stats$Corners <- epl.away.cast$Away.Team.Corners + epl.home.cast$Home.Team.Corners
epl.stats$Corners.Conceeded <- epl.away.cast$Home.Team.Corners + epl.home.cast$Away.Team.Corners
epl.stats$Yellow.Cards <- epl.away.cast$Away.Team.Yellow.Cards + epl.home.cast$Home.Team.Yellow.Cards
epl.stats$Red.Cards <- epl.away.cast$Away.Team.Red.Cards + epl.home.cast$Home.Team.Red.Cards

## Plot the statistics
d1 <- dPlot(y = "Team", x = "Points", groups = "Team", data = epl.stats, type="bar")
d1$yAxis(type="addCategoryAxis", orderRule="Points")
d1$xAxis(type="addMeasureAxis")
