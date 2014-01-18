# http://www.cookbook-r.com/Graphs/Facets_(ggplot2)/

library(ggplot2)
library(reshape2)

sp <- ggplot(tips, aes(x=total_bill, y=tip/total_bill)) + geom_point(shape=1)
sp
