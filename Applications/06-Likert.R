# http://www.r-bloggers.com/plotting-likert-scales-net-stacked-distributions-with-ggplot-rstats/

likert_2 <- data.frame(as.factor(sample(1:2, 500, replace=T, prob=c(0.3,0.7))),
                       as.factor(sample(1:2, 500, replace=T, prob=c(0.6,0.4))),
                       as.factor(sample(1:2, 500, replace=T, prob=c(0.25,0.75))),
                       as.factor(sample(1:2, 500, replace=T, prob=c(0.9,0.1))),
                       as.factor(sample(1:2, 500, replace=T, prob=c(0.35,0.65))))
levels_2 <- list(c("Disagree", "Agree"))
items <- list(c("Q1", "Q2", "Q3", "Q4", "Q5"))
source("sjPlotLikert.R")
sjp.likert(likert_2, legendLabels=levels_2, axisLabels.x=items, orderBy="neg")



likert_4 <- data.frame(as.factor(sample(1:4, 500, replace=T, prob=c(0.2,0.3,0.1,0.4))),
                       as.factor(sample(1:4, 500, replace=T, prob=c(0.5,0.25,0.15,0.1))),
                       as.factor(sample(1:4, 500, replace=T, prob=c(0.25,0.1,0.4,0.25))),
                       as.factor(sample(1:4, 500, replace=T, prob=c(0.1,0.4,0.4,0.1))),
                       as.factor(sample(1:4, 500, replace=T, prob=c(0.35,0.25,0.15,0.25))))
levels_4 <- list(c("Strongly disagree", "Disagree", "Agree", "Strongly Agree"))
items <- list(c("Q1", "Q2", "Q3", "Q4", "Q5"))
source("sjPlotLikert.R")
sjp.likert(likert_4, legendLabels=levels_4, axisLabels.x=items)


likert_6 <- data.frame(as.factor(sample(1:6, 500, replace=T, prob=c(0.2,0.1,0.1,0.3,0.2,0.1))),
                       as.factor(sample(1:6, 500, replace=T, prob=c(0.15,0.15,0.3,0.1,0.1,0.2))),
                       as.factor(sample(1:6, 500, replace=T, prob=c(0.2,0.25,0.05,0.2,0.2,0.2))),
                       as.factor(sample(1:6, 500, replace=T, prob=c(0.2,0.1,0.1,0.4,0.1,0.1))),
                       as.factor(sample(1:6, 500, replace=T, prob=c(0.1,0.4,0.1,0.3,0.05,0.15))))
levels_6 <- list(c("Very strongly disagree", "Strongly disagree", "Disagree", "Agree", "Strongly Agree", "Very strongly agree"))
items <- list(c("Q1", "Q2", "Q3", "Q4", "Q5"))
source("sjPlotLikert.R")
sjp.likert(likert_6, legendLabels=levels_6, barColor="brown", axisLabels.x=items, orderBy="pos")


levels_42 <- list(c("Independent", "Slightly dependent", "Dependent", "Severely dependent"))
levels_62 <- list(c("Independent", "Slightly dependent", "Dependent", "Very dependent", "Severely dependent", "Very severely dependent"))
source("lib/sjPlotStackFrequencies.R")
sjp.stackfrq(likert_4, legendLabels=levels_42, axisLabels.x=items)
sjp.stackfrq(likert_6, legendLabels=levels_62, axisLabels.x=items)
