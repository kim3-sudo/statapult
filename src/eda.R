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

stata.full.model=lm(distance~C*D*E+A*B+A*E+A*C+C*E, data=statapult)
stata.red.model=lm(distance~1, data=statapult)

#red vs. full
anova(stata.red.model, stata.full.model)

#anova 3 way #significant
anova(stata.full.model)

#anova 2 way (A:B) #signifcant
anova(stata.full.model)

#contrasts/pairwise comparisons on 3 way interaction cells
library(emmeans)
lsm_CDE.int <- lsmeans(stata.full.model , ~C:D:E)
summary(contrast(lsm_CDE.int, method="pairwise", adjust="Bonferroni"), 
        infer=c(T,T), level=.95, side="two.sided")

#position (C) high, tilt (E) low, height (D) low (last three interaction plot)
#to maximize distance we want 1, -1, -1, which is significantly different 
#from everything else

#contrasts/pairwise comparisons on 2 way interaction cells (A:B)
lsm_AB.int <- lsmeans(stata.full.model , ~A:B)
summary(contrast(lsm_AB.int, method="pairwise", adjust="Bonferroni"), 
        infer=c(T,T), level=.95, side="two.sided")
#AB at high level max distance (interaction plot 1) and significantly different
#from everything else

