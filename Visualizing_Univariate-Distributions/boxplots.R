set.seed(1234)
df <- data.frame(cond = factor( rep(c("A","B"), each=200) ), 
                   rating = c(rnorm(200),rnorm(200, mean=.8)))
# cond     rating
#    A -1.2070657
#    A  0.2774292
#    A  1.0844412
#   ...
#    B  1.3388331
#    B  0.8146431
#    B -0.1164891

library(ggplot2)
######################################################
# A basic box plot
ggplot(df, aes(x=cond, y=rating)) + geom_boxplot()

# A basic box with the conditions colored
ggplot(df, aes(x=cond, y=rating, fill=cond)) + geom_boxplot()

# The above adds a redundant legend. With the legend removed:
ggplot(df, aes(x=cond, y=rating, fill=cond)) + geom_boxplot() +
    guides(fill=FALSE)

# With flipped axes
ggplot(df, aes(x=cond, y=rating, fill=cond)) + geom_boxplot() + 
    guides(fill=FALSE) + coord_flip()
