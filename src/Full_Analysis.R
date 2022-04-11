## Full_Analysis.R - Statapult
## E. Croffoot-Suede, S. Kim
## 7 Apr 2022 - STAT 306 DoE
## Full analysis of the data using 2^5 design

## Load data
statapult <- read.csv(url("https://github.com/kim3-sudo/statapult/raw/main/data/data.csv"))

## Load libraries
library(emmeans)

## Overall F-test for model
stata.full.model = lm(distance ~ C*D*E + A*B + A*E + A*C + C*E, data = statapult)
stata.red.model = lm(distance ~ 1, data = statapult)
### Test full model against reduced model
anova(stata.red.model, stata.full.model)
anova(stata.full.model)
# The full model is significantly different
# ANOVA 3 way (C:D:E)
anova(stata.full.model)
# ANOVA 2 way (A:B)
anova(stata.full.model)
# Also significantly idfferent

# Run contrasts/pairwise comparisons on 3 way interaction cells
lsm_CDE.int <- lsmeans(stata.full.model , ~ C:D:E)
summary(contrast(lsm_CDE.int,
                 method = "pairwise",
                 adjust = "Bonferroni"), 
        infer = c(T,T),
        level = .95,
        side = "two.sided")

# position (C) high, tilt (E) low, height (D) low (last three interaction plot) to maximize distance we want 1, -1, -1, which is significantly different from everything else

# contrasts/pairwise comparisons on 2 way interaction cells (A:B)
lsm_AB.int <- lsmeans(stata.full.model, ~ A:B)
summary(contrast(lsm_AB.int, 
                 method = "pairwise",
                 adjust = "Bonferroni"), 
        infer = c(T,T),
        level = .95,
        side = "two.sided")
# AB at high level max distance (interaction plot 1) and significantly different from everything else