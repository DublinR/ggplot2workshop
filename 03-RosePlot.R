# http://learnr.wordpress.com/2010/08/16/consultants-chart-in-ggplot2/

set.seed(9876)

DF <- data.frame(variable = 1:10, value = sample(10,replace = TRUE))

last_plot() + scale_y_continuous(breaks = 0:10) +
   coord_polar() + labs(x = "", y = "") + opts(legend.position = "none",
   axis.text.x = theme_blank(), axis.text.y = theme_blank(),
   axis.ticks = theme_blank())
   
##########################################################################
