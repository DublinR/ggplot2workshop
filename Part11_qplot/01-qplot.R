# http://rstudio-pubs-static.s3.amazonaws.com/2176_75884214fc524dc0bc2a140573da38bb.html
# http://www.ling.upenn.edu/~joseff/rstudy/summer2010_ggplot2_intro.html
############################################################################
# Installing ggplot2

install.packages("ggplot2")
library(ggplot2)

############################################################################
# qplot examples 
 
qplot(diamonds$cut, diamonds$carat)
qplot(carat, price, data = diamonds)
qplot(carat, price, data = diamonds, colour=clarity)
qplot(carat, price, data = diamonds, geom=c("point", "smooth"), method=lm)
