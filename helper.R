## 
epl <- read.csv("epl_13_14.csv")

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

## Melt the data frame
epl.melt <- melt(epl, id.vars = c("HomeTeam", "AwayTeam"))

## Create Home/Away casts
epl.away.cast <- dcast(epl.melt, AwayTeam ~ variable, sum)
epl.home.cast <- dcast(epl.melt, HomeTeam ~ variable, sum)

nPlot(FTHG~AwayTeam, data=epl.away.cast, type='multiBarChart')

