## eda.R - Statapult
## E. Croffoot-Suede, S. Kim
## 7 Apr 2022 - STAT 306 DoE
## Exploratory Data Analysis

statapult <- read.csv(url("https://github.com/kim3-sudo/statapult/raw/main/data/data.csv"))

head(statapult)

# Boxplots ----
boxplot(distance ~ arm, data = statapult)
boxplot(distance ~ ball, data = statapult)
boxplot(distance ~ position, data = statapult)
boxplot(distance ~ height, data = statapult)
boxplot(distance ~ tilt, data = statapult)

# Interaction plots ----
interaction.plot(statapult$arm, statapult$ball, statapult$distance)
interaction.plot(statapult$arm, statapult$position, statapult$distance)
interaction.plot(statapult$arm, statapult$height, statapult$distance)
interaction.plot(statapult$arm, statapult$tilt, statapult$distance)
interaction.plot(statapult$ball, statapult$position, statapult$distance)
interaction.plot(statapult$ball, statapult$height, statapult$distance)
interaction.plot(statapult$ball, statapult$tilt, statapult$distance)
interaction.plot(statapult$position, statapult$height, statapult$distance)
interaction.plot(statapult$position, statapult$tilt, statapult$distance)
interaction.plot(statapult$height, statapult$tilt, statapult$distance)

# Half normal plot ----
## Re-encode variables to ABCDE ----
statapult$A = statapult$arm
statapult$B = statapult$ball
statapult$C = statapult$position
statapult$D = statapult$height
statapult$E = statapult$tilt
## Generate HNP ----
library(daewr)
myout = lm(distance ~ A*B*C*D*E, data = statapult)
effects = myout$coefficients[2:31]
halfnorm(effects, labs=names(effects), 
         alpha = 0.10, refline = "TRUE")
# You may need to zoom this plot in to see all of the effects
#B, AB, CDE, AE, CE, AC, CD, E, D, A, C
