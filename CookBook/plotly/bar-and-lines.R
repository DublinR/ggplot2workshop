library(plotly)
set_credentials_file("ggplot2-cookbook", "gzcn4660jr")
py <- plotly();

df <- data.frame(time = factor(c("Lunch","Dinner"), levels=c("Lunch","Dinner")),
                 total_bill = c(14.89, 17.23))
#   time total_bill
#  Lunch      14.89
# Dinner      17.23

# Load the ggplot2 library
library(ggplot2)

# Very basic bar graph
g <- ggplot(data=df, aes(x=time, y=total_bill)) + geom_bar(stat="identity")
py$ggplotly(g, kwargs=list(filename='R-Cookbook/basic-bar'))

# Map the time of day to different fill colors. These both have the same result.
g <- ggplot(data=df, aes(x=time, y=total_bill, fill=time)) + geom_bar(stat="identity")
py$ggplotly(g, kwargs=list(filename='R-Cookbook/basic-bar-fill-colors-1'))
g <- ggplot(data=df, aes(x=time, y=total_bill)) + geom_bar(aes(fill=time), stat="identity")
py$ggplotly(g, kwargs=list(filename='R-Cookbook/basic-bar-fill-colors-2'))

# Add a black outline
g <- ggplot(data=df, aes(x=time, y=total_bill, fill=time)) + geom_bar(colour="black", stat="identity")
py$ggplotly(g, kwargs=list(filename='R-Cookbook/basic-bar-fill-colors-black-outline'))

# No legend, since the information is redundant
g <- ggplot(data=df, aes(x=time, y=total_bill, fill=time)) +
    geom_bar(colour="black", stat="identity") +
    guides(fill=FALSE)
py$ggplotly(g, kwargs=list(filename='R-Cookbook/basic-bar-fill-colors-black-outline-no-legend'))

# Add title, narrower bars, gray fill, and change axis labels
g <- ggplot(data=df, aes(x=time, y=total_bill, fill=time)) +
    geom_bar(colour="black", fill="#DD8888", width=.7, stat="identity") +
    guides(fill=FALSE) +
    xlab("Time of day") + ylab("Total bill") +
    ggtitle("Average bill for 2 people")
py$ggplotly(g, kwargs=list(filename='R-Cookbook/basic-bar-fully-styled'))

library(reshape2)
tips
# total_bill   tip    sex smoker  day   time size
#      16.99  1.01 Female     No  Sun Dinner    2
#      10.34  1.66   Male     No  Sun Dinner    3
#      21.01  3.50   Male     No  Sun Dinner    3
#  ... <244 total rows> ...
#      22.67  2.00   Male    Yes  Sat Dinner    2
#      17.82  1.75   Male     No  Sat Dinner    2
#      18.78  3.00 Female     No Thur Dinner    2

# Bar graph of counts
g <- ggplot(data=tips, aes(x=day)) + geom_bar(stat="bin")
py$ggplotly(g, kwargs=list(filename='R-Cookbook/bar-graph-of-counts'))

# Equivalent to this, since stat="bin" is the default:
g <- ggplot(data=tips, aes(x=day)) + geom_bar()
py$ggplotly(g, kwargs=list(filename='R-Cookbook/bar-graph-of-counts-2'))

# Basic line graph. These both have the same result.
g <- ggplot(data=df, aes(x=time, y=total_bill, group=1)) + geom_line()
py$ggplotly(g, kwargs=list(filename='R-Cookbook/basic-line'))
g <- ggplot(data=df, aes(x=time, y=total_bill)) + geom_line(aes(group=1))
py$ggplotly(g, kwargs=list(filename='R-Cookbook/basic-line-2'))

# Add points
g <- ggplot(data=df, aes(x=time, y=total_bill, group=1)) + geom_line() + geom_point()
py$ggplotly(g, kwargs=list(filename='R-Cookbook/basic-line-with-points'))

# Change color of both line and points
# Change line type and point type, and use thicker line and larger points
# Change points to circles with white fill
g <- ggplot(data=df, aes(x=time, y=total_bill, group=1)) +
    geom_line(colour="red", linetype="dotted", size=1.5) +
    geom_point(colour="red", size=4, shape=21, fill="white")
py$ggplotly(g, kwargs=list(filename='R-Cookbook/basic-dashed-line-with-colors'))

# Change the y-range to go from 0 to the maximum value in the total_bill column,
# and change axis labels
g <- ggplot(data=df, aes(x=time, y=total_bill, group=1)) + geom_line() + geom_point() +
    ylim(0, max(df$total_bill)) +
    xlab("Time of day") + ylab("Total bill") +
    ggtitle("Average bill for 2 people")
py$ggplotly(g, kwargs=list(filename='R-Cookbook/basic-line-fully-styled'))

df1 <- data.frame(sex       = factor(c("Female","Female","Male","Male")),
                 time       = factor(c("Lunch","Dinner","Lunch","Dinner"), levels=c("Lunch","Dinner")),
                 total_bill = c(13.53, 16.81, 16.24, 17.42))
#    sex   time total_bill
# Female  Lunch      13.53
# Female Dinner      16.81
#   Male  Lunch      16.24
#   Male Dinner      17.42

# Stacked bar graph -- this is probably not what you want
g <- ggplot(data=df1, aes(x=time, y=total_bill, fill=sex)) + geom_bar(stat="identity")
py$ggplotly(g, kwargs=list(filename='R-Cookbook/multi-var-stacked-bar'))

# Bar graph, time on x-axis, color fill grouped by sex -- use position_dodge()
g <- ggplot(data=df1, aes(x=time, y=total_bill, fill=sex)) + geom_bar(stat="identity", position=position_dodge())
py$ggplotly(g, kwargs=list(filename='R-Cookbook/multi-var-grouped-bar'))
g <- ggplot(data=df1, aes(x=time, y=total_bill, fill=sex)) + geom_bar(stat="identity", position=position_dodge(), colour="black")
py$ggplotly(g, kwargs=list(filename='R-Cookbook/multi-var-grouped-bar-black-outline'))

# Change colors
g <- ggplot(data=df1, aes(x=time, y=total_bill, fill=sex)) + geom_bar(stat="identity", position=position_dodge(), colour="black") +
    scale_fill_manual(values=c("#999999", "#E69F00"))
py$ggplotly(g, kwargs=list(filename='R-Cookbook/multi-var-grouped-bar-colored'))

# Bar graph, time on x-axis, color fill grouped by sex -- use position_dodge()
g <- ggplot(data=df1, aes(x=sex, y=total_bill, fill=time)) + geom_bar(stat="identity", position=position_dodge(), colour="black")
py$ggplotly(g, kwargs=list(filename='R-Cookbook/multi-var-grouped-bar-reversed-vars'))

# Basic line graph with points
g <- ggplot(data=df1, aes(x=time, y=total_bill, group=sex)) + geom_line() + geom_point()
py$ggplotly(g, kwargs=list(filename='R-Cookbook/basic-line-with-points'))

# Map sex to color
g <- ggplot(data=df1, aes(x=time, y=total_bill, group=sex, colour=sex)) + geom_line() + geom_point()
py$ggplotly(g, kwargs=list(filename='R-Cookbook/basic-line-with-mapped-colors'))

# Map sex to different point shape, and use larger points
g <- ggplot(data=df1, aes(x=time, y=total_bill, group=sex, shape=sex)) + geom_line() + geom_point()
py$ggplotly(g, kwargs=list(filename='R-Cookbook/basic-line-with-symbols'))

# Use thicker lines and larger points, and hollow white-filled points
g <- ggplot(data=df1, aes(x=time, y=total_bill, group=sex, shape=sex)) +
    geom_line(size=1.5) +
    geom_point(size=3, fill="white") +
    scale_shape_manual(values=c(22,21))
py$ggplotly(g, kwargs=list(filename='R-Cookbook/basic-line-with-points-fully-styled'))

g <- ggplot(data=df1, aes(x=sex, y=total_bill, group=time, shape=time, color=time)) + geom_line() + geom_point()
py$ggplotly(g, kwargs=list(filename='R-Cookbook/basic-line-swapped-vars'))

# A bar graph
g <- ggplot(data=df1, aes(x=time, y=total_bill, fill=sex)) +
    geom_bar(colour="black", stat="identity",
             position=position_dodge(),
             size=.3) +                        # Thinner lines
    scale_fill_hue(name="Sex of payer") +      # Set legend title
    xlab("Time of day") + ylab("Total bill") + # Set axis labels
    ggtitle("Average bill for 2 people") +  # Set title
    theme_bw()
py$ggplotly(g, kwargs=list(filename='R-Cookbook/finished-bar-bw-theme'))

# A line graph
g <- ggplot(data=df1, aes(x=time, y=total_bill, group=sex, shape=sex, colour=sex)) +
    geom_line(aes(linetype=sex), size=1) +     # Set linetype by sex
    geom_point(size=3, fill="white") +         # Use larger points, fill with white
    ylim(0, max(df1$total_bill)) +             # Set y range
    scale_colour_hue(name="Sex of payer",      # Set legend title
                     l=30)  +                  # Use darker colors (lightness=30)
    scale_shape_manual(name="Sex of payer",
                       values=c(22,21)) +      # Use points with a fill color
    scale_linetype_discrete(name="Sex of payer") +
    xlab("Time of day") + ylab("Total bill") + # Set axis labels
    ggtitle("Average bill for 2 people") +  # Set title
    theme_bw() +
    theme(legend.position=c(.7, .4)) # Position legend inside
                                    # This must go after theme_bw
py$ggplotly(g, kwargs=list(filename='R-Cookbook/finished-line'))

dfn <- read.table(header=T, text='
supp dose length
  OJ  0.5  13.23
  OJ  1.0  22.70
  OJ  2.0  26.06
  VC  0.5   7.98
  VC  1.0  16.77
  VC  2.0  26.14
')

g <- ggplot(data=dfn, aes(x=dose, y=length, group=supp, colour=supp)) + geom_line() + geom_point()
py$ggplotly(g, kwargs=list(filename='R-Cookbook/line-continuous-numerical-x-axis'))

# Copy the data frame and convert dose to a factor
dfn2 <- dfn
dfn2$dose <- factor(dfn2$dose)
g <- ggplot(data=dfn2, aes(x=dose, y=length, group=supp, colour=supp)) + geom_line() + geom_point()
py$ggplotly(g, kwargs=list(filename='R-Cookbook/line-continuous-categorical-x-axis'))

# Use the original data frame, but put factor() directly in the plot specification
g <- ggplot(data=dfn, aes(x=factor(dose), y=length, group=supp, colour=supp)) + geom_line() + geom_point()
py$ggplotly(g, kwargs=list(filename='R-Cookbook/line-continuous-categorical-x-axis-with-factor'))

# Use dfn2 from above
g <- ggplot(data=dfn2, aes(x=dose, y=length, fill=supp)) + geom_bar(stat="identity", position=position_dodge())
py$ggplotly(g, kwargs=list(filename='R-Cookbook/bar-categorical-numerical-labels'))

# Use the original data frame, but put factor() directly in the plot specification
g <- ggplot(data=dfn, aes(x=factor(dose), y=length, fill=supp)) + geom_bar(stat="identity", position=position_dodge())
py$ggplotly(g, kwargs=list(filename='R-Cookbook/bar-categorical-numerical-labels-with-factor'))
