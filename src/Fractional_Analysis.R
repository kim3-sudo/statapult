## Fractional_Analysis.R - Statapult
## E. Croffoot-Suede, S. Kim
## 11 Apr 2022 - STAT 306 DoE
## Fractional Analysis

# Load data
statapult <- read.csv(url("https://github.com/kim3-sudo/statapult/raw/main/data/data.csv"))

# Load packages
library(mosaic)
library(emmeans)
library(daewr)

# Figure out indexes of fractional runs ----
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

# Create df of just 16 fractional runs ----
fractional_statapult <- subset(statapult, index==17|index==2|index==3|index==20|index==5|
                                 index==22|index==23|index==8|index==9|index==26|index==27|
                                 index==12|index==29|index==14|index==15|index==32,
                  select=index:distance)

# Re-encode variables to factor naming ----
fractional_statapult$A = fractional_statapult$arm
fractional_statapult$B = fractional_statapult$ball
fractional_statapult$C = fractional_statapult$position
fractional_statapult$D = fractional_statapult$height
fractional_statapult$E = fractional_statapult$tilt

# EDA ----
## Boxplots ----
boxplot(distance ~ arm, data = fractional_statapult)
boxplot(distance ~ ball, data = fractional_statapult)
boxplot(distance ~ position, data = fractional_statapult)
boxplot(distance ~ height, data = fractional_statapult)
boxplot(distance ~ tilt, data = fractional_statapult)

## Interaction plots ----
interaction.plot(fractional_statapult$arm, fractional_statapult$ball, fractional_statapult$distance) #1
interaction.plot(fractional_statapult$arm, fractional_statapult$position, fractional_statapult$distance) #2
interaction.plot(fractional_statapult$arm, fractional_statapult$height, fractional_statapult$distance) #3
interaction.plot(fractional_statapult$arm, fractional_statapult$tilt, fractional_statapult$distance) #4
interaction.plot(fractional_statapult$ball, fractional_statapult$position, fractional_statapult$distance) #5
interaction.plot(fractional_statapult$ball, fractional_statapult$height, fractional_statapult$distance) #6
interaction.plot(fractional_statapult$ball, fractional_statapult$tilt, fractional_statapult$distance) #7
interaction.plot(fractional_statapult$position, fractional_statapult$height, fractional_statapult$distance) #8
interaction.plot(fractional_statapult$position, fractional_statapult$tilt, fractional_statapult$distance) #9
interaction.plot(fractional_statapult$height, fractional_statapult$tilt, fractional_statapult$distance) #10

## Half normal plot ----
myout = lm(distance ~ A*B*C*D*E, data = fractional_statapult)
effects = myout$coefficients[2:15]
halfnorm(effects, labs = names(effects), alpha = 0.70, refline = "TRUE")
# C, A, D, E, B, CD, AB, AE, CE, AC -> AB, AC, CE, AE, CD

# Overall F-test for the model ----
statb.full.model = lm(distance ~ A*B + A*C + A*E + C*E + C*D, data = fractional_statapult)
statb.red.model = lm(distance ~ 1, data = fractional_statapult)
## Test full model against reduced model
anova(statb.red.model, statb.full.model)
## Full model is significant
anova(statb.full.model)
## Checked two-way interactions, and was significant

lsm_AB.int <- lsmeans(statb.full.model, ~ A:B)
summary(contrast(lsm_AB.int,
                 method = "pairwise",
                 adjust = "Bonferroni"),
        infer = c(T, T),
        level = .95,
        side = "two.sided")
# A and B at high level (interaction plot 1)

lsm_AC.int <- lsmeans(statb.full.model, ~ A:C)
summary(contrast(lsm_AC.int,
                 method = "pairwise",
                 adjust = "Bonferroni"),
        infer = c(T, T),
        level = .95,
        side = "two.sided")
# A and C at high level (interaction plot 2)

lsm_AE.int <- lsmeans(statb.full.model, ~ A:E)
summary(contrast(lsm_AE.int,
                 method = "pairwise",
                 adjust = "Bonferroni"),
        infer = c(T, T),
        level = .95,
        side = "two.sided")
# A at high level, E at low level or high level (interaction plot 4)

lsm_CE.int <- lsmeans(statb.full.model, ~ C:E)
summary(contrast(lsm_CE.int,
                 method = "pairwise",
                 adjust = "Bonferroni"),
        infer = c(T, T),
        level = .95,
        side = "two.sided")
# C at high level, E at low level (interaction plot 9)

lsm_CD.int <- lsmeans(statb.full.model, ~ C:D)
summary(contrast(lsm_CD.int,
                 method = "pairwise",
                 adjust = "Bonferroni"),
        infer = c(T, T),
        level = .95,
        side = "two.sided")
# C at high level, D at low level (interaction plot 9)