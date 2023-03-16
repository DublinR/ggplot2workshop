# You want to do add lines to a plot.
# http://www.cookbook-r.com/Graphs/Lines_(ggplot2)/

#######################################

# Some sample data
df <- read.table(header=T, text='
     cond result
  control     10
treatment   11.5
')

library(ggplot2)

########################################

# Adding Lines

# Basic bar plot
bp <- ggplot(df, aes(x=cond, y=result)) + geom_bar(position=position_dodge())
bp    

# Add a horizontal line
bp + geom_hline(aes(yintercept=12))

# Make the line red and dashed
bp + geom_hline(aes(yintercept=12), colour="#990000", linetype="dashed")

#######################################
# Lines over grouped bars
df <- read.table(header=T, text='
     cond group result hline
  control     A     10     9
treatment     A   11.5    12
  control     B     12     9
treatment     B     14    12
')

# Define basic bar plot
bp <- ggplot(df, aes(x=cond, y=result, fill=group)) + geom_bar(position=position_dodge()) 
bp

# The error bars get plotted over one another -- there are four but it looks like two
bp + geom_errorbar(aes(y=hline, ymax=hline, ymin=hline), linetype="dashed")
