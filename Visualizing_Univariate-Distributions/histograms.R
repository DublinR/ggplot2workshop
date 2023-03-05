# http://www.cookbook-r.com/Graphs/Plotting_distributions_(ggplot2)/

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

# Basic histogram from the vector "rating". Each bin is .5 wide.
# These both do the same thing:
qplot(df$rating, binwidth=.5)
ggplot(df, aes(x=rating)) + geom_histogram(binwidth=.5)

# Draw with black outline, white fill
ggplot(df, aes(x=rating)) + geom_histogram(binwidth=.5, colour="black", fill="white")

# Density curve
ggplot(df, aes(x=rating)) + geom_density()

# Histogram overlaid with kernel density curve
ggplot(df, aes(x=rating)) + 
    geom_histogram(aes(y=..density..),      # Histogram with density instead of count on y-axis
                   binwidth=.5,
                   colour="black", fill="white") +
    geom_density(alpha=.2, fill="#FF6666")  # Overlay with transparent density plot
##Add Line for the mean
ggplot(df, aes(x=rating)) + geom_histogram(binwidth=.5, colour="black", fill="white") +
    geom_vline(aes(xintercept=mean(rating, na.rm=T)),   # Ignore NA values for mean
               color="red", linetype="dashed", size=1)
################################################################

# Overlaid histograms
ggplot(df, aes(x=rating, fill=cond)) + geom_histogram(binwidth=.5, alpha=.5, position="identity")

# Interleaved histograms
ggplot(df, aes(x=rating, fill=cond)) + geom_histogram(binwidth=.5, position="dodge")

# Density plots
ggplot(df, aes(x=rating, colour=cond)) + geom_density()

# Density plots with semi-transparent fill
ggplot(df, aes(x=rating, fill=cond)) + geom_density(alpha=.3)
##################################################################
# Find the mean of each group
library(plyr)
cdf <- ddply(df, "cond", summarise, rating.mean=mean(rating))
# cond rating.mean
#    A -0.05775928
#    B  0.87324927

# Overlaid histograms with means
ggplot(df, aes(x=rating, fill=cond)) +
    geom_histogram(binwidth=.5, alpha=.5, position="identity") +
    geom_vline(data=cdf, aes(xintercept=rating.mean,  colour=cond),
               linetype="dashed", size=1)

# Density plots with means
ggplot(df, aes(x=rating, colour=cond)) + geom_density() +
    geom_vline(data=cdf, aes(xintercept=rating.mean,  colour=cond),
               linetype="dashed", size=1)
