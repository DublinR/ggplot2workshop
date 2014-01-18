# Basic histogram from the vector "rating". 
# Each bin is .5 wide.
# http://www.cookbook-r.com/Graphs/Plotting_distributions_(ggplot2)/
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
    
###########################################################################
