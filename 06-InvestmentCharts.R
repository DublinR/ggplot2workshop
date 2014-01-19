# http://www.r-bloggers.com/analyze-gold-demand-and-investments-using-r/

####################################
library(quantmod)
loadSymbols(c('^XAU', 'GLD', 'IAU'))


chartSeries(GLD)

####################################
ggplot(melted_gold, aes(Quarter, Value)) 
    + geom_bar() 
    + facet_wrap(~Name, ncol = 2)
####################################
ggplot(melted_gold, aes(Quarter, Value, fill=Name)) + 
    geom_bar(stat="identity") + 
    facet_wrap(~Name, nrow=4) + 
    coord_flip()
