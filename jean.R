jean <- read.csv("http://www.ling.upenn.edu/~joseff/data/jean2.csv")
ay <- subset(jean, VClass %in% c("ay","ay0"))
ay$VClass <- as.factor(as.character(ay$VClass))

ay.m <- melt(ay, id = c("Time","RTime", "Word","VClass"), measure = c("F1","F2"))

ggplot(ay.m, aes(RTime, value, color = VClass, linetype = variable)) + 
  geom_line()
