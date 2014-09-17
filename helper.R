epl <- read.csv("E0.csv")

## Convert Team Names to factor variables
epl$HomeTeam <- as.factor(epl$HomeTeam)
epl$AwayTeam <- as.factor(epl$AwayTeam)

## Remove odds columns
epl <- epl[,1:23]

## Remove division and date of game played
epl <- epl[,3:23]

## Melt the data frame
epl.melt <- melt(epl, id.vars = c("HomeTeam", "AwayTeam"), measure.vars = colnames(epl)[c(3,4,6,7,10:21)])

