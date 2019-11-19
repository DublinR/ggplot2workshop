library(plotly)

Sys.setenv("plotly_username"="XXXXXXXXXXX")
Sys.setenv("plotly_api_key"="YYYYYYYYYYY")

library(plotly)
p <- plot_ly(midwest, x = ~percollege, color = ~state, type = "box")


api_create(p, filename = "midwest-boxplots", sharing = "public")

#################################################

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
g <- ggplot(df, aes(x=rating)) + geom_histogram(binwidth=.5)
api_create(g, kwargs=list(fileopt='overwrite', filename='basic-histogram'))

# Draw with black outline, white fill
g <- ggplot(df, aes(x=rating)) + geom_histogram(binwidth=.5, colour="black", fill="white")
api_create(g, kwargs=list(fileopt='overwrite', filename='basic-histogram-white-filling'))

# Density curve
g <- ggplot(df, aes(x=rating)) + geom_density()
api_create(g, kwargs=list(fileopt='overwrite', filename='basic-density-curve'))

# Histogram overlaid with kernel density curve
g <- ggplot(df, aes(x=rating)) +
    geom_histogram(aes(y=..density..),      # Histogram with density instead of count on y-axis
                   binwidth=.5,
                   colour="black", fill="white") +
    geom_density(alpha=.2, fill="#FF6666")  # Overlay with transparent density plot
api_create(g, kwargs=list(fileopt='overwrite', filename='basic-density-curve-with-histogram'))

g <- ggplot(df, aes(x=rating)) + geom_histogram(binwidth=.5, colour="black", fill="white") +
    geom_vline(aes(xintercept=mean(rating, na.rm=T)),   # Ignore NA values for mean
               color="red", linetype="dashed", size=1)
api_create(g, kwargs=list(fileopt='overwrite', filename='histogram-with-vertical-line'))

# Overlaid histograms
g <- ggplot(df, aes(x=rating, fill=cond)) + geom_histogram(binwidth=.5, alpha=.5, position="identity")
api_create(g, kwargs=list(fileopt='overwrite', filename='overlaid-histograms'))

# Interleaved histograms
g <- ggplot(df, aes(x=rating, fill=cond)) + geom_histogram(binwidth=.5, position="dodge")
api_create(g, kwargs=list(fileopt='overwrite', filename='grouped-histograms'))

# Density plots
g <- ggplot(df, aes(x=rating, colour=cond)) + geom_density()
api_create(g, kwargs=list(fileopt='overwrite', filename='multiple-density-plots'))

# Density plots with semi-transparent fill
g <- ggplot(df, aes(x=rating, fill=cond)) + geom_density(alpha=.3)
api_create(g, kwargs=list(fileopt='overwrite', filename='filled-density-plots'))

# Find the mean of each group
library(plyr)
cdf <- ddply(df, "cond", summarise, rating.mean=mean(rating))
# cond rating.mean
#    A -0.05775928
#    B  0.87324927


# Overlaid histograms with means
g <- ggplot(df, aes(x=rating, fill=cond)) +
    geom_histogram(binwidth=.5, alpha=.5, position="identity") +
    geom_vline(data=cdf, aes(xintercept=rating.mean,  colour=cond),
               linetype="dashed", size=1)
api_create(g, kwargs=list(fileopt='overwrite', filename='overlaid-histograms-with-means'))

# Density plots with means
g <- ggplot(df, aes(x=rating, colour=cond)) + geom_density() +
    geom_vline(data=cdf, aes(xintercept=rating.mean,  colour=cond),
               linetype="dashed", size=1)
api_create(g, kwargs=list(fileopt='overwrite', filename='density-plot-with-means'))

g <- ggplot(df, aes(x=rating)) + geom_histogram(binwidth=.5, colour="black", fill="white") +
    facet_grid(cond ~ .)
api_create(g, kwargs=list(fileopt='overwrite', filename='faceted-histograms'))

# With mean lines, using cdf from above
g <- ggplot(df, aes(x=rating)) + geom_histogram(binwidth=.5, colour="black", fill="white") +
    facet_grid(cond ~ .) +
    geom_vline(data=cdf, aes(xintercept=rating.mean),
               linetype="dashed", size=1, colour="red")
api_create(g, kwargs=list(fileopt='overwrite', filename='faceted-histograms-with-mean-lines'))

# A basic box plot
g <- ggplot(df, aes(x=cond, y=rating)) + geom_boxplot()
api_create(g, kwargs=list(fileopt='overwrite', filename='basic-box-plot'))

# A basic box with the conditions colored
g <- ggplot(df, aes(x=cond, y=rating, fill=cond)) + geom_boxplot()
api_create(g, kwargs=list(fileopt='overwrite', filename='box-plot-with-conditions-colored'))

# The above adds a redundant legend. With the legend removed:
g <- ggplot(df, aes(x=cond, y=rating, fill=cond)) + geom_boxplot() +
    guides(fill=FALSE)
api_create(g, kwargs=list(fileopt='overwrite', filename='box-plot-with-legend-removed'))

# With flipped axes
g <- ggplot(df, aes(x=cond, y=rating, fill=cond)) + geom_boxplot() +
    guides(fill=FALSE) + coord_flip()
api_create(g, kwargs=list(fileopt='overwrite', filename='box-plot-with-flipped-axes'))

# Add a diamond at the mean, and make it larger
g <- ggplot(df, aes(x=cond, y=rating)) + geom_boxplot() +
    stat_summary(fun.y=mean, geom="point", shape=5, size=4)
api_create(g, kwargs=list(fileopt='overwrite', filename='box-plot-with-diamond-means'))
