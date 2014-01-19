# http://www.r-bloggers.com/analyze-gold-demand-and-investments-using-r/

####################################
library(quantmod)
loadSymbols(c('^XAU', 'GLD', 'IAU'))


chartSeries(GLD)

####################################
library(ggplot2)
qplot(Quarter, Value, data=melted_gold, fill=Name, geom="bar" ) +
opts(title='2009-2010 Gold Demand')

####################################
ggplot(melted_gold, aes(Quarter, Value)) 
    + geom_bar() 
    + facet_wrap(~Name, ncol = 2)
####################################
ggplot(melted_gold, aes(Quarter, Value, fill=Name)) + 
    geom_bar(stat="identity") + 
    facet_wrap(~Name, nrow=4) + 
    coord_flip()
