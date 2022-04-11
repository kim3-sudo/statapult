## Fractional_Analysis.R - Statapult
## E. Croffoot-Suede, S. Kim
## 11 Apr 2022 - STAT 306 DoE
## Fractional Analysis

statapult <- read.csv(url("https://github.com/kim3-sudo/statapult/raw/main/data/data.csv"))

statapult$A = statapult$arm
statapult$B = statapult$ball
statapult$C = statapult$position
statapult$D = statapult$height
statapult$E = statapult$tilt

head(statapult)
factional_statapult <- statapult[
  which(statapult$arm==-1 & statapult$ball== -1 & statapult$position==-1 & statapult$height == -1 & statapult$tilt==1),
  which(statapult$arm==1 & statapult$ball== -1 & statapult$position==-1 & statapult$height == -1 & statapult$tilt==-1),
  which(statapult$arm==-1 & statapult$ball==1 & statapult$position==-1 & statapult$height == -1 & statapult$tilt==-1),
  which(statapult$arm==1 & statapult$ball==1 & statapult$position==-1 & statapult$height == -1 & statapult$tilt==1),
  which(statapult$arm==-1 & statapult$ball== -1 & statapult$position==1 & statapult$height == -1 & statapult$tilt==-1),
  which(statapult$arm==1 & statapult$ball== -1 & statapult$position==1 & statapult$height == -1 & statapult$tilt==1),
  which(statapult$arm==-1 & statapult$ball==1 & statapult$position==1 & statapult$height == -1 & statapult$tilt==1),
  which(statapult$arm==1 & statapult$ball== 1 & statapult$position==1 & statapult$height == -1 & statapult$tilt==-1),
  which(statapult$arm==-1 & statapult$ball== -1 & statapult$position==-1 & statapult$height ==1 & statapult$tilt==-1),
  which(statapult$arm==1 & statapult$ball== -1 & statapult$position==-1 & statapult$height == 1 & statapult$tilt==1),
  which(statapult$arm==-1 & statapult$ball== 1 & statapult$position==-1 & statapult$height == 1 & statapult$tilt==1),
  which(statapult$arm==1 & statapult$ball== 1 & statapult$position==-1 & statapult$height == 1 & statapult$tilt==-1),
  which(statapult$arm==-1 & statapult$ball== -1 & statapult$position==1 & statapult$height == 1 & statapult$tilt==1),
  which(statapult$arm==1 & statapult$ball== -1 & statapult$position==1 & statapult$height == 1 & statapult$tilt==-1),
  which(statapult$arm==-1 & statapult$ball== 1 & statapult$position==1 & statapult$height == 1 & statapult$tilt==-1),
  which(statapult$arm==1 & statapult$ball==1 & statapult$position==1 & statapult$height == 1 & statapult$tilt==1)]

factional_statapult <- statapult[
  which(statapult$arm==-1 & statapult$ball== -1 & statapult$position==-1 & statapult$height == -1 & statapult$tilt==1)]
