
http://www.cookbook-r.com/Graphs/Plotting_means_and_error_bars_(ggplot2)/
################################################################

# Standard error of the mean
ggplot(dfc, aes(x=dose, y=len, colour=supp)) + 
    geom_errorbar(aes(ymin=len-se, ymax=len+se), width=.1) +
    geom_line() +
    geom_point()

# The errorbars overlapped, so use position_dodge to move them horizontally
pd <- position_dodge(.1) # move them .05 to the left and right

ggplot(dfc, aes(x=dose, y=len, colour=supp)) + 
    geom_errorbar(aes(ymin=len-se, ymax=len+se), width=.1, position=pd) +
    geom_line(position=pd) +
    geom_point(position=pd)

# Use 95% confidence interval instead of SEM
ggplot(dfc, aes(x=dose, y=len, colour=supp)) + 
    geom_errorbar(aes(ymin=len-ci, ymax=len+ci), width=.1, position=pd) +
    geom_line(position=pd) +
    geom_point(position=pd)

# Black error bars - notice the mapping of 'group=supp' -- without it, the error
# bars won't be dodged!
ggplot(dfc, aes(x=dose, y=len, colour=supp, group=supp)) + 
    geom_errorbar(aes(ymin=len-ci, ymax=len+ci), colour="black", width=.1, position=pd) +
    geom_line(position=pd) +
    geom_point(position=pd, size=3)
    
#################################################################

ggplot(dfc, aes(x=dose, y=len, colour=supp, group=supp)) + 
    geom_errorbar(aes(ymin=len-se, ymax=len+se), colour="black", width=.1, position=pd) +
    geom_line(position=pd) +
    geom_point(position=pd, size=3, shape=21, fill="white") + # 21 is filled circle
    xlab("Dose (mg)") +
    ylab("Tooth length") +
    scale_colour_hue(name="Supplement type", # Legend label, use darker colors
                     breaks=c("OJ", "VC"),
                     labels=c("Orange juice", "Ascorbic acid"),
                     l=40) +                  # Use darker colors, lightness=40
    ggtitle("The Effect of Vitamin C on\nTooth Growth in Guinea Pigs") +
    scale_y_continuous(limits=c(0, max(dfc$len + dfc$se)),    # Set y range
                       breaks=0:20*4) +                       # Set tick every 4
    theme_bw() +
    theme(legend.justification=c(1,0), legend.position=c(1,0)) # Position legend in bottom right
