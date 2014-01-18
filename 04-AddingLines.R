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
