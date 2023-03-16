# http://www.cookbook-r.com/Graphs/Legends_(ggplot2)/

#############################
#Part 1
library(ggplot2)

bp <- ggplot(data=PlantGrowth, aes(x=group, y=weight, fill=group)) + geom_boxplot()

bp

#############################
# Part 2 Removing the Legend

# Remove legend for a particular aesthetic (fill)
bp + guides(fill=FALSE)

# It can also be done when specifying the scale
bp + scale_fill_discrete(guide=FALSE)

# This removes all legends
bp + theme(legend.position="none")

############################
# Part 3

bp + scale_fill_discrete(breaks=c("trt1","ctrl","trt2"))


############################
# Part 4 Hiding the Legend

# Remove title for fill legend
bp + guides(fill=guide_legend(title=NULL))

# Remove title for all legends
bp + theme(legend.title=element_blank())
