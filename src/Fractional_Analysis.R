library(mosaic)
## Fractional_Analysis.R - Statapult
## E. Croffoot-Suede, S. Kim
## 11 Apr 2022 - STAT 306 DoE
## Fractional Analysis

statapult <- read.csv(url("https://github.com/kim3-sudo/statapult/raw/main/data/data.csv"))

#figure out indexes of fractional runs----
statapult[(statapult$arm==-1) & (statapult$ball== -1) & (statapult$position==-1) & 
            (statapult$height == -1) & (statapult$tilt==1),]
statapult[(statapult$arm==1) & (statapult$ball== -1) & (statapult$position==-1) & 
            (statapult$height == -1) & (statapult$tilt==-1),]
statapult[(statapult$arm==-1) & (statapult$ball==1) & (statapult$position==-1) & 
            (statapult$height == -1) & (statapult$tilt==-1),]
statapult[(statapult$arm==1) & (statapult$ball==1) & (statapult$position==-1) & 
            (statapult$height == -1) & (statapult$tilt==1),]
statapult[(statapult$arm==-1) & (statapult$ball== -1) & (statapult$position==1) & 
            (statapult$height == -1) & (statapult$tilt==-1),]
statapult[(statapult$arm==1) & (statapult$ball== -1) & (statapult$position==1) & 
            (statapult$height == -1) & (statapult$tilt==1),]
statapult[(statapult$arm==-1) & (statapult$ball==1) & (statapult$position==1) & 
            (statapult$height == -1) & (statapult$tilt==1),]
statapult[(statapult$arm==1) & (statapult$ball== 1) & (statapult$position==1) & 
            (statapult$height == -1) & (statapult$tilt==-1),]
statapult[(statapult$arm==-1) & (statapult$ball== -1) & (statapult$position==-1) & 
            (statapult$height ==1) & (statapult$tilt==-1),]
statapult[(statapult$arm==1) & (statapult$ball== -1) & (statapult$position==-1) & 
            (statapult$height == 1) & (statapult$tilt==1),]
statapult[(statapult$arm==-1) & (statapult$ball== 1) & (statapult$position==-1) & 
            (statapult$height == 1) & (statapult$tilt==1),]
statapult[(statapult$arm==1) & (statapult$ball== 1) & (statapult$position==-1) & 
            (statapult$height == 1) & (statapult$tilt==-1),]
statapult[(statapult$arm==-1) & (statapult$ball== -1) & (statapult$position==1) & 
            (statapult$height == 1) & (statapult$tilt==1),]
statapult[(statapult$arm==1) & (statapult$ball== -1) & (statapult$position==1) & 
            (statapult$height == 1) & (statapult$tilt==-1),]
statapult[(statapult$arm==-1) & (statapult$ball== 1) & (statapult$position==1) & 
            (statapult$height == 1) & (statapult$tilt==-1),]
statapult[(statapult$arm==1) & (statapult$ball==1) & (statapult$position==1) & 
            (statapult$height == 1) & (statapult$tilt==1),]

#create df of just 16 fractional runs----
fractional_statapult <- subset(statapult, index==17|index==2|index==3|index==20|index==5|
                                 index==22|index==23|index==8|index==9|index==26|index==27|
                                 index==12|index==29|index==14|index==15|index==32,
                  select=index:distance)

fractional_statapult$A = fractional_statapult$arm
fractional_statapult$B = fractional_statapult$ball
fractional_statapult$C = fractional_statapult$position
fractional_statapult$D = fractional_statapult$height
fractional_statapult$E = fractional_statapult$tilt